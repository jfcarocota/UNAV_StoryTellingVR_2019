Shader "Custom/CustomLight"
{
	Properties
	{
		_Albedo("Albedo Color", Color) = (1, 1, 1, 1)
		_MainTex("Main Texture", 2D) = "white"{}
		_BumpTex("Normal Map", 2D) = "bump"{}
		_BumpAmount("Normal level", Range(0.001, 2)) = 1
		_RimColor("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower("Rim Power", Range(0.1, 8.0)) = 1
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		float4 _Albedo;
		sampler2D _MainTex;
		sampler2D _BumpTex;
		float _BumpAmount;
		float4 _RimColor;
		float _RimPower;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Albedo.rgb * 
				tex2D(_MainTex, IN.uv_MainTex).rgb;
			float3 normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			normal.z = normal.z / _BumpAmount;
			o.Normal = normal;
			half rim = 1 - saturate(dot(IN.viewDir, o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
		}
		ENDCG
	}
}
