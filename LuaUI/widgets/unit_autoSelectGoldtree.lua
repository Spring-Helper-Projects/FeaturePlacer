function widget:GetInfo()
	return {
		name		= "goldtree autoselect",
		desc		= "Selects and reselects goldtree if ever deselected",
		author	= "Funkencool",
		date		= "2013",
		license = "Public Domain",
		layer		= math.huge,
		enabled = true,
		handler = true,
	}
end
local goldtree = 0

function widget:UnitCreated(unitID)
	if goldtree == 0 then
		goldtree = unitID
		Spring.SelectUnitArray({goldtree})
	end
end

function widget:CommandsChanged()
	if not Spring.IsUnitSelected(goldtree) then Spring.SelectUnitArray({goldtree}) end
end