Shader "Custom/spritesheet" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Dimensions ("Cols, Rows", Vector)  = (1,1,0,0)
		_Frames ("Frame Number", int) = 0

	}

	SubShader 
	{
		Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		half4 _Dimensions;
		int _Frame;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			int w = _Dimensions.x;
			int h = _Dimensions.y;


			half2 uv = IN.uv_MainTex;
			uv.x = (uv.x + _Frame % w)/ _Dimensions.x;
			uv.y = (uv.y + _Frame /w) / _Dimensions.y;

			half4 c = tex2D (_MainTex, uv);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
