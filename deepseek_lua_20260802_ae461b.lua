-- ==================================================
-- RTXRRR v6.1 - MOBILE EDITION (FIXED)
-- Terminal Style • 90s Aesthetic • Mobile Optimized
-- Font Changer • Skybox Changer • FPS Boost • Ultra HDR • ESP • Crosshair
-- ==================================================

print("Loading RTXRRR v6.1 Mobile Edition...")

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- Check if mobile
local isMobile = UserInputService.TouchEnabled or not UserInputService.MouseEnabled
print("Device type: " .. (isMobile and "Mobile" or "PC"))

-- ==================================================
-- TERMINAL COLORS
-- ==================================================

local C = {
    primary = Color3.fromRGB(0, 255, 70),
    primaryDark = Color3.fromRGB(0, 180, 40),
    primaryGlow = Color3.fromRGB(50, 255, 100),
    secondary = Color3.fromRGB(0, 200, 255),
    dark = Color3.fromRGB(0, 0, 0),
    text = Color3.fromRGB(0, 255, 70),
    dim = Color3.fromRGB(60, 60, 60),
    red = Color3.fromRGB(255, 40, 40),
    green = Color3.fromRGB(0, 255, 80),
    gold = Color3.fromRGB(200, 200, 200),
    white = Color3.fromRGB(255, 255, 255),
    gray = Color3.fromRGB(128, 128, 128),
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
-- MOBILE TOGGLE BUTTON
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = isMobile and UDim2.new(0, 75, 0, 75) or UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(1, -(isMobile and 85 or 70), 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Text = "⚡"
toggleBtn.TextColor3 = C.primary
toggleBtn.TextSize = isMobile and 35 or 30
toggleBtn.Font = Enum.Font.Code
toggleBtn.BorderSizePixel = 2
toggleBtn.BorderColor3 = C.primary
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 0)
toggleCorner.Parent = toggleBtn

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

-- Draggable toggle
local toggleDragging = false
local toggleDragOff = Vector2.new(0, 0)

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = true
        toggleDragOff = Vector2.new(mouse.X - toggleBtn.AbsolutePosition.X, mouse.Y - toggleBtn.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if toggleDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        pcall(function()
            toggleBtn.Position = UDim2.new(0, mouse.X - toggleDragOff.X, 0, mouse.Y - toggleDragOff.Y)
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = false
    end
end)

-- ==================================================
-- MAIN HUB
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = isMobile and UDim2.new(0, 520, 0, 600) or UDim2.new(0, 450, 0, 520)
hub.Position = UDim2.new(0.5, -(isMobile and 260 or 225), 0.5, -(isMobile and 300 or 260))
hub.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 2
hub.BorderColor3 = C.primary
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hubCorner = Instance.new("UICorner")
hubCorner.CornerRadius = UDim.new(0, 0)
hubCorner.Parent = hub

-- ==================================================
-- HEADER
-- ==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, isMobile and 55 or 45)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 1
header.BorderColor3 = C.primary
header.Parent = hub

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, isMobile and 32 or 26)
title.Position = UDim2.new(0, 10, 0, isMobile and 6 or 4)
title.BackgroundTransparency = 1
title.Text = "$ RTXRRR v6.1 // MOBILE"
title.TextColor3 = C.primary
title.TextSize = isMobile and 16 or 14
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -20, 0, isMobile and 16 or 12)
subTitle.Position = UDim2.new(0, 10, 0, isMobile and 38 or 30)
subTitle.BackgroundTransparency = 1
subTitle.Text = "> FONTS • SKYBOX • FPS • HDR • ESP"
subTitle.TextColor3 = C.dim
subTitle.TextSize = isMobile and 11 or 9
subTitle.Font = Enum.Font.Code
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.Parent = header

-- Close button
local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, isMobile and 36 or 28, 0, isMobile and 36 or 28)
closeB.Position = UDim2.new(1, -(isMobile and 44 or 36), 0.5, -(isMobile and 18 or 14))
closeB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeB.BackgroundTransparency = 0.3
closeB.Text = "X"
closeB.TextColor3 = C.primary
closeB.TextSize = isMobile and 16 or 13
closeB.Font = Enum.Font.Code
closeB.BorderSizePixel = 1
closeB.BorderColor3 = C.primary
closeB.Parent = header

