local options= {
	{
		key="comm",
		name="Game Mode",
		desc="Choose the type of game",
		type="list",
		def="feature",
		items = {
			{ key = "feature", name = "Feature Placer", desc = "Not for gameplay, used for map development." }
			--{ key = "con", name = "Standard Constructor", desc = "A regular T1 construction unit" }
		},
	},
}

return options