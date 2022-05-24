import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics

local cat = nil

function setUp()
    local cat = playdate.sprites.new("gfx/cat") -- load player sprite
    assert cat
    catSprite = cat.sprite.new( cat )
    catSprite:moveTo( 200, 120 )
end

function playdate.update()
    if playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp) then
        -- todo: jump
    end

    catSprite:moveBy( 0, 5 )
end