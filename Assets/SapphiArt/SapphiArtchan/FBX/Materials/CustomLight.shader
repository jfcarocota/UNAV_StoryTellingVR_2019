Shader "Custom/CustomLight"
{
	Properties
	{
		_Albedo("Albedo Color", Color) = (1, 1, 1, 1)
	}

		SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _Albedo;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb;
		}
		ENDCG
	}
}
