import "CoreLibs/timer"
import "gameScene/sprites.lua"

function setUp()
    setUpSprites()
end

setUp()

function playdate.update()
    updateSprites()
    playdate.timer.updateTimers()
end