_G.License = "f62095ee-d4d5-4b7a-8528-d00f608e0a65"

type Plan = "Standard" | "Neo" | nil
type User = {
	instance: Player,
	key: string,
	plan: Plan,
}
type Command = {
	aliases: { string },
	description: string,
	run: (args: { any }) -> (),
	requiredPlan: "Standard" | "Neo",
}
type Commands = {
	[string]: Command,
}

local database: { [number]: { key: string, plan: Plan } } = {
	[1317503926] = { key = "f62095ee-d4d5-4b7a-8528-d00f608e0a65", plan = "Neo" },
	[191308004] = { key = "d9046def-bfd4-402a-a2e4-0aa63c7bc7d9", plan = "Neo" },
}

local enviroment = {
	CoreGui = game:GetService("CoreGui"),
	StarterGui = game:GetService("StarterGui"),
	Workspace = game:GetService("Workspace"),
	Lighting = game:GetService("Lighting"),
	Players = game:GetService("Players"),
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	HttpService = game:GetService("HttpService"),
	RunService = game:GetService("RunService"),
	TweenService = game:GetService("TweenService"),
	UserInputService = game:GetService("UserInputService"),
}

local events = {
	StatAPI = enviroment.ReplicatedStorage:WaitForChild("StatAPI"),
	WorkspaceAPI = enviroment.ReplicatedStorage:WaitForChild("WorkspaceAPI")
}

local function getUser(player: Player, key: string): User
	local data = database[player.UserId]
	if not data then
		return {
			instance = nil,
			key = nil,
			plan = nil,
		}
	end
	if data.key ~= key then
		return {
			instance = nil,
			key = nil,
			plan = nil,
		}
	end
	return {
		instance = player,
		key = data.key,
		plan = data.plan,
	}
end

local notify = function(Text: string)
	enviroment.StarterGui:SetCore("SendNotification", {
    	Title = "Softlocked V1.0",
    	Text = Text,
    	Duration = 7
	})

	local sound = Instance.new("Sound", enviroment.CoreGui)
	sound.SoundId = "rbxassetid://3450794184"
	sound.Volume = 1
	sound:Play()
end

local plr: Player = enviroment.Players.LocalPlayer
local user: User = getUser(plr, _G.License)

if user.plan == nil then
	notify("Invalid Key!")
	return
end

