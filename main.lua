import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"

local gfx <const> = playdate.graphics

local catSprite = nil

animX = 200
animY = 120

function setUp()
    catAnim = gfx.imagetable.new("gfx/anim/cat")
    catAnimation = playdate.graphics.animation.loop.new(80, catAnim)
end

setUp()

function playdate.update()
    gfx.clear()
    animY = 120
    if playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp) then
        -- jump
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        -- move left
        catAnimation.paused = false
        animX -= 5
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        -- move right
        catAnimation.paused = false
        animX += 5
    end
    catAnimation:draw(animX, animY)
    playdate.timer.updateTimers()
end