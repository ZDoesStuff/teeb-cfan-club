local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local Loaded = workspace:WaitForChild("Loaded")

local HealthCore = Enum.CoreGuiType.Health
local AllCores = Enum.CoreGuiType.All

warn("Cores")

repeat
	RunService.RenderStepped:Wait()
	local Success = pcall(function()
		StarterGui:SetCoreGuiEnabled(AllCores, false)
		StarterGui:SetCoreGuiEnabled(HealthCore, true)

		StarterGui:SetCore("TopbarEnabled", false)
	end)
until Success

warn("Values")

local Values = Loaded:GetChildren()
local Length = #Values

repeat
	local Index = 0
	for _, Value in pairs(Values) do
		Index += Value.Value == true and 1 or 0
	end
	RunService.RenderStepped:Wait()
until Index >= Length

warn("Loaded")

ReplicatedFirst:RemoveDefaultLoadingScreen()
Loaded.Value = true