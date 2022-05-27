import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "menuScene/menu.lua"

SceneMenu = 0
SceneGame = 1

local scene = 0

function SetScene(sceneID)
    scene = sceneID
end


function SetUp()
    SetupRNG()
    SetUpSprites()
end

SetUp()

function playdate.update()
    if scene == SceneMenu then
        UpdateMenu()
    elseif scene == SceneGame then
        UpdateSprites()
    else
        assert(false, "how did this happen")
    end
    playdate.timer.updateTimers()
end