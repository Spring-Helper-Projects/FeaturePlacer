--http://springrts.com/wiki/Modinfo.lua
local modinfo = {
	name = "Feature Placer -",
	shortname = "FP",
	game = "FP",
	shortgame = "FP",
	description = "Featureplacer Module for Mappers",
	url = "https://code.google.com/p/feature-placer/",
	version = "$VERSION", --when zipping .sdz for releasing make this a full integer like 1,2,3
	modtype = 1,
	depend = {
		"cursors.sdz",
	}
}
return modinfo