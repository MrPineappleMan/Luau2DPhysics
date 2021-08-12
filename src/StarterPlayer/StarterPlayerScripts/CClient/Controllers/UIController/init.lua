local Knit = require(game:GetService("ReplicatedStorage").Knit)

local Players = game:GetService("Players")

local UIController = Knit.CreateController { Name = "UIController" }

local PhysicsController

local Roact
local e 

local Container

function UIController:KnitStart()
    Roact.mount(e(Container),Players.LocalPlayer.PlayerGui)

    PhysicsController:AddObject("BoxContainer")
    
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(500,600))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(500,700))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(500,400))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(500,500))

    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(400,600))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(400,700))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(400,400))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(400,500))

    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(600,600))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(600,700))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(600,400))
    PhysicsController:AddObject("Ball"):SetPosition(Vector2.new(600,500))
end


function UIController:KnitInit()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement

    Container = require(script.Components.Container)

    PhysicsController = require(Knit.Client.Controllers.PhysicsController)
end


return UIController