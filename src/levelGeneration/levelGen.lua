--[[
    original p5.js code courtesy of https://devforum.play.date/t/nine-lives-a-weird-platformer/6538/12
--]]

-- Current x position of the generator
local xPos
-- Current y position of the generator
local yPos
-- Width of rectangle
local width
-- Height of rectangle
local height
-- Base difficulty
local difficultyBase
-- Added difficulty (i.e., due to how long the player has ran)
local addedDifficulty
-- Max width of the platforms
local mWidth
-- Max height of the platforms
local mHeight

DifficultyEasy = 0 -- too easy, my cat could do this
DifficultyMedium = 100 -- not too hard, my cat can't do this anymore :(
DifficultyHard = 200 -- hard(ish), good luck, have fun
DifficultyHardcore = 500 -- ouch
DifficultyForceKill = 99999999 -- for testing death screen and whatnot



-- Initialize level generator
function SetUpLevelGen(x, y, w, h, metersRan, baseDifficulty, maxWidth, maxHeight)
    xPos = x
    yPos = y
    width = w
    height = h
    addedDifficulty = metersRan -- not actually meters, but whatever
    difficultyBase = baseDifficulty
    mWidth = maxWidth
    mHeight = maxHeight
    if maxWidth == nil then
        mWidth = w
    end
    if maxHeight == nil then
        mHeight = h
    end
end

-- Add platforms from the x point specified at fromX to the x point specified at toX
-- Returns an array of platforms
-- Platform (array):
-- platformRect
-- sprite
function AddPlatforms(fromX, toX, toDifficulty)
    xPos = fromX
    platformWidth = 25 -- 1/16th of a playdate screen, if I rember correctly
    platformHeight = 10 -- height is almost all cosmetic, no need to make it too big
    local platforms = {}
    while xPos < toX do
        local platformTable = {}
        offsetX = math.random(xPos + 50, xPos + 50 + difficultyBase)
        offsetY = math.random(yPos - difficultyBase, yPos + difficultyBase)
        xPos = xPos + offsetX
        yPos = yPos + offsetY
        local platformRect = playdate.geometry.rect.new(xPos, yPos, platformHeight, platformWidth)
        playdate.graphics.drawRect(platformRect)
        table.insert(platformTable, platformRect)
        local fakeSprite = playdate.graphics.sprite.new(rect)
        table.insert(fakeSprite)
        fakeSprite:add()
        SetUpCollision(fakeSprite, "ground")
        fakeSprite:setCollideRect(rect)
        table.insert(platforms, platformTable)
    end
end



