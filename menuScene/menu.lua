import "CoreLibs/ui"
import "CoreLibs/graphics"

local gfx = playdate.graphics
local options = {"you'd", "better", "properly", "draw", "these"}
local menu = playdate.ui.gridview.new(0, 20)
menu:setNumberOfRows(#options)

function menu:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.fillRoundRect(x, y, width, 20, 4)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    else
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRoundRect(x, y, width, 20, 4)
        gfx.setColor(gfx.kColorBlack)
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)
    end
    gfx.drawText(options[row], x, y+2, width, height, kTextAlignment.center)
end

function UpdateMenu()
    if playdate.buttonJustPressed(playdate.kButtonDown) then
        menu:selectNextRow(false)
    elseif playdate.buttonJustPressed(playdate.kButtonUp) then
        menu:selectPreviousRow(false)
    end
    menu:drawInRect(0, 0, 400, 240)
end