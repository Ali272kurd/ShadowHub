-- ==================================================
-- SHADOWHUB - ULTIMATE BLADE BALL CHEAT
-- Shadow Parry // Auto Clicker // Premium UI
-- Version: 2.5 - Jin-Woo Shadow Monarch Edition
-- ==================================================

-- Safety pcall
local success, err = pcall(function()

print("Loading ShadowHub v2.5...")

-- Disable broken game script
pcall(function()
    local replicatedFirst = game:GetService("ReplicatedFirst")
    local actor = replicatedFirst:FindFirstChild("Actor")
    if actor then
        local script = actor:FindFirstChild("LocalScript")
        if script then
            script.Disabled = true
        end
    end
end)

task.wait(0.3)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- SHADOW COLORS - Jin-Woo Monarch Theme
-- ==================================================

local C = {
    primary = Color3.fromRGB(120, 50, 255),        -- Electric Violet
    primaryDark = Color3.fromRGB(60, 20, 150),
    primaryGlow = Color3.fromRGB(150, 80, 255),
    secondary = Color3.fromRGB(0, 200, 255),        -- Neon Blue
    secondaryGlow = Color3.fromRGB(50, 220, 255),
    accent = Color3.fromRGB(200, 100, 255),
    dark = Color3.fromRGB(4, 4, 8),
    bg = Color3.fromRGB(6, 6, 12),
    panel = Color3.fromRGB(10, 10, 18),
    panelLight = Color3.fromRGB(18, 18, 28),
    text = Color3.fromRGB(240, 240, 245),
    dim = Color3.fromRGB(140, 140, 170),
    green = Color3.fromRGB(0, 255, 80),
    gold = Color3.fromRGB(255, 215, 0),
    blue = Color3.fromRGB(60, 160, 255),
    red = Color3.fromRGB(255, 40, 40),
    purple = Color3.fromRGB(160, 60, 255),
    pink = Color3.fromRGB(255, 80, 180),
    cyan = Color3.fromRGB(0, 255, 255),
    orange = Color3.fromRGB(255, 150, 0),
    glass = Color3.fromRGB(255, 255, 255),
    shadow = Color3.fromRGB(2, 2, 6),
}

local function notify(msg, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🌑 ShadowHub",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShadowHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- SHADOW UI HELPERS
-- ==================================================

local function addShadowStroke(obj, thickness)
    thickness = thickness or 2
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.primary
    stroke.Transparency = 0.3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

local function addGlowStroke(obj, thickness)
    thickness = thickness or 3
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.primaryGlow
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

local function addBlueGlow(obj, thickness)
    thickness = thickness or 3
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.secondary
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

-- ==================================================
-- OPEN/CLOSE BUTTON - Shadow Monarch
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 70)
toggleBtn.Position = UDim2.new(1, -80, 0, 10)
toggleBtn.BackgroundColor3 = C.dark
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🌑"
toggleBtn.TextColor3 = Color3.fromRGB(200, 150, 255)
toggleBtn.TextSize = 35
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

-- Glow ring - violet
local glowRing = Instance.new("Frame")
glowRing.Size = UDim2.new(1.4, 0, 1.4, 0)
glowRing.Position = UDim2.new(-0.2, 0, -0.2, 0)
glowRing.BackgroundColor3 = C.primary
glowRing.BackgroundTransparency = 0.9
glowRing.BorderSizePixel = 0
glowRing.Parent = toggleBtn
local glowRingCorner = Instance.new("UICorner")
glowRingCorner.CornerRadius = UDim.new(0, 28)
glowRingCorner.Parent = glowRing

-- Secondary blue glow
local blueGlow = Instance.new("Frame")
blueGlow.Size = UDim2.new(1.6, 0, 1.6, 0)
blueGlow.Position = UDim2.new(-0.3, 0, -0.3, 0)
blueGlow.BackgroundColor3 = C.secondary
blueGlow.BackgroundTransparency = 0.92
blueGlow.BorderSizePixel = 0
blueGlow.Parent = toggleBtn
local blueGlowCorner = Instance.new("UICorner")
blueGlowCorner.CornerRadius = UDim.new(0, 32)
blueGlowCorner.Parent = blueGlow

-- Corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 20)
toggleCorner.Parent = toggleBtn

-- Strokes
addShadowStroke(toggleBtn, 2.5)
addGlowStroke(toggleBtn, 3)
addBlueGlow(toggleBtn, 2)