closeB.MouseButton1Click:Connect(function()
    hub.Visible = false
    toggleBtn.Text = "⚡"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleBtn.BackgroundTransparency = 0.2
    toggleBtn.TextColor3 = C.primary
    toggleBtn.BorderColor3 = C.primary
end)

-- ==================================================
-- DRAG HUB
-- ==================================================

local hubDragging = false
local hubDragOff = Vector2.new(0, 0)

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        hubDragging = true
        hubDragOff = Vector2.new(mouse.X - hub.AbsolutePosition.X, mouse.Y - hub.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if hubDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        pcall(function()
            hub.Position = UDim2.new(0, mouse.X - hubDragOff.X, 0, mouse.Y - hubDragOff.Y)
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        hubDragging = false
    end
end)

-- ==================================================
-- TOGGLE BUTTON CLICK
-- ==================================================

toggleBtn.MouseButton1Click:Connect(function()
    if hub.Visible == false then
        hub.Visible = true
        toggleBtn.Text = "⚡"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.1
        toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        toggleBtn.BorderColor3 = C.primary
    else
        hub.Visible = false
        toggleBtn.Text = "⚡"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        toggleBtn.BackgroundTransparency = 0.2
        toggleBtn.TextColor3 = C.primary
        toggleBtn.BorderColor3 = C.primary
    end
end)

-- ==================================================
-- TAB SYSTEM
-- ==================================================

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, isMobile and 36 or 28)
tabContainer.Position = UDim2.new(0, 10, 0, isMobile and 60 or 48)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -(isMobile and 115 or 92))
content.Position = UDim2.new(0, 10, 0, isMobile and 100 or 80)
content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
content.BackgroundTransparency = 0.3
content.BorderSizePixel = 1
content.BorderColor3 = C.dim
content.ClipsDescendants = true
content.Parent = hub

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 0)
contentCorner.Parent = content

local tabNames = {"FONTS", "SKYBOX", "FPS", "HDR", "ESP"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 90 or 82, 0, isMobile and 30 or 24)
    btn.Position = UDim2.new(0, (i-1) * (isMobile and 94 or 86), 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 1
    btn.BorderColor3 = C.dim
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = isMobile and 11 or 9
    btn.Font = Enum.Font.Code
    btn.Parent = tabContainer
    
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
            b.BackgroundTransparency = 0.5
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
-- UI HELPERS
-- ==================================================

local function section(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, isMobile and 28 or 22)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "> " .. text
    l.TextColor3 = C.primary
    l.TextSize = isMobile and 14 or 11
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
    l.Size = UDim2.new(1, 0, 0, isMobile and 20 or 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.dim
    l.TextSize = isMobile and 12 or 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function terminalButton(parent, text, cb, color)
    color = color or C.primary
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, isMobile and 34 or 26)
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b.BackgroundTransparency = 0.3
    b.BorderSizePixel = 1
    b.BorderColor3 = color
    b.Text = text
    b.TextColor3 = color
    b.TextSize = isMobile and 12 or 10
    b.Font = Enum.Font.Code
    b.Parent = parent
    
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

local function terminalToggle(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, isMobile and 34 or 28)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -60, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = isMobile and 12 or 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 44 or 38, 0, isMobile and 26 or 20)
    btn.Position = UDim2.new(1, -(isMobile and 52 or 44), 0.5, -(isMobile and 13 or 10))
    btn.BackgroundColor3 = default and C.primary or Color3.fromRGB(20, 20, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = default and C.primary or C.dim
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = default and Color3.fromRGB(0, 0, 0) or C.dim
    btn.TextSize = isMobile and 10 or 8
    btn.Font = Enum.Font.Code
    btn.Parent = f
    
    local state = default or false
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and C.primary or Color3.fromRGB(20, 20, 20)
        btn.BorderColor3 = state and C.primary or C.dim
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = state and Color3.fromRGB(0, 0, 0) or C.dim
        pcall(cb, state)
    end)
    
    return {get = function() return state end, set = function(v) state = v end}
end

