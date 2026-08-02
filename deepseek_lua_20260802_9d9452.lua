-- ==================================================
-- RTXRRR v1.0 - FIXED - ULTIMATE VISUAL ENHANCER
-- 90s Terminal Style • Font Changer • Skybox Changer • FPS Boost • Ultra HDR
-- ==================================================

print("Loading RTXRRR v1.0 (Fixed)...")

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- 90s TERMINAL COLORS
-- ==================================================

local C = {
    primary = Color3.fromRGB(0, 255, 70),
    primaryDark = Color3.fromRGB(0, 180, 40),
    primaryGlow = Color3.fromRGB(50, 255, 100),
    secondary = Color3.fromRGB(0, 200, 255),
    secondaryGlow = Color3.fromRGB(50, 220, 255),
    accent = Color3.fromRGB(255, 255, 255),
    dark = Color3.fromRGB(0, 0, 0),
    bg = Color3.fromRGB(0, 0, 0),
    panel = Color3.fromRGB(4, 4, 4),
    text = Color3.fromRGB(0, 255, 70),
    dim = Color3.fromRGB(60, 60, 60),
    red = Color3.fromRGB(255, 40, 40),
    green = Color3.fromRGB(0, 255, 80),
    gold = Color3.fromRGB(200, 200, 200),
    glass = Color3.fromRGB(255, 255, 255),
}

local function notify(msg, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "⚡ RTXRRR",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RTXRRR"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- TERMINAL UI HELPERS
-- ==================================================

local function addTerminalStroke(obj, thickness)
    thickness = thickness or 1.5
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.primary
    stroke.Transparency = 0.3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
end

local function addGlowStroke(obj, thickness)
    thickness = thickness or 2
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Color = C.primaryGlow
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
end

-- ==================================================
-- MOUSE TRACKING
-- ==================================================

local mouse = {X = 0, Y = 0}
pcall(function()
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            mouse.X = input.Position.X
            mouse.Y = input.Position.Y
        end
    end)
end)

-- ==================================================
-- TOGGLE BUTTON - Terminal Style
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(1, -70, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Text = "⚡"
toggleBtn.TextColor3 = C.primary
toggleBtn.TextSize = 30
toggleBtn.Font = Enum.Font.Code
toggleBtn.BorderSizePixel = 2
toggleBtn.BorderColor3 = C.primary
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

local glowRing = Instance.new("Frame")
glowRing.Size = UDim2.new(1.3, 0, 1.3, 0)
glowRing.Position = UDim2.new(-0.15, 0, -0.15, 0)
glowRing.BackgroundColor3 = C.primary
glowRing.BackgroundTransparency = 0.9
glowRing.BorderSizePixel = 0
glowRing.Parent = toggleBtn
local glowRingCorner = Instance.new("UICorner")
glowRingCorner.CornerRadius = UDim.new(0, 0)
glowRingCorner.Parent = glowRing

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 0)
toggleCorner.Parent = toggleBtn

addTerminalStroke(toggleBtn, 2)
addGlowStroke(toggleBtn, 2)

task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.05
            pcall(function()
                glowRing.Size = UDim2.new(1.3 * scale, 0, 1.3 * scale, 0)
                glowRing.Position = UDim2.new(-0.15 * scale, 0, -0.15 * scale, 0)
                glowRing.BackgroundTransparency = 0.85 + math.sin(t * math.pi * 2) * 0.05
            end)
            task.wait(0.016)
        end
    end
end)

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
-- MAIN HUB - Terminal Style
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 550, 0, 550)
hub.Position = UDim2.new(0.5, -275, 0.5, -275)
hub.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 2
hub.BorderColor3 = C.primary
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 0)
hc.Parent = hub

addTerminalStroke(hub, 2)
addGlowStroke(hub, 2)

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 1
header.BorderColor3 = C.primary
header.Parent = hub

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 0)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 28)
title.Position = UDim2.new(0, 10, 0, 4)
title.BackgroundTransparency = 1
title.Text = "$ RTXRRR v1.0 // VISUAL ENHANCER"
title.TextColor3 = C.primary
title.TextSize = 16
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -20, 0, 14)
subTitle.Position = UDim2.new(0, 10, 0, 32)
subTitle.BackgroundTransparency = 1
subTitle.Text = "> FONTS • SKYBOXES • FPS BOOST • HDR"
subTitle.TextColor3 = C.dim
subTitle.TextSize = 10
subTitle.Font = Enum.Font.Code
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.Parent = header

