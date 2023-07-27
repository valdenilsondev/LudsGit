// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

///////////////////////////////////////////
//  CameraFilterPack v2.0 - by VETASOFT 2015 ///
///////////////////////////////////////////


Shader "CameraFilterPack/TV_Chromatical2" { 
Properties 
{
_MainTex ("Base (RGB)", 2D) = "white" {}
_TimeX ("Time", Range(0.0, 1.0)) = 1.0
_ScreenResolution ("_ScreenResolution", Vector) = (0.,0.,0.,0.)
}
SubShader
{
Pass
{
ZTest Always
CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#pragma target 3.0
#pragma glsl
#include "UnityCG.cginc"
uniform sampler2D _MainTex;
uniform float _TimeX;
uniform float _Value;
uniform float4 _ScreenResolution;
struct appdata_t
{
float4 vertex   : POSITION;
float4 color    : COLOR;
float2 texcoord : TEXCOORD0;
};
struct v2f
{
half2 texcoord  : TEXCOORD0;
float4 vertex   : SV_POSITION;
fixed4 color    : COLOR;
};
v2f vert(appdata_t IN)
{
v2f OUT;
OUT.vertex = UnityObjectToClipPos(IN.vertex);
OUT.texcoord = IN.texcoord;
OUT.color = IN.color;
return OUT;
}
float4 frag (v2f i) : COLOR
{
float2 q = i.texcoord.xy;
float2 uv = 0.5 + (q-0.5)*(0.9 + 0.1*sin(0.2*_TimeX));

float Effect = abs(uv.x - 0.5) * _Value;
float3 aberration = float3(0.019, 0, -0.019);
aberration *= Effect;
float3 col;
col.r = tex2D(_MainTex,float2(uv.x+aberration.x,uv.y)).x;
col.g = tex2D(_MainTex,float2(uv.x+aberration.y,uv.y)).y;
col.b = tex2D(_MainTex,float2(uv.x+aberration.z,uv.y)).z;
return  float4(col,1.0);

}
ENDCG
}
}
}
