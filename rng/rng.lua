function SetupRNG(seed)
    if seed == nil then
        seed = playdate.getSecondsSinceEpoch()
    end
    math.randomseed(seed)
end

function RandomNumber(min, max)
    return math.random(min, max)
end