Shader "Custom/Blurr" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_XSpacing("X Offset", float) = .1
		_YSpacing("Y Offset", float) = .1
		//_OtherTex("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		half _XSpacing;
		half _YSpacing;
		
		//sampler2D _OtherTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			half2 uv = IN.uv_MainTex;
			
			
			//Galsium Blur
			half4 c = tex2D(_MainTex,uv)/5;
			c += tex2D (_MainTex, uv + half2(_XSpacing, -_YSpacing))*.367879;
			c += tex2D (_MainTex, uv + half2(-_XSpacing,_YSpacing))*.367879;
			c += tex2D (_MainTex, uv + half2(_XSpacing,_YSpacing))*.367879;
			c += tex2D (_MainTex, uv + half2(-_XSpacing, -_YSpacing))*.367879;
			
			c += tex2D (_MainTex, uv + half2(_XSpacing, 0))*.135335;
			c += tex2D (_MainTex, uv + half2(-_XSpacing,0))*.135335;
			c += tex2D (_MainTex, uv + half2(0,_YSpacing))*.135335;
			c += tex2D (_MainTex, uv + half2(0, -_YSpacing))*.135335;
			
			c /= 3.01286;
			
			//linear blur
			//half4 c = tex2D(_MainTex,uv)/5;
			//c += tex2D (_MainTex, uv + half2(_XSpacing, -_YSpacing))/9;
			//c += tex2D (_MainTex, uv + half2(-_XSpacing,_YSpacing))/9
			//c += tex2D (_MainTex, uv + half2(_XSpacing,_YSpacing))/9;
			//c += tex2D (_MainTex, uv + half2(-_XSpacing, -_YSpacing))/9;
			
			//c += tex2D (_MainTex, uv + half2(_XSpacing, 0))/9;
			//c += tex2D (_MainTex, uv + half2(-_XSpacing,0))/9;
			//c += tex2D (_MainTex, uv + half2(0,_YSpacing))/9;
			//c += tex2D (_MainTex, uv + half2(0, -_YSpacing))/9;
			
			
			//average
			//half m = (c.r + c.g+c.b)/3;
			
			//lightness
			//half m = (max(max(c.r,c.g),c.b));
			
			//luminosity
			//half m = (min(min(c.r,c.g),c.b));
			
			//c.r = m;
			//c.g = m;
			//c.b= m;
			
			
			o.Albedo = c.rgb; //+ d.rgb/2;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
