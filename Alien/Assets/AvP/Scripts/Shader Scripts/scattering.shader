Shader "Custom/scattering" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_UnderTex("Under Texture", 2D) = "black"{}
		_BumpMap("Bump Map", 2D) = "bump" {}
		//_Wrap("Light Wrap", Range(0,1)) = 0.5
		_Emissive("Emissive Scale", Range(0,1)) = 0.5
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf BlinnPhong

		sampler2D _MainTex;
		sampler2D _UnderTex;
		sampler2D _BumpMap;
		//half _Wrap;
		half _Emissive;

		struct Input 
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};


		half4 LightingSpecular(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h = normalize(lightDir + viewDir);
			half diff = max(0, dot(s.Normal, lightDir)); //or half diff = max(0, dot(s.Normal, lightDir)*0.5*_Wrap);
			

			float nh = max(0, dot(s.Normal,h));
			float spec = pow(nh, 100.0);

			half4 c;
			c.rgb = 0.75*(s.Albedo *_LightColor0.rgb*diff) * (atten *2);
			c.rgb+= (_LightColor0.rgb *spec) *(atten*2);
			
			return c;
		}

		void surf (Input IN, inout SurfaceOutput o) 
		{
			half t = 1+0.1*sin(_Time.w);
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half4 d = tex2D(_UnderTex, IN.uv_MainTex*t);
			
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Emission = d.rgb*_Emissive;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
