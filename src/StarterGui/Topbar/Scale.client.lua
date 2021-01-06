local GuiService = game:GetService("GuiService")

local Topbar = script.Parent
local Bar = Topbar:WaitForChild("Bar")

local Inset = GuiService:GetGuiInset()

local FromOffset = UDim2.fromOffset
local FromScale = UDim2.fromScale

Bar.Size = FromScale(1) + FromOffset(0, Inset.Y)