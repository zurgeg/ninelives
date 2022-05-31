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
function AddPlatforms(fromX, toX, toDifficulty)
    xPos = fromX
    if toDifficulty ~= nil and toX == nil then
        local diff = 0
        while (diff >= toDifficulty) do
            diff = math.floor(xPos / 100)
            local currentWidth = math.random(width - diff,  mWidth - diff)
            local currentHeight = math.random(height - diff, mHeight - diff)
            xPos = xPos + math.random(1, 1 + diff) * currentWidth
            yPos = yPos + math.random(-diff, diff) * currentHeight
            local rect = playdate.geometry.rect.new(xPos-width, yPos, currentWidth, currentHeight)
            playdate.graphics.drawRect(rect)
            local fakeSprite = playdate.graphics.sprite.new(rect)
            fakeSprite:add()
            SetUpCollision(fakeSprite, "ground")
            fakeSprite:setCollideRect(rect)
            Boxes[#Boxes+1] = rect
        end
    else
        assert(toX, "toX is nil, please pass it")
        while (xPos < toX) do
            local diff = math.floor(xPos / 100)
            local currentWidth = math.random(width - diff,  mWidth - diff)
            local currentHeight = math.random(height - diff, mHeight - diff)
            xPos = xPos + math.random(1, 1 + diff) * currentWidth
            yPos = yPos + math.random(-diff, diff) * currentHeight
            local rect = playdate.geometry.rect.new(xPos-width, yPos, currentWidth, currentHeight)
            playdate.graphics.drawRect(rect)
            local fakeSprite = playdate.graphics.sprite.new(rect)
            fakeSprite:add()
            SetUpCollision(fakeSprite, "ground")
            fakeSprite:setCollideRect(rect)
            Boxes[#Boxes+1] = rect
        end
    end
end



