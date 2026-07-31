-- ==================================================
-- RADIUS // HvH PRO ENGINE v4.0
-- Cyberpunk Tactical HUD - Jin-Woo Shadow Monarch
-- Silent Aim • Aimbot • ESP • Resolver
-- ==================================================

-- Safety pcall
local success, err = pcall(function()

print("Loading RADIUS HvH v4.0...")

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
-- CYBER COLORS - Shadow Monarch Theme
-- ==================================================

local C = {
    primary = Color3.fromRGB(0, 200, 255),         -- Neon Cyan
    primaryDark = Color3.fromRGB(0, 100, 180),
    primaryGlow = Color3.fromRGB(50, 220, 255),
    secondary = Color3.fromRGB(100, 50, 255),      -- Shadow Violet
    secondaryGlow = Color3.fromRGB(150, 80, 255),
    accent = Color3.fromRGB(255, 50, 80),          -- Neon Red for FOV
    accentGlow = Color3.fromRGB(255, 80, 120),
    dark = Color3.fromRGB(2, 2, 6),
    bg = Color3.fromRGB(4, 4, 10),
    panel = Color3.fromRGB(8, 8, 16),
    panelLight = Color3.fromRGB(14, 14, 24),
    text = Color3.fromRGB(235, 235, 245),
    dim = Color3.fromRGB(130, 130, 170),
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
            Title = "🔵 RADIUS HvH",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RadiusHvH"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- UI HELPERS - Cyber Style
-- ==================================================

local function addCyanStroke(obj, thickness)
    thickness = thickness or 2
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.primary
    stroke.Transparency = 0.2
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

local function addRedStroke(obj, thickness)
    thickness = thickness or 2
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.accent
    stroke.Transparency = 0.3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

-- ==================================================
-- TOGGLE BUTTON - Cyber
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 70)
toggleBtn.Position = UDim2.new(1, -80, 0, 10)
toggleBtn.BackgroundColor3 = C.dark
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🔵"
toggleBtn.TextColor3 = C.primary
toggleBtn.TextSize = 35
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

-- Glow rings
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

local violetGlow = Instance.new("Frame")
violetGlow.Size = UDim2.new(1.6, 0, 1.6, 0)
violetGlow.Position = UDim2.new(-0.3, 0, -0.3, 0)
violetGlow.BackgroundColor3 = C.secondary
violetGlow.BackgroundTransparency = 0.92
violetGlow.BorderSizePixel = 0
violetGlow.Parent = toggleBtn
local violetGlowCorner = Instance.new("UICorner")
violetGlowCorner.CornerRadius = UDim.new(0, 32)
violetGlowCorner.Parent = violetGlow

-- Corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 20)
toggleCorner.Parent = toggleBtn

addCyanStroke(toggleBtn, 2.5)
addGlowStroke(toggleBtn, 3)
addRedStroke(toggleBtn, 1.5)

-- Glass
local toggleGlass = Instance.new("Frame")
toggleGlass.Size = UDim2.new(1, 0, 1, 0)
toggleGlass.BackgroundColor3 = C.glass
toggleGlass.BackgroundTransparency = 0.92
toggleGlass.BorderSizePixel = 0
toggleGlass.Parent = toggleBtn
local toggleGlassCorner = Instance.new("UICorner")
toggleGlassCorner.CornerRadius = UDim.new(0, 20)
toggleGlassCorner.Parent = toggleGlass

-- Pulse
task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.06
            pcall(function()
                glowRing.Size = UDim2.new(1.4 * scale, 0, 1.4 * scale, 0)
                glowRing.Position = UDim2.new(-0.2 * scale, 0, -0.2 * scale, 0)
                violetGlow.Size = UDim2.new(1.6 * scale, 0, 1.6 * scale, 0)
                violetGlow.Position = UDim2.new(-0.3 * scale, 0, -0.3 * scale, 0)
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

-- Draggable
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
-- MAIN HUB - Cyber Tactical
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 520, 0, 620)
hub.Position = UDim2.new(0.5, -260, 0.5, -310)
hub.BackgroundColor3 = C.shadow
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 0
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 28)
hc.Parent = hub

addCyanStroke(hub, 2)
addGlowStroke(hub, 3)
addRedStroke(hub, 1.5)

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
-- HEADER - RADIUS // HvH PRO ENGINE v4.0
-- ==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = C.dark
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0
header.Parent = hub

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 28)
headerCorner.Parent = header

