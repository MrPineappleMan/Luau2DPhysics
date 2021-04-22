local parent = script.Parent

local Knit = require(game:GetService("ReplicatedStorage").Knit)

-- Load services or controllers here
Knit.AddServices(parent.Services)
Knit.Server = parent
Knit.Shared = game:GetService("ReplicatedStorage").Shared

Knit.Start()