--[[local char = plr.Character
local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")]]

local Noclip = nil
local Clip = nil

local function noclip()
	local char = plr.Character

	Clip = false
	local function Nocl()
		if Clip == false and char ~= nil then
			for i, v in pairs(char:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
				end
			end
		end
	end
	Noclip = enviroment.RunService.Stepped:Connect(Nocl)
end

local clip = function()
	if Noclip then
		Noclip:Disconnect()
	end
	Clip = true
end

local Mods = {
    1969561115, -- SocialCreditTester
    8336650773, -- LetsParty_Staff
    51412923,   -- fallen
    442532766,  -- JDG
    1060165990, -- pufflecats
    867772557,  -- bob
    91716037,   -- anubis
    107495120,  -- ledrtroll
    84322362,   -- ohman
    120957544,  -- zynches
    77757985,   -- bluedogz
    75089864,   -- PatrykZPZ
    127029308,  -- LetsParty_Pro
    60639506,   -- orinrino
    110175890,  -- FoxBin
    4255442393, -- pufflecats alt
    3353304684, -- pufflecats alt
    201937123,  -- LetsParty_MOD
    72433682,   -- masterhalo
    94360439,   -- DjSquidey
    201061673,  -- KorZero
    126105491,  -- Zack_NQuack
    329063274,  -- Vanitaws
    118822846,  -- ledrtroll alt
    2489360616, -- LetsParty_puffle
    85871775,   -- gamerforeverisangel
    108679763,  -- masato
    6268962,    -- Manchenzo
    161241750,  -- unknown account just in case
    3360693,    -- fallen alt
    2037259178, -- fallen alt
    1418089498, -- fallen alt
}

local function isMod(userId)
    for _, id in ipairs(Mods) do
        if userId == id then
            return true
        end
    end
    return false
end

local function checkForMods()
    for _, player in ipairs(enviroment.Players:GetPlayers()) do
        if isMod(player.UserId) then
            notify("⚠️ MOD DETECTED: " .. player.Name)
        end
    end
end

checkForMods()

enviroment.Players.PlayerAdded:Connect(function(player)
    if isMod(player.UserId) then
        notify("⚠️ MOD JOINED: " .. player.Name)
    end
end)

local f3x = {}

local HumanToInternal = {
	["RecolorHandle"] = "VSyJoGy4XA23",
	["Clone"] = "JUgZNEWGGdWu",
	["CreatePart"] = "ztyCETNySL1Y",
	["Remove"] = "bwQ1YR25XRpc",
	["UndoRemove"] = "euq28hgFDHqS",
	["SyncMove"] = "eysFEmrS4f94",
	["SyncResize"] = "ewdgAalIUk47",
	["SyncRotate"] = "2dxh0G8RBA35",
	["SyncColor"] = "aGBcjBm2jh21",
	["SyncSurface"] = "nCV90LPVwSR2",
	["CreateLights"] = "Tqtsy2IOruAY",
	["SyncLighting"] = "GNLqGAadViXu",
	["CreateDecorations"] = "5IbqCcBiVsrp",
	["SyncDecorate"] = "hg3vP4YsnaPD",
	["CreateMeshes"] = "JgsKqcLctEW7",
	["SyncMesh"] = "LbALt5VLjJYq",
	["CreateTextures"] = "qqSNCtPwOMMD",
	["SyncTexture"] = "de1wvqp5o4ZZ",
	["SyncAnchor"] = "VA4fHFfNXnne",
	["SyncCollision"] = "LwGYa30PF5Ln",
	["SyncMaterial"] = "pIAugi8tzJG1",
	["CreateWelds"] = "ZlxQn1bV2N6X",
	["RemoveWelds"] = "r5fxU6bTHCs7",
	["UndoRemovedWelds"] = "gHWAqmW4rrdf",
	["Export"] = "FhSmexBUCA9z",
	["IsHttpServiceEnabled"] = "KSADIoS26VSc",
	["ExtractMeshFromAsset"] = "eIFftOlVfqmK",
	["ExtractImageFromDecal"] = "YKH0WrPikvu5",
	["SetMouseLockEnabled"] = "rkiLyoOOLOfS",
}

local function getRemote()
    local Players = game:GetService("Players")
    local pl = Players.LocalPlayer
    local char = pl and (pl.Character or pl.CharacterAdded:Wait())
    if not char then return nil end

    local function findRemote(folder)
        if not folder then return nil end
        local bf = folder:FindFirstChildOfClass("BindableFunction")
        if bf then
            local rf = bf:FindFirstChildOfClass("RemoteFunction")
            if rf then return rf end
        end
        for _, v in pairs(folder:GetDescendants()) do
            if v:IsA("RemoteFunction") then return v end
        end
        return nil
    end

    local folder = char:FindFirstChild("F3X")
    local rf = findRemote(folder)
    if rf then return rf end

    local backpack = pl:FindFirstChild("Backpack")
    if backpack then
        local tool = backpack:FindFirstChild("F3X")
        if tool then
            tool.Parent = char
            rf = findRemote(tool)
            if rf then return rf end
        end
    end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("RemoteFunction") then return v end
    end

    return nil
end

local function unequipF3X()
    local pl = game:GetService("Players").LocalPlayer
    local char = pl and (pl.Character or pl.CharacterAdded:Wait())
    if not char then return end
    local backpack = pl:FindFirstChild("Backpack")
    if not backpack then return end

    local tool = char:FindFirstChild("F3X")
    if tool and tool:IsA("Tool") then
        tool.Parent = backpack
    end
end

local function shiftString(s, shift)
	local out = {}
	for _, code in utf8.codes(s) do
		table.insert(out, utf8.char(code + shift))
	end
	return table.concat(out)
end

local function encryptArgs(argsTbl)
	local pl = game:GetService("Players").LocalPlayer
	local shift = (pl and pl.AccountAge or 0) + 2
	local first = argsTbl[1]
	local internal = HumanToInternal[first] or first
	if type(internal) == "string" then
		argsTbl[1] = shiftString(internal, shift)
	end
	return argsTbl
end

function f3x.Invoke(args)
	local rf = getRemote()
	if not rf then return nil end
	local ok, res = pcall(function()
		return rf:InvokeServer(table.unpack(encryptArgs(args)))
	end)
	if ok then return res end
	return nil
end

function f3x.Export(instances)
	return f3x.Invoke({"Export", instances})
end

function f3x.GrabSelectedParts()
	local sel = {}
	for _, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v.Name == "BTSelectionBox" and v.Adornee then
			table.insert(sel, v.Adornee)
		end
	end
	return sel
end

function f3x.RecolorHandle(brickcolor)
	return f3x.Invoke({"RecolorHandle", brickcolor})
end

function f3x.EditProperties(Part, Props)
	local PropData = {}
	for i, v in next, Props do
		PropData[tostring(i) .. "0"] = v
	end
	return f3x.Invoke({"SyncSurface", {{Part = Part, Surfaces = PropData}}})
end

function f3x.Clone(instances, parent)
	return f3x.Invoke({"Clone", instances, parent})
end

function f3x.CreatePart(shape, parent)
	local newPart = f3x.Invoke({"CreatePart", tostring(shape), CFrame.new(0, 0, 0), parent})
	if newPart then
		f3x.EditProperties(newPart, {["Parent"] = parent})
		return newPart
	end
	return nil
end

function f3x.SetParent(instance, parent)
	return f3x.EditProperties(instance, {["Parent"] = parent})
end

function f3x.SetName(instance, name)
	return f3x.EditProperties(instance, {["Name"] = name})
end

function f3x.Remove(instance)
	return f3x.Invoke({"UndoRemove", instance})
end

function f3x.Moveto(instance, cframe)
	return f3x.EditProperties(instance, {["CFrame"] = cframe})
end

function f3x.Resizeto(instance, vector3)
	return f3x.EditProperties(instance, {["Size"] = vector3})
end

function f3x.Rotateto(instance, vector3)
	return f3x.EditProperties(instance, {["Rotation"] = vector3})
end

function f3x.Color(instance, color3)
	return f3x.EditProperties(instance, {["Color"] = color3})
end

function f3x.ColorInstances(tbl)
	return f3x.Invoke({"SyncColor", tbl})
end

function f3x.AddLight(instance)
	return f3x.Invoke({"CreateLights", instance})
end

function f3x.ChangeLights(instance, _type, value)
	if _type == "Range" then
		return f3x.EditProperties(instance, {["Range"] = value})
	elseif _type == "Brightness" then
		return f3x.EditProperties(instance, {["Brightness"] = value})
	elseif _type == "Color" then
		return f3x.EditProperties(instance, {["Color"] = value})
	elseif _type == "Shadows" then
		return f3x.EditProperties(instance, {["Shadows"] = value})
	elseif _type == "Face" then
		return f3x.EditProperties(instance, {["Face"] = value})
	elseif _type == "Angle" then
		return f3x.EditProperties(instance, {["Angle"] = value})
	end
	return nil
end

function f3x.CreateMeshes(instance)
	return f3x.Invoke({"CreateMeshes", instance})
end

local allCommands: Commands = {
	["f3x"] = {
		aliases = { "f", "btools" },
		description = "Gives you the ingame Building Tools",
		requiredPlan = "Standard",
		run = function(args: { any })
			--[[do
				local char = plr.Character
				local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
				local F3XSpawnPad = nil
				local SafePlate = enviroment.Workspace:FindFirstChild("SafePlate")
				

				for i, v in pairs(SafePlate.Mesh.Value:GetChildren()) do
					if v.Bricks:FindFirstChild("Bar") then
						F3XSpawnPad = v
					end
				end

				for i, v in pairs({ Backpack, char }) do
					if v:FindFirstChild("F3X") then
						notify("You already have F3X!")
						return
					end
				end

				if F3XSpawnPad == nil or SafePlate == nil then
					notify("The f3x giver is gone (searching for traces of f3x...)")
					for i, v in pairs(enviroment.Workspace:GetDescendants()) do
						if
							v:IsA("Tool")
							and v.Name == "F3X"
							and v:FindFirstChild("Handle")
							and not v.Parent:FindFirstChild("Humanoid")
						then
							v.Handle.CFrame = HumanoidRootPart.CFrame
							notify("F3X Grab Success!")
							return
						end
					end
					notify("No traces of F3X!")
				end

				noclip()
				local prevcframe = HumanoidRootPart.CFrame

				while task.wait() do
					for i, v in pairs(Backpack:GetChildren()) do
						if v:FindFirstChild("F3X") then
							return
						end
					end

					HumanoidRootPart.CFrame = CFrame.new(9.5, 3.954, -115.698)
				end

				HumanoidRootPart.CFrame = prevcframe
				notify("F3X Grab Success!")
				clip()
			end]]

			do
				local Backpack = plr:FindFirstChild("Backpack")

				local char = plr.Character
				if not char then
					notify("Character not loaded yet!")
					return
				end
				local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
				if not HumanoidRootPart then
					notify("HumanoidRootPart not found!")
					return
				end

				local function hasF3X()
    				if Backpack:FindFirstChild("F3X") or char:FindFirstChild("F3X") then
   			     		return true
    				end
    				return false
				end


				if hasF3X() then
					notify("You already have F3X!")
					return
				end

				local F3XSpawnPad = nil
				local SafePlate = enviroment.Workspace:FindFirstChild("SafePlate")
				if SafePlate then
					for _, v in pairs(SafePlate.Mesh.Value:GetChildren()) do
						if v.Bricks:FindFirstChild("Bar") then
							F3XSpawnPad = v
							break
						end
					end
				end

				if not F3XSpawnPad then
					notify("The f3x giver is gone (searching for traces of F3X...)")
					for _, v in pairs(enviroment.Workspace:GetDescendants()) do
						if v:IsA("Tool") and v.Name == "F3X" and v:FindFirstChild("Handle") and not v.Parent:FindFirstChild("Humanoid") then
							v.Handle.CFrame = HumanoidRootPart.CFrame
							notify("F3X Grab Success!")
							return
						end
					end
					notify("No traces of F3X!")
					return
				end

				noclip()
				local prevCFrame = HumanoidRootPart.CFrame

				task.spawn(function()
					while not hasF3X() do
						HumanoidRootPart.CFrame = CFrame.new(10, 3.954, -115.698)
						task.wait()
						HumanoidRootPart.CFrame = CFrame.new(9.5, 3.954, -115.698)
						task.wait()
					end
					HumanoidRootPart.CFrame = prevCFrame
					notify("F3X Grab Success!")
					clip()
				end)
			end
		end,
	},
	["respawn"] = {
		aliases = { "re" },
		description = "Respawns you to a random spawnpoint or the main island",
		requiredPlan = "Standard",
		run = function(args: { any })
			events.StatAPI:FireServer("LoadChar", 1)
		end,
	},
	["refresh"] = {
		aliases = { "ref" },
		description = "Refreshes you in the same exact location",
		requiredPlan = "Neo",
		run = function(args: { any })
			local char = plr.Character
			local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
			local oldcframe = HumanoidRootPart.CFrame
			events.StatAPI:FireServer("LoadChar", 1)

			local newChar = plr.CharacterAdded:Wait()
			local newHRP = newChar:WaitForChild("HumanoidRootPart")
			newHRP.CFrame = oldcframe
		end,
	},
	["to"] = {
		aliases = { },
		description = "Tp's you to the specified target",
		requiredPlan = "Standard",
		run = function(args: { any })
			local input = args[1]
			if not input then return end

			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			local targetPlayer
			for _, player in pairs(enviroment.Players:GetPlayers()) do
				local username = player.Name:lower()
				local displayName = player.DisplayName:lower()
				local search = input:lower()

				if username:sub(1, #search) == search or displayName:sub(1, #search) == search then
					targetPlayer = player
					break
				end
			end

			if targetPlayer and targetPlayer.Character then
				local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
				if targetHRP then
					local frontOffset = targetHRP.CFrame.LookVector * 5
					hrp.CFrame = CFrame.new(targetHRP.Position + frontOffset, targetHRP.Position)
				end
			end
		end,
	},
	["shutdown"] = {
		aliases = { "crashserver" },
		description = "Completely lags out the server rendering it a shutdown",
		requiredPlan = "Neo",
		run = function(args: { any })
			notify("Lagging server.. (This may take time)")						

			local iterations = 200
			if events.WorkspaceAPI then
				local txt = string.rep("abcdefghijklmnopqrstuvwxyz",134).."3"
				local tck = tick()

				task.spawn(function()
					local changed = 0
					local function tbfunc(v)
						local tb = v:FindFirstChild("TopBox",true)
						if tb then
							v:Destroy()
							changed += 1
							tck = tick()
						end
					end
					local event = enviroment.Workspace.ChildAdded:Connect(tbfunc)
					while task.wait() do
						for _,v in pairs(enviroment.Workspace:GetChildren()) do
							tbfunc(v)
						end
					end
				end)
				for i = 1,1000*iterations do
					events.WorkspaceAPI:FireServer("GenerateText",txt,"3",Color3.new(0,0,0),0)
				end
			else
				NotifySystem.Error("Failed to crash server!")
			end
		end,
	},
	["island"] = {
		aliases = { "spawn", "toisland", "tospawn", "ti" },
		description = "Teleports you to the starting island",
		requiredPlan = "Standard",
		run = function(args: { any })
			local char = plr.Character
			local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
			HumanoidRootPart.CFrame = CFrame.new(0, 2, 0)
		end,
	},
	["museum"] = {
		aliases = { "secretmuseum", "tm" },
		description = "Teleports you to the secret museum",
		requiredPlan = "Standard",
		run = function(args: { any })
			local char = plr.Character
			local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
			HumanoidRootPart.CFrame = CFrame.new(-23833.7715, 40.3003426, -132.2677, 0.999337018, -2.71821623e-08, -0.0364074148, 2.33046045e-08, 1, -1.06928994e-07, 0.0364074148, 1.06009644e-07, 0.999337018)
		end,
	},
	["deadlands"] = {
		aliases = { "todeadlands", "td" },
		description = "Teleports you to the deadlands",
		requiredPlan = "Standard",
		run = function(args: { any })
			local char = plr.Character
			local HumanoidRootPart = char:FindFirstChild("HumanoidRootPart")
			HumanoidRootPart.CFrame = CFrame.new(99999999999999,99999999999999,99999999999999)
		end, 
	},
	["infiniteyield"] = {
		aliases = { "infy", "iy" },
		description = "Infinite Yield Admin",
		requiredPlan = "Standard",
		run = function(args: { any })
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		end,
	},
	["kill"] = {
		aliases = {  },
		description = "Kills the specified target (REQUIRES F3X)",
		requiredPlan = "Neo",
		run = function(args: { any })
			local input = args[1]
			if not input then return end

			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			if input:lower() == "all" then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= plr and player.Character then
                    local torso = player.Character:FindFirstChild("Torso")
                    if torso and torso:FindFirstChild("Neck") then
                        f3x.Remove({torso.Neck})
                    end
                end
            end
        else
            local targetPlayer
            local search = input:lower()
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                local username = player.Name:lower()
                local displayName = player.DisplayName:lower()
                if username:sub(1, #search) == search or displayName:sub(1, #search) == search then
                    targetPlayer = player
                    break
                end
            end

            if targetPlayer and targetPlayer.Character then
                local torso = targetPlayer.Character:FindFirstChild("Torso")
                if torso and torso:FindFirstChild("Neck") then
                    f3x.Remove({torso.Neck})
                end
            end
        end

			unequipF3X()
		end,
	},
	["removeboards"] = {
		aliases = {  },
		description = "Removes the boards from the island. (REQUIRES F3X)",
		requiredPlan = "Neo",
		run = function(args: { any })
			f3x.Remove({
				game.Workspace["made by FoxBin"], 
				game.Workspace["made by FoxBin1"], 
				game.Workspace["made byFoxBin MK2"], 
				game.Workspace["made by FoxBinMK4"], 
				game.Workspace["made by FoxBinMK6"], 
				game.Workspace["FoxBinMK5"], 
				game.Workspace["GearBoardManagerModel"]
			})

			unequipF3X()
		end, 
	},
	["removebaseplate"] = {
		aliases = {  },
		description = "Removes the baseplate from the island. (REQUIRES F3X)",
		requiredPlan = "Neo",
		run = function(args: { any })
			f3x.Remove({
				game.Workspace["Baseplate"]
			})

			unequipF3X()
		end, 
	},
	["speed"] = {
		aliases = { "s" },
		description = "Sets a desired walkspeed",
		requiredPlan = "Neo",
		run = function(args: { any })
			plr.Character.Humanoid.WalkSpeed = args[1]
		end, 
	},
	["jumppower"] = {
		aliases = { "jp" },
		description = "Sets a desired walkspeed",
		requiredPlan = "Neo",
		run = function(args: { any })
			plr.Character.Humanoid.JumpPower = args[1]
		end, 
	},
}

local function findCommand(name: string): Command
	for cmdName, cmd in pairs(allCommands) do
		if cmdName == name then
			return cmd
		end
		for _, alias in ipairs(cmd.aliases) do
			if alias == name then
				return cmd
			end
		end
	end
	return nil
end

local function canRun(required: "Standard" | "Neo", actual: Plan): boolean
	if actual == nil then
		return false
	end
	if required == "Standard" then
		return true
	elseif required == "Neo" then
		return actual == "Neo"
	end
	return false
end

local function runCommand(name: string, args: { any })
	if not user then
		notify("No valid user")
		return
	end
	local cmd = findCommand(name)
	if not cmd then
		notify("Unknown command: " .. name)
		return
	end
	if not canRun(cmd.requiredPlan, user.plan) then
		notify("You need " .. cmd.requiredPlan .. " to run this command: " .. name .. "!")
		return
	end
	cmd.run(args)
end

task.spawn(function()
	for i,v in pairs (workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Locked == false then
			v.CanTouch = false
		end
	end
end)

--runCommand("f3x", {})

--gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CoreGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = enviroment.CoreGui

local BG = Instance.new("Frame")
BG.BackgroundTransparency = 0.550000011920929
BG.Name = "BG"
BG.BorderColor3 = Color3.fromRGB(0, 0, 0)
BG.Size = UDim2.new(1, 0, 1, 0)
BG.BorderSizePixel = 0
BG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BG.Parent = ScreenGui

local bar = Instance.new("Frame")
bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
bar.AnchorPoint = Vector2.new(0.5, 0.5)
bar.BackgroundTransparency = 0.25
bar.Position = UDim2.new(0.5, 0, 0.5, 0)
bar.Name = "bar"
bar.Size = UDim2.new(0, 250, 0, 35)
bar.BorderSizePixel = 0
bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
bar.Parent = BG

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = bar

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 82
UIGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 199, 199)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 85, 85)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 186, 186)),
})
UIGradient.Parent = UIStroke

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = bar

