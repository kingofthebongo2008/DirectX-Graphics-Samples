//
// Copyright (c) Microsoft. All rights reserved.
// This code is licensed under the MIT License (MIT).
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
//
// Developed by Minigraph
//
// Author(s):    James Stanard
//                Alex Nankervis
//
// Thanks to Michal Drobot for his feedback.

#include "ModelViewerRS.hlsli"
#include "LightGrid.hlsli"

// outdated warning about for-loop variable scope
#pragma warning (disable: 3078)
// single-iteration loop
#pragma warning (disable: 3557)

struct VSOutput
{
    sample float4 position	: SV_Position;
    sample float2 uv		: TexCoord0;
    sample float3 normal	: Normal;
    sample float3 tangent	: Tangent;
    sample float3 bitangent : Bitangent;
};

struct PSOutput
{
	float4 attributes0 : SV_Target0;
	float4 attributes1 : SV_Target1;
	float4 attributes2 : SV_Target2;
};

Texture2D<float4> texDiffuse	: register(t0);
Texture2D<float3> texSpecular   : register(t1);
Texture2D<float3> texNormal     : register(t3);
SamplerState sampler0			: register(s0);

void AntiAliasSpecular( inout float3 texNormal, inout float gloss )
{
    float normalLenSq = dot(texNormal, texNormal);
    float invNormalLen = rsqrt(normalLenSq);
    texNormal *= invNormalLen;
    gloss = lerp(1, gloss, rcp(invNormalLen));
}

[RootSignature(ModelViewer_RootSig)]
PSOutput main(VSOutput vsOutput)
{
	float4 sampleAlbedo  = texDiffuse.Sample(sampler0, vsOutput.uv);
	float3 diffuseAlbedo = sampleAlbedo.rgb;
	float gloss = 128.0;

	if (sampleAlbedo.a < 0.5)
		discard;

	float3 normal;
	{
		normal = texNormal.Sample(sampler0, vsOutput.uv) * 2.0 - 1.0;
		AntiAliasSpecular(normal, gloss);
		float3x3 tbn = float3x3(normalize(vsOutput.tangent), normalize(vsOutput.bitangent), normalize(vsOutput.normal));
		normal = normalize(mul(normal, tbn));
	}

	float specularMask = texSpecular.Sample(sampler0, vsOutput.uv).g;

	//specularMask, gloss, normal, albedo

	PSOutput r = (PSOutput)0;

	r.attributes0 = float4(diffuseAlbedo, 1);
	r.attributes1 = float4(normal * 0.5 + 0.5, 1);
	r.attributes2 = float4(specularMask, gloss, 1, 1);

	return r;
}
