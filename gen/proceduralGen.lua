import "rng/rng.lua"

function GenerateNRects(n, minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight, minGap, maxGap)
    local rects = {}
    local gap = 0
    local x = 0
    local y = 0
    local width = 0
    local height = 0
    for i = 1, n do
        x = RandomNumber(minX, maxX)
        y = RandomNumber(minY, maxY)
        width = RandomNumber(minWidth, maxWidth)
        height = RandomNumber(minHeight, maxHeight)
        gap = RandomNumber(minGap, maxGap)
        table.insert(rects, {x = x, y = y, width = width, height = height, gap = gap})
    end
    return rects
end

function RectsToSprites(collisionType, n, minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight, minGap, maxGap)
    local sprites = {}
    local rects = GenerateNRects(n, minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight, minGap, maxGap)
    for i = 1, #rects do
        local invalid = true
        local rect = playdate.geometry.rect.new(rects[i].x, rects[i].y, rects[i].width, rects[i].height)
        while invalid do
            local fakeSprite = playdate.graphics.sprite.new(rect)
            local checks = {
                {
                    rects[i].x + rects[i].gap,
                    rects[i].y + rects[i].gap
                },
                {
                    rects[i].x + rects[i].gap,
                    0
                },
                {
                    0,
                    rects[i].y + rects[i].gap
                },
                {
                    -rects[i].x + rects[i].gap,
                    rects[i].y + rects[i].gap
                },
                {
                    -rects[i].x + rects[i].gap,
                    0
                },
                {
                    0,
                    -rects[i].y + rects[i].gap
                },
                {
                    rects[i].x + rects[i].gap,
                    -rects[i].y + rects[i].gap
                }
            }
            SetUpCollision(fakeSprite, collisionType)
            fakeSprite:setCollideRect(rect)
            for j = 1, #checks do
                local x = checks[j][1]
                local y = checks[j][2]
                local aX, aY, col, length = fakeSprite:checkCollisions(rect.x + x, rect.y + y)
                if aX ~= x + rect.x or aY ~= y + rect.x then
                    local newRect = GenerateNRects(1, minX, maxX, minY, maxY, minWidth, maxWidth, minHeight, maxHeight, minGap, maxGap)
                    rects[i] = newRect[1]
                    invalid = true
                    break
                else
                    invalid = false
                end
            end
        end
        local validrect = playdate.geometry.rect.new(rects[i].x, rects[i].y, rects[i].width, rects[i].height)
        local sprite = playdate.graphics.sprite.new(validrect)
        sprite:add()
        SetUpCollision(sprite, collisionType)
        assert (validrect)
        sprite:setCollideRect(validrect)
        playdate.graphics.fillRect(validrect)
        table.insert(sprites, sprite)
    end
    return sprites
end