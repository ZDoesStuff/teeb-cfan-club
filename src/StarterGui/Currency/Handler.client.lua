local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Objects = ReplicatedStorage:WaitForChild("Objects")
local Money = Objects:WaitForChild("Money")

local Currency = script.Parent

local Back = Currency:WaitForChild("Back")
local Viewport = Back:WaitForChild("Viewport")

local CFAng = CFrame.Angles
local CFNew = CFrame.new

local INew = Instance.new

local rad = math.rad
local Theta = 0

local Camera = INew("Camera")
Camera.CFrame = CFNew(0, 0, 3)
Camera.Parent = Viewport

local Clone = Money:Clone()
Clone.Parent = Viewport

Viewport.CurrentCamera = Camera

local Angle = CFAng(rad(40), 0, 0)
RunService:BindToRenderStep("Spin", 0, function(dT)
	local Scale = dT * 60
	Clone.CFrame = Angle * CFAng(0, rad(Theta), 0)

	Theta -= 2 * Scale
end)