Shader "Custom/CustomLight"
{
	Properties
	{
		_Albedo("Albedo Color", Color) = (1, 1, 1, 1)
		_MainTex("Main Texture", 2D) = "white"{}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _Albedo;
		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb * 
				tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
}