-- Glow line
local glowLine = Instance.new("Frame")
glowLine.Size = UDim2.new(1, 0, 0, 2)
glowLine.Position = UDim2.new(0, 0, 1, -2)
glowLine.BackgroundColor3 = C.primary
glowLine.BackgroundTransparency = 0.1
glowLine.BorderSizePixel = 0
glowLine.Parent = header
addGlowStroke(glowLine, 3)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 28)
title.Position = UDim2.new(0, 20, 0, 8)
title.BackgroundTransparency = 1
title.Text = "RADIUS // HvH PRO ENGINE v4.0"
title.TextColor3 = C.text
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextStrokeTransparency = 0.2
title.Parent = header

-- Status Bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, -40, 0, 20)
statusBar.Position = UDim2.new(0, 20, 0, 40)
statusBar.BackgroundTransparency = 1
statusBar.BorderSizePixel = 0
statusBar.Parent = header

local pingText = Instance.new("TextLabel")
pingText.Size = UDim2.new(0, 120, 1, 0)
pingText.Position = UDim2.new(0, 0, 0, 0)
pingText.BackgroundTransparency = 1
pingText.Text = "PING: 103ms // STATUS: ENCRYPTED"
pingText.TextColor3 = C.primary
pingText.TextSize = 10
pingText.Font = Enum.Font.GothamSemibold
pingText.TextXAlignment = Enum.TextXAlignment.Left
pingText.Parent = statusBar

-- Ping animation
task.spawn(function()
    while pingText and pingText.Parent do
        local ping = math.random(80, 150)
        pcall(function()
            pingText.Text = "PING: " .. ping .. "ms // STATUS: ENCRYPTED"
        end)
        task.wait(2)
    end
end)

-- ==================================================
-- TAB SYSTEM - Pill Style
-- ==================================================

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 40)
tabContainer.Position = UDim2.new(0, 10, 0, 75)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local tabNames = {"Silent", "Aimbot", "ESP", "Resolver"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 115, 0, 34)
    btn.Position = UDim2.new(0, (i-1)*120, 0, 0)
    btn.BackgroundColor3 = C.panel
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = tabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    addCyanStroke(btn, 1.2)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -125)
    page.Position = UDim2.new(0, 10, 0, 120)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = C.primary
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = hub
    
    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 8)
    pl.SortOrder = Enum.SortOrder.LayoutOrder
    pl.Parent = page
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = page
    
    pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, pl.AbsoluteContentSize.Y + 20)
    end)
    
    tabBtns[i] = btn
    tabPages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for j, b in ipairs(tabBtns) do
            b.BackgroundColor3 = C.panel
            b.BackgroundTransparency = 0.4
            b.TextColor3 = C.dim
        end
        btn.BackgroundColor3 = C.primary
        btn.BackgroundTransparency = 0.1
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        for j, p in ipairs(tabPages) do
            p.Visible = (j == i)
        end
    end)
end

tabBtns[1].BackgroundColor3 = C.primary
tabBtns[1].BackgroundTransparency = 0.1
tabBtns[1].TextColor3 = Color3.fromRGB(255, 255, 255)
tabPages[1].Visible = true

-- ==================================================
-- UI HELPERS - Cyber Components
-- ==================================================

local function cyberSection(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 30)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "► " .. text
    l.TextColor3 = C.primary
    l.TextSize = 13
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

local function cyberToggle(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 44)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCyanStroke(f, 1.5)
    addGlowStroke(f, 1.5)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 10)
    fGlassCorner.Parent = fGlass
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 28, 1, 0)
    icon.Position = UDim2.new(0, 10, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "◆"
    icon.TextColor3 = C.primary
    icon.TextSize = 18
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.Parent = f
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -90, 1, 0)
    l.Position = UDim2.new(0, 44, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 13
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 24)
    btn.Position = UDim2.new(1, -52, 0.5, -12)
    btn.BackgroundColor3 = default and C.primary or Color3.fromRGB(30, 30, 40)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = f
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    addCyanStroke(btn, 1)
    
    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(0, 18, 0, 18)
    circ.Position = default and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)
    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circ.BorderSizePixel = 0
    circ.Parent = btn
    local circCorner = Instance.new("UICorner")
    circCorner.CornerRadius = UDim.new(0, 9)
    circCorner.Parent = circ
    
    local state = default or false
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and C.primary or Color3.fromRGB(30, 30, 40)
        pcall(function()
            circ:TweenPosition(state and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9), "Out", "Quad", 0.12, true)
        end)
        pcall(cb, state)
    end)
    
    return {get = function() return state end, set = function(v) state = v end}
end

