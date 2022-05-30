import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "AnimatedSprite/AnimatedSprite"
import "physics/spriteCollision"
import "rng/rng"
import "levelGeneration/levelGen"

local gfx <const> = playdate.graphics

local catSprite = nil

Boxes = {}

local hasUpdated = false

local movedThisFrame = false

local firstJumpFrame = true

function SetUpSprites()
    playdate.graphics.setColor(playdate.graphics.kColorXOR)
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    --box = playdate.geometry.rect.new(0, 200, 400,100)
    --playdate.graphics.fillRect(box)
    --boxSprite = playdate.graphics.sprite.new(box)
    ---@diagnostic disable-next-line: undefined-global
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    -- assert (boxSprite, "Failed to create box sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    -- boxSprite:add()
    catSprite:playAnimation()
    SetUpCollision(catSprite)
    -- SetUpCollision(boxSprite, "ground")
    -- boxSprite:setCollideRect(box)
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    -- playdate.graphics.fillRect(box)

    AddPlatforms(0, 400)
    
    function catSprite:collisionResponse(otherSprite)
        if CollisionList[otherSprite] == "ground" then
            return "slide"
        else
            return "slide"
        end
    end
end

function UpdateSprites()
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    movedThisFrame = false
    local crankDelta = playdate.getCrankChange()
    if not hasUpdated then
        hasUpdated = true
        playdate.graphics.sprite.update()
    end
    if ((playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp)) and IsGrounded(catSprite) and not JumpingSprites["cat"]) or JumpingSprites["cat"] then
        catSprite:pauseAnimation()
        movedThisFrame = true
        if IsGrounded(catSprite) and not JumpingSprites["cat"] then
            SetJumpForce("cat", 10)
            firstJumpFrame = true
        end
        if firstJumpFrame and not IsGrounded(catSprite) then
            catSprite:setRotation(RandomNumber(-10,10))
            if #catSprite:overlappingSprites() > 0 then
                catSprite:setRotation(0)
            else
                firstJumpFrame = false
            end
        end
        if crankDelta ~= 0 and not IsGrounded(catSprite) then
            local catRotation = catSprite:getRotation()
            local newCatRotation = catRotation + crankDelta
            catSprite:setRotation(newCatRotation)
            if #catSprite:overlappingSprites() > 0 then
                catSprite:setRotation(catRotation)
            end
        end
        ApplyJumpForce(catSprite, "cat")
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
    if IsGrounded(catSprite) and ((-3 > catSprite:getRotation()) or (catSprite:getRotation() > 3)) then
        -- todo: the player should die if they land on the box and are rotated
        catSprite:setRotation(0)
        JumpingSprites["cat"] = false
        playdate.graphics.sprite.update()
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
    for _, box in pairs(Boxes) do
        playdate.graphics.drawRect(box)
    end
end

