Shader "Custom/CustomLight"
{
	Properties
	{
		_Albedo("Albedo Color", Color) = (1, 1, 1, 1)
		_MainTex("Main Texture", 2D) = "white"{}
		_BumpTex("Normal Map", 2D) = "bump"{}
		_BumpAmount("Normal level", Range(0.001, 2)) = 1
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _Albedo;
		sampler2D _MainTex;
		sampler2D _BumpTex;
		float _BumpAmount;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb * 
				tex2D(_MainTex, IN.uv_MainTex).rgb;
			float3 normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			normal.z = normal.z / _BumpAmount;
			o.Normal = normal;
		}
		ENDCG
	}
}
