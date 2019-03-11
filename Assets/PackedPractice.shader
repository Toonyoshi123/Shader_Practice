Shader "Holistic/FullShader" {

	Properties {
		_myDifTex ("Diffuse Texture", 2D) = "white" {}
		_myEmTex ("Emissive Texture", 2D) = "white" {}
		_myNormTex ("Normal Texture", 2D) = "bump" {}
		_myRange ("Example Range", Range(0,10)) = 1
		_myBright ("Brightness", Range(0,10)) = 1

	}

	Subshader {
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input {
				float2 uv_myDifTex;
				float2 uv_myEmTex;
				float2 uv_myNormTex;
			};

			sampler2D _myDifTex;
			sampler2D _myEmTex;
			sampler2D _myNormTex;
			half _myRange;
			half _myBright;

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_myDifTex, IN.uv_myDifTex).rgb;
				o.Emission = tex2D(_myEmTex, IN.uv_myEmTex).rgb;
				o.Normal = UnpackNormal(tex2D(_myNormTex, IN.uv_myNormTex)) * _myBright;
				o.Normal *= float3(_myRange,_myRange,1);
			}

		ENDCG
	}

	Fallback "Diffuse"
}