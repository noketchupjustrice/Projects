local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldmt = mt.__namecall
mt.__namecall =
    newcclosure(
    function(Self, ...)
        local method = getnamecallmethod()
        if method == "Kick" then
            print("Kick Attempt Detected")
            wait(9e9)
            return nil
        end
        return oldmt(Self, ...)
    end
)
setreadonly(mt, true)
