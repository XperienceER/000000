if not game:IsLoaded() then
    game.Loaded:Wait()
end

local scripts = {
    [142823291] = "https://raw.githubusercontent.com/XperienceER/000000/refs/heads/main/Murder%20Mystery%202.lua", -- Murder Mystery 2
    [124216119978534] = "https://raw.githubusercontent.com/XperienceER/000000/refs/heads/main/Ride%20a%20Pet.lua", -- Ride a Pet
    [537413528] = "https://raw.githubusercontent.com/XperienceER/000000/refs/heads/main/Build%20a%20Boat%20For%20Treasure.lua"  -- Build a Boat For Treasure
}

local scriptUrl = scripts[game.PlaceId]

if not scriptUrl then
    return
end

local success, source = pcall(function()
    return game:HttpGet(scriptUrl, true)
end)

if not success or not source or source == "" then
    return
end

local compileSuccess, fn = pcall(loadstring, source)

if not compileSuccess or type(fn) ~= "function" then
    return
end

pcall(fn)