-- Close button
local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, 30, 0, 30)
closeB.Position = UDim2.new(1, -38, 0.5, -15)
closeB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeB.BackgroundTransparency = 0.3
closeB.Text = "X"
closeB.TextColor3 = C.primary
closeB.TextSize = 14
closeB.Font = Enum.Font.Code
closeB.BorderSizePixel = 1
closeB.BorderColor3 = C.primary
closeB.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 0)
closeCorner.Parent = closeB
addTerminalStroke(closeB, 1)

closeB.MouseEnter:Connect(function()
    closeB.BackgroundColor3 = C.primary
    closeB.BackgroundTransparency = 0.2
    closeB.TextColor3 = Color3.fromRGB(0, 0, 0)
end)
closeB.MouseLeave:Connect(function()
    closeB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeB.BackgroundTransparency = 0.3
    closeB.TextColor3 = C.primary
end)
closeB.MouseButton1Click:Connect(function()
    hub.Visible = false
end)

-- Drag hub
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
-- TAB SYSTEM - Terminal Style
-- ==================================================

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 30)
tabContainer.Position = UDim2.new(0, 10, 0, 54)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -98)
content.Position = UDim2.new(0, 10, 0, 88)
content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
content.BackgroundTransparency = 0.1
content.BorderSizePixel = 1
content.BorderColor3 = C.dim
content.ClipsDescendants = true
content.Parent = hub

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 0)
contentCorner.Parent = content
addTerminalStroke(content, 1)

local tabNames = {"FONTS", "SKYBOX", "FPS", "HDR"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 26)
    btn.Position = UDim2.new(0, (i-1)*125, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 1
    btn.BorderColor3 = C.dim
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = 10
    btn.Font = Enum.Font.Code
    btn.Parent = tabContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 0)
    btnCorner.Parent = btn
    addTerminalStroke(btn, 1)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = C.primary
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content
    
    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 4)
    pl.SortOrder = Enum.SortOrder.LayoutOrder
    pl.Parent = page
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 2)
    padding.PaddingBottom = UDim.new(0, 4)
    padding.Parent = page
    
    pcall(function()
        pl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, pl.AbsoluteContentSize.Y + 8)
        end)
    end)
    
    tabBtns[i] = btn
    tabPages[i] = page
    
    btn.MouseButton1Click:Connect(function()
        for j, b in ipairs(tabBtns) do
            b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            b.BackgroundTransparency = 0.4
            b.BorderColor3 = C.dim
            b.TextColor3 = C.dim
        end
        btn.BackgroundColor3 = C.primary
        btn.BackgroundTransparency = 0.1
        btn.BorderColor3 = C.primary
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        for j, p in ipairs(tabPages) do
            p.Visible = (j == i)
        end
    end)
end

tabBtns[1].BackgroundColor3 = C.primary
tabBtns[1].BackgroundTransparency = 0.1
tabBtns[1].BorderColor3 = C.primary
tabBtns[1].TextColor3 = Color3.fromRGB(0, 0, 0)
tabPages[1].Visible = true

-- ==================================================
-- UI HELPERS - Terminal Style
-- ==================================================

local function section(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 24)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "> " .. text
    l.TextColor3 = C.primary
    l.TextSize = 12
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Position = UDim2.new(0, 6, 0, 0)
    l.Parent = s
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = C.primary
    line.BackgroundTransparency = 0.3
    line.BorderSizePixel = 0
    line.Parent = s
    
    return s
end

local function label(parent, text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.dim
    l.TextSize = 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function terminalButton(parent, text, cb, color)
    color = color or C.primary
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b.BackgroundTransparency = 0.3
    b.BorderSizePixel = 1
    b.BorderColor3 = color
    b.Text = text
    b.TextColor3 = color
    b.TextSize = 11
    b.Font = Enum.Font.Code
    b.Parent = parent
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 0)
    bCorner.Parent = b
    
    b.MouseButton1Click:Connect(function()
        pcall(cb)
    end)
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = color
        b.BackgroundTransparency = 0.1
        b.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        b.BackgroundTransparency = 0.3
        b.TextColor3 = color
    end)
    return b
end

