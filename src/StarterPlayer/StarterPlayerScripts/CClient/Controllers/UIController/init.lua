local Knit = require(game:GetService("ReplicatedStorage").Knit)

local UserInputService = game:GetService("UserInputService")

local UIController = Knit.CreateController { Name = "UIController" }
local SpeedTest

local Roact
local e 
local Grid 

function UIController:SetStart(startPos)
    self.StartPosition = startPos
end

function UIController:SetEnd(endPos)
    self.EndPosition = endPos
end

function UIController:KnitStart()

end


function UIController:KnitInit()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement
    SpeedTest = require(Knit.Shared.Utils.SpeedTest)
end


return UIController