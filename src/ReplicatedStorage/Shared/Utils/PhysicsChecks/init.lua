local Checks = {}

function Checks:GetResolveFromTypes(origType: string,targetType: string)
    return self[origType][string.format("ResolveWith%s",targetType)]
end

function Checks:GetCheckFromTypes(origType: string,targetType: string)
    return self[origType][string.format("CheckCollisionWith%s",targetType)]
end

for _,module in pairs(script:GetChildren()) do
    Checks[module.Name] = require(module)
end

return Checks