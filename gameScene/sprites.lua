import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "AnimatedSprite/AnimatedSprite"
import "physics/spriteCollision"
import "rng/rng"

local gfx <const> = playdate.graphics

local catSprite = nil

local boxSprite = nil

local box

local hasUpdated = false

local movedThisFrame = false

local firstJumpFrame = true

local purrlinArray

PurrlinBoxes = {}
PurrlinSprites = {}

function SetUpSprites()
    playdate.graphics.setColor(playdate.graphics.kColorXOR)
    local catAnim = gfx.imagetable.new("gfx/anim/cat")
    box = playdate.geometry.rect.new(0, 200, 400,100)
    playdate.graphics.fillRect(box)
    boxSprite = playdate.graphics.sprite.new(box)
    purrlinArray = playdate.graphics.perlinArray(12, 0, 0.5) -- gens three rects (x, y, width, height)
    ---@diagnostic disable-next-line: undefined-global
    catSprite = AnimatedSprite.new(catAnim)
    assert (catSprite, "Failed to create cat sprite")
    assert (boxSprite, "Failed to create box sprite")
    catSprite:moveTo(200, 100)
    catSprite:add()
    boxSprite:add()
    catSprite:playAnimation()
    SetUpCollision(catSprite)
    SetUpCollision(boxSprite, "ground")
    boxSprite:setCollideRect(box)
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.fillRect(box)
    for i = 1, #purrlinArray do
        if i + 3 > #purrlinArray then
            break
        end
        local perlinBox = playdate.geometry.rect.new(purrlinArray[i], purrlinArray[i + 1], purrlinArray[i + 2], purrlinArray[i + 3])
        local perlinBoxSprite = playdate.graphics.sprite.new(perlinBox)
        SetUpCollision(perlinBoxSprite, "ground")
        perlinBoxSprite:setCollideRect(perlinBox)
        perlinBoxSprite:add()
        table.insert(PurrlinBoxes, perlinBox)
        table.insert(PurrlinSprites, perlinBoxSprite)
        i = i + 3
    end
    
    function catSprite:collisionResponse(otherSprite)
        if CollisionList[otherSprite] == "ground" then
            return "slide"
        else
            return "slide"
        end
    end
end

function UpdateSprites()
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    movedThisFrame = false
    local crankDelta = playdate.getCrankChange()
    if not hasUpdated then
        hasUpdated = true
        playdate.graphics.sprite.update()
    end
    if ((playdate.buttonJustPressed(playdate.kButtonA) or playdate.buttonJustPressed(playdate.kButtonB) or playdate.buttonJustPressed(playdate.kButtonUp)) and IsGrounded(catSprite) and not JumpingSprites["cat"]) or JumpingSprites["cat"] then
        catSprite:pauseAnimation()
        movedThisFrame = true
        if IsGrounded(catSprite) and not JumpingSprites["cat"] then
            SetJumpForce("cat", 10)
            firstJumpFrame = true
        end
        if firstJumpFrame and not IsGrounded(catSprite) then
            catSprite:setRotation(RandomNumber(-10,10))
            if #catSprite:overlappingSprites() > 0 then
                catSprite:setRotation(0)
            else
                firstJumpFrame = false
            end
        end
        if crankDelta ~= 0 and not IsGrounded(catSprite) then
            local catRotation = catSprite:getRotation()
            local newCatRotation = catRotation + crankDelta
            catSprite:setRotation(newCatRotation)
            if #catSprite:overlappingSprites() > 0 then
                catSprite:setRotation(catRotation)
            end
        end
        ApplyJumpForce(catSprite, "cat")
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
    if IsGrounded(catSprite) and ((-3 > catSprite:getRotation()) or (catSprite:getRotation() > 3)) then
        -- todo: the player should die if they land on the box and are rotated
        catSprite:setRotation(0)
        JumpingSprites["cat"] = false
        playdate.graphics.sprite.update()
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        catSprite.globalFlip = gfx.kImageFlippedX
        if not JumpingSprites["cat"] then
            MoveWithGravity(catSprite, -7, 0)
        else
            TryMoveBy(catSprite, -7, 0)
        end
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        catSprite.globalFlip = gfx.kImageUnflipped
        if not JumpingSprites["cat"] then
            MoveWithGravity(catSprite, 7, 0)
        else
            TryMoveBy(catSprite, 7, 0)
        end
        movedThisFrame = true
        playdate.graphics.sprite.update()
    end
    if not movedThisFrame then
        catSprite:pauseAnimation()
        UpdateGravity(catSprite)
        playdate.graphics.sprite.update()
        catSprite:playAnimation()
    end
    box = playdate.geometry.rect.new(0, 200, 400,100)
    playdate.graphics.fillRect(box)
    for i = 1, #PurrlinBoxes do
        playdate.graphics.fillRect(PurrlinBoxes[i])
    end
end

