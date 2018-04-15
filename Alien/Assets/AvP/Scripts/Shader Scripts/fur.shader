Shader "Custom/fur" {
	Properties {
		_MainTex   ("Base (RGB)", 2D) = "white" {}
		_AlphaChan ("Alpha (RGB)", 2D) = "white" {}
		_Height  ("Height", float) = 1
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent"}
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 200
		//ZWrite On
		
		//pass 0
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0
			#include "fur_helper.cginc"
			ENDCG
		}
		
		//pass 1
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.1
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 2
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.2
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 3
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.3
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 4
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.4
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 5
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.5
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 6
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.6
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 7
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.7
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 8
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.8
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 9
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 0.9
			#include "fur_helper.cginc"
			ENDCG
		}
		//pass 10
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#define FUR_MULTIPLIER 1.0
			#include "fur_helper.cginc"
			ENDCG
		}
		
		
	} 
	FallBack "Diffuse"
}
