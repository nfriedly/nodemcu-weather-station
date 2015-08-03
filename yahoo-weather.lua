httpClient = require "http-client"

-- woeid query: select woeid from geo.places(1) where text="Pleasant Hill, OH"
-- test at https://developer.yahoo.com/yql/console/

local url = "https://query.yahooapis.com/v1/public/yql?format=json&q="
    .."select%20atmosphere.humidity%2Citem.condition.temp%2C%20item.condition.text"
    .."%20from%20weather.forecast%20where%20woeid=2473861"
    --skipping %2C%20item.forecast for now
        
local y = {}

function y.fetch(callback)
    httpClient.getJson(url, function(json) 
        local outTemp = json.query.results.channel.item.condition.temp -- arrays start at 1 in lua
        local outHum = json.query.results.channel.atmosphere.humidity
        local outCond = json.query.results.channel.item.condition.text --json.query.results.channel[1].forecast.text
        -- todo: get pressure, high, low, more of forecast, maybe "real feel"
        json = nil
        collectgarbage()
        callback(outTemp, outHum, outCond)
    end)
end

return y