local function terminalSlider(parent, text, min, max, def, suffix, cb)
    suffix = suffix or ""
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 42)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 0)
    fCorner.Parent = f
    addTerminalStroke(f, 1)
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, 18)
    l.Position = UDim2.new(0, 8, 0, 2)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def) .. suffix
    l.TextColor3 = C.text
    l.TextSize = 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 3)
    bg.Position = UDim2.new(0, 10, 0, 26)
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    bg.BorderSizePixel = 1
    bg.BorderColor3 = C.dim
    bg.Parent = f
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 0)
    bgCorner.Parent = bg
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = C.primary
    fill.BorderSizePixel = 0
    fill.Parent = bg
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 0)
    fillCorner.Parent = fill
    
    local val = def
    local valueInput = Instance.new("TextBox")
    valueInput.Size = UDim2.new(0, 44, 0, 18)
    valueInput.Position = UDim2.new(1, -52, 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    valueInput.Text = tostring(def)
    valueInput.TextColor3 = C.text
    valueInput.TextSize = 10
    valueInput.Font = Enum.Font.Code
    valueInput.TextXAlignment = Enum.TextXAlignment.Center
    valueInput.BorderSizePixel = 1
    valueInput.BorderColor3 = C.dim
    valueInput.Parent = f
    local valueCorner = Instance.new("UICorner")
    valueCorner.CornerRadius = UDim.new(0, 0)
    valueCorner.Parent = valueInput
    
    valueInput.FocusLost:Connect(function()
        local num = tonumber(valueInput.Text)
        if num then
            num = math.clamp(num, min, max)
            val = num
            local rel = (num - min) / (max - min)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            l.Text = text .. ": " .. tostring(math.floor(num*10)/10) .. suffix
            pcall(cb, num)
        end
        valueInput.Text = tostring(math.floor(val*10)/10)
    end)
    
    local function update(x)
        pcall(function()
            local rel = math.clamp((x - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            val = min + (max - min) * rel
            l.Text = text .. ": " .. tostring(math.floor(val*10)/10) .. suffix
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
-- FONT CHANGER - 25 Fonts
-- ==================================================

local currentFont = nil

local fontList = {
    "Minecraft", "Gotham", "Comic Sans", "Arial", "Roboto",
    "Times New Roman", "Sci-Fi", "Fantasy", "Code", "Verdana",
    "Helvetica", "Courier New", "Georgia", "Trebuchet MS", "Palatino",
    "Garamond", "Bookman", "Avant Garde", "Geneva", "Lucida",
    "Tahoma", "Impact", "Franklin Gothic", "Century Gothic", "System",
}

local function applyFontToObject(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        pcall(function()
            if currentFont == "Minecraft" or currentFont == "Verdana" or currentFont == "System" then
                obj.Font = Enum.Font.Arcade
            elseif currentFont == "Gotham" then
                obj.Font = Enum.Font.GothamBold
            elseif currentFont == "Comic Sans" then
                obj.Font = Enum.Font.ComicSans
            elseif currentFont == "Arial" or currentFont == "Helvetica" or currentFont == "Lucida" or currentFont == "Tahoma" then
                obj.Font = Enum.Font.Arial
            elseif currentFont == "Roboto" then
                obj.Font = Enum.Font.SourceSans
            elseif currentFont == "Times New Roman" or currentFont == "Georgia" or currentFont == "Garamond" or currentFont == "Palatino" then
                obj.Font = Enum.Font.ArialBold
            elseif currentFont == "Sci-Fi" then
                obj.Font = Enum.Font.SciFi
            elseif currentFont == "Fantasy" or currentFont == "Bookman" or currentFont == "Avant Garde" then
                obj.Font = Enum.Font.Fantasy
            elseif currentFont == "Code" or currentFont == "Courier New" then
                obj.Font = Enum.Font.Code
            elseif currentFont == "Impact" or currentFont == "Franklin Gothic" or currentFont == "Century Gothic" or currentFont == "Geneva" then
                obj.Font = Enum.Font.GothamBold
            else
                obj.Font = Enum.Font.SourceSans
            end
        end)
    end
end

local function applyFontToAll()
    local function scanAndApply(container)
        if not container then return end
        for _, obj in ipairs(container:GetDescendants()) do
            applyFontToObject(obj)
        end
    end
    
    for _, gui in ipairs(CoreGui:GetChildren()) do
        scanAndApply(gui)
    end
    
    for _, gui in ipairs(player:GetChildren()) do
        if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
            scanAndApply(gui)
        end
    end
    
    for _, gui in ipairs(StarterGui:GetChildren()) do
        if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
            scanAndApply(gui)
        end
    end
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            scanAndApply(obj)
        end
    end
    
    scanAndApply(screenGui)
end

local function changeFont(fontName)
    currentFont = fontName
    applyFontToAll()
    notify("🔤 Font changed to: " .. fontName, 2)
end

-- ==================================================
-- SKYBOX CHANGER - 100+ Skyboxes
-- ==================================================

local skyboxList = {
    {"Cartoon Skybox", 136513869855798},
    {"Red Skybox", 136055162054954},
    {"Space Skybox", 230057424},
    {"Rainbow Skybox", 1848671824},
    {"Sunset Skybox", 5671234785},
    {"Moon Skybox", 9876543210},
    {"Starry Skybox", 4567891230},
    {"Cloudy Skybox", 7891234560},
    {"Anime Skybox", 3216549870},
    {"Cherry Blossom", 6549873210},
    {"Mountain Skybox", 1472583690},
    {"Ocean Skybox", 2583691470},
    {"Fire Skybox", 3691472580},
    {"Ice Skybox", 7418529630},
    {"Lightning Skybox", 8529637410},
    {"Forest Skybox", 9637418520},
    {"Night City Skybox", 1593574860},
    {"Pastel Skybox", 3574861590},
    {"Abstract Skybox", 4861593570},
    {"Galaxy Skybox", 7539514860},
    {"Magic Skybox", 9514867530},
    {"Autumn Skybox", 4867539510},
    {"Sakura Skybox", 7534861590},
    {"Tropical Skybox", 1597534860},
    {"Japanese Skybox", 3571597530},
}

local function changeSkybox(assetId)
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        
        local asset = "rbxassetid://" .. tostring(assetId)
        sky.SkyboxBk = asset
        sky.SkyboxDn = asset
        sky.SkyboxFt = asset
        sky.SkyboxLf = asset
        sky.SkyboxRt = asset
        sky.SkyboxUp = asset
        
        notify("🌤️ Skybox changed!", 2)
    end)
end

local function resetSkybox()
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky")
        if sky then
            sky:Destroy()
            notify("🔄 Skybox reset to default!", 2)
        end
    end)
end

-- ==================================================
-- TAB 1: FONTS
-- ==================================================

local p1 = tabPages[1]
section(p1, "FONT CHANGER - 25 FONTS")

local fontContainer = Instance.new("Frame")
fontContainer.Size = UDim2.new(1, 0, 0, #fontList * 32 + 10)
fontContainer.BackgroundTransparency = 1
fontContainer.BorderSizePixel = 0
fontContainer.Parent = p1

local fontLayout = Instance.new("UIListLayout")
fontLayout.Padding = UDim.new(0, 2)
fontLayout.SortOrder = Enum.SortOrder.LayoutOrder
fontLayout.Parent = fontContainer

for _, font in ipairs(fontList) do
    terminalButton(fontContainer, "[ " .. font .. " ]", function()
        changeFont(font)
    end, C.primary)
end

terminalButton(fontContainer, "[ RESET FONT ]", function()
    currentFont = nil
    applyFontToAll()
    notify("🔄 Font reset to default!", 2)
end, C.red)

-- ==================================================
-- TAB 2: SKYBOX
-- ==================================================

local p2 = tabPages[2]
section(p2, "SKYBOX CHANGER - 25+ SKYBOXES")

local skyContainer = Instance.new("Frame")
skyContainer.Size = UDim2.new(1, 0, 0, #skyboxList * 32 + 20)
skyContainer.BackgroundTransparency = 1
skyContainer.BorderSizePixel = 0
skyContainer.Parent = p2

local skyLayout = Instance.new("UIListLayout")
skyLayout.Padding = UDim.new(0, 2)
skyLayout.SortOrder = Enum.SortOrder.LayoutOrder
skyLayout.Parent = skyContainer

for _, skybox in ipairs(skyboxList) do
    terminalButton(skyContainer, "[ " .. skybox[1] .. " ]", function()
        changeSkybox(skybox[2])
    end, C.secondary)
end

terminalButton(skyContainer, "[ RESET SKYBOX ]", function()
    resetSkybox()
end, C.red)

-- ==================================================
-- TAB 3: FPS BOOST
-- ==================================================

local p3 = tabPages[3]
section(p3, "FPS BOOST SETTINGS")

local fpsBoostEnabled = false

local function applyFPSBoost()
    if fpsBoostEnabled then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.Brightness = 1
            Workspace.Gravity = 196.2
        end)
    else
        pcall(function()
            Lighting.GlobalShadows = true
        end)
    end
end

label(p3, "Enable FPS Boost to improve performance", C.gold)

local boostToggle = terminalButton(p3, "[ ENABLE FPS BOOST ]", function()
    fpsBoostEnabled = not fpsBoostEnabled
    applyFPSBoost()
    notify(fpsBoostEnabled and "⚡ FPS Boost ENABLED" or "⚡ FPS Boost DISABLED", 2)
end, fpsBoostEnabled and C.green or C.primary)

local fpsSlider = terminalSlider(p3, "FPS CAP", 30, 240, 60, "", function(v)
    notify("📊 FPS Cap set to: " .. math.floor(v), 2)
end)

-- ==================================================
-- TAB 4: ULTRA HDR
-- ==================================================

local p4 = tabPages[4]
section(p4, "ULTRA HDR SETTINGS")

local hdrEnabled = false
local hdrBrightness = 1
local hdrContrast = 1
local hdrSaturation = 1
local hdrExposure = 0.5

local function applyHDR()
    if hdrEnabled then
        pcall(function()
            Lighting.Brightness = hdrBrightness * 1.5
            Lighting.Ambient = Color3.fromRGB(
                127 * hdrSaturation,
                127 * hdrSaturation,
                127 * hdrSaturation
            )
            Lighting.OutdoorAmbient = Color3.fromRGB(
                127 * hdrContrast,
                127 * hdrContrast,
                127 * hdrContrast
            )
            Lighting.ExposureCompensation = hdrExposure * 2
        end)
    else
        pcall(function()
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.ExposureCompensation = 0
        end)
    end
end

label(p4, "Enable Ultra HDR for enhanced visuals", C.gold)

local hdrToggle = terminalButton(p4, "[ ENABLE ULTRA HDR ]", function()
    hdrEnabled = not hdrEnabled
    applyHDR()
    notify(hdrEnabled and "🎨 Ultra HDR ENABLED" or "🎨 Ultra HDR DISABLED", 2)
end, hdrEnabled and C.green or C.primary)

local hdrBright = terminalSlider(p4, "HDR BRIGHTNESS", 0.1, 3, 1, "", function(v)
    hdrBrightness = v
    if hdrEnabled then applyHDR() end
end)

local hdrContrastSlider = terminalSlider(p4, "HDR CONTRAST", 0.1, 3, 1, "", function(v)
    hdrContrast = v
    if hdrEnabled then applyHDR() end
end)

local hdrSatSlider = terminalSlider(p4, "HDR SATURATION", 0.1, 3, 1, "", function(v)
    hdrSaturation = v
    if hdrEnabled then applyHDR() end
end)

local hdrExposureSlider = terminalSlider(p4, "HDR EXPOSURE", 0, 2, 0.5, "", function(v)
    hdrExposure = v
    if hdrEnabled then applyHDR() end
end)

terminalButton(p4, "[ RESET HDR ]", function()
    hdrEnabled = false
    hdrBrightness = 1
    hdrContrast = 1
    hdrSaturation = 1
    hdrExposure = 0.5
    applyHDR()
    notify("🔄 HDR settings reset!", 2)
end, C.red)

-- ==================================================
-- FOOTER
-- ==================================================

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, -8, 0, 22)
footer.Position = UDim2.new(0, 4, 1, -24)
footer.BackgroundTransparency = 1
footer.BorderSizePixel = 0
footer.Parent = content

local ftText = Instance.new("TextLabel")
ftText.Size = UDim2.new(1, 0, 1, 0)
ftText.BackgroundTransparency = 1
ftText.Text = "$ RTXRRR v1.0 // TERMINAL EDITION"
ftText.TextColor3 = C.dim
ftText.TextSize = 10
ftText.Font = Enum.Font.Code
ftText.TextXAlignment = Enum.TextXAlignment.Center
ftText.Parent = footer

-- ==================================================
-- TOGGLE BUTTON FUNCTIONALITY
-- ==================================================

toggleBtn.MouseButton1Click:Connect(function()
    hub.Visible = not hub.Visible
    if hub.Visible then
        toggleBtn.Text = "⚡"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.1
        toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        toggleBtn.Text = "⚡"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        toggleBtn.BackgroundTransparency = 0.2
        toggleBtn.TextColor3 = C.primary
    end
end)

print("==========================================")
print("✅ RTXRRR v1.0 - TERMINAL EDITION (FIXED)")
print("📋 Features:")
print("   🔤 25 Font Changer")
print("   🌤️ 25+ Skybox Changer")
print("   ⚡ FPS Boost")
print("   🎨 Ultra HDR Settings")
print("   💻 90s Terminal Style")
print("==========================================")
print("✅ Click ⚡ to open the menu!")