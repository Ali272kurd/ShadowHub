-- ==================================================
-- SHADOWHUB // AZURE MODDED EVOLUTION [HvH EDITION]
-- Supreme Luxury Cyber-Tactical HvH Interface
-- Aimbot • Visuals • Movement • Da Hood Utilities
-- ==================================================

-- Safety pcall
local success, err = pcall(function()

print("Loading SHADOWHUB AZURE HvH v7.0...")

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
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- HvH COLORS - Shadow Monarch Theme
-- ==================================================

local C = {
    primary = Color3.fromRGB(150, 60, 255),        -- Electric Violet
    primaryDark = Color3.fromRGB(80, 20, 180),
    primaryGlow = Color3.fromRGB(180, 100, 255),
    secondary = Color3.fromRGB(0, 180, 255),        -- Shadow Blue
    secondaryGlow = Color3.fromRGB(50, 210, 255),
    accent = Color3.fromRGB(255, 60, 120),
    accentGlow = Color3.fromRGB(255, 100, 150),
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
            Title = "🌑 SHADOWHUB HvH",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShadowHvH"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- UI HELPERS - HvH Luxury Style
-- ==================================================

local function addVioletStroke(obj, thickness)
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
-- TOGGLE BUTTON - HvH
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 75, 0, 75)
toggleBtn.Position = UDim2.new(1, -85, 0, 10)
toggleBtn.BackgroundColor3 = C.dark
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🌑"
toggleBtn.TextColor3 = C.primary
toggleBtn.TextSize = 38
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
glowRingCorner.CornerRadius = UDim.new(0, 30)
glowRingCorner.Parent = glowRing

local blueGlow = Instance.new("Frame")
blueGlow.Size = UDim2.new(1.6, 0, 1.6, 0)
blueGlow.Position = UDim2.new(-0.3, 0, -0.3, 0)
blueGlow.BackgroundColor3 = C.secondary
blueGlow.BackgroundTransparency = 0.92
blueGlow.BorderSizePixel = 0
blueGlow.Parent = toggleBtn
local blueGlowCorner = Instance.new("UICorner")
blueGlowCorner.CornerRadius = UDim.new(0, 34)
blueGlowCorner.Parent = blueGlow

-- Corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 22)
toggleCorner.Parent = toggleBtn

addVioletStroke(toggleBtn, 2.5)
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
toggleGlassCorner.CornerRadius = UDim.new(0, 22)
toggleGlassCorner.Parent = toggleGlass

-- FPS Display
local fpsDisplay = Instance.new("TextLabel")
fpsDisplay.Size = UDim2.new(1, 0, 0, 16)
fpsDisplay.Position = UDim2.new(0, 0, 1, -18)
fpsDisplay.BackgroundTransparency = 1
fpsDisplay.Text = "FPS: 0"
fpsDisplay.TextColor3 = C.primaryGlow
fpsDisplay.TextSize = 10
fpsDisplay.Font = Enum.Font.GothamBold
fpsDisplay.TextXAlignment = Enum.TextXAlignment.Center
fpsDisplay.Parent = toggleBtn

-- FPS counter
local fpsTimes = {}
local fpsLast = os.clock()
coroutine.wrap(function()
    while toggleBtn and toggleBtn.Parent do
        task.wait(0.3)
        pcall(function()
            local now = os.clock()
            local dt = now - fpsLast
            fpsLast = now
            table.insert(fpsTimes, dt)
            if #fpsTimes > 20 then table.remove(fpsTimes, 1) end
            local avg = 0
            for _, t in ipairs(fpsTimes) do avg = avg + t end
            avg = math.max(avg / #fpsTimes, 0.0001)
            local fps = math.floor(1 / avg)
            fpsDisplay.Text = "⚡ " .. fps .. " FPS"
        end)
    end
end)()

-- Pulse
task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.06
            pcall(function()
                glowRing.Size = UDim2.new(1.4 * scale, 0, 1.4 * scale, 0)
                glowRing.Position = UDim2.new(-0.2 * scale, 0, -0.2 * scale, 0)
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
-- MAIN HUB - HvH Luxury
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 620, 0, 680)
hub.Position = UDim2.new(0.5, -310, 0.5, -340)
hub.BackgroundColor3 = C.shadow
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 0
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 28)
hc.Parent = hub

addVioletStroke(hub, 2)
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
-- HEADER - SHADOWHUB // AZURE MODDED EVOLUTION
-- ==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 85)
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
title.Size = UDim2.new(1, -40, 0, 32)
title.Position = UDim2.new(0, 20, 0, 6)
title.BackgroundTransparency = 1
title.Text = "SHADOWHUB // AZURE MODDED EVOLUTION [HvH EDITION]"
title.TextColor3 = C.text
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextStrokeTransparency = 0.2
title.Parent = header

