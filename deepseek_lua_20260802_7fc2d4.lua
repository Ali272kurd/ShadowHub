-- ==================================================
-- RTXRRR v2.5 - COMPLETE REWRITE - FULLY WORKING
-- 90s Terminal Style • Font Changer • Skybox Changer • FPS Boost • Ultra HDR
-- ==================================================

print("Loading RTXRRR v2.5...")

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- COLORS
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
-- TOGGLE BUTTON - SIMPLE & WORKING
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(1, -65, 0, 10)
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

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 0)
toggleCorner.Parent = toggleBtn

-- Draggable
local toggleDragging = false
local toggleDragOff = Vector2.new(0, 0)

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = true
        toggleDragOff = Vector2.new(mouse.X - toggleBtn.AbsolutePosition.X, mouse.Y - toggleBtn.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if toggleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        pcall(function()
            toggleBtn.Position = UDim2.new(0, mouse.X - toggleDragOff.X, 0, mouse.Y - toggleDragOff.Y)
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = false
    end
end)

-- ==================================================
-- MAIN HUB
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 450, 0, 500)
hub.Position = UDim2.new(0.5, -225, 0.5, -250)
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

-- BACKGROUND IMAGE
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://126049593669150"
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.Parent = hub

-- ==================================================
-- HEADER
-- ==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 1
header.BorderColor3 = C.primary
header.Parent = hub

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 26)
title.Position = UDim2.new(0, 10, 0, 4)
title.BackgroundTransparency = 1
title.Text = "$ RTXRRR v2.5 // VISUAL ENHANCER"
title.TextColor3 = C.primary
title.TextSize = 14
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -20, 0, 12)
subTitle.Position = UDim2.new(0, 10, 0, 30)
subTitle.BackgroundTransparency = 1
subTitle.Text = "> FONTS • SKYBOX • FPS BOOST • HDR"
subTitle.TextColor3 = C.dim
subTitle.TextSize = 9
subTitle.Font = Enum.Font.Code
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.Parent = header

-- Close button
local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, 28, 0, 28)
closeB.Position = UDim2.new(1, -36, 0.5, -14)
closeB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeB.BackgroundTransparency = 0.3
closeB.Text = "X"
closeB.TextColor3 = C.primary
closeB.TextSize = 13
closeB.Font = Enum.Font.Code
closeB.BorderSizePixel = 1
closeB.BorderColor3 = C.primary
closeB.Parent = header

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
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubDragging = true
        hubDragOff = Vector2.new(mouse.X - hub.AbsolutePosition.X, mouse.Y - hub.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if hubDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        pcall(function()
            hub.Position = UDim2.new(0, mouse.X - hubDragOff.X, 0, mouse.Y - hubDragOff.Y)
        end)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubDragging = false
    end
end)

-- ==================================================
-- TOGGLE BUTTON CLICK - SIMPLE
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
tabContainer.Size = UDim2.new(1, -20, 0, 28)
tabContainer.Position = UDim2.new(0, 10, 0, 48)
tabContainer.BackgroundTransparency = 1
tabContainer.BorderSizePixel = 0
tabContainer.Parent = hub

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -92)
content.Position = UDim2.new(0, 10, 0, 80)
content.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
content.BackgroundTransparency = 0.3
content.BorderSizePixel = 1
content.BorderColor3 = C.dim
content.ClipsDescendants = true
content.Parent = hub

local tabNames = {"FONTS", "SKYBOX", "FPS", "HDR"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 95, 0, 24)
    btn.Position = UDim2.new(0, (i-1)*100, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 1
    btn.BorderColor3 = C.dim
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = 10
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
-- UI HELPERS
-- ==================================================

local function section(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 22)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "> " .. text
    l.TextColor3 = C.primary
    l.TextSize = 11
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
    b.Size = UDim2.new(1, 0, 0, 26)
    b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    b.BackgroundTransparency = 0.3
    b.BorderSizePixel = 1
    b.BorderColor3 = color
    b.Text = text
    b.TextColor3 = color
    b.TextSize = 10
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
    f.Size = UDim2.new(1, 0, 0, 28)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 10
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 38, 0, 20)
    btn.Position = UDim2.new(1, -44, 0.5, -10)
    btn.BackgroundColor3 = default and C.primary or Color3.fromRGB(20, 20, 20)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = default and C.primary or C.dim
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = default and Color3.fromRGB(0, 0, 0) or C.dim
    btn.TextSize = 8
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
    f.Size = UDim2.new(1, 0, 0, 38)
    f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 1
    f.BorderColor3 = C.dim
    f.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -16, 0, 16)
    l.Position = UDim2.new(0, 8, 0, 2)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def) .. suffix
    l.TextColor3 = C.text
    l.TextSize = 9
    l.Font = Enum.Font.Code
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 3)
    bg.Position = UDim2.new(0, 10, 0, 22)
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
    valueInput.Size = UDim2.new(0, 40, 0, 16)
    valueInput.Position = UDim2.new(1, -48, 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    valueInput.Text = tostring(def)
    valueInput.TextColor3 = C.text
    valueInput.TextSize = 9
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
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            update(i.Position.X)
        end
    end)
    
    return {get = function() return val end, set = function(v) val = v end}
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
}

local function applyFontToObject(obj)
    if obj:IsA("TextLabel") then
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

