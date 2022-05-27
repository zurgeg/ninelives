import "CoreLibs/ui"
import "CoreLibs/graphics"

local gfx = playdate.graphics
local options = {"you'd", "better", "properly", "draw", "these"}
local menu = playdate.ui.gridview.new(0, 20)
menu:setNumberOfRows(#options)

function menu:drawCell(section, row, column, selected, x, y, width, height)
    gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    gfx.drawText(options[row], x, y+2, width, height, kTextAlignment.center)
end

function UpdateMenu()
    menu:drawInRect(0, 0, 400, 240)
end