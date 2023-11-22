--
-- Main Premake5 file for building MsdfGen project.
-- Copyright (c) 2023 by Danil (Kenny) Dukhovenko, All rights reserved.
--
-- Requirement:
--  - ForceEngine.lua
--  - FreeType.lua
--

include "FreeType.lua"

-- MsdfGen C++ Project
project "MsdfGen"
	kind          "StaticLib"
	language      "C++"
	cppdialect    "C++17"
	staticruntime "on"
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/obj")

	files {
		"core/**.h",
		"core/**.hpp",
		"core/**.cpp",
		"ext/**.h",
		"ext/**.hpp",
		"ext/**.cpp",
		"lib/**.cpp",
		"include/**.h"
	}

	includedirs {
		"include",
		"freetype/include"
	}

	links   = {}
	defines = {}

	if LinkLibrary["FreeType"] then
		table.insert(links,   "FreeType")
		table.insert(defines, "FE_LIBRARY_FREETYPE")
	end

	table.insert(defines, "MSDFGEN_USE_CPP11")

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"