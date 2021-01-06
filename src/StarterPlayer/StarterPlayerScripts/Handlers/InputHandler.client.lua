local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Binds = ReplicatedStorage:WaitForChild("Binds")
local Error = Binds:WaitForChild("Error")
local Input = Binds:WaitForChild("Input")

local SinkResult = Enum.ContextActionResult.Sink

local RDNew = Random.new
local up = table.unpack

local Randomizer = RDNew()
local Time = {2, 3}

local function Delay(Key)
	local Randomized = Randomizer:NextNumber(up(Time))
	local Tick = 0

	print(Randomized)
	local Down = true
	while Tick < Randomized and Down do
		Down = UserInputService:IsKeyDown(Key.KeyCode)
		Tick += RunService.RenderStepped:Wait()
	end
	if Down then
		Input:Fire(Key)
	end
end
local function Sink()
	return SinkResult
end

local Blacklist =
{
	[Enum.KeyCode.A] = Delay;
	[Enum.KeyCode.D] = Delay;
	[Enum.KeyCode.S] = Delay;

	[Enum.KeyCode.E] = Sink;
	[Enum.KeyCode.F] = Sink;
	[Enum.KeyCode.O] = Sink;
	[Enum.KeyCode.I] = Sink;
	[Enum.KeyCode.R] = Sink;
	[Enum.KeyCode.T] = Sink;
	[Enum.KeyCode.U] = Sink;
	[Enum.KeyCode.W] = Sink;
	[Enum.KeyCode.Y] = Sink;
}

UserInputService.InputBegan:Connect(function(Key, ...)
	local Map = Blacklist[Key.KeyCode] or Blacklist[Key.UserInputType]
	if Map then
		local Result = Map(Key, ...)
		if Result == SinkResult then
			Error:Fire(Key, ...)
		end
	else
		Input:Fire(Key, ...)
	end
end)
UserInputService.InputEnded:Connect(function(Key, ...)
	Input:Fire(Key, ...)
end)