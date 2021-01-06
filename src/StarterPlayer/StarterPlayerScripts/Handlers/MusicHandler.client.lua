local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local CameraPriority = Enum.RenderPriority.Camera

local Binds = ReplicatedStorage:WaitForChild("Binds")
local Soundtrack = Binds:WaitForChild("Soundtrack")

local Music = SoundService:WaitForChild("Music")
local List = Music:GetChildren()

local CurrentCamera = workspace.CurrentCamera

local Loaded = workspace:WaitForChild("Loaded")
local Value = Loaded:WaitForChild("Music")

local CFAng = CFrame.Angles
local CFNew = CFrame.new
local RDNew = Random.new

local insert = table.insert
local rad = math.rad

local Randomizer = RDNew()
local Current = nil

local Empty = CFNew()
local Angle = Empty

Music.ChildAdded:Connect(function(Track)
	insert(List, Track)
end)
Soundtrack.Event:Connect(function(New)
	New = New or ""
	Current = Music:FindFirstChild(New)
end)

RunService:BindToRenderStep("Music", CameraPriority.Value + 10, function(dT)
	for _, Track in pairs(List) do
		if Track ~= Current then
			Track:Stop()
		end
	end
	if Current then
		CurrentCamera.CFrame *= Angle
		if not Current.IsPlaying then
			Current:Play()
		end
	end

	local Loudness = Current and Current.PlaybackLoudness or 0
	local Scale = dT * 60
	
	Angle = Angle:Lerp(CFNew(0, 0, -Loudness / 250) * CFAng(0, 0, rad(Loudness / 100) * Randomizer:NextInteger(-1, 1)), .2 * Scale)
end)

Value.Value = true