-- Glass overlay
local toggleGlass = Instance.new("Frame")
toggleGlass.Size = UDim2.new(1, 0, 1, 0)
toggleGlass.BackgroundColor3 = C.glass
toggleGlass.BackgroundTransparency = 0.92
toggleGlass.BorderSizePixel = 0
toggleGlass.Parent = toggleBtn
local toggleGlassCorner = Instance.new("UICorner")
toggleGlassCorner.CornerRadius = UDim.new(0, 20)
toggleGlassCorner.Parent = toggleGlass

-- Pulse animation
task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.06
            pcall(function()
                glowRing.Size = UDim2.new(1.4 * scale, 0, 1.4 * scale, 0)
                glowRing.Position = UDim2.new(-0.2 * scale, 0, -0.2 * scale, 0)
                glowRing.BackgroundTransparency = 0.85 + math.sin(t * math.pi * 2) * 0.05
                blueGlow.Size = UDim2.new(1.6 * scale, 0, 1.6 * scale, 0)
                blueGlow.Position = UDim2.new(-0.3 * scale, 0, -0.3 * scale, 0)
            end)
            task.wait(0.016)
        end
    end
end)

-- Mouse tracking
local mouse = {X = 0, Y = 0}
pcall(function()
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            mouse.X = input.Position.X
            mouse.Y = input.Position.Y
        end
    end)
end)

-- Draggable toggle
local toggleDragging = false
local toggleDragOff = Vector2.new(0, 0)

pcall(function()
    toggleBtn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDragging = true
            toggleDragOff = Vector2.new(mouse.X - toggleBtn.AbsolutePosition.X, mouse.Y - toggleBtn.AbsolutePosition.Y)
        end
    end)
end)

pcall(function()
    UserInputService.InputChanged:Connect(function(i)
        if toggleDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            pcall(function()
                toggleBtn.Position = UDim2.new(0, mouse.X - toggleDragOff.X, 0, mouse.Y - toggleDragOff.Y)
            end)
        end
    end)
end)

pcall(function()
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDragging = false
        end
    end)
end)

-- ==================================================
-- SHADOW MAIN HUB - Ultra Premium
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 500, 0, 600)
hub.Position = UDim2.new(0.5, -250, 0.5, -300)
hub.BackgroundColor3 = C.shadow
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 0
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 28)
hc.Parent = hub

addShadowStroke(hub, 2)
addGlowStroke(hub, 3)
addBlueGlow(hub, 2)

-- Outer glow
local outerGlow = Instance.new("Frame")
outerGlow.Size = UDim2.new(1.15, 0, 1.15, 0)
outerGlow.Position = UDim2.new(-0.075, 0, -0.075, 0)
outerGlow.BackgroundColor3 = C.primary
outerGlow.BackgroundTransparency = 0.96
outerGlow.BorderSizePixel = 0
outerGlow.Parent = hub
local outerGlowCorner = Instance.new("UICorner")
outerGlowCorner.CornerRadius = UDim.new(0, 32)
outerGlowCorner.Parent = outerGlow

-- Glass panel
local glassPanel = Instance.new("Frame")
glassPanel.Size = UDim2.new(1, 0, 1, 0)
glassPanel.BackgroundColor3 = C.glass
glassPanel.BackgroundTransparency = 0.94
glassPanel.BorderSizePixel = 0
glassPanel.Parent = hub
local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 28)
glassCorner.Parent = glassPanel

-- ==================================================
-- HEADER - Shadow Parry // Blade Ball v2.5
-- ==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 80)
header.BackgroundColor3 = C.dark
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0
header.Parent = hub

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 28)
headerCorner.Parent = header

-- Header glow line
local glowLine = Instance.new("Frame")
glowLine.Size = UDim2.new(1, 0, 0, 2)
glowLine.Position = UDim2.new(0, 0, 1, -2)
glowLine.BackgroundColor3 = C.primary
glowLine.BackgroundTransparency = 0.1
glowLine.BorderSizePixel = 0
glowLine.Parent = header
addGlowStroke(glowLine, 3)

-- Blue accent line
local blueLine = Instance.new("Frame")
blueLine.Size = UDim2.new(0.6, 0, 0, 1.5)
blueLine.Position = UDim2.new(0.2, 0, 1, -2)
blueLine.BackgroundColor3 = C.secondary
blueLine.BackgroundTransparency = 0.3
blueLine.BorderSizePixel = 0
blueLine.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 10)
title.BackgroundTransparency = 1
title.Text = "SHADOW PARRY // BLADE BALL v2.5"
title.TextColor3 = C.text
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextStrokeTransparency = 0.2
title.Parent = header

