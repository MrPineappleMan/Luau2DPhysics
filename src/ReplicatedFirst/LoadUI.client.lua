-- Load UI
-- Crazyman32
-- May 10, 2020
local event = Instance.new("BindableEvent")

_G.Loaded = event.Event


local REP_STORAGE_FOLDER_NAME = "StarterGui"

-- Wait for game to load:
if (not game:IsLoaded()) then
	game.Loaded:Wait()
end


local guis = game:GetService("ReplicatedStorage"):FindFirstChild(REP_STORAGE_FOLDER_NAME)
local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui

if (not guis) then
	warn("UI loader failed to find " .. REP_STORAGE_FOLDER_NAME .. " folder in ReplicatedStorage")
	return
end

-- Move ScreenGuis into PlayerGui:
local shouldRemove = true
for i,v in ipairs(guis:GetChildren()) do
	if (v:IsA("LayerCollector") and v.ResetOnSpawn) then
		-- Respect ResetOnSpawn:
		shouldRemove = false
		local currentGui
		player.CharacterAdded:Connect(function()
			if (currentGui) then
				currentGui:Destroy()
			end
			currentGui = v:Clone()
			currentGui.Parent = playerGui
		end)
	else
		-- Move objects to PlayerGui:
		v.Parent = playerGui
	end
end
wait(2)
_G.GuiLoaded = true
event:Fire()
warn("Fired")
print(tick())
if (shouldRemove) then
	script:Destroy()
end