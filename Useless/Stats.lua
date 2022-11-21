local Stats = game:GetService("Stats")
local CurrentPing = string.split(Stats.Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. "ms"
local FpsManager = Stats.FrameRateManager
print("Current Ping | " .. tostring(CurrentPing))
task.wait(0.5)
print("Current FPS | "..math.round(1000 / FpsManager.RenderAverage:GetValue()))