-- Subtitle - Pulsing aura
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -40, 0, 20)
subtitle.Position = UDim2.new(0, 20, 0, 52)
subtitle.BackgroundTransparency = 1
subtitle.Text = "✦ SHADOW MONARCH ✦ JIN-WOO EDITION ✦"
subtitle.TextColor3 = C.primaryGlow
subtitle.TextSize = 12
subtitle.Font = Enum.Font.GothamSemibold
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextStrokeTransparency = 0.3
subtitle.Parent = header

-- Pulsing subtitle
task.spawn(function()
    while subtitle and subtitle.Parent do
        for t = 0, 1, 0.05 do
            local alpha = 0.5 + math.sin(t * math.pi * 2) * 0.5
            pcall(function()
                subtitle.TextStrokeTransparency = 0.3 + (1 - alpha) * 0.5
                subtitle.TextColor3 = C.primaryGlow:Lerp(C.secondary, alpha * 0.5)
            end)
            task.wait(0.02)
        end
    end
end)

-- ==================================================
-- MAIN CONTENT AREA
-- ==================================================

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -100)
content.Position = UDim2.new(0, 10, 0, 90)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = C.primary
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = hub

local cl = Instance.new("UIListLayout")
cl.Padding = UDim.new(0, 12)
cl.SortOrder = Enum.SortOrder.LayoutOrder
cl.Parent = content

local cp = Instance.new("UIPadding")
cp.PaddingTop = UDim.new(0, 5)
cp.PaddingBottom = UDim.new(0, 10)
cp.Parent = content

cl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(0, 0, 0, cl.AbsoluteContentSize.Y + 20)
end)

-- ==================================================
-- CUSTOM UI ELEMENTS - Shadow Style
-- ==================================================

local function shadowSection(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 30)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "◈ " .. text
    l.TextColor3 = C.primaryGlow
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Position = UDim2.new(0, 10, 0, 0)
    l.Parent = s
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1.5)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = C.primary
    line.BackgroundTransparency = 0.3
    line.BorderSizePixel = 0
    line.Parent = s
    addGlowStroke(line, 2)
    
    return s
end

local function shadowToggle(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 12)
    fCorner.Parent = f
    addShadowStroke(f, 1.5)
    addGlowStroke(f, 2)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 12)
    fGlassCorner.Parent = fGlass
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 1, 0)
    icon.Position = UDim2.new(0, 12, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "⚔"
    icon.TextColor3 = C.primaryGlow
    icon.TextSize = 22
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.Parent = f
    
    -- Title
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -100, 0, 20)
    l.Position = UDim2.new(0, 50, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    -- Status text
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -100, 0, 18)
    status.Position = UDim2.new(0, 50, 0, 26)
    status.BackgroundTransparency = 1
    status.Text = default and "STATE: ACTIVE // PRECISION: PROXIMITY_LOCK" or "STATE: INACTIVE"
    status.TextColor3 = default and C.green or C.dim
    status.TextSize = 10
    status.Font = Enum.Font.GothamSemibold
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = f
    
    -- Toggle switch
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 52, 0, 28)
    btn.Position = UDim2.new(1, -60, 0.5, -14)
    btn.BackgroundColor3 = default and C.primary or Color3.fromRGB(30, 30, 40)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = f
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    addShadowStroke(btn, 1)
    
    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(0, 22, 0, 22)
    circ.Position = default and UDim2.new(1, -26, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)
    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circ.BorderSizePixel = 0
    circ.Parent = btn
    local circCorner = Instance.new("UICorner")
    circCorner.CornerRadius = UDim.new(0, 11)
    circCorner.Parent = circ
    
    local state = default or false
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and C.primary or Color3.fromRGB(30, 30, 40)
        status.Text = state and "STATE: ACTIVE // PRECISION: PROXIMITY_LOCK" or "STATE: INACTIVE"
        status.TextColor3 = state and C.green or C.dim
        pcall(function()
            circ:TweenPosition(state and UDim2.new(1, -26, 0.5, -11) or UDim2.new(0, 4, 0.5, -11), "Out", "Quad", 0.12, true)
        end)
        pcall(cb, state)
    end)
    
    return {get = function() return state end, set = function(v) state = v end}
