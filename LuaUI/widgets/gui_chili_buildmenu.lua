function widget:GetInfo()
	return {
		name		= "Feature window",
		desc		= "Contains all the features",
		author		= "Sunspot, Funkencool",
		date		= "2011, 2013",
		license     = "GNU GPL v2",
		layer		= math.huge,
		enabled   	= true,
		handler		= true,
	}
end

-- CONSTANTS
local MAXBUTTONSONROW = 5
local COMMANDSTOEXCLUDE = {"timewait","deathwait","squadwait","gatherwait","loadonto","nextmenu","prevmenu"}
local Chili
local screen0
local debug = false

-- MEMBERS
local x
local y
local imageDir = 'LuaUI/Images/commands/'
local commandWindow
local stateCommandWindow
local buildCommandWindow
local updateRequired = true

-- CONTROLS
local spGetActiveCommand 	= Spring.GetActiveCommand
local spGetActiveCmdDesc 	= Spring.GetActiveCmdDesc
local spGetSelectedUnits    = Spring.GetSelectedUnits
local spSendCommands        = Spring.SendCommands


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

		if DEBUG then Spring.Echo("active command set to ", chiliButton.cmdid) end
		Spring.SetActiveCommand(index, button, left, right, alt, ctrl, meta, shift)
	end
end


function createMyButton(cmd)
	if(type(cmd) == 'table')then
		local buttontext = ""
		if (cmd.id < 0) then
			local texture = '#'..-cmd.id
			local result = buildCommandWindow.xstep % MAXBUTTONSONROW
			buildCommandWindow.xstep = buildCommandWindow.xstep + 1
			local increaseRow = false
			if(result==0)then
				result 		= MAXBUTTONSONROW
				increaseRow = true
			end	
			
			local color  = {0,0,0,1}
			local button = Chili.Button:New {
				parent      = buildCommandWindow,
				x           = screen0.width * .04 * (result-1),
				y           = screen0.width * .04 * (buildCommandWindow.ystep-1),
				padding     = {0, 0, 0, 0},
				margin      = {0, 0, 0, 0},
				width    	= screen0.width * .04,
				height   	= screen0.width * .04,
				caption     = buttontext,
				isDisabled  = false,
				cmdid       = cmd.id,
				OnMouseDown = {ClickFunc},		
			}
			
			if texture then
				image = Chili.Image:New {
					width     	='90%',
					x			='5%',
					height    	='90%',
					y 			='5%',
					file      	= texture,
					parent    	= button,
				}		
			end
			if(increaseRow)then
				buildCommandWindow.ystep = buildCommandWindow.ystep+1
			end	
		end
	end
end



function loadPanel()
	if (buildCommandWindow.xstep == 1) then
		local commands = Spring.GetActiveCmdDescs()
		for cmdid, cmd in pairs(commands) do
			local rowcount = createMyButton(commands[cmdid]) 
		end
	end
end

-- WIDGET CODE
function widget:Initialize()
	spSendCommands("resbar 0")
	spSendCommands("info 0")
	widgetHandler:ConfigLayoutHandler(LayoutHandler)
	Spring.ForceLayoutUpdate()
	
	if (not WG.Chili) then
		widgetHandler:RemoveWidget()
		return
	end

	Chili = WG.Chili
	screen0 = Chili.Screen0
		

	buildCommandWindow = Chili.ScrollPanel:New{
		parent = screen0,
		right = 0,
		y = 0,	
		width = screen0.width * 0.215,
		height = '100%',
		xstep = 1,
		ystep = 1,
		scrollbarSize = 20,
		scrollPosX    = 0,
		scrollPosY    = 100,
	}		
	
end

function widget:CommandsChanged()
	if DEBUG then Spring.Echo("commandChanged called") end
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
	spSendCommands("info 1")
	spSendCommands("resbar 1")
end