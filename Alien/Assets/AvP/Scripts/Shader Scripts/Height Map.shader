Shader "Custom/Height Map" {
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MainTex ("Base (RGB)", 2D) = "Black" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		#pragma glsl
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _Height;
		float _Amount;

		struct Input 
		{
			float2 uv_MainTex;
		};
		
		void vert(inout appdata_full v)
		{
			float2 uv = v.texcoord.xy;
			//uv.x += _Time.x;
			half4 c = tex2Dlod(_Height, float4(uv,0,0));
			v.vertex.xyz += v.normal * c.r*_Amount;
		}

		void surf (Input IN, inout SurfaceOutput o) 
		{
			float2 uv = IN.uv_MainTex;
			//uv.x += _Time.x;
			half4 c = tex2D (_MainTex, uv);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}