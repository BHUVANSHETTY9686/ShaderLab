Shader "Unlit/UnlitShader01"
{
    Properties
    {
        _Value ("Float Value", float) = 0.1
        _Color ("Color Plate",Color)=(1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            #include "UnityCG.cginc"



            float _Value;
            float4 _Color;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal:NORMAL;
            };

            struct FragmentValue
            {
                float4 vertex : SV_POSITION;
                float3 normals : TEXCOORD0;
            };


            FragmentValue vert (MeshData v)
            {
                FragmentValue o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normals=UnityObjectToWorldNormal(v.normal);
                return o;
            }

            float4 frag (FragmentValue i) : SV_Target
            {
                float4 norme=float4(i.normals,1);
                return norme;
            }
            ENDCG
        }
    }
}
