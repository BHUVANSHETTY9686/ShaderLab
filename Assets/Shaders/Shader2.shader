Shader "Custom/Shader2"
{
    Properties
    {
        // _Color ("Color", Color) = (1,1,1,1)
        // _MainTex ("Albedo (RGB)", 2D) = "white" {}
        // _Glossiness ("Smoothness", Range(0,1)) = 0.5
        // _Metallic ("Metallic", Range(0,1)) = 0.0

        _diffuseTexture ("Diffuse",2D)="white" {}
        _emissiveTexture ("Emissive",2D)="white" {}
        _normalTexture ("Normal", 2D)="bump" {}
        _normalMapSlider ("Slider",Range(1,5))=1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        // sampler2D _MainTex;

        sampler2D _diffuseTexture;
        sampler2D _emissiveTexture;
        sampler2D _normalTexture;
        half _normalMapSlider;
        struct Input
        {
             float2 uv_diffuseTexture;  // Corrected name
            float2 uv_emissiveTexture; // Corrected name
            float2 uv_normalTexture;
        };

        // half _Glossiness;
        // half _Metallic;
        // fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
          
             o.Albedo = tex2D(_diffuseTexture, IN.uv_diffuseTexture).rgb;
             o.Emission = tex2D(_emissiveTexture, IN.uv_emissiveTexture).rgb;
             o.Normal=UnpackNormal(tex2D(_normalTexture,IN.uv_normalTexture));
             o.Normal*=float3(_normalMapSlider,_normalMapSlider,1);
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
