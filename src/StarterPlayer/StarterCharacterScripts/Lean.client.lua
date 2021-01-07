local RunService = game:GetService("RunService")
local Character = script.Parent

local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local Root = RootPart:WaitForChild("RootJoint")
local Original = Root.C1

local CFAng = CFrame.Angles
local Divider = 10

RunService:BindToRenderStep("Lean", 0, function(dT)
	local Scale = dT * 60

	local Direction = Humanoid.MoveDirection
	local Vector = RootPart.CFrame:VectorToObjectSpace(Direction / Divider)

	Root.C1 = Root.C1:Lerp(Original * CFAng(Vector.Z, 0, Vector.X * 3), .25 * Scale)
end)