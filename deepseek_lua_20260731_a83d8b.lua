-- ==================================================
-- APEX METAVERSE // UNIVERSAL REPLICATION MATRIX v6.0
-- Supreme Luxury Dark-Mode Cyber-Tactical Interface
-- Identity Sync • Rare Assets • Horns • Animation Studio
-- ==================================================

-- Safety pcall
local success, err = pcall(function()

print("Loading APEX METAVERSE v6.0...")

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
-- LUXURY COLORS - Shadow Monarch Theme
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
            Title = "🌐 APEX METAVERSE",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ApexMetaverse"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- UI HELPERS - Luxury Style
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
-- TOGGLE BUTTON - Luxury
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 70)
toggleBtn.Position = UDim2.new(1, -80, 0, 10)
toggleBtn.BackgroundColor3 = C.dark
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🌐"
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

addVioletStroke(toggleBtn, 2.5)
addGlowStroke(toggleBtn, 3)
addBlueGlow(toggleBtn, 2)

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
-- MAIN HUB - Luxury Cyber
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 600, 0, 700)
hub.Position = UDim2.new(0.5, -300, 0.5, -350)
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
-- HEADER - APEX METAVERSE
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
title.Position = UDim2.new(0, 20, 0, 8)
title.BackgroundTransparency = 1
title.Text = "APEX METAVERSE // UNIVERSAL REPLICATION MATRIX v6.0"
title.TextColor3 = C.text
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextStrokeTransparency = 0.2
title.Parent = header

-- Status Bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, -40, 0, 24)
statusBar.Position = UDim2.new(0, 20, 0, 44)
statusBar.BackgroundTransparency = 1
statusBar.BorderSizePixel = 0
statusBar.Parent = header

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "STATUS: GLOBAL SERVER SYNC // ENCRYPTION: ACTIVE"
statusText.TextColor3 = C.secondary
statusText.TextSize = 11
statusText.Font = Enum.Font.GothamSemibold
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.Parent = statusBar

-- Pulse status
task.spawn(function()
    while statusText and statusText.Parent do
        local states = {
            "STATUS: GLOBAL SERVER SYNC // ENCRYPTION: ACTIVE",
            "STATUS: METAVERSE CONNECTED // ENCRYPTION: ACTIVE",
            "STATUS: REPLICATION MATRIX ONLINE // ENCRYPTION: ACTIVE",
            "STATUS: GLOBAL SERVER SYNC // ENCRYPTION: STEALTH"
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
tabContainer.Position = UDim2.new(0, 10, 0, 85)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local tabNames = {"Identity Sync", "Rare Assets", "Horns", "Animation Studio"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 135, 0, 34)
    btn.Position = UDim2.new(0, (i-1)*140, 0, 0)
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
    page.Size = UDim2.new(1, -20, 1, -135)
    page.Position = UDim2.new(0, 10, 0, 130)
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
-- UI HELPERS - Luxury Components
-- ==================================================

local function luxurySection(parent, text)
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

local function luxuryToggle(parent, text, default, cb)
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

local function luxuryInput(parent, placeholder, default)
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
    
    local i = Instance.new("TextBox")
    i.Size = UDim2.new(1, -16, 1, 0)
    i.Position = UDim2.new(0, 8, 0, 0)
    i.BackgroundTransparency = 1
    i.PlaceholderText = placeholder
    i.PlaceholderColor3 = Color3.fromRGB(60, 60, 90)
    i.Text = default or ""
    i.TextColor3 = C.text
    i.TextSize = 13
    i.Font = Enum.Font.GothamSemibold
    i.TextXAlignment = Enum.TextXAlignment.Left
    i.ClearTextOnFocus = false
    i.Parent = f
    return i
end

local function luxuryButton(parent, text, cb, color)
    color = color or C.primary
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 40)
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

local function assetGridItem(parent, name, id, thumbnail, equipped)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 60)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addVioletStroke(f, 1)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 10)
    fGlassCorner.Parent = fGlass
    
    -- Thumbnail placeholder
    local thumb = Instance.new("ImageLabel")
    thumb.Size = UDim2.new(0, 44, 0, 44)
    thumb.Position = UDim2.new(0, 8, 0.5, -22)
    thumb.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    thumb.BackgroundTransparency = 0.3
    thumb.BorderSizePixel = 0
    thumb.Image = thumbnail or ""
    thumb.Parent = f
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 8)
    thumbCorner.Parent = thumb
    addVioletStroke(thumb, 1)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 150, 0, 18)
    nameLabel.Position = UDim2.new(0, 60, 0, 6)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = C.text
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = f
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(0, 120, 0, 16)
    idLabel.Position = UDim2.new(0, 60, 0, 26)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "ID: " .. tostring(id)
    idLabel.TextColor3 = C.dim
    idLabel.TextSize = 10
    idLabel.Font = Enum.Font.GothamSemibold
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Parent = f
    
    local state = equipped or false
    
    local actionBtn = Instance.new("TextButton")
    actionBtn.Size = UDim2.new(0, 110, 0, 28)
    actionBtn.Position = UDim2.new(1, -118, 0.5, -14)
    actionBtn.BackgroundColor3 = state and C.green or C.primary
    actionBtn.BackgroundTransparency = 0.1
    actionBtn.BorderSizePixel = 0
    actionBtn.Text = state and "UNEQUIP" or "EQUIP"
    actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    actionBtn.TextSize = 11
    actionBtn.Font = Enum.Font.GothamBold
    actionBtn.Parent = f
    local actionCorner = Instance.new("UICorner")
    actionCorner.CornerRadius = UDim.new(0, 8)
    actionCorner.Parent = actionBtn
    addVioletStroke(actionBtn, 1.5)
    
    actionBtn.MouseButton1Click:Connect(function()
        state = not state
        actionBtn.Text = state and "UNEQUIP" or "EQUIP"
        actionBtn.BackgroundColor3 = state and C.green or C.primary
        notify((state and "✅ " or "❌ ") .. name .. " " .. (state and "equipped!" or "unequipped!"), 2)
    end)
    
    return {get = function() return state end, set = function(v) state = v end}
