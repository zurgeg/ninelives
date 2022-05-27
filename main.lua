import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "menuScene/menu.lua"

local testMenu = true

function SetUp()
    SetupRNG()
    SetUpSprites()
end

SetUp()

function playdate.update()
    if testMenu then
        UpdateMenu()
    else
        UpdateSprites()
    end
    playdate.timer.updateTimers()
end