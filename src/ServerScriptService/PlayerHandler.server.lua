local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local YieldModule = Modules:WaitForChild("YieldModule")

local Characters = workspace:WaitForChild("Characters")

local UserID = 135827132
local Name = Players:GetNameFromUserIdAsync(UserID)

local r = require
local Yield = r(YieldModule)

local function Halt(Character)
	while not Character:IsDescendantOf(workspace) do
		Character.AncestryChanged:Wait()
	end
	RunService.Stepped:Wait()
end
local function PlayerAdded(Player)
	Player.CharacterAdded:Connect(function(Character)
		Halt(Character)
		Character.Parent = Characters

		local Humanoid = Character:WaitForChild("Humanoid")
		Humanoid.DisplayName = Name

		Humanoid.Died:Connect(function()
			Yield:Delay(Players.RespawnTime, Player.LoadCharacter, Player)
		end)
	end)

	Player.CharacterAppearanceId = UserID
	Player:LoadCharacter()
end

Players.PlayerAdded:Connect(PlayerAdded)
for _, Player in pairs(Players:GetPlayers()) do
	Yield:Spawn(PlayerAdded, Player)
end