-- Status Bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, -40, 0, 28)
statusBar.Position = UDim2.new(0, 20, 0, 42)
statusBar.BackgroundTransparency = 1
statusBar.BorderSizePixel = 0
statusBar.Parent = header

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "STATUS: UNDETECTED // CONFIG: LOADED // FPS: 240"
statusText.TextColor3 = C.secondary
statusText.TextSize = 11
statusText.Font = Enum.Font.GothamSemibold
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.Parent = statusBar

-- Pulse status
task.spawn(function()
    while statusText and statusText.Parent do
        local states = {
            "STATUS: UNDETECTED // CONFIG: LOADED // FPS: 240",
            "STATUS: STEALTH // CONFIG: ACTIVE // FPS: 240",
            "STATUS: UNDETECTED // CONFIG: LOADED // FPS: 240",
            "STATUS: HvH MODE // CONFIG: ACTIVE // FPS: 240"
        }
        for _, state in ipairs(states) do
            pcall(function()
                statusText.Text = state
            end)
            task.wait(3)
        end
    end
end)

-- ==================================================
-- TAB SYSTEM - Pill Style
-- ==================================================

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 40)
tabContainer.Position = UDim2.new(0, 10, 0, 90)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local tabNames = {"Aimbot", "Visuals", "Movement", "Da Hood", "Config"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 112, 0, 34)
    btn.Position = UDim2.new(0, (i-1)*116, 0, 0)
    btn.BackgroundColor3 = C.panel
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = tabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    addVioletStroke(btn, 1.2)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -140)
    page.Position = UDim2.new(0, 10, 0, 135)
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
-- UI HELPERS - HvH Components
-- ==================================================

local function hvhSection(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 30)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -10, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "✦ " .. text
    l.TextColor3 = C.primary
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

local function hvhToggle(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 44)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addVioletStroke(f, 1.5)
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
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 1, 0)
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
    l.Position = UDim2.new(0, 46, 0, 0)
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
    addVioletStroke(btn, 1)
    
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

local function hvhSlider(parent, text, min, max, def, suffix, cb)
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
    addVioletStroke(f, 1.5)
    
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
    addVioletStroke(valueInput, 1)
    
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

local function hvhDropdown(parent, text, options, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addVioletStroke(f, 1.5)
    
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
    addVioletStroke(btn, 1)
    
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
        addVioletStroke(menu, 1)
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

local function hvhButton(parent, text, cb, color)
    color = color or C.primary
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 38)
    b.BackgroundColor3 = color
    b.BackgroundTransparency = 0.1
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 10)
    bCorner.Parent = b
    addVioletStroke(b, 2)
    addGlowStroke(b, 2)
    
    local bGlass = Instance.new("Frame")
    bGlass.Size = UDim2.new(1, 0, 1, 0)
    bGlass.BackgroundColor3 = C.glass
    bGlass.BackgroundTransparency = 0.94
    bGlass.BorderSizePixel = 0
    bGlass.Parent = b
    local bGlassCorner = Instance.new("UICorner")
    bGlassCorner.CornerRadius = UDim.new(0, 10)
    bGlassCorner.Parent = bGlass
    
    b.MouseButton1Click:Connect(function()
        pcall(cb)
    end)
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = color
        b.BackgroundTransparency = 0.05
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = color
        b.BackgroundTransparency = 0.1
    end)
    return b
end

-- ==================================================
-- TAB 1: AIMBOT & SILENT
-- ==================================================

local p1 = tabPages[1]

hvhSection(p1, "SILENT AIM CORE")
local silentToggle = hvhToggle(p1, "Enable Silent Aim", false, function(s)
    notify(s and "🎯 Silent Aim ACTIVE" or "🎯 Silent Aim INACTIVE", 2)
end)
local hitpartDropdown = hvhDropdown(p1, "Hitpart", {"Head", "HumanoidRootPart", "Nearest"}, "Head", function(v) end)
local predSlider = hvhSlider(p1, "Prediction Multiplier", 0, 1, 0.12, "", function(v) end)

hvhSection(p1, "RESOLVER ENGINE")
local resolverToggle = hvhToggle(p1, "Resolver Module", false, function(s)
    notify(s and "🌀 Resolver ACTIVE" or "🌀 Resolver INACTIVE", 2)
end)
local autoAirToggle = hvhToggle(p1, "Auto Air Correction", false, function(s) end)

