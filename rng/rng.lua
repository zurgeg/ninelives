import "os"
import "math"

function SetupRNG(seed)
    if seed == nil then
        seed = os.time()
    end
    math.randomseed(seed)
end

function RandomNumber(min, max)
    return math.random(min, max)
end