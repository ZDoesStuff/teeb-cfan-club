local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Animations = ReplicatedStorage:WaitForChild("Animations")
local Binds = ReplicatedStorage:WaitForChild("Binds")
local Input = Binds:WaitForChild("Input")

local RunAnimation = Animations:WaitForChild("Run")
local Character = script.Parent

local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local Animator = Humanoid:WaitForChild("Animator")

local BeginState = Enum.UserInputState.Begin
local JumpKey = Enum.KeyCode.Space

local RunningState = Enum.HumanoidStateType.Running
local Run = Animator:LoadAnimation(RunAnimation)

local V3New = Vector3.new
local find = table.find

local Threshold = .05
local Tween = .25

local Jumping = false
local Remapping =
{
	[Enum.HumanoidStateType.RunningNoPhysics] = RunningState;
}
local Delta =
{
	Horizontal =
	{
		Negative = false;
		Positive = false;
	};
	Vertical =
	{
		Negative = false;
		Positive = false;
	};
}
local Keys =
{
	Vertical =
	{
		Negative = {Enum.KeyCode.Down, Enum.KeyCode.S};
		Positive = {Enum.KeyCode.Up, Enum.KeyCode.W};
	};
	Horizontal =
	{
		Positive = {Enum.KeyCode.A};
		Negative = {Enum.KeyCode.D};
	};
}

local function Int(Boolean)
	return Boolean and 1 or 0
end
local function Sub(Table)
	return Int(Table.Negative) - Int(Table.Positive)
end

Input.Event:Connect(function(Key, Sink)
	if not Sink then
		local State = Key.UserInputState == BeginState
		local Code = Key.KeyCode

		if Code == JumpKey then
			Jumping = State
		else
			for Index, Table in pairs(Keys) do
				for Pos, Data in pairs(Table) do
					if find(Data, Code) then
						Delta[Index][Pos] = State
					end
				end
			end
		end
	end
	print(Sink, Key.KeyCode, Key.UserInputType)
end)
while Character.Parent ~= nil do
	local Direction = V3New(Sub(Delta.Horizontal), 0, Sub(Delta.Vertical))
	local Velocity = RootPart.Velocity * V3New(1, 0, 1)

	local State = Humanoid:GetState()
	local Remapped = Remapping[State] or State

	local Magnitude = Velocity.Magnitude
	if Magnitude >= Threshold and Remapped == RunningState then
		Run:AdjustSpeed(Magnitude / 16)
		if not Run.IsPlaying then
			Run:Play(Tween)
		end
	else
		Run:AdjustSpeed(1)
		Run:Stop()
	end

	Humanoid:Move(Direction, true)
	Humanoid.Jump = Jumping

	RunService.RenderStepped:Wait()
end