Shader "Holistic/CustomStandard"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		_Emissive ("Emission", Range(0.0,10.0)) = 1.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        #pragma surface surf Standard

        sampler2D _MetallicTex;

        struct Input
        {
            float2 uv_MetallicTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
		half _Emission;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			o.Albedo = _Color.rgb;
			o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
			o.Metallic = _Metallic;
			o.Emission = tex2D(_MetallicTex, IN.uv_MetallicTex).r * _Emission;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
