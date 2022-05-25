import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "AnimatedSprite/AnimatedSprite"
import "physics/spriteCollision"

local gfx <const> = playdate.graphics

local catSprite = nil

local hasUpdated = false

local movedThisFrame = false

function setUpSprites()
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    catSprite:playAnimation()
    setUpCollision(catSprite)
end

function updateSprites()
    movedThisFrame = false
    if not hasUpdated then
        hasUpdated = true
        playdate.graphics.sprite.update()
    end
    if playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp) then
        -- jump
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        catSprite.globalFlip = gfx.kImageFlippedX
        moveWithGravity(catSprite, -7, 0)
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        catSprite.globalFlip = gfx.kImageUnflipped
        moveWithGravity(catSprite, 7, 0)
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if not movedThisFrame then
        catSprite:pauseAnimation()
        updateGravity(catSprite)
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
end

