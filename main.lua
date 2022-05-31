import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "levelGeneration/levelGen.lua"
import "menuScene/menu.lua"
import "optionsScene/options.lua"

SceneMenu = 0
SceneGame = 1
SceneOptions = 2

local scene = 0

function SetScene(sceneID)
    scene = sceneID
end

function SetUp()
    SetupRNG()
    SetUpLevelGen(0, 200, 20, 20, 0, 0, 60)
    SetUpSprites()
end

SetUp()

function playdate.update()
    if scene == SceneMenu then
        UpdateMenu()
    elseif scene == SceneGame then
        UpdateSprites()
    elseif scene == SceneOptions then
        UpdateOptions()
    else
        assert(false, "how did this happen")
    end
    playdate.timer.updateTimers()
end