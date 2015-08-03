--init.lua, 3 second delay before running file
countdown = 3
tmr.alarm(0,1000,1,function()
    print(countdown)
    countdown = countdown-1
    if countdown<1 then
        tmr.stop(0)
        countdown = nil
        local s,err
        s,err = pcall(function() dofile("displayTemp.lua") end)
        if not s then print(err) end
    end
end)
