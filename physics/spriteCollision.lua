---@diagnostic disable-next-line: undefined-global
import "CoreLibs/sprites"
---@diagnostic disable-next-line: undefined-global
import "CoreLibs/graphics"

function AddCollideRect(sprite)
    sprite:setCollideRect(0, 0, sprite:getSize())
end

function SetUpCollision(sprite)
    AddCollideRect(sprite)
    -- todo: what else should we do?
end

function TryMoveBy(sprite, dx, dy)
    NewX = sprite.x + dx
    NewY = sprite.y + dy
    return sprite:moveWithCollisions(NewX, NewY)
end

function MoveWithGravity(sprite, xForce, yForce)
    TryMoveBy(sprite, xForce, 1 + yForce)
end

function UpdateGravity(sprite)
    MoveWithGravity(sprite, 0, 0)
end