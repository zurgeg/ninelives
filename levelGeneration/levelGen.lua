--[[
    function setup() {
        createCanvas(400, 400);
        background(220);
        
        let x = 0;
        let y = 200;
        
        const w = 20;
        const h = 20;
        
        while (x < 600){
          const diff = x / 100
          
          x += int(random(1, 1 + diff)) * w
          y += int(random(-diff, diff)) * h
          rect(x-w, y, w, h)
        }
      }
      
      function draw() {
        
      }
p5.js code courtesy of https://devforum.play.date/t/nine-lives-a-weird-platformer/6538/12
--]]
local xPos
local yPos
local width
local height
local difficulty
local metersRan

DifficultyEasy = 0
DifficultyMedium = 100
DifficultyHard = 200
DifficultyHardcore = 500
DifficultyForceKill = 99999999 -- for testing death screen and whatnot

function SetUpLevelGen(x, y, w, h, metersRan, baseDifficulty)
    xPos = x
    yPos = y
    width = w
    height = h
    metersRan = metersRan -- not actually meters, but whatever
    difficulty = baseDifficulty
end

function AddPlatforms(fromX, toX)
    xPos = fromX
    
    local diff = difficulty + metersRan / 100
    
    while (xPos < toX) do
        xPos = xPos + math.random(1, 1 + diff) * width
        yPos = yPos + math.random(-diff, diff) * height
        playdate.graphics.fillRect(xPos-width, yPos, width, height) -- todo: add collision
    end
end


    



