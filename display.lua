local display = {}

local disp

display.init = function(oledAddr)
    -- i2c.setup(0, sda, scl, i2c.SLOW) - bmp180 does this automatically
    disp = u8g.ssd1306_128x64_i2c(oledAddr)
end

function draw(data)
    local y = 0
    -- font options are font_10x20r,font_6x10,font_9x18r,font_helvR18r,font_helvR24
    -- create a new build with more options at http://frightanic.com/nodemcu-custom-build/

    y = y+10
    disp:setFont(u8g.font_9x18r)
    disp:drawStr(0, y, "In:")
    disp:drawStr(64, y, "Out:")
    
    y = y+30
    disp:setFont(u8g.font_helvR24)
    
    disp:drawStr(0, y, data.inTemp .. string.char(0xb0)) -- degree symbol
    disp:drawStr(64, y, data.outTemp .. string.char(0xb0))

    y = y+14
    disp:setFont(u8g.font_6x10)
    disp:drawStr(0, y, data.inPress .. " mbar")
    disp:drawStr(64, y, data.outCond)
    y = y+10
    disp:drawStr(0, y, data.inHum .. "% humid")
    disp:drawStr(64, y, data.outHum .. "% humid")
end

display.render = function(data)
    disp:firstPage()
    repeat
        draw(data)
    until disp:nextPage() == false
end

return display