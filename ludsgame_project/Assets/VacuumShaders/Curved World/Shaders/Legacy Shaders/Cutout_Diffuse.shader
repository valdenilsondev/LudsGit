// VacuumShaders 2015
// https://www.facebook.com/VacuumShaders

Shader "Hidden/VacuumShaders/Curved World/Legacy Shaders/Cutout/Diffuse" 
{
	Properties 
	{
		[CurvedWorldGearMenu] V_CW_Label_Tag("", float) = 0
		[CurvedWorldLabel] V_CW_Label_UnityDefaults("Default Visual Options", float) = 0


		//Modes
		[CurvedWorldLargeLabel] V_CW_Label_Modes("Modes", float) = 0	
		[CurvedWorldRenderingMode] V_CW_Rendering_Mode("  Rendering", float) = 0	
		[CurvedWorldTextureMixMode] V_CW_Texture_Mix_Mode("  Texture Mix", float) = 0	

		//Albedo
		[CurvedWorldLargeLabel] V_CW_Label_Albedo("Albedo", float) = 0	
		_Color ("  Color", Color) = (1,1,1,1)
		_MainTex ("  Map (RGB) RefStr, Gloss & Trans (A)", 2D) = "white" {}
		[CurvedWorldUVScroll] _V_CW_MainTex_Scroll("    ", vector) = (0, 0, 0, 0)

		//Cutoff
		[CurvedWorldLargeLabel] V_CW_Label_Cutoff("Cutout", float) = 0	
		_Cutoff ("  Alpha cutoff", Range(0,1)) = 0.5



		//CurvedWorld Options
		[CurvedWorldLabel] V_CW_CW_OPTIONS("Curved World Optionals", float) = 0
		
		[HideInInspector] _V_CW_Rim_Color("", color) = (1, 1, 1, 1)
		[HideInInspector] _V_CW_Rim_Bias("", Range(-1, 1)) = 0.2
		[HideInInspector] _V_CW_Rim_Power("", Range(0.5, 8.0)) = 3
		
		[HideInInspector] _EmissionMap("", 2D) = "black"{}
		[HideInInspector] _EmissionColor("", color) = (1, 1, 1, 1)	

		[HideInInspector] _SpecColor ("", Color) = (0.5,0.5,0.5,1)
	    [HideInInspector] _Shininess ("", Range (0.01, 1)) = 0.078125

		[HideInInspector] _ReflectColor("", color) = (1, 1, 1, 1)
		[HideInInspector] _ReflectStrengthAlphaOffset("", Range(-1, 1)) = 0
		[HideInInspector] _Cube("", Cube) = "_Skybox"{}	
		[HideInInspector] _V_CW_Fresnel_Power("", Range(0.5, 8.0)) = 1
		[HideInInspector] _V_CW_Fresnel_Bias("", Range(-1, 1)) = 0

		[HideInInspector] _BumpStrength("", float) = 1
		[HideInInspector] _BumpMap ("", 2D) = "bump" {}
		[HideInInspector] _BumpMap_UV_Scale ("", float) = 1

		[HideInInspector] _SecondBumpMap("", 2D) = ""{}
		[HideInInspector] _SecondBumpMap_UV_Scale("", float) = 1
	}

	SubShader 
	{
		Tags { "Queue"="AlphaTest"
			   "IgnoreProjector"="True"
			   "RenderType"="CurvedWorld_TransparentCutout" 
			   "CurvedWorldTag"="Legacy Shaders/Cutout/Diffuse" 
			   "CurvedWorldNoneRemoveableKeywords"=""  
			   "CurvedWorldAvailableOptions"="V_CW_REFLECTIVE;V_CW_VERTEX_COLOR;_EMISSION;V_CW_RIM;_NORMALMAP;V_CW_SPECULAR_HD;" 
			 }
		LOD 200
	
		CGPROGRAM
		#pragma surface surf BlinnPhong alphatest:_Cutoff vertex:vert addshadow nodirlightmap nodynlightmap
		#pragma target 3.0
		
		
		#pragma shader_feature V_CW_REFLECTIVE_OFF V_CW_REFLECTIVE V_CW_REFLECTIVE_FRESNEL
		#pragma shader_feature V_CW_VERTEX_COLOR_OFF V_CW_VERTEX_COLOR 
		#pragma shader_feature _EMISSION_OFF _EMISSION
		#pragma shader_feature V_CW_RIM_OFF V_CW_RIM

		#pragma shader_feature _NORMALMAP_OFF _NORMALMAP
		#pragma shader_feature V_CW_SPECULAR_OFF V_CW_SPECULAR

		#include "../cginc/CurvedWorld_Surface.cginc"

				
		ENDCG
	}

	Fallback "Hidden/VacuumShaders/Curved World/VertexLit/Cutout"
	CustomEditor "CurvedWorld_Material_Editor"
}
