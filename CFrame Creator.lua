local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
local CreateCFrame = function(Round)
    local CFrame = RootPart.CFrame.Position
    if Round then
        local function RoundX(x)
            return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
        end
        local function RoundY(y)
            return y >= 0 and math.floor(y + 0.5) or math.ceil(y - 0.5)
        end
        local function RoundZ(z)
            return z >= 0 and math.floor(z + 0.5) or math.ceil(z - 0.5)
        end
        local RoundedCFrame = RoundX(CFrame.X) .. ", " .. RoundY(CFrame.Y) .. ", " .. RoundZ(CFrame.Z)
        return RoundedCFrame
    else
        return CFrame
    end
end

local NewCFrame = CreateCFrame(true)
local String = "CFrame.new(" .. tostring(NewCFrame) .. ")"
print(String)
setclipboard(String)