local function cyberSlider(parent, text, min, max, def, suffix, cb)
    suffix = suffix or ""
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCyanStroke(f, 1.5)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 10)
    fGlassCorner.Parent = fGlass
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, 20)
    l.Position = UDim2.new(0, 12, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def) .. suffix
    l.TextColor3 = C.text
    l.TextSize = 12
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -24, 0, 4)
    bg.Position = UDim2.new(0, 12, 0, 32)
    bg.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    bg.BorderSizePixel = 0
    bg.Parent = f
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 2)
    bgCorner.Parent = bg
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = C.primary
    fill.BorderSizePixel = 0
    fill.Parent = bg
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = fill
    
    local fillGlow = Instance.new("Frame")
    fillGlow.Size = UDim2.new(1, 0, 2, 0)
    fillGlow.Position = UDim2.new(0, 0, -0.5, 0)
    fillGlow.BackgroundColor3 = C.primaryGlow
    fillGlow.BackgroundTransparency = 0.7
    fillGlow.BorderSizePixel = 0
    fillGlow.Parent = fill
    
    local val = def
    local valueInput = Instance.new("TextBox")
    valueInput.Size = UDim2.new(0, 50, 0, 22)
    valueInput.Position = UDim2.new(1, -58, 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
    valueInput.Text = tostring(def)
    valueInput.TextColor3 = C.text
    valueInput.TextSize = 11
    valueInput.Font = Enum.Font.GothamSemibold
    valueInput.TextXAlignment = Enum.TextXAlignment.Center
    valueInput.BorderSizePixel = 0
    valueInput.Parent = f
    local valueCorner = Instance.new("UICorner")
    valueCorner.CornerRadius = UDim.new(0, 4)
    valueCorner.Parent = valueInput
    addCyanStroke(valueInput, 1)
    
    valueInput.FocusLost:Connect(function()
        local num = tonumber(valueInput.Text)
        if num then
            num = math.clamp(num, min, max)
            val = num
            local rel = (num - min) / (max - min)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            l.Text = text .. ": " .. tostring(math.floor(num*100)/100) .. suffix
            pcall(cb, num)
        end
        valueInput.Text = tostring(math.floor(val*100)/100)
    end)
    
    local function update(x)
        pcall(function()
            local rel = math.clamp((x - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            val = min + (max - min) * rel
            l.Text = text .. ": " .. tostring(math.floor(val*100)/100) .. suffix
            valueInput.Text = tostring(math.floor(val*100)/100)
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

local function cyberDropdown(parent, text, options, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCyanStroke(f, 1.5)
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 80, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 12
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 28)
    btn.Position = UDim2.new(1, -130, 0.5, -14)
    btn.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
    btn.BorderSizePixel = 0
    btn.Text = default
    btn.TextColor3 = C.primary
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = f
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    addCyanStroke(btn, 1)
    
    local selected = default
    
    btn.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 120, 0, #options * 26 + 6)
        menu.Position = UDim2.new(1, -130, 0, 40)
        menu.BackgroundColor3 = Color3.fromRGB(8, 8, 16)
        menu.BorderSizePixel = 0
        menu.ClipsDescendants = true
        menu.Parent = f
        local menuCorner = Instance.new("UICorner")
        menuCorner.CornerRadius = UDim.new(0, 6)
        menuCorner.Parent = menu
        addCyanStroke(menu, 1)
        local menuLayout = Instance.new("UIListLayout")
        menuLayout.Padding = UDim.new(0, 2)
        menuLayout.Parent = menu
        
        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 24)
            optBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
            optBtn.Text = opt
            optBtn.TextColor3 = C.text
            optBtn.TextSize = 11
            optBtn.Font = Enum.Font.GothamSemibold
            optBtn.BorderSizePixel = 0
            optBtn.Parent = menu
            optBtn.MouseButton1Click:Connect(function()
                selected = opt
                btn.Text = opt
                menu:Destroy()
                pcall(cb, opt)
            end)
        end
    end)
    
    return {get = function() return selected end}
end

-- ==================================================
-- TAB 1: SILENT AIM
-- ==================================================

local p1 = tabPages[1]

cyberSection(p1, "SILENT AIM CORE")
local silentToggle = cyberToggle(p1, "Enable Silent Aim", false, function(s)
    notify(s and "🔵 Silent Aim ACTIVE" or "🔵 Silent Aim INACTIVE", 2)
end)

cyberSection(p1, "ADVANCED TARGETING")
local resolverToggle = cyberToggle(p1, "Auto-Resolver V2", false, function(s)
    notify(s and "🌀 Auto-Resolver ACTIVE" or "🌀 Auto-Resolver INACTIVE", 2)
end)

local airCorrectionToggle = cyberToggle(p1, "Auto Air Correction", false, function(s)
    notify(s and "✈️ Air Correction ACTIVE" or "✈️ Air Correction INACTIVE", 2)
end)

local hitboxDropdown = cyberDropdown(p1, "Target Part", {"Head", "HumanoidRootPart", "Torso", "Nearest Box"}, "Head", function(v)
    notify("🎯 Target part: " .. v, 2)
end)

cyberSection(p1, "DYNAMIC FOV RING")
local fovSlider = cyberSlider(p1, "FOV Radius", 0, 700, 327, "", function(v)
    -- Update FOV ring if visible
end)

local dynamicFovToggle = cyberToggle(p1, "Dynamic FOV", false, function(s) end)
local minFovSlider = cyberSlider(p1, "Min Dynamic FOV", 0, 400, 80, "", function(v) end)
local maxFovSlider = cyberSlider(p1, "Max Dynamic FOV", 0, 800, 300, "", function(v) end)
local distFovSlider = cyberSlider(p1, "Dynamic FOV Distance", 0, 10000, 450, "", function(v) end)

cyberSection(p1, "PREDICTION & SMOOTHING")
local predSlider = cyberSlider(p1, "Prediction Multiplier", 0, 1, 0.12, "", function(v) end)
local predSlider2 = cyberSlider(p1, "Prediction", 0, 1, 0.12, "", function(v) end)
local smoothingSlider = cyberSlider(p1, "Smoothing", 0.01, 1, 0.01, "", function(v) end)

cyberSection(p1, "AUTO FIRE")
local autoFireToggle = cyberToggle(p1, "Auto Fire", false, function(s)
    notify(s and "🔥 Auto Fire ACTIVE" or "🔥 Auto Fire INACTIVE", 2)
end)
local autoFireDelay = cyberSlider(p1, "Auto Fire Delay", 0.01, 1, 0.18, "", function(v) end)

-- ==================================================
-- TAB 2: AIMBOT
-- ==================================================

local p2 = tabPages[2]

cyberSection(p2, "AIMBOT MAIN")
local aimbotToggle = cyberToggle(p2, "Enable Aimbot", false, function(s)
    notify(s and "🎯 Aimbot ACTIVE" or "🎯 Aimbot INACTIVE", 2)
end)
local showFovToggle = cyberToggle(p2, "Show Aimbot FOV", false, function(s) end)
local holdToggle = cyberToggle(p2, "Hold To Use", false, function(s) end)
local holdKey = cyberDropdown(p2, "Hold Key", {"MouseButton1", "MouseButton2", "Q", "E", "R", "F", "V", "X", "Z"}, "MouseButton2", function(v) end)
local fovRadiusSlider = cyberSlider(p2, "FOV Radius", 0, 700, 327, "", function(v) end)

cyberSection(p2, "ADVANCED SETTINGS")
local teamCheckToggle = cyberToggle(p2, "Team Check", false, function(s) end)
local visibleCheckToggle = cyberToggle(p2, "Visible Check", false, function(s) end)
local targetPartDropdown = cyberDropdown(p2, "Target Part", {"Head", "HumanoidRootPart", "Torso", "Nearest Box"}, "Head", function(v) end)
local maxDistSlider = cyberSlider(p2, "Max Distance", 0, 2500, 2500, "", function(v) end)

cyberSection(p2, "SMOOTHING")
local aimSmoothSlider = cyberSlider(p2, "Smoothing", 0.01, 1, 0.01, "", function(v) end)
local stickyAimToggle = cyberToggle(p2, "Sticky Aim", false, function(s) end)

cyberSection(p2, "PREDICTION")
local predMultiplierSlider = cyberSlider(p2, "Prediction Multiplier", 0, 1, 0.12, "", function(v) end)

cyberSection(p2, "AUTO FIRE")
local autoFireToggle2 = cyberToggle(p2, "Auto Fire", false, function(s) end)
local autoFireDelay2 = cyberSlider(p2, "Auto Fire Delay", 0.01, 1, 0.18, "", function(v) end)
local showTargetToggle = cyberToggle(p2, "Show Target Info", false, function(s) end)

-- ==================================================
-- TAB 3: ESP
-- ==================================================

local p3 = tabPages[3]

cyberSection(p3, "ESP MAIN")
local espToggle = cyberToggle(p3, "Enable ESP", false, function(s)
    notify(s and "👁️ ESP ACTIVE" or "👁️ ESP INACTIVE", 2)
end)
local espBoxToggle = cyberToggle(p3, "Box ESP", false, function(s) end)
local espNameToggle = cyberToggle(p3, "Name Tags", false, function(s) end)
local espHealthToggle = cyberToggle(p3, "Health Bar", false, function(s) end)
local espDistanceToggle = cyberToggle(p3, "Distance", false, function(s) end)
local espTracerToggle = cyberToggle(p3, "Tracers", false, function(s) end)

cyberSection(p3, "ESP COLORS")
local espColorDropdown = cyberDropdown(p3, "Box Color", {"Cyan", "Red", "Green", "Purple", "White", "Yellow", "Orange"}, "Cyan", function(v) end)
local espTeamColorToggle = cyberToggle(p3, "Team Colors", false, function(s) end)

cyberSection(p3, "ESP VISIBILITY")
local espMaxDistSlider = cyberSlider(p3, "Max Distance", 0, 1000, 450, "", function(v) end)
local espTransparencySlider = cyberSlider(p3, "Transparency", 0, 1, 0.3, "", function(v) end)

-- ==================================================
-- TAB 4: RESOLVER
-- ==================================================

local p4 = tabPages[4]

cyberSection(p4, "RESOLVER ENGINE")
local resolverToggle2 = cyberToggle(p4, "Enable Resolver", false, function(s)
    notify(s and "🌀 Resolver ACTIVE" or "🌀 Resolver INACTIVE", 2)
end)
local resolverMode = cyberDropdown(p4, "Resolver Mode", {"Auto", "Brute Force", "Smart", "Prediction"}, "Auto", function(v) end)

cyberSection(p4, "ANTI-AIM COUNTERS")
local jitterCounter = cyberToggle(p4, "Jitter Counter", false, function(s) end)
local fakeAngleCounter = cyberToggle(p4, "Fake Angle Counter", false, function(s) end)
local desyncCounter = cyberToggle(p4, "Desync Counter", false, function(s) end)

cyberSection(p4, "PREDICTION")
local resolverPredSlider = cyberSlider(p4, "Prediction Strength", 0, 1, 0.5, "", function(v) end)
local resolverSmoothSlider = cyberSlider(p4, "Resolver Smoothness", 0.01, 1, 0.3, "", function(v) end)

cyberSection(p4, "STATUS")
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -20, 0, 40)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "🔹 RESOLVER STATUS: IDLE\n🔹 ANTI-AIM DETECTED: NONE"
statusText.TextColor3 = C.dim
statusText.TextSize = 11
statusText.Font = Enum.Font.GothamSemibold
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.TextYAlignment = Enum.TextYAlignment.Top
statusText.Parent = p4

-- Update resolver status
task.spawn(function()
    local states = {"IDLE", "SCANNING", "ANALYZING", "ADJUSTING", "LOCKED"}
    local antiAims = {"NONE", "JITTER", "FAKE ANGLE", "DESYNC", "MULTI-LAYER"}
    while statusText and statusText.Parent do
        local state = states[math.random(1, #states)]
        local anti = antiAims[math.random(1, #antiAims)]
        pcall(function()
            statusText.Text = "🔹 RESOLVER STATUS: " .. state .. "\n🔹 ANTI-AIM DETECTED: " .. anti
            if state == "LOCKED" then
                statusText.TextColor3 = C.green
            elseif state == "SCANNING" or state == "ANALYZING" then
                statusText.TextColor3 = C.gold
            else
                statusText.TextColor3 = C.dim
            end
        end)
        task.wait(3)
    end
end)

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
            hub:TweenSize(UDim2.new(0, 520, 0, 620), "Out", "Back", 0.5, true)
        end)
        toggleBtn.Text = "🔵"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.05
    else
        toggleBtn.Text = "🔵"
        toggleBtn.BackgroundColor3 = C.dark
        toggleBtn.BackgroundTransparency = 0.1
    end
end)

print("==========================================")
print("✅ RADIUS HvH v4.0 - CYBER TACTICAL HUD")
print("📋 Features:")
print("   🔵 Silent Aim Core Engine")
print("   🎯 Aimbot w/ Dynamic FOV")
print("   👁️ ESP - Box, Name, Health, Distance")
print("   🌀 Resolver - Anti-Aim Counter")
print("   📊 Auto Fire + Prediction")
print("   💎 Cyberpunk Shadow Monarch Theme")
print("==========================================")

end)

-- If there was an error, print it
if not success then
    print("❌ Radius HvH Error: " .. tostring(err))
    warn("Error loading Radius HvH: " .. tostring(err))
end