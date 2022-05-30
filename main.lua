import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "levelGeneration/levelGen.lua"

function SetUp()
    SetupRNG()
    SetUpLevelGen(0, 200, 20, 20, 0, 0)
    SetUpSprites()
end

SetUp()

function playdate.update()
    UpdateSprites()
    playdate.timer.updateTimers()
end