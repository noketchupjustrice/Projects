--noketchupjustrice#3666
--\\Settings//
local Sets = {
    LegRescale = true,
    RHandCheck = true,
    SeatCheck = true,
    Hide = true,
    Delay = true
}

--\\Variables//--
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Character:FindFirstChild("HumanoidRootPart")
--//\\--

--\\Functions//--
function GetPlayer(Target)
    for _, v in next, game:GetService("Players"):GetPlayers() do
        if v.Name:lower():sub(1, #Target) == Target:lower() or v.DisplayName:lower():sub(1, #Target) == Target then
            return v
        end
    end
end
function LegRescale()
    for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
        v:Stop()
    end
    Character:WaitForChild("Animate"):Destroy()
    Humanoid.Sit = true
    Humanoid:SetStateEnabled("Seated", false)
    local function Remove()
        for i, BasePart in pairs(Character:GetDescendants()) do
            if BasePart:IsA("BasePart") then
                for i, Attachment in pairs(BasePart:GetDescendants()) do
                    if Attachment:IsA("ValueBase") and Attachment:FindFirstChild("OriginalPosition") then
                        Attachment.OriginalPosition:Destroy()
                    end
                end
                BasePart:WaitForChild("OriginalSize"):Destroy()
            end
        end
    end
    Character.LeftUpperLeg.LeftKneeRigAttachment:Destroy()
    Character.LeftLowerLeg.LeftAnkleRigAttachment:Destroy()
    Character.LeftFoot.LeftFootAttachment:Destroy()
    for i = 1, 6 do
        Remove()
        Humanoid:FindFirstChildWhichIsA("NumberValue"):Destroy()
    end
end
TargetRigType = nil
function CheckRigType(Target)
    if Target.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
        TargetRigType = "R15"
    else
        TargetRigType = "R6"
    end
end
--\\//--

local Target = GetPlayer("dril")
--\\Start//--
if Sets.RHandCheck then
    CheckRigType(Target)
    if TargetRigType == "R15" then
        if not Target.Character:FindFirstChild("RightHand") then
            return print("Error, Player Is RHanded")
        end
    else
        if not Target.Character:FindFirstChild("Right Arm") then
            return print("Error, Player Is RArmed")
        end
    end
end
if Sets.SeatCheck then
    if Target.Character:FindFirstChildOfClass("Humanoid").Sit == true then
        return print("Error, Player Is Seated")
    end
end
Humanoid:UnequipTools()
if
    not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") or
        not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool"):FindFirstChildWhichIsA("Part")
 then
    return print("Error, Make Sure You Have A Tool With A Handle In Your BackPack")
end
if Sets.Delay then
    local Character = Humanoid:Clone()
    local OldC = LocalPlayer.Character
    LocalPlayer.Character = Clone
    LocalPlayer.Character = OldC
end
local Tool = LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
local SavedCFrame = Character:FindFirstChild("Head").CFrame
if Sets.LegRescale then
    LegRescale()
end
local Cloned = Humanoid:Clone()
Cloned.Parent = Character
Humanoid:Destroy()
if Sets.Delay then
    task.wait(4)
end
if Sets.Hide then
    Character:SetPrimaryPartCFrame(CFrame.new(RootPart.CFrame * Vector3.new(0, 2 ^ 53, 0)))
end
Tool.Parent = Character
firetouchinterest(Tool:FindFirstChildWhichIsA("Part"), Target.Character:FindFirstChild("Head"), 0)
Tool.AncestryChanged:Wait()
LocalPlayer.Character.Humanoid.Health = 0
LocalPlayer.Character = nil
LocalPlayer.CharacterAdded:Wait()
LocalPlayer.Character:WaitForChild "ForceField":Destroy()
LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = SavedCFrame
