import "CoreLibs/sprites"
import "CoreLibs/graphics"

function addCollideRect(sprite)
    sprite:setCollideRect(0, 0, sprite:getSize())
end

function setUpCollision(sprite)
    addCollideRect(sprite)
    -- todo: what else should we do?
end

function tryMoveBy(sprite, dx, dy)
    newX = sprite.x + dx
    newY = sprite.y + dy
    return sprite:moveWithCollisions(newX, newY)
end

function moveWithGravity(sprite, xForce, yForce)
    tryMoveBy(sprite, xForce, 1 + yForce)
end

function updateGravity(sprite)
    moveWithGravity(sprite, 0, 0)
end