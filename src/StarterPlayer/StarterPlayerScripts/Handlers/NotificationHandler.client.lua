local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local Sounds = SoundService:WaitForChild("Sounds")
local Fart = Sounds:WaitForChild("Fart")

local Binds = ReplicatedStorage:WaitForChild("Binds")
local Error = Binds:WaitForChild("Error")

local CameraPriority = Enum.RenderPriority.Camera
local CurrentCamera = workspace.CurrentCamera

local Loaded = workspace:WaitForChild("Loaded")
local Value = Loaded:WaitForChild("Notifications")

local format = string.format
local FOV =
{
	Normal = 80;
	Zoom = 70;
}

local Formatting = "Can't press %s"

local TINew = TweenInfo.new
local Info = TINew(1)

local Timeout = 3
local Revert = 1

local Negate = 0
local Tick = 0

RunService:BindToRenderStep("Notices", CameraPriority.Value, function(dT)
	local Tween = TweenService:Create(
		CurrentCamera,
		Info,
		{
			FieldOfView = FOV.Normal;
		}
	)
	Tween:Play()

	Tick -= dT
	if Tick <= 0 then
		Negate = 0
	end
end)
Error.Event:Connect(function(Key)
	Tick = Revert
	Negate += 2.5

	CurrentCamera.FieldOfView = FOV.Zoom - Negate
	Fart:Play()

	StarterGui:SetCore(
		"SendNotification",
		{
			Text = format(Formatting, Key.KeyCode.Name);
			Icon = "rbxassetid://2499304014";
			Duration = Timeout;
			Button1 = "Okay";
			Title = "Error";
		}
	)
end)

Value.Value = true