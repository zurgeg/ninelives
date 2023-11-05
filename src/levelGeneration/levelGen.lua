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

DifficultyEasy = 30 -- too easy, my cat could do this
DifficultyMedium = 50 -- not too hard, my cat can't do this anymore :(
DifficultyHard = 150 -- hard(ish), good luck, have fun
DifficultyHardcore = 200 -- ouch
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
function math.clamp(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

function AddPlatforms(fromX, toX, toDifficulty)
    xPos = fromX
    platformWidth = 50
    platformHeight = 10 -- height is almost all cosmetic, no need to make it too big
    local platforms = {}
    while xPos < toX do
        local platformTable = {}
        offsetX = math.random(xPos + platformWidth, xPos + difficultyBase + platformWidth)
        platformWidth = math.random(20, 50)
        offsetY = math.clamp(math.random(yPos - difficultyBase, yPos + difficultyBase), 25, 240)
        xPos = offsetX
        yPos = offsetY
        local platformRect = playdate.geometry.rect.new(xPos, yPos, platformWidth, platformHeight)
        playdate.graphics.drawRect(platformRect)
        table.insert(platformTable, platformRect)
        local fakeSprite = playdate.graphics.sprite.new(rect)
        table.insert(platformTable, fakeSprite)
        fakeSprite:add()
        SetUpCollision(fakeSprite, "ground")
        fakeSprite:setCollideRect(platformRect)
        table.insert(platforms, platformTable)
        table.insert(Boxes, platformRect)
    end
end



