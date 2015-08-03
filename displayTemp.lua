OSS = 3 -- oversampling setting (0-3)
bmp180 = require("bmp180")

local tempOffset = -3 -- deg f, how much to offset the reported number
dhtPin = 4

config = require("config")

wifi.setmode(wifi.STATION)
wifi.sta.config(config.wifiNetwork,config.wifiPassword)

local data = {
    inTemp = "",
    outTemp = "",
    inPress = "",
    outCond = "",
    inHum = "",
    outHum = ""
}

local display = require("display")

-- setup I2c and connect to modules
function init()
    -- SDA and SCL can be assigned freely to available GPIOs
    local sda = 1 -- GPIO0 == pin D3
    local scl = 2 -- GPIO2 == pin D4 
    bmp180.init(sda, scl)
    
end


function getIn() 
    bmp180.read(OSS)
    t = bmp180.getTemperature()
    p = bmp180.getPressure()
    data.inTemp = (9 * t / 50 + 32) + tempOffset
    data.inPress = (p / 100)

    status,temp,humidity,temp_decimial,humi_decimial = dht.read11(dhtPin)
    if (status == dht.OK) then
      data.inHum = humidity
    else
        -- other possibilities are dht.ERROR_TIMEOUT and dht.ERROR_CHECKSUM
      data.inHum = "?"
    end
end

y = require "yahoo-weather"
function getOut() 
    y.fetch(function(outTemp, outHum, outCond)
        data.outTemp = outTemp or "?"
        data.outHum = outHum or "?"
        data.outCond = outCond or "?"
        display.render(data)
    end)
end

function update() 
    getIn()
    display.render(data)
end



print("setting up")
init()
display.init(config.oledAddr)
getOut()
update()
tmr.alarm(0, 1000, 1, update )
tmr.alarm(2, 5*60*1000, 1, getOut ) -- 5*60*1000 = every 5 minutes
print("all set")
