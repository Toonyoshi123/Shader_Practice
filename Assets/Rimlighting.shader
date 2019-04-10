Shader "Holistic/Rimlighting" {
	Properties {
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
		_RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
		_RimDiffuse("Diffuse Texture", 2D) = "white" {}
		_SliderRange("Stripe size", Range(1.0,10.0)) = 3.0
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
			float3 worldPos;
			float2 uv_RimDiffuse;
		};

		float4 _RimColor;
		float _RimPower;
		float _SliderRange;
		sampler2D _RimDiffuse;

		void surf (Input IN, inout SurfaceOutput o) {
			//half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Albedo = frac(IN.worldPos.y*_SliderRange*0.5) > 0.4 ? tex2D(_RimDiffuse, IN.uv_RimDiffuse).rgb: tex2D(_RimDiffuse, IN.uv_RimDiffuse).a*0;
			//o.Emission = _RimColor.rgb * pow(rim,_RimPower);
			//o.Emission = frac(IN.worldPos.y*10*0.5) > 0.4 ? float3(0,1,0)*rim: float3(1,0,0)*rim;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