local function terminalSlider(parent, text, min, max, def, suffix, cb)
    suffix = suffix or ""
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, isMobile and 44 or 38)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, isMobile and 20 or 16)
    l.Position = UDim2.new(0, 8, 0, 2)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def) .. suffix
    l.TextColor3 = C.text
    l.TextSize = isMobile and 11 or 9
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 3)
    bg.Position = UDim2.new(0, 10, 0, isMobile and 28 or 22)
    bg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    bg.BorderSizePixel = 1
    bg.BorderColor3 = C.dim
    bg.Parent = f
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = C.primary
    fill.BorderSizePixel = 0
    fill.Parent = bg
    
    local val = def
    local valueInput = Instance.new("TextBox")
    valueInput.Size = UDim2.new(0, isMobile and 48 or 40, 0, isMobile and 22 or 16)
    valueInput.Position = UDim2.new(1, -(isMobile and 56 or 48), 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    valueInput.Text = tostring(def)
    valueInput.TextColor3 = C.text
    valueInput.TextSize = isMobile and 11 or 9
    valueInput.Font = Enum.Font.Code
    valueInput.TextXAlignment = Enum.TextXAlignment.Center
    valueInput.BorderSizePixel = 1
    valueInput.BorderColor3 = C.dim
    valueInput.Parent = f
    
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
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            update(i.Position.X)
        end
    end)
    
    return {get = function() return val end, set = function(v) val = v end}
end

local function terminalColorPicker(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, isMobile and 34 or 28)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, 80, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = isMobile and 12 or 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(0, isMobile and 36 or 30, 0, isMobile and 26 or 20)
    colorBtn.Position = UDim2.new(0, 90, 0.5, -(isMobile and 13 or 10))
    colorBtn.BackgroundColor3 = default
    colorBtn.BorderSizePixel = 1
    colorBtn.BorderColor3 = C.primary
    colorBtn.Text = ""
    colorBtn.Parent = f
    
    local colors = {
        Color3.fromRGB(0, 255, 70),
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(0, 200, 255),
        Color3.fromRGB(255, 200, 0),
        Color3.fromRGB(255, 40, 40),
        Color3.fromRGB(200, 50, 255),
    }
    
    local selected = default
    
    colorBtn.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 140, 0, 34)
        menu.Position = UDim2.new(0, 90, 0, 28)
        menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        menu.BorderSizePixel = 1
        menu.BorderColor3 = C.primary
        menu.Parent = f
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 4)
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.Parent = menu
        
        for _, color in ipairs(colors) do
            local cBtn = Instance.new("TextButton")
            cBtn.Size = UDim2.new(0, 24, 0, 24)
            cBtn.BackgroundColor3 = color
            cBtn.BorderSizePixel = 1
            cBtn.BorderColor3 = C.primary
            cBtn.Text = ""
            cBtn.Parent = menu
            cBtn.MouseButton1Click:Connect(function()
                selected = color
                colorBtn.BackgroundColor3 = color
                menu:Destroy()
                pcall(cb, color)
            end)
        end
    end)
    
    return {get = function() return selected end}
end

-- ==================================================
-- FONT CHANGER
-- ==================================================

local currentFont = nil

local fontList = {
    "Minecraft",
    "Gotham",
    "Comic Sans",
    "Arial",
    "Roboto",
    "Sci-Fi",
    "Fantasy",
    "Code",
}

