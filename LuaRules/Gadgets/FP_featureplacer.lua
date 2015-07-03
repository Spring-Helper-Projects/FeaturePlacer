function gadget:GetInfo()
	return {
		name      = "feature placer",
		desc      = "Spawns Features and Units",
		author    = "Gnome, Smoth",
		date      = "August 2008",
		license   = "PD",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

if (not gadgetHandler:IsSyncedCode()) then
  return false
end

local	SetUnitNeutral			= Spring.SetUnitNeutral
local	SetUnitBlocking			= Spring.SetUnitBlocking
local   SetUnitRotation 		= Spring.SetUnitRotation
local	SetUnitAlwaysVisible	= Spring.SetUnitAlwaysVisible
local	CreateUnit				= Spring.CreateUnit
local	CreateFeature			= Spring.CreateFeature
local 	SetMetalAmount			= Spring.SetMetalAmount
local 	GetGroundHeight			= Spring.GetGroundHeight

local	featurecfg 
local	featureslist	= {}
local	buildinglist	= {}
local	unitlist		= {}	
local 	metalspots		= {}


if VFS.FileExists("config/EVOconfig.lua") then
	featurecfg = VFS.Include("config/EVOconfig.lua")

	featureslist	= featurecfg.objectlist
	buildinglist	= featurecfg.buildinglist
	unitlist	= featurecfg.unitlist
	metalspots   	= featurecfg.metalspots
else
	Spring.Echo("No evo specific features loaded")
end 
		

if ( featurecfg ~= nil ) then
	local gaiaID = Spring.GetGaiaTeamID()
		
	if ( featureslist )	then
		for i,fDef in pairs(featureslist) do
			local flagID = CreateFeature(fDef.name, fDef.x, Spring.GetGroundHeight(fDef.x,fDef.z)+5, fDef.z, fDef.rot)
		end
	end
				
	if ( unitlist )	then	
		for i,uDef in pairs(unitlist) do
			local flagID = CreateUnit(uDef.name, uDef.x, 0, uDef.z, 0, gaiaID)
			SetUnitRotation(flagID, 0, -uDef.rot * math.pi / 32768, 0)
			SetUnitNeutral(flagID,true)
			Spring.SetUnitLosState(flagID,0,{los=true, prevLos=true, contRadar=true, radar=true})
			SetUnitAlwaysVisible(flagID,true)
			SetUnitBlocking(flagID,true)
		end
	end
				
	if ( buildinglist )	then
		for i,bDef in pairs(buildinglist) do
			local flagID = CreateUnit(bDef.name, bDef.x, 0, bDef.z, bDef.rot, gaiaID)
			SetUnitNeutral(flagID,true)
			Spring.SetUnitLosState(flagID,0,{los=true, prevLos=true, contRadar=true, radar=true})
			SetUnitAlwaysVisible(flagID,true)
			SetUnitBlocking(flagID,true)
		end
	end
	
	if ( metalspots ) then
		for i,mDef in pairs(metalspots) do
			SetMetalAmount( mDef.x/16, mDef.z/16, mDef.amt)
		end
	end

end	
