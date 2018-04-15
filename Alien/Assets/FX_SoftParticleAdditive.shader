// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0,fgcg:0,fgcb:0,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:4795,x:32724,y:32693,varname:node_4795,prsc:2|normal-7174-RGB,emission-100-OUT,alpha-3843-OUT;n:type:ShaderForge.SFN_VertexColor,id:2053,x:31643,y:32248,varname:node_2053,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:7638,x:31643,y:32541,varname:node_7638,prsc:2,ntxv:0,isnm:False|TEX-8233-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:8233,x:31407,y:32498,ptovrint:False,ptlb:Albedo,ptin:_Albedo,varname:node_8233,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3909,x:31941,y:32540,varname:node_3909,prsc:2|A-2904-RGB,B-7638-RGB,C-2053-RGB;n:type:ShaderForge.SFN_Color,id:2904,x:31643,y:32391,ptovrint:False,ptlb:Albedo_Color,ptin:_Albedo_Color,varname:node_2904,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_DepthBlend,id:3606,x:31746,y:32871,varname:node_3606,prsc:2|DIST-3992-OUT;n:type:ShaderForge.SFN_Multiply,id:3843,x:32021,y:32906,varname:node_3843,prsc:2|A-7638-A,B-3606-OUT;n:type:ShaderForge.SFN_Slider,id:3992,x:31407,y:32870,ptovrint:False,ptlb:Depth Blend Value,ptin:_DepthBlendValue,varname:node_3992,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:7174,x:31407,y:32686,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_7174,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_ValueProperty,id:953,x:31941,y:32476,ptovrint:False,ptlb:Albedo Multiplier,ptin:_AlbedoMultiplier,varname:node_953,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:100,x:32263,y:32542,varname:node_100,prsc:2|A-953-OUT,B-3909-OUT;proporder:8233-2904-3992-7174-953;pass:END;sub:END;*/

Shader "Shader Forge/FX_SoftParticleAdditive" {
    Properties {
        _Albedo ("Albedo", 2D) = "white" {}
        _Albedo_Color ("Albedo_Color", Color) = (1,1,1,1)
        _DepthBlendValue ("Depth Blend Value", Range(0, 1)) = 1
        _Normal ("Normal", 2D) = "bump" {}
        _AlbedoMultiplier ("Albedo Multiplier", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _Albedo; uniform float4 _Albedo_ST;
            uniform float4 _Albedo_Color;
            uniform float _DepthBlendValue;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform float _AlbedoMultiplier;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                float4 vertexColor : COLOR;
                float4 projPos : TEXCOORD5;
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float3 normalLocal = _Normal_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
////// Lighting:
////// Emissive:
                float4 node_7638 = tex2D(_Albedo,TRANSFORM_TEX(i.uv0, _Albedo));
                float3 node_3909 = (_Albedo_Color.rgb*node_7638.rgb*i.vertexColor.rgb);
                float3 emissive = (_AlbedoMultiplier*node_3909);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,(node_7638.a*saturate((sceneZ-partZ)/_DepthBlendValue)));
                UNITY_APPLY_FOG_COLOR(i.fogCoord, finalRGBA, fixed4(0,0,0,1));
                return finalRGBA;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
