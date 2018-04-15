// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

#ifndef _FUR_HELPER_INC
#define _FUR_HELPER_INC

#include "UnityCG.cginc"

sampler2D _MainTex;
sampler2D _AlphaChan;
float4 _MainTex_ST;
half _Height;

struct v2f
{
	float4 pos : SV_POSITION;
	float2 uv  : TEXCOORD0;
};

v2f vert(appdata_full v)
{
	v2f o;				
	v.vertex.xyz += _Height*v.normal*FUR_MULTIPLIER;
	o.pos = UnityObjectToClipPos(v.vertex);
	o.uv  = mul(UNITY_MATRIX_TEXTURE0, v.texcoord);
	return o;
}

float4 frag(v2f i) : COLOR
{
	float4 c = tex2D(_MainTex, i.uv);
	c.a = 1 - FUR_MULTIPLIER;
	//c.a = pow(tex2D(_AlphaChan, i.uv).r, FUR_MULTIPLIER);
	return c;
}

#endif