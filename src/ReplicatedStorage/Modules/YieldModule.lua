local Yield = {}

-- 56203888

-- Get this for version checking:
-- https://www.roblox.com/library/6033928757/Yield-Module-Checker

local RunService = game:GetService("RunService")
local IsClient = RunService:IsClient()

local INew = Instance.new
local osclock = os.clock

local clamp = math.clamp
local huge = math.huge

local up = table.unpack

local sel = select
local r = require

local Minimums =
{
	-- I keep this minimum as 0.01 due to FPS Unlockers, but change it if you'd like.
		Client = .01;
	-- This is here incase you want there to be a difference in minimums.
		Server = .01;
}

-- Yields for a certain amount of seconds before it stops.
function Yield:Wait(Seconds)
	local Minimum = Minimums[IsClient and "Client" or "Server"]
	local Type = IsClient and "RenderStepped" or "Stepped"
	local Select = IsClient and 1 or 2
	
	local Current = osclock()
	local Tick = 0
	
	local Wait = RunService[Type]
	Seconds = clamp(Seconds or Minimum, Minimum, huge)
	
	while Tick < Seconds do
		Tick += sel(Select, Wait:Wait())
	end
	
	-- The first argument is how fast it took in Stepped/RenderStepped to reach.
	-- The second argument is how long it took in real time (based on os.clock()).
	return Tick, osclock() - Current
end
-- A better version of executing a function without yielding a script.
function Yield:Spawn(Function, ...)
	local Args = {...}
	
	local Bind = INew("BindableEvent")
	Bind.Event:Connect(function()
		Function(up(Args))
	end)
	
	Bind:Fire()
	Bind:Destroy()
end
-- Waits a certain amount of seconds without yielding to execute a function.
-- If you don't want to yield, this is best used for execution.
function Yield:Delay(Seconds, Function, ...)
	local Args = {...}
	Yield:Spawn(function()
		Yield:Wait(Seconds)
		Function(up(Args))
	end)
end

-- This is for version checking.
Yield:Spawn(function()
	if not IsClient then
		local Checker = r(6033928757)
		Checker("1.0.2", script)
	end
end)

return Yield