end

local function animGridItem(parent, name, id)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addBlueGlow(f, 1)
    
    local fGlass = Instance.new("Frame")
    fGlass.Size = UDim2.new(1, 0, 1, 0)
    fGlass.BackgroundColor3 = C.glass
    fGlass.BackgroundTransparency = 0.94
    fGlass.BorderSizePixel = 0
    fGlass.Parent = f
    local fGlassCorner = Instance.new("UICorner")
    fGlassCorner.CornerRadius = UDim.new(0, 10)
    fGlassCorner.Parent = fGlass
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 150, 1, 0)
    nameLabel.Position = UDim2.new(0, 12, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = C.text
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = f
    
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(0, 100, 1, 0)
    idLabel.Position = UDim2.new(0, 165, 0, 0)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "ID: " .. tostring(id)
    idLabel.TextColor3 = C.dim
    idLabel.TextSize = 10
    idLabel.Font = Enum.Font.GothamSemibold
    idLabel.TextXAlignment = Enum.TextXAlignment.Left
    idLabel.Parent = f
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0, 70, 0, 28)
    applyBtn.Position = UDim2.new(1, -160, 0.5, -14)
    applyBtn.BackgroundColor3 = C.primary
    applyBtn.BackgroundTransparency = 0.1
    applyBtn.BorderSizePixel = 0
    applyBtn.Text = "APPLY"
    applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyBtn.TextSize = 11
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.Parent = f
    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 8)
    applyCorner.Parent = applyBtn
    addVioletStroke(applyBtn, 1.5)
    
    applyBtn.MouseButton1Click:Connect(function()
        notify("✅ Applied animation: " .. name, 2)
        -- Apply animation logic here
    end)
    
    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0, 70, 0, 28)
    resetBtn.Position = UDim2.new(1, -82, 0.5, -14)
    resetBtn.BackgroundColor3 = C.red
    resetBtn.BackgroundTransparency = 0.1
    resetBtn.BorderSizePixel = 0
    resetBtn.Text = "RESET"
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextSize = 11
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Parent = f
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 8)
    resetCorner.Parent = resetBtn
    addVioletStroke(resetBtn, 1.5)
    
    resetBtn.MouseButton1Click:Connect(function()
        notify("🔄 Reset animation: " .. name, 2)
        -- Reset animation logic here
    end)
