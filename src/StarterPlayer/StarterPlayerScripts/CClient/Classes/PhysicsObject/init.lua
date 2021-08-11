local PhysicsObject = {}
PhysicsObject.__index = PhysicsObject


function PhysicsObject.new(config)
    return require(script[config.Type]).new(config)
end

return PhysicsObject