type User = {
				instance: Player,
				plan: "Standard" | "Neo"
}

type Command = {
    aliases: {string},
    run: (args: {any}) -> ()
}
type Commands = {
    [string]: Command
}

local server = game:HttpGet("http://127.0.0.1")
local enviroment = {
				Workspace: workspace = game:GetService("Workspace"),
				Lighting: Lighting = game:GetService("Lighting"),
				Players: lPlayers = game:GetService("Players"),
				ReplicatedStorage: ReplicatedStorage = game:GetService("ReplicatedStorage"),

	   User: Player = Players.LocalPlayer
}
local modules = {
				f3xendpoint = nil,
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