local TextBox = Instance.new("TextBox")
TextBox.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.Text = ""
TextBox.Size = UDim2.new(0, 225, 1, 0)
TextBox.Position = UDim2.new(0.5, 0, 0, 0)
TextBox.AnchorPoint = Vector2.new(0.5, 0)
TextBox.BorderSizePixel = 0
TextBox.BackgroundTransparency = 1
TextBox.PlaceholderColor3 = Color3.fromRGB(163, 163, 163)
TextBox.TextTruncate = Enum.TextTruncate.AtEnd
TextBox.PlaceholderText = "execute cmd..."
TextBox.TextSize = 16
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = bar

local autosuggestions = Instance.new("TextLabel")
autosuggestions.FontFace =
	Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
autosuggestions.TextColor3 = Color3.fromRGB(255, 255, 255)
autosuggestions.BorderColor3 = Color3.fromRGB(0, 0, 0)
autosuggestions.Text = "f3x: Lorem Ipsum"
autosuggestions.Name = "autosuggestions"
autosuggestions.TextStrokeTransparency = 0.5
autosuggestions.Size = UDim2.new(1, 0, 0, 70)
autosuggestions.Position = UDim2.new(0, 0, 1, 0)
autosuggestions.BackgroundTransparency = 1
autosuggestions.TextXAlignment = Enum.TextXAlignment.Left
autosuggestions.BorderSizePixel = 0
autosuggestions.TextYAlignment = Enum.TextYAlignment.Top
autosuggestions.TextSize = 14
autosuggestions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
autosuggestions.Parent = bar

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 5)
UIPadding.PaddingLeft = UDim.new(0, 11)
UIPadding.Parent = autosuggestions

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = enviroment.Lighting

