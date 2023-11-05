import "CoreLibs/timer"
import "gameScene/sprites.lua"
import "rng/rng.lua"
import "levelGeneration/levelGen.lua"
import "menuScene/menu.lua"
import "optionsScene/options.lua"

local gfx <const> = playdate.graphics

SceneMenu = 0
SceneGame = 1
SceneOptions = 2

local scene = 0

function SetScene(sceneID)
    scene = sceneID
end

function SetUp()
    local menuFont = gfx.font.new("resources/Roobert-11-Medium")
    gfx.setFont(menuFont)
    SetupRNG()
    SetUpLevelGen(0, 200, 20, 20, 0, DifficultyMedium, 60)
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