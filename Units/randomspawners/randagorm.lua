-- UNITDEF -- ZEONMINOVSKY --
--------------------------------------------------------------------------------

local unitName = "randagorm"

--------------------------------------------------------------------------------

local unitDef = {
  bmcode             = "0",
  buildCostEnergy    = 0,
  buildCostMetal     = 0,
  buildPic			 = "randagorm.png",
  description        = "Spawns a palm type feature",
  explodeAs          = "ELECTRIC_EXPLOSION",
  footprintX         = 1,
  footprintZ         = 1,
  levelGround		= false,
  maxslope			= 255,
  maxwaterdepth		= 255,
  maxDamage          = 1000,
  name               = "Spawns a palm type feature",
  objectName         = "features/agorm/palmfat1.s3o",
  power              = 1,
  reclaimable        = false,
  selfDestructAs     = "ELECTRIC_EXPLOSION",
  script		 	 = "default.cob",  
  shootme            = "1",
  unitname			 = unitName,
  yardMap            = "o o",
  customparams = {
	armortype			= "building",  
  	factionname		   = "randm",
  },
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
