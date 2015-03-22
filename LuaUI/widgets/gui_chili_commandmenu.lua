function widget:GetInfo()
	return {
		name		= "FP commands",
		desc		= "Chili window for the state commands (spread, jitter, rotate)",
		author	= "Funkencool",
		date		= "2013",
		license = "GNU GPL v2",
		layer		= math.huge,
		enabled = true,
		handler = true,
	}
end
-- CONSTANTS
local MAXBUTTONSONROW = 7
local COMMANDSTOEXCLUDE = {"timewait","deathwait","squadwait","gatherwait","loadonto","nextmenu","prevmenu"}
local Chili
local debug = false

-- MEMBERS
local x
local y
local imageDir = 'LuaUI/Images/commands/'
local commandWindow
local updateRequired = true


-- SCRIPT FUNCTIONS
function LayoutHandler(xIcons, yIcons, cmdCount, commands)
	widgetHandler.commands   = commands
	widgetHandler.commands.n = cmdCount
	widgetHandler:CommandsChanged()
	local reParamsCmds = {}
	local customCmds = {}

	return "", xIcons, yIcons, {}, customCmds, {}, {}, {}, {}, reParamsCmds, {[1337]=9001}
end

function ClickFunc(chiliButton, x, y, button, mods) 
	local index = Spring.GetCmdDescIndex(chiliButton.cmdid)
	if (index) then
		local left, right = (button == 1), (button == 3)
		local alt, ctrl, meta, shift = mods.alt, mods.ctrl, mods.meta, mods.shift
		Spring.SetActiveCommand(index, button, left, right, alt, ctrl, meta, shift)
	end
end

-- Returns the caption, parent container and commandtype of the button	
function createMyButton(cmd)
	if(type(cmd) == 'table')then
		if (cmd.name == "fjitter" or cmd.name == "fspread" or cmd.name == "frotrand") then
			local indexChoice 		= cmd.params[1] + 2
			local buttontext      = cmd.params[indexChoice]
			local button = Chili.Button:New {
				parent      = commandWindow,
				width    = 140,
				height   = 40,
				backgroundColor  = {0,0,0,1},
				caption     = buttontext,
				cmdid       = cmd.id,
				OnMouseDown = {ClickFunc},
			}
		end
	end
end

function resetWindow(container)
	container:ClearChildren()
end

function loadPanel()
	resetWindow(commandWindow)
	local commands = Spring.GetActiveCmdDescs()
	for cmdid, cmd in pairs(commands) do
		rowcount = createMyButton(commands[cmdid]) 
	end
end

-- WIDGET CODE
function widget:Initialize()
	widgetHandler:ConfigLayoutHandler(LayoutHandler)
	Spring.ForceLayoutUpdate()
	
	if (not WG.Chili) then
		Spring.Echo("Needs chili")
		widgetHandler:RemoveWidget()
		return
	end

	Chili = WG.Chili
	local screen0 = Chili.Screen0
		
	commandWindow = Chili.TabBar:New{
		parent = screen0,
		right = '21.5%',
		y = 0,
		width = 120,
		height = "100%",	
		children = {},
	}
	
end


function widget:CommandsChanged()
	updateRequired = true
end

function widget:DrawScreen()
    if updateRequired then
      updateRequired = false
			loadPanel()
    end
end

function widget:Shutdown()
  widgetHandler:ConfigLayoutHandler(nil)
  Spring.ForceLayoutUpdate()
end