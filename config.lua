local config = {
    oledAddr = 0x3c,
    
-- woeid query: select woeid from geo.places(1) where text="Pleasant Hill, OH"
-- (obviously, update with your location)
-- run/test at https://developer.yahoo.com/yql/console/

    woeid = "2473861",
    
    wifiNetwork = "...",
    wifiPassword = "..."
}

return config