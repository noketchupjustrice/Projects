local Targets = {"fawedawfawfawfwa","l"}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local OldFPDH = workspace.FallenPartsDestroyHeight
local AllPlayers = false
local function GetPlayer(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllPlayers = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers, Player) then
            table.remove(GetPlayers, table.find(GetPlayers, Player))
        end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^" .. Name) then
                    return x
                elseif x.DisplayName:lower():match("^" .. Name) then
                    return x
                end
            end
        end
    else
        return
    end
end

local FWait = function(Number)
    local Current = tick()
    Number = Number or 0
    repeat
        game:GetService("RunService").Heartbeat:Wait()
    until tick() - Current >= Number
    return tick() - Current
end

local Fling = function(Target)
    local Character = LocalPlayer.Character
    local RootPart = Character.HumanoidRootPart
    local Humanoid = Character:FindFirstChild("Humanoid")
    local Head = Character:FindFirstChild("Head")

    local TargetCharacter = Target.Character
    local TargetHead = TargetCharacter:FindFirstChild("Head")
    local TargetHumanoid = TargetCharacter:FindFirstChild("Humanoid")
    local TargetRoot = TargetCharacter:FindFirstChild("HumanoidRootPart")

    if Character and Humanoid and RootPart and Head then
        OldPos = RootPart.CFrame
        if TargetHead then
            workspace.CurrentCamera.CameraSubject = TargetHead
        else
            workspace.CurrentCamera.CameraSubject = TargetCharacter
        end
        if not Character:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local function ForcePosition(Base, Position, Angle)
            LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Base.Position) * Position * Angle)
            RootPart.Velocity = Vector3.new(9e9, 9e9, 9e9)
            RootPart.RotVelocity = Vector3.new(9e9, 9e9, 9e9)
            RootPart.AssemblyAngularVelocity = Vector3.new(9e9, 9e9, 9e9)
            RootPart.AssemblyLinearVelocity = Vector3.new(9e9, 9e9, 9e9)
        end

        local ForceBasePart = function(BasePart)
            local FlingTime = 3.5
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and TargetCharacter then
                    Angle = Angle + 100
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection * BasePart.Velocity.Magnitude / 2,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, 3, 0) + TargetHumanoid.MoveDirection,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                    ForcePosition(
                        BasePart,
                        CFrame.new(0, -3, 0) + TargetHumanoid.MoveDirection,
                        CFrame.Angles(0, 0, math.rad(Angle))
                    )
                    FWait(0)
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 1000 or BasePart.Parent ~= TargetCharacter or Humanoid.Health <= 0 or
                tick() > Time + FlingTime
        end
        workspace.FallenPartsDestroyHeight = 0 / 0
        Humanoid:SetStateEnabled("Seated", false)
        if Character:FindFirstChild("Animate") then
            Character:FindFirstChild("Animate").Disabled = true
        end
        local B = Instance.new("BodyVelocity")
        B.Parent = RootPart
        B.Velocity = Vector3.new(9e9, 9e9, 9e9)
        B.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
        if TargetCharacter and TargetRoot then
            ForceBasePart(TargetRoot)
        else
            ForceBasePart(TargetHead)
        end
        B:Destroy()
        Humanoid:ChangeState("GettingUp")
        Humanoid:SetStateEnabled("Seated", true)
        workspace.CurrentCamera.CameraSubject = Character
        workspace.FallenPartsDestroyHeight = OldFPDH
        if Character:FindFirstChild("Animate") then
            Character:FindFirstChild("Animate").Disabled = false
        end
        for i, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Velocity, v.RotVelocity, v.AssemblyAngularVelocity, v.AssemblyLinearVelocity =
                    Vector3.new(),
                    Vector3.new(),
                    Vector3.new(),
                    Vector3.new()
            end
        end
        Character:SetPrimaryPartCFrame(OldPos)
    end
end

if Targets[1] then
    for i, v in next, Targets do
        GetPlayer(v)
    end
else
    return
end

if AllPlayers then
    for i, v in next, Players:GetPlayers() do
        Fling(v)
    end
else
    for i, v in next, Targets do
        if GetPlayer(v) and GetPlayer(v) ~= LocalPlayer then
            local TPlayer = GetPlayer(v)
            if TPlayer then
                Fling(TPlayer)
            end
        else
            print("Error Target Not Found")
        end
    end
end
