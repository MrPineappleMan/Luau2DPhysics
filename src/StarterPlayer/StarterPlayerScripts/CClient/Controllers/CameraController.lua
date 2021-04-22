-- Camera Controller
-- UnknownParabellum
-- March 26, 2021

--[[
	

--]]

local Knit = require(game:GetService("ReplicatedStorage").Knit)
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CurrentCamera = workspace.CurrentCamera

local CameraController = Knit.CreateController({Name = "CameraController"})
CameraController.Friction = 0.999 --// in demos: y\ =\ \left(0.95^{60\cdot x}\cdot\ 1\right)
CameraController.Force = Vector2.new()

local function setToRelativePos(currentPos,relativeTo)
	return currentPos - relativeTo
end

local function normalizeVector(vector)
	local mag = vector.Magnitude
	mag = (mag == 0) and 1 or mag 
	return Vector2.new(vector.X/mag,vector.Y/mag)
end

local function flipY(pos)
	return Vector2.new(pos.X,-pos.Y)
end

function CameraController:SetCameraType() --// For future possibilities 
	
end

function CameraController:ApplySpeed(vector,pSpeed)
	if typeof(vector) ~= "Vector2" or  typeof(pSpeed) ~= "number" then
		return
	end
	local rSpeed = math.clamp(pSpeed/200,0.1,5)/300
	self.Force = self.Force + (normalizeVector(vector) * Vector2.new(rSpeed,rSpeed))
end

function CameraController:KnitStart()
	--//This will currently just move the camera based on 
	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	CurrentCamera.CFrame = CFrame.new()
	
	local lastTime = tick()
	local lastMousePosition = UserInputService:GetMouseLocation()
	UserInputService.InputChanged:Connect(function(input,gpe)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local mousePosition = UserInputService:GetMouseLocation()
			
			local relativeVector = flipY(normalizeVector(setToRelativePos(mousePosition,lastMousePosition)))
			
			local diffDistance = (lastMousePosition - mousePosition).Magnitude
			local diffTime = tick() - lastTime
			diffTime = (diffTime == 0) and 1 or diffTime
			
			local pixelSpeed = diffDistance/diffTime
			self:ApplySpeed(relativeVector,pixelSpeed)
			lastTime = tick()
			lastMousePosition = mousePosition
		end
	end)
	
	RunService.Heartbeat:Connect(function()
		CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.Angles(-math.rad(self.Force.Y/15),math.rad(self.Force.X/15),0)
		self.Force = self.Force * Vector2.new(self.Friction,self.Friction,0)
	end)
end


function CameraController:KnitInit()
	
end


return CameraController