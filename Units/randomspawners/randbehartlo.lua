-- UNITDEF -- ZEONMINOVSKY --
--------------------------------------------------------------------------------

local unitName = "randbehartlo"

--------------------------------------------------------------------------------

local unitDef = {
  bmcode             = "0",
  buildCostEnergy    = 0,
  buildCostMetal     = 0,
  buildPic			 = "randbeheartlo.png",
  corpse             = "",
  description        = "Spawns a random artturi or beherith tree type feature",
  explodeAs          = "ELECTRIC_EXPLOSION",
  footprintX         = 1,
  footprintZ         = 1,
  levelGround		= false,
  maxslope			= 255,
  maxwaterdepth		= 255,
  maxDamage          = 1000,
  name               = "Spawns a random artturi or beherith tree type feature",
  objectName         = "features/artturi/artBirchMediumLo.s3o",
  power              = 1,
  reclaimable        = false,
  selfDestructAs     = "ELECTRIC_EXPLOSION",
  script		 	 = "default.cob",  
  shootme            = "1",
  unitname			 = unitName,
  yardMap            = "o o",
  customparams = {
  	factionname		   = "randm",
  },
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