end

-- ==================================================
-- TAB 1: IDENTITY SYNC
-- ==================================================

local p1 = tabPages[1]

luxurySection(p1, "GLOBAL SERVER-SIDED IDENTITY INJECTOR")

local targetInput = luxuryInput(p1, "ENTER USERNAME OR USER ID...", "")
luxuryButton(p1, "DEPLOY GLOBAL SYNC [SERVER-SIDED]", function()
    local input = targetInput.Text
    if input == "" then
        notify("⚠️ Please enter a username or user ID!", 3)
        return
    end
    notify("🌐 Deploying global sync for: " .. input, 3)
end, C.primary)

luxurySection(p1, "SYNC STATUS")
local syncStatus = Instance.new("TextLabel")
syncStatus.Size = UDim2.new(1, -20, 0, 40)
syncStatus.Position = UDim2.new(0, 10, 0, 0)
syncStatus.BackgroundTransparency = 1
syncStatus.Text = "🔹 SERVER SYNC: STANDBY\n🔹 REPLICATION: READY\n🔹 LATENCY: 12ms"
syncStatus.TextColor3 = C.dim
syncStatus.TextSize = 11
syncStatus.Font = Enum.Font.GothamSemibold
syncStatus.TextXAlignment = Enum.TextXAlignment.Left
syncStatus.TextYAlignment = Enum.TextYAlignment.Top
syncStatus.Parent = p1

