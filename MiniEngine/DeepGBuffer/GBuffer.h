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
// Author(s):  Alex Nankervis
//             James Stanard
//

#pragma once

//using namespace Graphics;

#include <cstdint>

class StructuredBuffer;
class ByteAddressBuffer;
class ColorBuffer;
class GraphicsContext;
class Camera;

namespace Math
{
	class Vector3;
	class Matrix4;
	class Camera;
}


namespace DeferredLighting
{
    extern ColorBuffer m_Albedo;
    extern ColorBuffer m_Normal;
	extern ColorBuffer m_Specular;

    void InitializeResources(void);
	void Direct(GraphicsContext& gfxContext, const Math::Camera& camera);
    void Shutdown(void);
}
