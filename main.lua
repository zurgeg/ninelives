import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "levelGeneration/levelGen.lua"

function SetUp()
    SetupRNG()
    SetUpLevelGen(0, 20, 100, 100, 0, DifficultyEasy)
    SetUpSprites()
end

SetUp()

function playdate.update()
    UpdateSprites()
    playdate.timer.updateTimers()
end