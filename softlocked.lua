type Command = {
    aliases: {string},
    run: (args: {any}) -> ()
}

type Commands = {
    [string]: Command
}

local enviroment = {
	--Workspace: Workspace = game:GetService("Workspace"),
	--Lighting: Lighting = game:GetService("Lighting"),
	--Players: Players = game:GetService("Players"),
	--ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage"),

    --User: Player = Players.LocalPlayer
}

local modules = {
	--f3xendpoint = require(services.ReplicatedStorage:WaitForChild("F3XModule")),
}

local commands: Commands = {
	["f3x"] = {
		aliases = {"f", "btools"},
		run = function(args)
			print("F3X command with args:", args)
		end
	},

	["spawn"] = {
		aliases = {"tospawn", "s"},
		run = function(args)
			print("Spawn command with args:", args)
		end
	}
}

commands["f3x"].run()