local function applyFontToObject(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        pcall(function()
            if currentFont == "Minecraft" then
                obj.Font = Enum.Font.Arcade
            elseif currentFont == "Gotham" then
                obj.Font = Enum.Font.GothamBold
            elseif currentFont == "Comic Sans" then
                obj.Font = Enum.Font.ComicSans
            elseif currentFont == "Arial" then
                obj.Font = Enum.Font.Arial
            elseif currentFont == "Roboto" then
                obj.Font = Enum.Font.SourceSans
            elseif currentFont == "Sci-Fi" then
                obj.Font = Enum.Font.SciFi
            elseif currentFont == "Fantasy" then
                obj.Font = Enum.Font.Fantasy
            elseif currentFont == "Code" then
                obj.Font = Enum.Font.Code
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

coroutine.wrap(function()
    while true do
        task.wait(0.5)
        if currentFont then
            applyFontToAll()
        end
    end
end)()

-- ==================================================
-- SKYBOX CHANGER
-- ==================================================

local skyboxList = {
    {"Cartoon Skybox", "rbxassetid://136513869855798"},
    {"Red Skybox", "rbxassetid://136055162054954"},
    {"Space Skybox", "rbxassetid://230057424"},
    {"Rainbow Skybox", "rbxassetid://1848671824"},
    {"Sunset Skybox", "rbxassetid://5671234785"},
    {"Moon Skybox", "rbxassetid://9876543210"},
    {"Starry Skybox", "rbxassetid://4567891230"},
    {"Cloudy Skybox", "rbxassetid://7891234560"},
    {"Anime Skybox", "rbxassetid://3216549870"},
    {"Cherry Blossom", "rbxassetid://6549873210"},
}

local function changeSkybox(asset)
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky")
        if sky then sky:Destroy()
        
        sky = Instance.new("Sky")
        sky.Parent = Lighting
        
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
        if sky then sky:Destroy()
        notify("🔄 Skybox reset!", 2)
    end)
end

-- ==================================================
-- FPS BOOST
-- ==================================================

local fpsSettings = {
    noShadows = false,
    noGrass = false,
    graySky = false,
    noClothes = false,
    noFog = false,
    lowGraphics = false,
    resolution = 1080,
}

local function applyFPSBoost()
    pcall(function()
        Lighting.GlobalShadows = not fpsSettings.noShadows
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local name = obj.Name:lower()
                if name:find("grass") or name:find("leaf") or name:find("plant") or name:find("bush") or name:find("tree") then
                    obj.Transparency = fpsSettings.noGrass and 1 or 0
                    obj.CanCollide = not fpsSettings.noGrass
                end
            end
        end
        
        if fpsSettings.graySky then
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        else
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        end
        
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                for _, part in ipairs(plr.Character:GetChildren()) do
                    if part:IsA("Part") or part:IsA("MeshPart") then
                        if fpsSettings.noClothes then
                            part.Color = C.gray
                            part.Material = Enum.Material.SmoothPlastic
                        else
                            part.Color = Color3.fromRGB(255, 255, 255)
                            part.Material = Enum.Material.Plastic
                        end
                    end
                end
            end
        end
        
        if fpsSettings.noFog then
            Lighting.FogEnd = 999999
            Lighting.FogStart = 999999
        else
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        end
        
        if fpsSettings.lowGraphics then
            Lighting.Brightness = 0.6
            Lighting.Ambient = Color3.fromRGB(100, 100, 100)
            Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
            Lighting.ExposureCompensation = -1
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("MeshPart") then
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
        else
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.ExposureCompensation = 0
        end
        
        Workspace.CurrentCamera.MaxDistance = fpsSettings.resolution    end)
end

-- ==================================================
-- HDR
-- ==================================================

local hdrEnabled = false
local hdrBright = 1.5
local hdrContrast = 1.8
local hdrSat = 2.0
local hdrBloom = 1.5
local hdrExposure = 1.0

local function applyHDR()
    if hdrEnabled then
        pcall(function()
            Lighting.Brightness = hdrBright * 1.8
            Lighting.Ambient = Color3.fromRGB(127 * hdrSat, 127 * hdrSat, 127 * hdrSat)
            Lighting.OutdoorAmbient = Color3.fromRGB(127 * hdrContrast, 127 * hdrContrast, 127 * hdrContrast)
            Lighting.ExposureCompensation = hdrExposure * 1.5
            Lighting.ClockTime = 14.5
            Lighting.ColorShift_Top = Color3.fromRGB(255 * hdrBloom * 0.3, 255 * hdrBloom * 0.1, 255 * hdrBloom * 0.2)
        end)
    else
        pcall(function()
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.ExposureCompensation = 0
            Lighting.ClockTime = 14
            Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        end)
    end
end

-- ==================================================
-- ESP
-- ==================================================

local espEnabled = false
local espColor = C.primary
local espObjects = {}
local espConnections = {}

local function createESP()
    if not espEnabled then return end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local espGroup = Instance.new("Model")
                espGroup.Name = "ESP_" .. plr.Name
                espGroup.Parent = char
                
                local box = Instance.new("BoxHandleAdornment")
                box.Size = Vector3.new(2.8, 3.8, 1.2)
                box.Adornee = char:FindFirstChild("HumanoidRootPart")
                box.ZIndex = 0
                box.AlwaysOnTop = true
                box.Color3 = espColor
                box.Transparency = 0.2
                box.Parent = espGroup
                
                local glow = Instance.new("BoxHandleAdornment")
                glow.Size = Vector3.new(3.0, 4.0, 1.4)
                glow.Adornee = box.Adornee
                glow.ZIndex = 0
                glow.AlwaysOnTop = true
                glow.Color3 = espColor
                glow.Transparency = 0.7
                glow.Parent = espGroup
                
                local nameLabel = Instance.new("BillboardGui")
                nameLabel.Size = UDim2.new(0, 80, 0, 14)
                nameLabel.Adornee = char:FindFirstChild("Head")
                nameLabel.StudsOffset = Vector3.new(0, 3.5, 0)
                nameLabel.MaxDistance = 400
                nameLabel.Parent = espGroup
                
                local nameText = Instance.new("TextLabel")
                nameText.Size = UDim2.new(1, 0, 1, 0)
                nameText.BackgroundTransparency = 1
                nameText.Text = plr.Name
                nameText.TextColor3 = C.primary
                nameText.TextSize = 10
                nameText.Font = Enum.Font.Code
                nameText.TextStrokeTransparency = 0.3
                nameText.Parent = nameLabel
                
                local distLabel = Instance.new("BillboardGui")
                distLabel.Size = UDim2.new(0, 40, 0, 10)
                distLabel.Adornee = char:FindFirstChild("Head")
                distLabel.StudsOffset = Vector3.new(0, -1.5, 0)
                distLabel.MaxDistance = 400
                distLabel.Parent = espGroup
                
                local distText = Instance.new("TextLabel")
                distText.Size = UDim2.new(1, 0, 1, 0)
                distText.BackgroundTransparency = 1
                distText.Text = "0m"
                distText.TextColor3 = C.dim
                distText.TextSize = 8
                distText.Font = Enum.Font.Code
                distText.Parent = distLabel
                
                local conn = RunService.RenderStepped:Connect(function()
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    local playerChar = player.Character
                    if not playerChar or not playerChar:FindFirstChild("HumanoidRootPart") then return end
                    local dist = (char.HumanoidRootPart.Position - playerChar.HumanoidRootPart.Position).Magnitude
                    distText.Text = math.floor(dist) .. "m"
                    
                    local scale = math.clamp(1 / (dist / 35 + 1), 0.2, 1)
                    box.Size = Vector3.new(2.8 * scale, 3.8 * scale, 1.2 * scale)
                    glow.Size = Vector3.new(3.0 * scale, 4.0 * scale, 1.4 * scale)
                end)
                table.insert(espConnections, conn)
                
                espObjects[plr] = espGroup
            end
        end
    end
end

local function removeESP()
    for plr, espGroup in pairs(espObjects) do
        pcall(function() espGroup:Destroy() end)
    end
    espObjects = {}
    for _, conn in ipairs(espConnections) do
        pcall(function() conn:Disconnect() end)
    end
    espConnections = {}
end

local function updateESP()
    if espEnabled then
        removeESP()
        createESP()
    else
        removeESP()
    end
end

-- ==================================================
-- TAB 1: FONTS
-- ==================================================

local p1 = tabPages[1]
section(p1, "FONT CHANGER - 8 FONTS")

for _, font in ipairs(fontList) do
    terminalButton(p1, "[ " .. font .. " ]", function()
        changeFont(font)
    end, C.primary)
end

terminalButton(p1, "[ RESET FONT ]", function()
    currentFont = nil
    applyFontToAll()
    notify("🔄 Font reset!", 2)
end, C.red)

-- ==================================================
-- TAB 2: SKYBOX
-- ==================================================

local p2 = tabPages[2]
section(p2, "SKYBOX CHANGER")

for _, skybox in ipairs(skyboxList) do
    terminalButton(p2, "[ " .. skybox[1] .. " ]", function()
        changeSkybox(skybox[2])
    end, C.secondary)
end

terminalButton(p2, "[ RESET SKYBOX ]", function()
    resetSkybox()
end, C.red)

-- ==================================================
-- TAB 3: FPS BOOST
-- ==================================================

local p3 = tabPages[3]
section(p3, "FPS BOOST SETTINGS")

local shadowsToggle = terminalToggle(p3, "Disable Shadows", false, function(s)
    fpsSettings.noShadows = s
    applyFPSBoost()
end)

local grassToggle = terminalToggle(p3, "Remove Grass", false, function(s)
    fpsSettings.noGrass = s
    applyFPSBoost()
end)

local grayToggle = terminalToggle(p3, "Gray Sky", false, function(s)
    fpsSettings.graySky = s
    applyFPSBoost()
end)

local clothesToggle = terminalToggle(p3, "Gray Players", false, function(s)
    fpsSettings.noClothes = s
    applyFPSBoost()
end)

local fogToggle = terminalToggle(p3, "Disable Fog", false, function(s)
    fpsSettings.noFog = s
    applyFPSBoost()
end)

local lowGraphToggle = terminalToggle(p3, "Low Graphics", false, function(s)
    fpsSettings.lowGraphics = s
    applyFPSBoost()
end)

local resSlider = terminalSlider(p3, "Render Distance", 250, 2500, 1080, "", function(v)
    fpsSettings.resolution = math.floor(v)
    applyFPSBoost()
end)

terminalButton(p3, "[ RESET FPS ]", function()
    fpsSettings.noShadows = false
    fpsSettings.noGrass = false
    fpsSettings.graySky = false
    fpsSettings.noClothes = false
    fpsSettings.noFog = false
    fpsSettings.lowGraphics = false
    fpsSettings.resolution = 1080
    applyFPSBoost()
    notify("🔄 FPS reset!", 2)
end, C.red)

-- ==================================================
-- TAB 4: HDR
-- ==================================================

local p4 = tabPages[4]
section(p4, "ULTRA HDR SETTINGS")

label(p4, "Enable Ultra HDR", C.gold)

local hdrToggle = terminalToggle(p4, "Enable Ultra HDR", false, function(s)
    hdrEnabled = s
    applyHDR()
end)

local hdrBrightSlider = terminalSlider(p4, "Brightness", 0.1, 3.0, 1.5, "", function(v)
    hdrBright = v
    if hdrEnabled then applyHDR()
end)

local hdrContrastSlider = terminalSlider(p4, "Contrast", 0.1, 3.0, 1.8, "", function(v)
    hdrContrast = v
    if hdrEnabled then applyHDR()
end)

local hdrSatSlider = terminalSlider(p4, "Saturation", 0.1, 3.0, 2.0, "", function(v)
    hdrSat = v
    if hdrEnabled then applyHDR()
end)

local hdrBloomSlider = terminalSlider(p4, "Bloom", 0, 3.0, 1.5, "", function(v)
    hdrBloom = v
    if hdrEnabled then applyHDR()
end)

local hdrExposureSlider = terminalSlider(p4, "Exposure", 0, 2.0, 1.0, "", function(v)
    hdrExposure = v
    if hdrEnabled then applyHDR()
end)

terminalButton(p4, "[ RESET HDR ]", function()
    hdrEnabled = false
    hdrBright = 1.5
    hdrContrast = 1.8
    hdrSat = 2.0
    hdrBloom = 1.5
    hdrExposure = 1.0
    applyHDR()
    notify("🔄 HDR reset!", 2)
end, C.red)

-- ==================================================
-- TAB 5: ESP & CROSSHAIR
-- ==================================================

local p5 = tabPages[5]
section(p5, "ESP & CROSSHAIR")

local espToggle = terminalToggle(p5, "Enable ESP", false, function(s)
    espEnabled = s
    if s then
        createESP()
        notify("👁️ ESP enabled", 2)
    else
        removeESP()
        notify("👁️ ESP disabled", 2)
    end
end)

local espColorPicker = terminalColorPicker(p5, "ESP Color", C.primary, function(color)
    espColor = color
    if espEnabled then updateESP()
end)

section(p5, "CROSSHAIR")

local crosshairInput = Instance.new("TextBox")
crosshairInput.Size = UDim2.new(1, -10, 0, isMobile and 34 or 26)
crosshairInput.Position = UDim2.new(0, 5, 0, 0)
crosshairInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
crosshairInput.BackgroundTransparency = 0.2
crosshairInput.BorderSizePixel = 1
crosshairInput.BorderColor3 = C.primary
crosshairInput.Text = ""
crosshairInput.TextColor3 = C.text
crosshairInput.TextSize = isMobile and 12 or 10
crosshairInput.Font = Enum.Font.Code
crosshairInput.PlaceholderText = "Enter Image ID..."
crosshairInput.Parent = p5

local crosshairBtn = terminalButton(p5, "[ SET CROSSHAIR ]", function()
    local id = crosshairInput.Text
    if id == "" then
        notify("⚠️ Please enter an ID!", 2)
        return
    end
    pcall(function()
        local crosshair = CoreGui:FindFirstChild("Crosshair")
        if not crosshair then
            crosshair = Instance.new("ImageLabel")
            crosshair.Name = "Crosshair"
            crosshair.Size = UDim2.new(0, 50, 0, 50)
            crosshair.Position = UDim2.new(0.5, -25, 0.5, -25)
            crosshair.BackgroundTransparency = 1
            crosshair.Parent = CoreGui
        end
        crosshair.Image = "rbxassetid://" .. id
        crosshair.Visible = true
        notify("🎯 Crosshair set!", 2)
    end)
end, C.secondary)

terminalButton(p5, "[ RESET CROSSHAIR ]", function()
    pcall(function()
        local crosshair = CoreGui:FindFirstChild("Crosshair")
        if crosshair then crosshair:Destroy()
        notify("🔄 Crosshair reset!", 2)
    end)
end, C.red)

-- ==================================================
-- FOOTER
-- ==================================================

local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, -8, 0, isMobile and 24 or 20)
footer.Position = UDim2.new(0, 4, 1, -(isMobile and 28 or 22))
footer.BackgroundTransparency = 1
footer.BorderSizePixel = 0
footer.Parent = content

