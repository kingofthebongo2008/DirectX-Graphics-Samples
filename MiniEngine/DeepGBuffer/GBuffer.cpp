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
#include "pch.h"
#include "GBuffer.h"
#include "ColorBuffer.h"
#include "PipelineState.h"
#include "RootSignature.h"
#include "CommandContext.h"
#include "Camera.h"

using namespace Math;
using namespace Graphics;

namespace DeferredLighting
{
	ColorBuffer m_Diffuse;
	ColorBuffer m_Normal;
	ColorBuffer m_Specular;
}

void DeferredLighting::InitializeResources( void )
{
   
}

void DeferredLighting::Shutdown(void)
{
	m_Diffuse.Destroy();
	m_Normal.Destroy();
	m_Specular.Destroy();
}

void DeferredLighting::Direct(GraphicsContext& gfxContext, const Math::Camera& camera)
{
    ScopedTimer _prof(L"FillLightGrid", gfxContext);

    ComputeContext& Context = gfxContext.GetComputeContext();


    
}
