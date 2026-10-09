
-- XperienceER Protected Loader V2

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local function stop()
    return nil
end

-- Executor Blacklist
local blacklist = {
    "xeno",
    "solara"
}

local function isBlocked()
    local ok, name = pcall(function()
        if type(identifyexecutor) == "function" then
            return tostring(identifyexecutor()):lower()
        end
        return ""
    end)

    if not ok then
        return false
    end

    for _, blocked in ipairs(blacklist) do
        if name:find(blocked, 1, true) then
            return true
        end
    end

    return false
end

if isBlocked() then
    return stop()
end

-- URL assembled at runtime
local parts = {
    "https://",
    "raw.githubusercontent.com/",
    "XperienceER/",
    "000000/",
    "refs/heads/",
    "main/"
}

local function decode(bytes)
    local chars = table.create(#bytes)

    for i = 1, #bytes do
        chars[i] = string.char(bytes[i])
    end

    return table.concat(chars)
end

local files = {
    -- Murder Mystery 2
    [142823291] = {
        77,117,114,100,101,114,37,50,48,
        77,121,115,116,101,114,121,37,50,48,
        50,46,108,117,97
    },

    -- Ride a Pet
    [124216119978534] = {
        82,105,100,101,37,50,48,
        97,37,50,48,80,101,116,46,108,117,97
    },

    -- Build a Boat For Treasure
    [537413528] = {
        66,117,105,108,100,37,50,48,
        97,37,50,48,66,111,97,116,37,50,48,
        70,111,114,37,50,48,
        84,114,101,97,115,117,114,101,46,108,117,97
    }
}

local selected = files[game.PlaceId]

if not selected then
    return stop()
end

local url = table.concat(parts) .. decode(selected)

local ok, source = pcall(function()
    return game:HttpGet(url, true)
end)

if not ok or type(source) ~= "string"
    or source == "" then
    return stop()
end

local compiled, fn = pcall(loadstring, source)

if not compiled or type(fn) ~= "function" then
    return stop()
end

pcall(fn)