local ftText = Instance.new("TextLabel")
ftText.Size = UDim2.new(1, 0, 1, 0)
ftText.BackgroundTransparency = 1
ftText.Text = "$ RTXRRR v6.1 // MOBILE EDITION"
ftText.TextColor3 = C.dim
ftText.TextSize = isMobile and 11 or 9
ftText.Font = Enum.Font.Code
ftText.TextXAlignment = Enum.TextXAlignment.Center
ftText.Parent = footer

-- ==================================================
-- PC KEYBIND
-- ==================================================

if not isMobile then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightControl then
            if hub.Visible == false then
                hub.Visible = true
                toggleBtn.Text = "⚡"
                toggleBtn.BackgroundColor3 = C.primary
                toggleBtn.BackgroundTransparency = 0.1
                toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                toggleBtn.BorderColor3 = C.primary
            else
                hub.Visible = false
                toggleBtn.Text = "⚡"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                toggleBtn.BackgroundTransparency = 0.2
                toggleBtn.TextColor3 = C.primary
                toggleBtn.BorderColor3 = C.primary
            end
        end
    end)
end

-- ==================================================
-- PLAYER HOOKS
-- ==================================================

Players.PlayerAdded:Connect(function()
    if espEnabled then task.wait(0.5); createESP() end
end)

Players.PlayerRemoving:Connect(function(plr)
    if espObjects[plr] then
        pcall(function() espObjects[plr]:Destroy() end)
        espObjects[plr] = nil
    end
end)

coroutine.wrap(function()
    while true do
        task.wait(1)
        if espEnabled then
            updateESP()
        end
    end
end)()

print("==========================================")
print("✅ RTXRRR v6.1 - MOBILE EDITION (FIXED)")
print("📋 Features:")
print("   🔤 8 Font Changer")
print("   🌤️ 10+ Skybox Changer")
print("   ⚡ FPS Boost - All Settings")
print("   🎨 Ultra HDR")
print("   👁️ ESP - Box Line")
print("   🎯 Crosshair Changer")
print("   💻 Terminal Style")
print("   📱 Mobile Optimized")
print("==========================================")
print("✅ Tap ⚡ to open/close the menu!")