local TweenService = enviroment.TweenService
local UserInputService = enviroment.UserInputService

BG.Visible = false
bar.Visible = false

local open = false

local function showUI()
	open = true
	BG.Visible = true
	bar.Visible = true
	bar.BackgroundTransparency = 1
	TextBox.TextTransparency = 1
	autosuggestions.TextTransparency = 1
	UIStroke.Transparency = 1

	TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = 54 }):Play()
	TweenService:Create(BG, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0.55 }):Play()

	bar.Position = UDim2.new(0.5, 0, 0.5, 40)
	TweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundTransparency = 0.25
	}):Play()
	TweenService:Create(TextBox, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
	TweenService:Create(autosuggestions, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 }):Play()
	TweenService:Create(UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 0 }):Play()

	TextBox:CaptureFocus()
	task.wait()
	TextBox.Text = ""
end

local function hideUI()
	open = false

	TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = 0 }):Play()
	TweenService:Create(BG, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()

	TweenService:Create(bar, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = UDim2.new(0.5, 0, 0.5, 40),
		BackgroundTransparency = 1
	}):Play()
	TweenService:Create(TextBox, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
	TweenService:Create(autosuggestions, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
	TweenService:Create(UIStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()

	task.delay(0.35, function()
		if not open then
			BG.Visible = false
			bar.Visible = false
		end
	end)

	TextBox:ReleaseFocus()
	TextBox.Text = ""
end



UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then
		return
	end
	if input.KeyCode == Enum.KeyCode.Quote then
		if not open then
			showUI()
		else
			hideUI()
		end
	end
end)

TextBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local txt = TextBox.Text
		local args = {}
		local split = string.split(txt, " ")
		local cmdName = split[1]
		for i = 2, #split do
			table.insert(args, split[i])
		end
		if cmdName and cmdName ~= "" then
			coroutine.wrap(function()
				runCommand(cmdName, args)
			end)()
		end  
	end
	hideUI()
end)

local function updateSuggestions(inputText: string)
	autosuggestions.Text = ""
	if inputText == "" then
		return
	end

	local matches = {}
	for cmdName, cmd in pairs(allCommands) do
		local allNames = { cmdName, unpack(cmd.aliases) }
		for _, name in ipairs(allNames) do
			if string.sub(name, 1, #inputText):lower() == inputText:lower() then
				table.insert(matches, name .. ": " .. cmd.description)
			end
		end
	end

	if #matches > 0 then
		autosuggestions.Text = table.concat(matches, "\n")
	end
end

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	updateSuggestions(TextBox.Text)
end)

local oldHide = hideUI
hideUI = function()
	oldHide()
	autosuggestions.Text = ""
end

notify("Welcome, " .. plr.Name .. "!")
wait(3)
notify("Current Plan: " .. (user.plan or "nil"))
