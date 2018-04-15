Shader "Custom/Wrapping"
{

	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Wrapper("Wrap", Range(0,1)) = 0
		_Shiny ("Shiny", float) = 48.0
		_Ramp ("Ramp", 2D) = "white" {}
	}
	
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Function
		
		sampler2D _MainTex;
		sampler2D _Ramp;
		half _Wrapper;
		half _Shiny;
		
		
		half4 LightingFunction(SurfaceOutput s, half3 lightDir, half3 viewDir , half atten)
		{
		//diffuse
			float NdotL = dot(s.Normal, lightDir)*0.5+_Wrapper;
			//NdotL = (NdotL + 1) * (1.5); //changing to range between 0-3
			//NdotL = ceil(NdotL); //rounds it up to 0, 1, 2, or 3
			//NdotL = (NdotL/1.5) - 1; //change back to range [-1, 1]
			NdotL =  (NdotL+1) *0.5;
			NdotL = saturate(NdotL);
			half3 ramp = tex2D(_Ramp, float2(1-NdotL)).rgb;
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten*2);
			c.a = s.Alpha;
	
			
		//specular
		
			half3 R = 2*dot(lightDir, s.Normal)*s.Normal - lightDir;
			float VdotR = dot(viewDir, R);
			VdotR = max(VdotR,0);
			c.rgb += _LightColor0.rgb * pow(VdotR, _Shiny) * (atten * 2);
			
			return c;
		}
		
		struct Input 
		{
			float2 uv_MainTex;

		};

	
		void surf (Input IN, inout SurfaceOutput o)
		{
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			half d = IN.uv_MainTex.y; 
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		
		ENDCG
	} 
	
	FallBack "Diffuse"
}
