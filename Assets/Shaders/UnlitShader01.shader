Shader "Unlit/UnlitShader01"
{
    Properties
    {
        _ColorA("Color A",Color)=(1,1,1,1)
        _ColorB("Color B",Color)=(1,1,1,1)
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

            float4 _ColorA;
            float4 _ColorB;

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
                float2 uv:TEXTCOORD1;
            };


            FragmentValue vert (MeshData v)
            {
                FragmentValue o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.normals=UnityObjectToWorldNormal(v.normal);
                o.uv=v.uv;
                return o;
            }

            float4 frag (FragmentValue i) : SV_Target
            {
                float4 color=lerp(_ColorA,_ColorB,i.uv.x);
                return color;
            }
            ENDCG
        }
    }
}
