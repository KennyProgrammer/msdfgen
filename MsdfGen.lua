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
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Obj")

	files {
		"include/**.h",
		"include/**.hpp",
		"include/**.cpp"
	}

	includedirs {
		"include",
		"freetype/include",
	}

	local DefinesList = {}
	local LinksList   = {}

	if Libraries["FreeType"] then
		table.insert(LinksList,   "FreeType")
		table.insert(DefinesList, "FE_LIBRARY_FREETYPE")
	end

	table.insert(DefinesList, "MSDFGEN_USE_CPP11")

	defines {
		DefinesList
	}

	links {
		LinksList
	}

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"