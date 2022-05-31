import "CoreLibs/ui"
import "CoreLibs/graphics"

local gfx = playdate.graphics
local options = {"Play", "Options"}
local menu = playdate.ui.gridview.new(0, 20)
local menuFont = gfx.font.new("resources/Roobert-11-Medium")
local glyphFont = gfx.font.new("resources/Asheville-Sans-14-Light")
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
    elseif playdate.buttonJustPressed(playdate.kButtonA) then
        local section, row, column = menu:getSelection()
        if row == 1 then
            SetScene(SceneGame)
        elseif row == 2 then
            SetScene(SceneOptions)
        end
    end

    gfx.setFont(menuFont)
    menu:drawInRect(0, 0, 400, 240)
    glyphFont:drawText("✛", 200, 40, kTextAlignment.center)
    gfx.drawText(": Select option", 219, 40, menuFont, kTextAlignment.center)
    gfx.drawText("Ⓑ: Back", 200, 60, menuFont, kTextAlignment.center)
    gfx.drawText("Ⓐ: Confirm selection", 200, 80, menuFont, kTextAlignment.center)
end