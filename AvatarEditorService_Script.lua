--\\ Made By noketchupjustrice#3666 //--
--\\ This script utilizes the AvatarEditorService service to change your character in game any way youd like without going to the avatar page on roblox. //--
--\\ Variables //--

--\\ Services //--
local AvatarEditorService = game:GetService("AvatarEditorService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game.CoreGui
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")

--\\ L //--
local AvatarEditorPrompts = CoreGui:WaitForChild("AvatarEditorPrompts")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

if not Character or not Character.Parent then
    Character = LocalPlayer.CharacterAdded:Wait()
end

local Humanoid = Character:WaitForChild("Humanoid")
local CurrentDescription = Humanoid:GetAppliedDescription()
--\\ Settings //--
local Settings = {
    TargetToCopy = "me", -- Either target's shortened username or display name or "me" for yourself and change the settings up
    RigType = Enum.HumanoidRigType.R15, -- R6/R15
    CustomScales = false,
    Refresh = true
}

local function GetPlayer(Name)
	Name = Name:lower()
	if Name == "me" then
		return LocalPlayer
	else
		for _,x in next, Players:GetPlayers() do
			if x ~= LocalPlayer then
				if x.Name:lower():match("^"..Name) then
					return x;
				elseif x.DisplayName:lower():match("^"..Name) then
					return x;
				end
			end
		end
	end
	return
end

local Target = GetPlayer(tostring(Settings.TargetToCopy))
local TargetRig = Target.Character.Humanoid.RigType
local CurrentDescription = Players:GetHumanoidDescriptionFromUserId(Target.UserId)

if Settings.CustomScales then
    CurrentDescription.BodyTypeScale = 1.5 -- 0 - 1.5 idk exact max and min values too lazy
	CurrentDescription.DepthScale = 1.5
	CurrentDescription.HeadScale = 1.5
	CurrentDescription.HeightScale = 1.5
	CurrentDescription.ProportionScale = 1.5
	CurrentDescription.WidthScale = 1.5
end

if Settings.TargetToCopy then
    AvatarEditorService:PromptSaveAvatar(CurrentDescription, TargetRig)
else
    AvatarEditorService:PromptSaveAvatar(CurrentDescription, Settings.RigType)
end

local PromptFrame = AvatarEditorPrompts:WaitForChild("PromptFrame")
local Prompt = PromptFrame:WaitForChild("Prompt")
local ConfirmButton = Prompt.AlertContents.Footer.Buttons:FindFirstChild("2")
local Origin = ConfirmButton.AbsolutePosition + ConfirmButton.AbsoluteSize / 2 + GuiService:GetGuiInset()

for i = 0,1 do
    VirtualInputManager:SendMouseButtonEvent(Origin.X, Origin.Y, 0, i == 0, ConfirmButton, 1)
end

if Settings.Refresh then
    local Saved = Character.HumanoidRootPart.CFrame
    Character:BreakJoints()
    LocalPlayer.CharacterAdded:Wait()
    LocalPlayer.Character:WaitForChild("ForceField"):Destroy()
    LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Saved
end
