--Bored so I made this
--\\ Variables //--
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserId = LocalPlayer.UserId
local NewPatchName = "p_" .. tostring(UserId)
if not CoreGui.PlayerList.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame[NewPatchName].ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName then
  return warn("Unsupported")
end
local PlayerNameText = CoreGui.PlayerList.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame[NewPatchName].ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName

--\\ Init //--
coroutine.wrap(function()
  while PlayerNameText ~= nil do
      task.wait()
      PlayerNameText.TextColor3 = Color3.fromHSV(tick() % 1 / 1, 1, 1)
  end
end)()
