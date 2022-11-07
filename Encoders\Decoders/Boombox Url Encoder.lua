--\\ Simple url encoder I made for boomboxes and also has baits so it can't be decoded by most stupid decoders //--
--\\ https://www.tutorialspoint.com/html/html_url_encoding.htm //--
local AssetID = "142376088"
local LocalPlayer = game:GetService("Players")["LocalPlayer"]
local Character = LocalPlayer["Character"]
Character["Humanoid"]:UnequipTools()
local Tool = LocalPlayer["Backpack"]:FindFirstChildOfClass("Tool")
local Format, Byte, Gsub = string.format, string.byte, string.gsub
local Stepped = game:GetService("RunService").Stepped

--\\ Bait Tables //--
local Id_Table = {
    "%&%69%64", -- "%&id"
    "%&%49%64", -- "%&Id"
    "%&%49%44", -- "%&ID"
    "%&%69%44" -- "%&iD"
}

local AssetVersionId_Table = {
    "%&%61%73%73%65%74%56%65%72%73%69%6F%6E%49%64", -- "%&assetVersionId"
    "%&%61%73%73%65%74%56%65%72%73%69%6F%6E%69%44", -- "%&assetVersioniD"
    "%&%61%73%73%65%74%56%65%72%73%69%6F%6E%49%44", -- "%&assetVersionID"
    "%&%61%73%73%65%74%56%65%72%73%69%6F%6E%69%64" -- "%&assetVersionid
}

--\\ Encoding Functions //--
local function Character_To_Hex(v)
    return Format("%%%02X", Byte(v))
end
local function Url_Encode(Input)
    if not Input then
        return
    end
    Input = Gsub(Input, "\n", "\r\n")
    Input = Gsub(Input, ".", Character_To_Hex)
    Input = Gsub(Input, " ", "+")
    return Input
end

--\\ Main Script //--
local Bait_Amount = 12

AssetID = Url_Encode(tostring(AssetID))

for i = 1, Bait_Amount do
    Stepped:Wait()
    AssetID = AssetID .. Id_Table[math.random(1, #Id_Table)] .. "=" .. "00" .. AssetID .. "%00"
end

for i = 1, Bait_Amount do
    Stepped:Wait()
    AssetID = AssetID .. AssetVersionId_Table[(math.random(1, #AssetVersionId_Table))] .. "=" .. "00%00" .. "%00"
end

AssetID = string.gsub(AssetID, "=", "=")

Character["Humanoid"]:EquipTool(Tool)
Tool["Remote"]:FireServer("PlaySong", AssetID)
print("Output: " .. AssetID)
setclipboard(AssetID)