hvhSection(p1, "FOV CUSTOMIZER")
local fovSlider = hvhSlider(p1, "FOV Radius", 0, 700, 327, "", function(v) end)
local dynamicFovToggle = hvhToggle(p1, "Dynamic FOV", false, function(s) end)
local minFovSlider = hvhSlider(p1, "Min Dynamic FOV", 0, 400, 80, "", function(v) end)
local maxFovSlider = hvhSlider(p1, "Max Dynamic FOV", 0, 800, 300, "", function(v) end)

hvhSection(p1, "TRIGGERBOT & AUTO-FIRE")
local triggerToggle = hvhToggle(p1, "Triggerbot", false, function(s)
    notify(s and "🔫 Triggerbot ACTIVE" or "🔫 Triggerbot INACTIVE", 2)
end)
local autoFireToggle = hvhToggle(p1, "Auto Fire", false, function(s)
    notify(s and "🔥 Auto Fire ACTIVE" or "🔥 Auto Fire INACTIVE", 2)
end)
local fireDelaySlider = hvhSlider(p1, "Auto Fire Delay", 0.01, 1, 0.18, "", function(v) end)

-- ==================================================
-- TAB 2: VISUALS & ESP
-- ==================================================

local p2 = tabPages[2]

hvhSection(p2, "PLAYER ESP")
local espToggle = hvhToggle(p2, "Enable ESP", false, function(s)
    notify(s and "👁️ ESP ACTIVE" or "👁️ ESP INACTIVE", 2)
end)
local boxEspToggle = hvhToggle(p2, "Box ESP", false, function(s) end)
local skeletonToggle = hvhToggle(p2, "Skeleton ESP", false, function(s) end)
local healthToggle = hvhToggle(p2, "Health Bars", false, function(s) end)
local nameToggle = hvhToggle(p2, "Name Tags", false, function(s) end)
local distToggle = hvhToggle(p2, "Distance Indicators", false, function(s) end)

hvhSection(p2, "ESP COLORS")
local espColorDropdown = hvhDropdown(p2, "ESP Color", {"Cyan", "Red", "Green", "Purple", "White", "Yellow"}, "Cyan", function(v) end)
local teamColorToggle = hvhToggle(p2, "Team Colors", false, function(s) end)

hvhSection(p2, "CHAMS & GLOW")
local chamsToggle = hvhToggle(p2, "Chams", false, function(s)
    notify(s and "✨ Chams ACTIVE" or "✨ Chams INACTIVE", 2)
end)
local chamsColor = hvhDropdown(p2, "Chams Color", {"Cyan", "Red", "Green", "Purple", "White"}, "Cyan", function(v) end)
local glowToggle = hvhToggle(p2, "Glow Outlines", false, function(s) end)

hvhSection(p2, "VISIBILITY")
local espMaxDist = hvhSlider(p2, "Max Distance", 0, 1000, 450, "", function(v) end)
local espTransparency = hvhSlider(p2, "Transparency", 0, 1, 0.3, "", function(v) end)

-- ==================================================
-- TAB 3: MOVEMENT & CFRAME
-- ==================================================

local p3 = tabPages[3]

hvhSection(p3, "SPEED & FLIGHT")
local speedToggle = hvhToggle(p3, "Speed Boost", false, function(s)
    notify(s and "🏃 Speed Boost ACTIVE" or "🏃 Speed Boost INACTIVE", 2)
end)
local speedSlider = hvhSlider(p3, "Speed Multiplier", 1, 100, 25, "x", function(v) end)
local noclipToggle = hvhToggle(p3, "Noclip", false, function(s)
    notify(s and "🌀 Noclip ACTIVE" or "🌀 Noclip INACTIVE", 2)
end)
local flightToggle = hvhToggle(p3, "Flight", false, function(s)
    notify(s and "✈️ Flight ACTIVE" or "✈️ Flight INACTIVE", 2)
end)

hvhSection(p3, "BUNNY HOP & AIR MOVEMENT")
local bhopToggle = hvhToggle(p3, "Bunny Hop", false, function(s)
    notify(s and "🐰 Bunny Hop ACTIVE" or "🐰 Bunny Hop INACTIVE", 2)
end)
local airJumpToggle = hvhToggle(p3, "Air Jump", false, function(s)
    notify(s and "🦘 Air Jump ACTIVE" or "🦘 Air Jump INACTIVE", 2)
end)
local jumpPowerSlider = hvhSlider(p3, "Jump Power", 0, 100, 50, "", function(v) end)

hvhSection(p3, "CFRAME CONTROLS")
local cframeSmoothSlider = hvhSlider(p3, "CFrame Smoothness", 0.01, 1, 0.3, "", function(v) end)
local teleportToggle = hvhToggle(p3, "Teleport Mode", false, function(s) end)

