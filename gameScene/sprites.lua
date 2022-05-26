import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "AnimatedSprite/AnimatedSprite"
import "physics/spriteCollision"

local gfx <const> = playdate.graphics

local catSprite = nil

local boxSprite = nil

local box

local hasUpdated = false

local movedThisFrame = false

function SetUpSprites()
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    box = playdate.geometry.rect.new(0, 200, 400,100)
    playdate.graphics.fillRect(box)
    boxSprite = playdate.graphics.sprite.new(box)
    ---@diagnostic disable-next-line: undefined-global
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    assert (boxSprite, "Failed to create box sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    boxSprite:add()
    catSprite:playAnimation()
    SetUpCollision(catSprite)
    boxSprite:setCollideRect(box)
    playdate.graphics.fillRect(box)
    function catSprite:collisionResponse(otherSprite)
        if otherSprite == boxSprite then
            return "slide"
        else
            return "slide"
        end
    end
end

function UpdateSprites()
    movedThisFrame = false
    local crankDelta = playdate.getCrankChange()
    if not hasUpdated then
        hasUpdated = true
        playdate.graphics.sprite.update()
    end
    if ((playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp)) and IsGrounded(catSprite, boxSprite) and not JumpingSprites["cat"]) or JumpingSprites["cat"] then
        catSprite:pauseAnimation()
        movedThisFrame = true
        if crankDelta ~= 0 then
            local catRotation = catSprite:getRotation()
            local newCatRotation = catRotation + crankDelta
            catSprite:setRotation(newCatRotation)
        end
        if IsGrounded(catSprite, boxSprite) and not JumpingSprites["cat"] then
            SetJumpForce("cat", 10)
        end
        ApplyJumpForce(catSprite, "cat")
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
    if IsGrounded(catSprite, boxSprite) and catSprite:getRotation() ~= 0 then
        -- todo: the player should die if they land on the box and are rotated
        catSprite:setRotation(0)
        JumpingSprites["cat"] = false
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        catSprite.globalFlip = gfx.kImageFlippedX
        if not JumpingSprites["cat"] then
            MoveWithGravity(catSprite, -7, 0)
        else
            TryMoveBy(catSprite, -7, 0)
        end
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        catSprite.globalFlip = gfx.kImageUnflipped
        if not JumpingSprites["cat"] then
            MoveWithGravity(catSprite, 7, 0)
        else
            TryMoveBy(catSprite, 7, 0)
        end
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if not movedThisFrame then
        catSprite:pauseAnimation()
        UpdateGravity(catSprite)
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
end

