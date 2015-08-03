-- based on https://github.com/mlk/nodemcu-http-client

local http = {}

function http.parseUrl(url)
    local components = {}
    components.scheme = string.match(url, "([^:]*):")
    components.host = string.match(url, components.scheme .. "://([^:/]*)[:/]?")
    components.port = string.match(url, components.scheme .. "://" .. components.host .. ":([%d]*)")
    baseUrl = components.scheme .. "://" .. components.host
    if components.port ~= nil then
        baseUrl = baseUrl .. ":" .. components.port
    end
    components.pathAndQueryString = string.sub(url, string.len(baseUrl) + 1)
    return components
end

function http.getContent(url, callWithData)
    http.sendContent("GET", url, nil, nil, callWithData)
end

function http.postContent(url, content, contentType, callWithData)
    http.sendContent("POST", url, content, contentType, callWithData)
end

function http.sendContent(method, url, contentToSend, contentType, callWithData)
    local components = http.parseUrl(url)
    if components.port == nil then
        components.port = 80
    else
        components.port = to_number(components.port)
    end
    if components.pathAndQueryString == nil or components.pathAndQueryString == "" then
        components.pathAndQueryString = "/"
    end


    
    local conn=net.createConnection(net.TCP, false) 
    conn:on("connection", function(conn) 
        conn:send(method .. " " .. components.pathAndQueryString .. " HTTP/1.0\r\nHost: " .. components.host .. "\r\n"
            .. "Accept: */*\r\nConnection: close\r\n")
            
                    
        if contentToSend ~= nil then
            if contentType == nil then
                contentType = "application/x-www-form-urlencoded"
            end
            conn:send("Content-Type: " .. contentType .. "\r\n");
            conn:send("Content-Length: " .. string.len(contentToSend) .. "\r\n\r\n")
            conn:send(contentToSend)
        else
            conn:send("\r\n")
        end
        
    end)
    local data = {}
    conn:on("receive", function(conn, pl)
        if (data.status) then -- already parsed first chunk, assuming done with headers
            data.content = data.content .. pl -- todo: consider creating a table of strings and concatenating at the end
        else -- parse status and headers, start of body
            data.status = string.match(pl, "HTTP/%d.%d (%d+)")
            local location = string.find(pl, "\r\n\r\n")
            if location ~= nil then
                data.content = string.sub(pl, location + 4)
            end
        end
        pl = nil
        collectgarbage()
    end)
    conn:on("disconnection", function() 
        callWithData(data)
        data = nil
        collectgarbage()
    end)
    conn:connect(components.port, components.host)
end

function http.getJson(url, callback)
    print("fetching "..url)
    httpClient.getContent(url, function(data) 
        if (data.status == 200 or data.status == "200") then
            json = cjson.decode(data.content)
            data = nil
            collectgarbage()
            callback(json)
        else
            print("status "..data.status.." from "..url.."\n"..data.content)
            return nil
        end
    end)
end

return http
