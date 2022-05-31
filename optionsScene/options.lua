import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

function UpdateOptions()
    gfx.clear()
    gfx.drawText("No options available. Press Ⓑ to go back.", 0, 0, nil, kTextAlignment.center)
end