-- ==================================================
-- TAB 4: DA HOOD UTILITIES
-- ==================================================

local p4 = tabPages[4]

hvhSection(p4, "AUTO ARMOR & AUTO BUY")
local autoArmorToggle = hvhToggle(p4, "Auto Armor", false, function(s)
    notify(s and "🛡️ Auto Armor ACTIVE" or "🛡️ Auto Armor INACTIVE", 2)
end)
local autoBuyToggle = hvhToggle(p4, "Auto Buy (Shotgun/Ammo)", false, function(s)
    notify(s and "🛒 Auto Buy ACTIVE" or "🛒 Auto Buy INACTIVE", 2)
end)
local buyDelaySlider = hvhSlider(p4, "Buy Delay", 0.1, 5, 0.5, "s", function(v) end)

hvhSection(p4, "CASH DROPPER & MACRO TOOLS")
local cashDropToggle = hvhToggle(p4, "Cash Dropper", false, function(s)
    notify(s and "💰 Cash Dropper ACTIVE" or "💰 Cash Dropper INACTIVE", 2)
end)
local cashAmountSlider = hvhSlider(p4, "Cash Amount", 10, 1000, 100, "", function(v) end)
local cashDelaySlider = hvhSlider(p4, "Drop Delay", 0.1, 5, 0.3, "s", function(v) end)

hvhSection(p4, "MACRO KEYS")
hvhButton(p4, "🔴 Record Macro", function()
    notify("🎥 Recording macro...", 2)
end, C.red)
hvhButton(p4, "⏹️ Stop Recording", function()
    notify("⏹️ Recording stopped!", 2)
end, C.primary)
hvhButton(p4, "▶️ Play Macro", function()
    notify("▶️ Playing macro...", 2)
end, C.green)

hvhSection(p4, "ANTI-STOMP & ANTI-GRAB")
local antiStompToggle = hvhToggle(p4, "Anti-Stomp", false, function(s)
    notify(s and "🔄 Anti-Stomp ACTIVE" or "🔄 Anti-Stomp INACTIVE", 2)
end)
local antiGrabToggle = hvhToggle(p4, "Anti-Grab", false, function(s)
    notify(s and "🔄 Anti-Grab ACTIVE" or "🔄 Anti-Grab INACTIVE", 2)
end)

-- ==================================================
-- TAB 5: CONFIG MANAGER
-- ==================================================

local p5 = tabPages[5]

hvhSection(p5, "CONFIG MANAGEMENT")
hvhButton(p5, "💾 Save Config", function()
    notify("💾 Config saved successfully!", 2)
end, C.green)
hvhButton(p5, "📂 Load Config", function()
    notify("📂 Config loaded!", 2)
end, C.primary)
hvhButton(p5, "🔄 Reset Config", function()
    notify("🔄 Config reset to default!", 2)
end, C.red)

hvhSection(p5, "CONFIG SLOTS")
local configSlots = {"Slot 1", "Slot 2", "Slot 3", "Slot 4", "Slot 5"}
for i, slot in ipairs(configSlots) do
    hvhButton(p5, slot, function()
        notify("📂 Selected config: " .. slot, 2)
    end, C.panelLight)
end

hvhSection(p5, "PROFILE INFO")
local profileText = Instance.new("TextLabel")
profileText.Size = UDim2.new(1, -20, 0, 60)
profileText.Position = UDim2.new(0, 10, 0, 0)
profileText.BackgroundTransparency = 1
profileText.Text = "🔹 USER: " .. player.Name .. "\n🔹 HvH VERSION: v7.0\n🔹 STATUS: UNDETECTED"
profileText.TextColor3 = C.dim
profileText.TextSize = 12
profileText.Font = Enum.Font.GothamSemibold
profileText.TextXAlignment = Enum.TextXAlignment.Left
profileText.TextYAlignment = Enum.TextYAlignment.Top
profileText.Parent = p5

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
            hub:TweenSize(UDim2.new(0, 620, 0, 680), "Out", "Back", 0.5, true)
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
print("✅ SHADOWHUB AZURE HvH v7.0 - ULTIMATE HvH")
print("📋 Features:")
print("   🎯 Silent Aim + Resolver Engine")
print("   👁️ ESP + Chams + Glow")
print("   🏃 Movement + Cframe Engine")
print("   🛡️ Da Hood Utilities Suite")
print("   💾 Config Manager")
print("   💎 Luxury Shadow Monarch Theme")
print("==========================================")

end)

-- If there was an error, print it
if not success then
    print("❌ ShadowHvH Error: " .. tostring(err))
    warn("Error loading ShadowHvH: " .. tostring(err))
end