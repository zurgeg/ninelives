import "CoreLibs/timer"
import "gameScene/sprites.lua"

function SetUp()
    SetUpSprites()
end

SetUp()

function playdate.update()
    UpdateSprites()
    playdate.timer.updateTimers()
end