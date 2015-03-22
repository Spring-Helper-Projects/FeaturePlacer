local objectname= "0metal" 
local featureDef	=	{
	name			= "metal",
	world				="allworld",
	description				="Metal Patch",
	category				="Resource",
	object				="metal.s3o",
	footprintx				=4,
	footprintz				=4,
	height				=5,
	blocking				=false,
	hitdensity				=0,
	energy				=1,
	metal				=1,
	damage				=100,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=false,
	indestructible				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
