---@diagnostic disable-next-line: undefined-global
import "CoreLibs/timer"
---@diagnostic disable-next-line: undefined-global
import "gameScene/sprites.lua"

function SetUp()
    SetUpSprites()
end

SetUp()

function playdate.update()
    UpdateSprites()
    playdate.timer.updateTimers()
end