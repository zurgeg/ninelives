import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"
import "AnimatedSprite/AnimatedSprite"

local gfx <const> = playdate.graphics

local catSprite = nil

local hasUpdated = false

function setUp()
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    catSprite:playAnimation()
end

setUp()

function playdate.update()
    if not hasUpdated then
        hasUpdated = true
        playdate.graphics.sprite.update()
    end
    if playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp) then
        -- jump
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        catSprite.globalFlip = gfx.kImageFlippedX
        catSprite:moveBy(-7, 0)
        playdate.graphics.sprite.update()
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        catSprite.globalFlip = gfx.kImageUnflipped
        catSprite:moveBy(7, 0)
        playdate.graphics.sprite.update()
    end
    playdate.timer.updateTimers()
end