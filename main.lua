import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"

function SetUp()
    SetupRNG()
    SetUpSprites()
end

SetUp()

function playdate.update()
    UpdateSprites()
    playdate.timer.updateTimers()
end