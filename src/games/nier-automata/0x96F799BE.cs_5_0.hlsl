// Manually reconstructed from cs_e2e11c067116291bdc3c5066a53895d7d250b0bca701d7832e5ef986cd73af81.instructions.asm and its RDEF reflection.
// Global/resource/member names are from RDEF; local names are inferred.
// Compilation and binary equivalence are tracked separately in status.jsonl.
cbuffer cb : register(b0) { uint4 const0 : packoffset(c0); uint4 const1 : packoffset(c1); }
Texture2D<float4> InputTexture : register(t0);
RWTexture2D<float4> OutputTexture : register(u0);
// The integer operations on float bit patterns in the assembly are deliberate
// fast reciprocal/square-root approximations. Do not replace with rcp/sqrt.
float ApproxRcp(float x) { return asfloat(0x7ef07ebbu-asuint(x)); }
float ApproxSqrt(float x) { return asfloat((asuint(x)>>1)+0x1fbc4639u); }
float RefinedRcp(float x) { float r=asfloat(0x7ef19fffu-asuint(x)); return mad(-r,x,2)*r; }
float3 Fetch(int2 p) { return InputTexture.Load(int3(p,0)).xyz; }
float Weight(float minimum,float maximum) {
    return ApproxSqrt(saturate(ApproxRcp(maximum)*min(minimum,1-maximum)))*asfloat(const1.x);
}
float3 Sharpen(int2 p) {
    float3 left=Fetch(p+int2(-1,0)),top=Fetch(p+int2(0,-1)),center=Fetch(p);
    float3 right=Fetch(p+int2(1,0)),bottom=Fetch(p+int2(0,1));
    float lo=min(min(right.y,center.y),left.y); lo=min(lo,min(bottom.y,top.y));
    float hi=max(max(right.y,center.y),left.y); hi=max(hi,max(bottom.y,top.y));
    float a=Weight(lo,hi);
    float3 sum=a*left; sum=mad(top,a,sum); sum=mad(right,a,sum); sum=mad(bottom,a,sum);
    return saturate(RefinedRcp(mad(a,4,1))*(center+sum));
}
uint2 RemapLane(uint lane) { return uint2((lane>>1)&7,((lane>>3)&~1u)|(lane&1)); }

// Upscaling variant: four bilinear corner crosses, with independent adaptive
// sharpness and inverse contrast at each corner. This factors repeated assembly.
float3 Upscale(uint2 outputPixel) {
    float2 source=mad((float2)outputPixel,asfloat(const0.xy),asfloat(const0.zw));
    int2 base=(int2)floor(source); float2 f=source-floor(source);
    float4 bilinear=float4((1-f.x)*(1-f.y),f.x*(1-f.y),(1-f.x)*f.y,f.x*f.y);
    float a[4],w[4]; float3 c[4],l[4],t[4],r[4],b[4];
    [unroll] for(uint corner=0;corner<4;++corner) {
        int2 p=base+int2(corner&1,corner>>1);
        c[corner]=Fetch(p);l[corner]=Fetch(p+int2(-1,0));t[corner]=Fetch(p+int2(0,-1));
        r[corner]=Fetch(p+int2(1,0));b[corner]=Fetch(p+int2(0,1));
        float lo=min(min(l[corner].y,c[corner].y),t[corner].y);lo=min(lo,min(r[corner].y,b[corner].y));
        float hi=max(max(l[corner].y,c[corner].y),t[corner].y);hi=max(hi,max(r[corner].y,b[corner].y));
        a[corner]=Weight(lo,hi);
        w[corner]=ApproxRcp((hi-lo)+0.03125)*bilinear[corner];
    }
    // Same twelve texels as the unrolled original, combining shared centers.
    float4 edge=float4(a[0]*w[0],a[1]*w[1],a[2]*w[2],a[3]*w[3]);
    float3 sum=edge.x*l[0];sum=mad(t[0],edge.x,sum);
    sum=mad(t[1],edge.y,sum);sum=mad(r[1],edge.y,sum);
    sum=mad(l[2],edge.z,sum);sum=mad(b[2],edge.z,sum);
    sum=mad(r[3],edge.w,sum);sum=mad(b[3],edge.w,sum);
    float sharedTop=edge.y+edge.z, sharedBottom=edge.x+edge.w;
    float4 centerWeight=float4(w[0]+sharedTop,w[1]+sharedBottom,w[2]+sharedBottom,w[3]+sharedTop);
    sum=mad(c[0],centerWeight.x,sum);sum=mad(c[1],centerWeight.y,sum);
    sum=mad(c[2],centerWeight.z,sum);sum=mad(c[3],centerWeight.w,sum);
    float denominator=2*edge.x+2*edge.y+2*edge.z+2*edge.w;
    denominator+=centerWeight.x;denominator+=centerWeight.y;denominator+=centerWeight.z;denominator+=centerWeight.w;
    // Preserve above-white RGB; adaptive weight clamps remain unchanged.
    return max(0.0, sum*RefinedRcp(denominator));
}
[numthreads(64,1,1)]
void main(uint3 groupID : SV_GroupID,uint3 localID : SV_GroupThreadID) {
    uint2 p=groupID.xy*16+RemapLane(localID.x);
    OutputTexture[p]=float4(Upscale(p),1);
    OutputTexture[p+uint2(8,0)]=float4(Upscale(p+uint2(8,0)),1);
    OutputTexture[p+uint2(8,8)]=float4(Upscale(p+uint2(8,8)),1);
    OutputTexture[p+uint2(0,8)]=float4(Upscale(p+uint2(0,8)),1);
}
