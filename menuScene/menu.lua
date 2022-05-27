import "CoreLibs/graphics"
import "CoreLibs/ui"


local gfx = playdate.graphics

local menuOptions = {"Play"}
local listview = playdate.ui.gridview.new(0, 10)
listview:setNumberOfRows(#menuOptions)
listview:setCellPadding(0, 0, 13, 10)
listview:setContentInset(24, 24, 13, 11)

function listview:drawCell(section, row, column, selected, x, y, width, height)
        if selected then
                gfx.fillRoundRect(x, y, width, 20, 4)
                gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        else
                gfx.setImageDrawMode(gfx.kDrawModeFIllBlack)
        end
        gfx.drawTextInRect(menuOptions[row], x, y+2, width, height, nil, "...", kTextAlignment.center)
end

function UpdateMenu()
    if playdate.buttonJustPressed("down") then
        listview:selectNextRow(false)
    end
    listview:drawInRect(220, 20, 160, 210)
end

