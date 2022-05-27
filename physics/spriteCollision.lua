import "CoreLibs/sprites"
import "CoreLibs/graphics"

local jumpForces = {}
JumpingSprites = {}
CollisionList = {}

function AddCollideRect(sprite)
    sprite:setCollideRect(0, 0, sprite:getSize())
end

function SetUpCollision(sprite, collisionType)
    AddCollideRect(sprite)
    CollisionList[sprite] = collisionType or "ground"
end

function TryMoveBy(sprite, dx, dy)
    NewX = sprite.x + dx
    NewY = sprite.y + dy
    return sprite:moveWithCollisions(NewX, NewY)
end

function MoveWithGravity(sprite, xForce, yForce)
    TryMoveBy(sprite, xForce, 3 + yForce)
end

function IsGrounded(sprite, groundSprite)
    NewX = sprite.x
    NewY = sprite.y + 1
    local aX, aY, col, length = sprite:checkCollisions(NewX, NewY)
    for i = 1, length do
        if CollisionList[col[i]["other"]] == "ground" then
            return true
        else
            return false
        end
    end
    return false
end

function UpdateGravity(sprite)
    MoveWithGravity(sprite, 0, 0)
end

function SetJumpForce(spritename, force)
    jumpForces[spritename] = force
end

function ApplyJumpForce(sprite, spritename)
    local force = jumpForces[spritename]
    if force == nil then
        JumpingSprites[spritename] = false
        return
    end
    if not JumpingSprites[spritename] and force ~= 0 then
        JumpingSprites[spritename] = true
    end
    if force > 0 then
        MoveWithGravity(sprite, 0, -force)
    else
        JumpingSprites[spritename] = false
    end
    jumpForces[spritename] = jumpForces[spritename] - 1
end