end

local function shadowSlider(parent, text, min, max, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 55)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 12)
    fCorner.Parent = f
    addShadowStroke(f, 1.5)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 12)
    fGlassCorner.Parent = fGlass
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, 22)
    l.Position = UDim2.new(0, 12, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 13
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -24, 0, 5)
    bg.Position = UDim2.new(0, 12, 0, 34)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    bg.BorderSizePixel = 0
    bg.Parent = f
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 3)
    bgCorner.Parent = bg
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = C.primary
    fill.BorderSizePixel = 0
    fill.Parent = bg
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = fill
    
    -- Blue glow on fill
    local fillGlow = Instance.new("Frame")
    fillGlow.Size = UDim2.new(1, 0, 2, 0)
    fillGlow.Position = UDim2.new(0, 0, -0.5, 0)
    fillGlow.BackgroundColor3 = C.secondary
    fillGlow.BackgroundTransparency = 0.7
    fillGlow.BorderSizePixel = 0
    fillGlow.Parent = fill
    local fillGlowCorner = Instance.new("UICorner")
    fillGlowCorner.CornerRadius = UDim.new(0, 3)
    fillGlowCorner.Parent = fillGlow
    
    local val = def
    local valueInput = Instance.new("TextBox")
    valueInput.Size = UDim2.new(0, 52, 0, 24)
    valueInput.Position = UDim2.new(1, -60, 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
    valueInput.Text = tostring(def)
    valueInput.TextColor3 = C.text
    valueInput.TextSize = 12
    valueInput.Font = Enum.Font.GothamSemibold
    valueInput.TextXAlignment = Enum.TextXAlignment.Center
    valueInput.BorderSizePixel = 0
    valueInput.Parent = f
    local valueCorner = Instance.new("UICorner")
    valueCorner.CornerRadius = UDim.new(0, 5)
    valueCorner.Parent = valueInput
    addShadowStroke(valueInput, 1)
    
    valueInput.FocusLost:Connect(function()
        local num = tonumber(valueInput.Text)
        if num then
            num = math.clamp(num, min, max)
            val = num
            local rel = (num - min) / (max - min)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            l.Text = text .. ": " .. tostring(math.floor(num*10)/10)
            pcall(cb, num)
        end
        valueInput.Text = tostring(math.floor(val*10)/10)
    end)
    
    local function update(x)
        pcall(function()
            local rel = math.clamp((x - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            val = min + (max - min) * rel
            l.Text = text .. ": " .. tostring(math.floor(val*10)/10)
            valueInput.Text = tostring(math.floor(val*10)/10)
            pcall(cb, val)
        end)
    end
    
    bg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            update(i.Position.X)
        end
    end)
    
    return {get = function() return val end, set = function(v) val = v end}
end

-- ==================================================
-- AUTO PARRY CORE ENGINE
-- ==================================================

local parryEnabled = false
local parryDelay = 0.15
local parryRadius = 15

local function getNearestBall()
    local playerChar = player.Character
    if not playerChar then return nil end
    
    local playerPos = playerChar:FindFirstChild("HumanoidRootPart")
    if not playerPos then return nil end
    
    local nearestBall = nil
    local nearestDist = math.huge
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Name:find("Ball") then
            local dist = (obj.Position - playerPos.Position).Magnitude
            if dist < nearestDist and dist < parryRadius then
                nearestDist = dist
                nearestBall = obj
            end
        end
    end
    
    return nearestBall, nearestDist
end

-- Auto Parry main loop
coroutine.wrap(function()
    while task.wait(parryDelay) do
        if parryEnabled then
            local ball, dist = getNearestBall()
            if ball then
                -- Simulate click to parry
                pcall(function()
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                    task.wait(0.01)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                end)
            end
        end
    end
end)()

-- ==================================================
-- AUTO CLICKER
-- ==================================================

local clickerEnabled = false
local clickFrequency = 12

coroutine.wrap(function()
    while task.wait(1 / clickFrequency) do
        if clickerEnabled then
            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.01)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end)
        end
    end
end)()

-- ==================================================
-- BUILD UI
-- ==================================================

-- Section: Parry Core
shadowSection(content, "AUTO PARRY CORE ENGINE")
local parryToggle = shadowToggle(content, "Auto Parry", false, function(s)
    parryEnabled = s
    notify(s and "⚔ Auto Parry ACTIVE" or "⚔ Auto Parry INACTIVE", 2)
end)

