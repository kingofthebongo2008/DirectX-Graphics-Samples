#ifndef __color_hlsli__


typedef float3 color_rec_709;
typedef float3 color_rec_709_gamma;
typedef float3 color_rec_709_srgb_gamma;

typedef float3 color_rec_2020;
typedef float3 color_rec_2020_gamma;

typedef float3 color_dci_p3;
typedef float3 color_dci_p3_gamma;

typedef float3 color_XYZ;


//reference functions, source wikipedia
color_rec_709_srgb_gamma color_eotf_srgb( color_rec_709 v )
{
    float  threshold        = 0.0031308;
    float  a                = 0.055;
    float3 a0               = 12.92 * v;
    float3 a1               = (1.0 + a) * pow( abs(v), 1.0 / 2.4 ) - a;
    return v <= threshold ? a0 : a1;
}

color_rec_709 color_oetf_srgb( color_rec_709_srgb_gamma v )
{
    float  threshold = 0.04045;
    float  a         = 0.055;    
    float3 a0 = v / 12.92;
    float3 a1 = pow( abs( ( (v + a) / (1 + a) ) ) , 2.4);

    return v <= threshold ? a0 : a1;
}


#endif