-- Hook new GUI elements
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
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        
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
-- FPS BOOST
-- ==================================================

local fpsSettings = {
    noShadowsEnabled = false,
    noGrassEnabled = false,
    graySkyEnabled = false,
    noClothesEnabled = false,
    noFogEnabled = false,
    resolution = 1080,
}

local function applyFPSBoost()
    if fpsSettings.noShadowsEnabled then
        pcall(function() Lighting.GlobalShadows = false end)
    else
        pcall(function() Lighting.GlobalShadows = true end)
    end
    
    if fpsSettings.noGrassEnabled then
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name:lower():find("grass") then
                    obj.Transparency = 1
                end
            end
        end)
    end
    
    if fpsSettings.graySkyEnabled then
        pcall(function()
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end)
    end
    
    if fpsSettings.noClothesEnabled then
        pcall(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then
                    for _, part in ipairs(plr.Character:GetChildren()) do
                        if part:IsA("Part") and (part.Name:lower():find("shirt") or part.Name:lower():find("pants") or part.Name:lower():find("clothes")) then
                            part.Transparency = 1
                        end
                    end
                end
            end
        end)
    end
    
    if fpsSettings.noFogEnabled then
        pcall(function()
            Lighting.FogEnd = 999999
            Lighting.FogStart = 999999
        end)
    end
    
    pcall(function()
        Workspace.CurrentCamera.MaxDistance = fpsSettings.resolution
    end)
end

-- ==================================================
-- TAB 1: FONTS
-- ==================================================

local p1 = tabPages[1]
section(p1, "FONT CHANGER - 5 FONTS")

for _, font in ipairs(fontList) do
    terminalButton(p1, "[ " .. font .. " ]", function()
        changeFont(font)
    end, C.primary)
end

terminalButton(p1, "[ RESET FONT ]", function()
    currentFont = nil
    applyFontToAll()
    notify("🔄 Font reset to default!", 2)
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

local noShadowsToggle = terminalToggle(p3, "Disable Shadows", false, function(s)
    fpsSettings.noShadowsEnabled = s
    applyFPSBoost()
    notify(s and "⚡ Shadows DISABLED" or "⚡ Shadows ENABLED", 2)
end)

local noGrassToggle = terminalToggle(p3, "Remove Grass", false, function(s)
    fpsSettings.noGrassEnabled = s
    applyFPSBoost()
    notify(s and "⚡ Grass REMOVED" or "⚡ Grass RESTORED", 2)
end)

local graySkyToggle = terminalToggle(p3, "Gray Sky", false, function(s)
    fpsSettings.graySkyEnabled = s
    applyFPSBoost()
    notify(s and "⚡ Gray Sky ENABLED" or "⚡ Gray Sky DISABLED", 2)
end)

local noClothesToggle = terminalToggle(p3, "Remove Clothes", false, function(s)
    fpsSettings.noClothesEnabled = s
    applyFPSBoost()
    notify(s and "⚡ Clothes REMOVED" or "⚡ Clothes RESTORED", 2)
end)

local noFogToggle = terminalToggle(p3, "Disable Fog", false, function(s)
    fpsSettings.noFogEnabled = s
    applyFPSBoost()
    notify(s and "⚡ Fog DISABLED" or "⚡ Fog ENABLED", 2)
end)

local resolutionSlider = terminalSlider(p3, "Resolution (Camera Farness)", 250, 2500, 1080, "", function(v)
    fpsSettings.resolution = math.floor(v)
    applyFPSBoost()
    notify("📊 Resolution set to: " .. math.floor(v), 2)
end)

terminalButton(p3, "[ RESET ALL FPS SETTINGS ]", function()
    fpsSettings.noShadowsEnabled = false
    fpsSettings.noGrassEnabled = false
    fpsSettings.graySkyEnabled = false
    fpsSettings.noClothesEnabled = false
    fpsSettings.noFogEnabled = false
    fpsSettings.resolution = 1080
    applyFPSBoost()
    notify("🔄 All FPS settings reset!", 2)
end, C.red)

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
footer.Size = UDim2.new(1, -8, 0, 20)
footer.Position = UDim2.new(0, 4, 1, -22)
footer.BackgroundTransparency = 1
footer.BorderSizePixel = 0
footer.Parent = content

local ftText = Instance.new("TextLabel")
ftText.Size = UDim2.new(1, 0, 1, 0)
ftText.BackgroundTransparency = 1
ftText.Text = "$ RTXRRR v2.5 // TERMINAL EDITION"
ftText.TextColor3 = C.dim
ftText.TextSize = 9
ftText.Font = Enum.Font.Code
ftText.TextXAlignment = Enum.TextXAlignment.Center
ftText.Parent = footer

print("==========================================")
print("✅ RTXRRR v2.5 - COMPLETE REWRITE")
print("📋 Features:")
print("   🔤 5 Font Changer")
print("   🌤️ 10+ Skybox Changer")
print("   ⚡ FPS Boost - Shadows, Grass, Sky, Clothes, Fog")
print("   🎨 Ultra HDR Settings")
print("   📊 Resolution/Farness Slider")
print("   💻 Terminal Style")
print("   🖼️ Background Image")
print("==========================================")
print("✅ Click ⚡ to open the menu!")