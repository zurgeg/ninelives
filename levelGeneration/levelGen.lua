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

DifficultyEasy = 0 -- too easy, my cat could do this
DifficultyMedium = 100 -- not too hard, my cat can't do this anymore :(
DifficultyHard = 200 -- hard(ish), good luck, have fun
DifficultyHardcore = 500 -- ouch
DifficultyForceKill = 99999999 -- for testing death screen and whatnot



-- Initialize level generator
function SetUpLevelGen(x, y, w, h, metersRan, baseDifficulty)
    xPos = x
    yPos = y
    width = w
    height = h
    addedDifficulty = metersRan -- not actually meters, but whatever
    difficultyBase = baseDifficulty
end

-- Add platforms from the x point specified at fromX to the x point specified at toX
function AddPlatforms(fromX, toX)
    xPos = fromX
    
    while (xPos < toX) do
        local diff = math.ceil(xPos / 1000)
        xPos = xPos + math.random(1, 1 + diff) * width
        yPos = yPos + math.random(-diff, diff) * height
        local rect = playdate.geometry.rect.new(xPos-width, yPos, width, height)
        playdate.graphics.drawRect(rect) -- todo: add collision
        Boxes[#Boxes+1] = rect
    end
end


    



