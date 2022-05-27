import "rng/rng.lua"

local function generateRect(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
    local width = RandomNumber(minWidth, maxWidth)
    local height = RandomNumber(minHeight, maxHeight)
    local x = RandomNumber(minX, maxX)
    local y = RandomNumber(minY, maxY)
    local platform = playdate.geometry.rect.new(x, y, width, height)
    return platform
end

local function generateGroundSprite(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
    local platform = generateRect(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
    playdate.graphics.fillRect(platform)
    local groundSprite = playdate.graphics.sprite.new(platform)
    groundSprite:add()
    return platform, groundSprite
end

local function generateGroundCollision(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
    local platform, groundSprite = generateGroundSprite(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
    groundSprite:setCollideRect(platform)
    return groundSprite
end

function GenerateGround(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight, numberRects)
    local platforms = {}
    for i = 1, numberRects do
        local platform = generateGroundCollision(minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight)
        table.insert(platforms, platform)
    end
    return platforms
end