local parrySlider = shadowSlider(content, "PARRY RESPONSE DELAY (ms)", 50, 500, 150, function(v)
    parryDelay = v / 1000
end)

local parryRadiusSlider = shadowSlider(content, "PARRY PROXIMITY RADIUS", 5, 30, 15, function(v)
    parryRadius = v
end)

-- Section: Auto Clicker
shadowSection(content, "AUTO CLICKER SYSTEM")
local clickerToggle = shadowToggle(content, "Auto Clicker", false, function(s)
    clickerEnabled = s
    notify(s and "🌀 Auto Clicker ACTIVE" or "🌀 Auto Clicker INACTIVE", 2)
end)

local clickSlider = shadowSlider(content, "CLICK FREQUENCY (CPS)", 1, 20, 12, function(v)
    clickFrequency = math.floor(v)
end)

-- ==================================================
-- FOOTER - SHADOW MONARCH CREDIT
-- ==================================================

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, 35)
footer.Position = UDim2.new(0, 0, 1, -35)
footer.BackgroundColor3 = C.dark
footer.BackgroundTransparency = 0.2
footer.BorderSizePixel = 0
footer.Parent = hub

local footerCorner = Instance.new("UICorner")
footerCorner.CornerRadius = UDim.new(0, 28)
footerCorner.Parent = footer

local footerText = Instance.new("TextLabel")
footerText.Size = UDim2.new(1, 0, 1, 0)
footerText.BackgroundTransparency = 1
footerText.Text = "🌑 SHADOW MONARCH // JIN-WOO EDITION 🌑"
footerText.TextColor3 = C.primaryGlow
footerText.TextSize = 12
footerText.Font = Enum.Font.GothamBold
footerText.TextXAlignment = Enum.TextXAlignment.Center
footerText.Parent = footer

local footerSub = Instance.new("TextLabel")
footerSub.Size = UDim2.new(1, 0, 0, 14)
footerSub.Position = UDim2.new(0, 0, 1, -14)
footerSub.BackgroundTransparency = 1
footerSub.Text = "✦ SHADOWHUB v2.5 // BLADE BALL CHEAT ✦"
footerSub.TextColor3 = C.secondary
footerSub.TextSize = 9
footerSub.Font = Enum.Font.GothamSemibold
footerSub.TextXAlignment = Enum.TextXAlignment.Center
footerSub.Parent = footer

-- ==================================================
-- DRAG HUB
-- ==================================================

local hubDragging = false
local hubDragOff = Vector2.new(0, 0)

pcall(function()
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            hubDragging = true
            hubDragOff = Vector2.new(mouse.X - hub.AbsolutePosition.X, mouse.Y - hub.AbsolutePosition.Y)
        end
    end)
end)

pcall(function()
    UserInputService.InputChanged:Connect(function(i)
        if hubDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            pcall(function()
                hub.Position = UDim2.new(0, mouse.X - hubDragOff.X, 0, mouse.Y - hubDragOff.Y)
            end)
        end
    end)
end)

pcall(function()
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            hubDragging = false
        end
    end)
end)

-- ==================================================
-- TOGGLE BUTTON FUNCTIONALITY
-- ==================================================

toggleBtn.MouseButton1Click:Connect(function()
    hub.Visible = not hub.Visible
    if hub.Visible then
        pcall(function()
            hub:TweenSize(UDim2.new(0, 500, 0, 600), "Out", "Back", 0.5, true)
        end)
        toggleBtn.Text = "🌑"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.05
    else
        toggleBtn.Text = "🌑"
        toggleBtn.BackgroundColor3 = C.dark
        toggleBtn.BackgroundTransparency = 0.1
    end
end)

print("==========================================")
print("✅ SHADOWHUB v2.5 - BLADE BALL CHEAT")
print("📋 Features:")
print("   🌑 Shadow Monarch Jin-Woo Theme")
print("   ⚔ Auto Parry - Proximity Lock")
print("   🌀 Auto Clicker - Adjustable CPS")
print("   🎯 Parry Response Delay Slider")
print("   📏 Parry Proximity Radius Slider")
print("   🖱️ Click Frequency Slider")
print("   💎 Premium Glassmorphism UI")
print("==========================================")

end) -- End of pcall

-- If there was an error, print it
if not success then
    print("❌ ShadowHub Error: " .. tostring(err))
    warn("Error loading ShadowHub: " .. tostring(err))
end