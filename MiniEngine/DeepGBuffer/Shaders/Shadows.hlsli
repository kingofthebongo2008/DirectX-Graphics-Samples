#ifndef __shadows_hlsli__
#define __shadows_hlsli__

float GetShadow( float3 ShadowCoord, Texture2D<float> shadowBuffer, SamplerComparisonState samplerShadow, float texelSize)
{
#ifdef SINGLE_SAMPLE
    float result = shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy, ShadowCoord.z );
#else
    const float Dilation = 2.0;
    float d1 = Dilation * texelSize.x * 0.125;
    float d2 = Dilation * texelSize.x * 0.875;
    float d3 = Dilation * texelSize.x * 0.625;
    float d4 = Dilation * texelSize.x * 0.375;
    float result = (
        2.0 * shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy, ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2(-d2,  d1), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2(-d1, -d2), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2( d2, -d1), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2( d1,  d2), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2(-d4,  d3), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2(-d3, -d4), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2( d4, -d3), ShadowCoord.z ) +
		shadowBuffer.SampleCmpLevelZero(samplerShadow, ShadowCoord.xy + float2( d3,  d4), ShadowCoord.z )
        ) / 10.0;
#endif
    return result * result;
}

#endif