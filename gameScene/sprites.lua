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

function setUpSprites()
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    box = playdate.geometry.rect.new(0, 200, 400,100)
    playdate.graphics.fillRect(box)
    boxSprite = playdate.graphics.sprite.new(box)
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    assert (boxSprite, "Failed to create box sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    boxSprite:add()
    catSprite:playAnimation()
    setUpCollision(catSprite)
    boxSprite:setCollideRect(box)
    function catSprite:collisionResponse(otherSprite)
        if otherSprite == boxSprite then
            return "slide"
        else
            return "slide"
        end
        
    end
end

function updateSprites()
    playdate.graphics.fillRect(box)
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