task.spawn(function()
    while syncStatus and syncStatus.Parent do
        local latency = math.random(8, 25)
        local statuses = {"STANDBY", "SYNCING", "REPLICATING", "ACTIVE", "STEALTH"}
        local status = statuses[math.random(1, #statuses)]
        pcall(function()
            syncStatus.Text = "🔹 SERVER SYNC: " .. status .. "\n🔹 REPLICATION: " .. (status == "ACTIVE" and "COMPLETE" or "READY") .. "\n🔹 LATENCY: " .. latency .. "ms"
            if status == "ACTIVE" then
                syncStatus.TextColor3 = C.green
            elseif status == "SYNCING" or status == "REPLICATING" then
                syncStatus.TextColor3 = C.gold
            else
                syncStatus.TextColor3 = C.dim
            end
        end)
        task.wait(2.5)
    end
end)

-- ==================================================
-- TAB 2: RARE ASSETS & LIMBS
-- ==================================================

local p2 = tabPages[2]

luxurySection(p2, "RARE ASSETS, LIMBS & COLLECTIBLES")

-- Headless Package
assetGridItem(p2, "Headless Package", 134082579, "", false)

-- Korblox Deathspeaker Leg
assetGridItem(p2, "Korblox Deathspeaker Leg", 139687141, "", false)

-- Valkyrie Helmets
assetGridItem(p2, "Valkyrie Helm", 1369159, "", false)
assetGridItem(p2, "Red Valkyrie", 4843077708, "", false)
assetGridItem(p2, "Ice Valkyrie", 597143977, "", false)

-- ==================================================
-- TAB 3: HORNS & COLLECTIBLES
-- ==================================================

local p3 = tabPages[3]

luxurySection(p3, "HORNS COLLECTION")

assetGridItem(p3, "Fire Horns", 114631242, "", false)
assetGridItem(p3, "Ice Horns", 114631257, "", false)
assetGridItem(p3, "Darkseed Horns", 14759602, "", false)

luxurySection(p3, "RARE COLLECTIBLES")
assetGridItem(p3, "Dominus Empyreus", 203638417, "", false)
assetGridItem(p3, "Arcane Raven", 534352112, "", false)

-- ==================================================
-- TAB 4: ANIMATION STUDIO
-- ==================================================

local p4 = tabPages[4]

luxurySection(p4, "MASTER ANIMATION STUDIO & MOTION ENGINE")

-- Animation Grid
animGridItem(p4, "Zombie Bundle", 806253443)
animGridItem(p4, "Bubbly Bundle", 1060915930)
animGridItem(p4, "TOYS Bundle", 1047600812)
animGridItem(p4, "Ghost Bundle", 1184719234)
animGridItem(p4, "Knight Bundle", 657155757)
animGridItem(p4, "Vampire Bundle", 1083168516)

luxurySection(p4, "GRANULAR STATE SELECTORS")

local stateContainer = Instance.new("Frame")
stateContainer.Size = UDim2.new(1, 0, 0, 220)
stateContainer.BackgroundTransparency = 1
stateContainer.BorderSizePixel = 0
stateContainer.Parent = p4

local stateLayout = Instance.new("UIListLayout")
stateLayout.Padding = UDim.new(0, 6)
stateLayout.SortOrder = Enum.SortOrder.LayoutOrder
stateLayout.Parent = stateContainer

local function stateItem(parent, name)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 30)
    f.BackgroundColor3 = C.panel
    f.BackgroundTransparency = 0.05
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = f
    addBlueGlow(f, 1)
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 80, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.text
    l.TextSize = 12
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local idInput = Instance.new("TextBox")
    idInput.Size = UDim2.new(0, 120, 0, 22)
    idInput.Position = UDim2.new(0, 96, 0.5, -11)
    idInput.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
    idInput.Text = ""
    idInput.TextColor3 = C.text
    idInput.TextSize = 11
    idInput.Font = Enum.Font.GothamSemibold
    idInput.TextXAlignment = Enum.TextXAlignment.Center
    idInput.PlaceholderText = "Enter ID..."
    idInput.PlaceholderColor3 = Color3.fromRGB(60, 60, 90)
    idInput.BorderSizePixel = 0
    idInput.Parent = f
    local idCorner = Instance.new("UICorner")
    idCorner.CornerRadius = UDim.new(0, 5)
    idCorner.Parent = idInput
    addVioletStroke(idInput, 1)
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0, 55, 0, 22)
    applyBtn.Position = UDim2.new(1, -60, 0.5, -11)
    applyBtn.BackgroundColor3 = C.primary
    applyBtn.BackgroundTransparency = 0.1
    applyBtn.BorderSizePixel = 0
    applyBtn.Text = "APPLY"
    applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyBtn.TextSize = 10
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.Parent = f
    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 6)
    applyCorner.Parent = applyBtn
    addVioletStroke(applyBtn, 1)
    
    applyBtn.MouseButton1Click:Connect(function()
        local id = idInput.Text
        if id == "" then
            notify("⚠️ Please enter an animation ID for " .. name, 2)
            return
        end
        notify("✅ Applied " .. name .. " animation ID: " .. id, 2)
    end)
end

stateItem(stateContainer, "Walk")
stateItem(stateContainer, "Run")
stateItem(stateContainer, "Jump")
stateItem(stateContainer, "Climb")
stateItem(stateContainer, "Fall")
stateItem(stateContainer, "Idle")
stateItem(stateContainer, "Swim")

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
            hub:TweenSize(UDim2.new(0, 600, 0, 700), "Out", "Back", 0.5, true)
        end)
        toggleBtn.Text = "🌐"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.05
    else
        toggleBtn.Text = "🌐"
        toggleBtn.BackgroundColor3 = C.dark
        toggleBtn.BackgroundTransparency = 0.1
    end
end)

print("==========================================")
print("✅ APEX METAVERSE v6.0 - LUXURY CYBER TACTICAL")
print("📋 Features:")
print("   🌐 Identity Sync - Server-Sided Replication")
print("   💎 Rare Assets & Limbs Grid")
print("   🦄 Horns & Collectibles")
print("   🎭 Animation Studio - Master Motion Engine")
print("   🎯 Granular State Selectors")
print("   💎 Luxury Shadow Monarch Theme")
print("==========================================")

end)

-- If there was an error, print it
if not success then
    print("❌ Apex Metaverse Error: " .. tostring(err))
    warn("Error loading Apex Metaverse: " .. tostring(err))
end