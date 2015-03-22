function widget:GetInfo()
	return {
		name      = "Dump all units/features into set.lua",
		desc      = "Writes the coordinates for all units and features to set.lua",
		author    = "Gnome, smoth",
		date      = "lol",
		license   = "PD",
		layer     = math.huge,
		enabled   = true  --  loaded by default?
	}
end



local rotlookup = {}

 rotlookup[0]		= "south" 
 rotlookup[16384]	= "east"
 rotlookup[32767]	= "north"
 rotlookup[-16384]	= "west"


function widget:Initialize()
		local Chili = WG.Chili
		local screen0 = Chili.Screen0		

		local window0 = Chili.Button:New{
		x = '67%',
		y = '92%',	
		dockable = false,
		parent = screen0,
		caption = "Dump set.lua",
		width = '10%',
		height = '8%',
		backgroundColor = {0,0,0,1},
		OnMouseDown = {dumpUnits},
	}
end
	

function dumpUnits()
	local allunits = Spring.GetAllUnits()
	local x, y, z	
	local dx, dy, dz	
	local rot
	local toUDump = {}
	local toBDump = {}
	local toFDump = {}

	for _,ud in ipairs(allunits) do
	
		x,y,z			= Spring.GetUnitBasePosition(ud)
		udid			= Spring.GetUnitDefID(ud)
		rot				= Spring.GetUnitHeading(ud)	
		
		unitname		= UnitDefs[udid].name
		
		if ( UnitDefs[udid].customParams.featureplacer ~= true ) then
		
			if ( UnitDefs[udid].canMove ) then		
				toUDump[#toUDump + 1]	= { name = unitname, x = x, z = z, rot = rot }
			else -- I am not a unit				
				toBDump[#toBDump + 1]	= { name = unitname, x = x, z = z, rot = rotlookup[rot] }
			end
		end
	end
	
	local allfeatures = Spring.GetAllFeatures()
	for _,fd in ipairs(allfeatures) do
		
		x,y,z 			= Spring.GetFeaturePosition(fd)
		rot				= Spring.GetFeatureHeading(fd)		
		fdid 			= Spring.GetFeatureDefID(fd)
		fname 			= FeatureDefs[fdid].name
		toFDump[#toFDump + 1] 	= { name = fname, x = x, z = z, rot = rot }
	end
	
	local mapname = Game.mapName
	local f = io.open("maps/" .. mapname .. "_Set.lua", "w+")
	if (f) then
		--f:write("xIcons " .. iconsX .. "\n")
		f:write("--Rename to set.lua if used in blueprint\n\n")
		
		f:write("local features = { \n\tunitlist = {\n")
		for i=1,#toUDump do
			if toUDump[i].name ~= 'goldtree' then
				f:write("\t\t{ name = '" .. toUDump[i].name .. "'\t,x = " .. toUDump[i].x .. "\t,z = " .. toUDump[i].z ..  "\t,rot = " .. toUDump[i].rot .." },\n")
			end
		end
		f:write("\t},\n")
		
		f:write("\tbuildinglist = {\n")
		for i=1,#toBDump do
			f:write("\t\t{ name = '" .. toBDump[i].name .. "'\t,x = " .. toBDump[i].x .. "\t,z = " .. toBDump[i].z ..  "\t,rot = \"" .. toBDump[i].rot .."\" },\n")
		end
		f:write("\t},\n")
		
		f:write("\tobjectlist = {\n")
		for i=1,#toFDump do
			if toFDump[i].name ~= '0metal' then
				f:write("\t\t{ name = '" .. toFDump[i].name .. "'\t,x = " .. toFDump[i].x .. "\t,z = " .. toFDump[i].z .. "\t,rot = \"" .. toFDump[i].rot .."\" },\n")
			end
		end
		f:write("\t},\n")
		
		f:write("\tmetalspots = {\n")
		for i=1,#toFDump do
			if toFDump[i].name == '0metal' then
				f:write("\t\t{ x = " .. toFDump[i].x .. "\t,z = " .. toFDump[i].z .. "\t,amt = 200 },\n")
			end
		end
		f:write("\t},\n}\nreturn features\n")
		
		f:close()
		Spring.Echo("\n")
		Spring.Echo("Features have been written to: \"<spring content directory>/maps/" .. mapname .. "_Set.lua\"")
		Spring.Echo("In windows the default content directory is located in \"my documents/my games/spring\"")
		Spring.Echo("In *nix the default content directory is located in \"~/.spring\"")
	else
		Spring.Echo("Could not open set.lua for writing!")
	end
end