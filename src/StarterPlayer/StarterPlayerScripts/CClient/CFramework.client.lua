local parent = script.Parent

local Knit = require(game:GetService("ReplicatedStorage").Knit)

-- Load services or controllers here
Knit.AddControllers(parent.Controllers)
Knit.Client = parent
Knit.Shared = game:GetService("ReplicatedStorage").Shared

Knit.Start()

