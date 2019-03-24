Shader "Custom/CustomLight"
{
	Properties
	{
		_Albedo("Albedo Color", Color) = (1, 1, 1, 1)
		_MainTex("Main Texture", 2D) = "white"{}
		_BumpTex("Normal Map", 2D) = "bump"{}
		_BumpAmount("Normal level", Range(0.001, 2)) = 1
		_RimColor("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower("Rim Power", Range(0.001, 12.0)) = 1
		_RampTex("Ramp Texture", 2D) = "white"{}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Toon

		float4 _Albedo;
		sampler2D _MainTex;
		sampler2D _BumpTex;
		sampler2D _RampTex;
		float _BumpAmount;
		float4 _RimColor;
		float _RimPower;

		/*half4 LightingBasicLambert(SurfaceOutput s, half lightDir, half atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * NdotL * atten;
			c.a = s.Alpha;
			return c;
		}*/

		half4 LightingToon(SurfaceOutput s, half lightDir, half atten)
		{
			half diff = dot(s.Normal, lightDir);//Lambert
			float uv = (diff * 0.5) + 0.5;
			float3 ramp = tex2D(_RampTex, uv).rgb;
			float4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * ramp;
			c.a = s.Alpha;
			return c;
		}

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
