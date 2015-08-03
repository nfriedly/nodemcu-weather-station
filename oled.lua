-- setup I2c and connect display
function init_i2c_display()
     -- SDA and SCL can be assigned freely to available GPIOs
     local sda = 3 -- GPIO0 == pin D3
     local scl = 4 -- GPIO2 == pin D4 
     local sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end


function draw()
    local y = 0
    -- font options are font_10x20r,font_6x10,font_9x18r,font_helvR18r,font_helvR24
    -- create a new build with more options at http://frightanic.com/nodemcu-custom-build/

    --y = y+10
    --disp:setFont(u8g.font_6x10)
    --disp:drawStr(0, y, "font_6x10")

    y = y+ 10
    disp:setFont(u8g.font_9x18r)
    disp:drawStr(0, y, "In:")
    disp:drawStr(64, y, "Out:")
    
    --y = y+ 22
    --disp:setFont(u8g.font_10x20r)
    --disp:drawStr(0, y, "font_10x20r")
    
    y = y + 34
    disp:setFont(u8g.font_helvR24)
    disp:drawStr(0, y, "72" .. string.char(0xb0)) -- degree symbol: ° (but it renders wrong if I just put that in the string)
    disp:drawStr(64, y, "86" .. string.char(0xb0)) -- degree symbol: ° (but it renders wrong if I just put that in the string)

    y = y+10 -- space
    y = y+10
    disp:setFont(u8g.font_6x10)
    disp:drawStr(0, y, "918 mbar")
end

print("start")
init_i2c_display()
disp:firstPage()
repeat
    draw()
until disp:nextPage() == false
print("done")
tmr.delay(50000)
