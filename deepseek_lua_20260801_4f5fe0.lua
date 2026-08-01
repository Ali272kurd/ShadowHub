-- ==================================================
-- REDDIEHUB v25.0 - ULTIMATE PREMIUM EDITION
-- Floating Buttons • Skybox Changer • Font Changer
-- Crystal/Snowflake Background • Key: Ali
-- ==================================================

-- Safety pcall for all operations
local success, err = pcall(function()

print("Loading ReddieHub v25.0...")

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
local MarketPlaceService = game:GetService("MarketplaceService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- PREMIUM COLORS - Crystal/Snowflake Theme
-- ==================================================

local C = {
    primary = Color3.fromRGB(0, 200, 255),         -- Crystal Blue
    primaryDark = Color3.fromRGB(0, 100, 180),
    primaryGlow = Color3.fromRGB(50, 220, 255),
    secondary = Color3.fromRGB(200, 230, 255),     -- Ice White
    secondaryGlow = Color3.fromRGB(220, 240, 255),
    accent = Color3.fromRGB(150, 200, 255),        -- Light Crystal
    accentGlow = Color3.fromRGB(180, 220, 255),
    dark = Color3.fromRGB(4, 4, 12),
    bg = Color3.fromRGB(8, 8, 18),
    panel = Color3.fromRGB(12, 12, 22),
    panelLight = Color3.fromRGB(18, 18, 28),
    text = Color3.fromRGB(235, 240, 250),
    dim = Color3.fromRGB(130, 150, 180),
    green = Color3.fromRGB(0, 255, 80),
    gold = Color3.fromRGB(255, 215, 0),
    blue = Color3.fromRGB(60, 160, 255),
    red = Color3.fromRGB(255, 40, 40),
    purple = Color3.fromRGB(190, 60, 255),
    pink = Color3.fromRGB(255, 80, 180),
    cyan = Color3.fromRGB(0, 255, 255),
    orange = Color3.fromRGB(255, 150, 0),
    glass = Color3.fromRGB(255, 255, 255),
}

local function notify(msg, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "🔷 ReddieHub",
            Text = tostring(msg),
            Duration = dur or 3
        })
    end)
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ReddieHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

print("ScreenGui created!")

-- ==================================================
-- CRYSTAL/SNOWFLAKE BACKGROUND
-- ==================================================

local function createCrystalBackground(parent)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.3
    bg.BorderSizePixel = 0
    bg.Parent = parent
    
    -- Crystal gradient
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 50, 100)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 100, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 150, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(0, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 50, 100)),
    })
    grad.Rotation = 45
    grad.Parent = bg
    
    -- Snowflakes
    for i = 1, 30 do
        local flake = Instance.new("Frame")
        flake.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        flake.Position = UDim2.new(math.random(), 0, math.random(), 0)
        flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        flake.BackgroundTransparency = math.random(30, 70) / 100
        flake.BorderSizePixel = 0
        flake.Parent = bg
        
        local flakeCorner = Instance.new("UICorner")
        flakeCorner.CornerRadius = UDim.new(1, 0)
        flakeCorner.Parent = flake
        
        -- Animate snowflakes
        task.spawn(function()
            local speed = math.random(5, 15) / 100
            local drift = math.random(-10, 10) / 100
            local startPos = flake.Position
            while flake and flake.Parent do
                local x = (flake.Position.X.Scale + drift) % 1
                local y = (flake.Position.Y.Scale + speed) % 1
                pcall(function()
                    flake.Position = UDim2.new(x, 0, y, 0)
                end)
                task.wait(0.05)
            end
        end)
    end
    
    return bg
end

-- ==================================================
-- STROKE HELPERS
-- ==================================================

local function addCrystalStroke(obj, thickness)
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
-- AUTH LOADING SCREEN - Key: Ali
-- ==================================================

local loadingScreenGui = Instance.new("ScreenGui")
loadingScreenGui.Name = "LoadingScreen"
loadingScreenGui.ResetOnSpawn = false
loadingScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Background
local loadingBg = Instance.new("Frame")
loadingBg.Size = UDim2.new(1, 0, 1, 0)
loadingBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingBg.BorderSizePixel = 0
loadingBg.Parent = loadingScreenGui

-- Crystal background for loading
createCrystalBackground(loadingBg)

-- Glowing border frame
local borderFrame = Instance.new("Frame")
borderFrame.Size = UDim2.new(0, 400, 0, 460)
borderFrame.Position = UDim2.new(0.5, -200, 0.5, -230)
borderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
borderFrame.BackgroundTransparency = 0.1
borderFrame.BorderSizePixel = 0
borderFrame.ClipsDescendants = true
borderFrame.Parent = loadingBg

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 24)
borderCorner.Parent = borderFrame

addCrystalStroke(borderFrame, 3)
addGlowStroke(borderFrame, 4)

-- Title
local authTitle = Instance.new("TextLabel")
authTitle.Size = UDim2.new(1, -40, 0, 55)
authTitle.Position = UDim2.new(0, 20, 0, 25)
authTitle.BackgroundTransparency = 1
authTitle.Text = "REDDIEHUB v25.0"
authTitle.TextColor3 = C.primaryGlow
authTitle.TextSize = 30
authTitle.Font = Enum.Font.GothamBold
authTitle.TextXAlignment = Enum.TextXAlignment.Center
authTitle.TextStrokeTransparency = 0.2
authTitle.Parent = borderFrame

-- Line
local titleLine = Instance.new("Frame")
titleLine.Size = UDim2.new(0.6, 0, 0, 2)
titleLine.Position = UDim2.new(0.2, 0, 0, 85)
titleLine.BackgroundColor3 = C.primary
titleLine.BorderSizePixel = 0
titleLine.Parent = borderFrame

-- Avatar
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 90, 0, 90)
avatar.Position = UDim2.new(0.5, -45, 0, 115)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420"
avatar.Parent = borderFrame
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 18)
avatarCorner.Parent = avatar
local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 3
avatarStroke.Color = C.primaryGlow
avatarStroke.Transparency = 0.1
avatarStroke.Parent = avatar

-- Username
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Size = UDim2.new(1, -40, 0, 28)
usernameLabel.Position = UDim2.new(0, 20, 0, 220)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = player.Name
usernameLabel.TextColor3 = C.text
usernameLabel.TextSize = 18
usernameLabel.Font = Enum.Font.GothamBold
usernameLabel.TextXAlignment = Enum.TextXAlignment.Center
usernameLabel.TextStrokeTransparency = 0.2
usernameLabel.Parent = borderFrame

-- TikTok
local tiktokLabel = Instance.new("TextLabel")
tiktokLabel.Size = UDim2.new(1, -40, 0, 22)
tiktokLabel.Position = UDim2.new(0, 20, 0, 250)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Text = "📱 Follow TikTok: .vfsv"
tiktokLabel.TextColor3 = C.primaryGlow
tiktokLabel.TextSize = 14
tiktokLabel.Font = Enum.Font.GothamBold
tiktokLabel.TextXAlignment = Enum.TextXAlignment.Center
tiktokLabel.Parent = borderFrame

-- "Enter License Key:" label
local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, -40, 0, 22)
keyLabel.Position = UDim2.new(0, 20, 0, 285)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Enter License Key:"
keyLabel.TextColor3 = C.dim
keyLabel.TextSize = 13
keyLabel.Font = Enum.Font.GothamSemibold
keyLabel.TextXAlignment = Enum.TextXAlignment.Center
keyLabel.Parent = borderFrame

-- License Key Input Box
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0, 45)
keyInput.Position = UDim2.new(0.1, 0, 0, 315)
keyInput.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
keyInput.Text = ""
keyInput.TextColor3 = C.primaryGlow
keyInput.TextSize = 18
keyInput.Font = Enum.Font.GothamBold
keyInput.TextXAlignment = Enum.TextXAlignment.Center
keyInput.PlaceholderText = "★★★★★★★★★★★★★★★"
keyInput.PlaceholderColor3 = Color3.fromRGB(40, 40, 60)
keyInput.ClearTextOnFocus = true
keyInput.BorderSizePixel = 0
keyInput.Parent = borderFrame
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keyInput
addCrystalStroke(keyInput, 2)

-- Activate Button
local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(0.6, 0, 0, 45)
activateBtn.Position = UDim2.new(0.2, 0, 0, 375)
activateBtn.BackgroundColor3 = C.primary
activateBtn.BackgroundTransparency = 0.1
activateBtn.Text = "Activate"
activateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
activateBtn.TextSize = 20
activateBtn.Font = Enum.Font.GothamBold
activateBtn.BorderSizePixel = 0
activateBtn.Parent = borderFrame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = activateBtn
addCrystalStroke(activateBtn, 2)
addGlowStroke(activateBtn, 2.5)

-- Auth state
local isAuthorized = false

-- Activate button function
activateBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if key == "" then
        notify("⚠️ Please enter a license key!", 3)
        return
    end
    
    if key == "Ali" then
        isAuthorized = true
        notify("✅ License key accepted!", 2)
        
        -- Destroy loading screen
        pcall(function()
            loadingScreenGui:Destroy()
        end)
        
        -- Show main GUI
        hub.Visible = false
        camlockFrame.Visible = true
        
        print("✅ Loading screen destroyed - Auth successful!")
        notify("🔷 ReddieHub v25.0 Loaded! Click 🔷 to open", 4)
        
        -- Setup keybinds for PC
        setupKeybinds()
    else
        notify("❌ Invalid license key! Please try again.", 3)
        keyInput.Text = ""
        keyInput.PlaceholderText = "Invalid Key"
        task.wait(1.5)
        keyInput.PlaceholderText = "★★★★★★★★★★★★★★★"
    end
end)

-- Enter key support
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        activateBtn.MouseButton1Click:Fire()
    end
end)

-- ==================================================
-- MAIN HUB
-- ==================================================

local hub = Instance.new("Frame")
hub.Size = UDim2.new(0, 620, 0, 560)
hub.Position = UDim2.new(0.5, -310, 0.5, -280)
hub.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
hub.BackgroundTransparency = 0.05
hub.BorderSizePixel = 0
hub.ClipsDescendants = true
hub.Visible = false
hub.Parent = screenGui

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 24)
hc.Parent = hub

addCrystalStroke(hub, 2)
addGlowStroke(hub, 3)

-- Crystal background for hub
local hubBg = createCrystalBackground(hub)
hubBg.BackgroundTransparency = 0.5

-- Outer glow
local outerGlow = Instance.new("Frame")
outerGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
outerGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
outerGlow.BackgroundColor3 = C.primary
outerGlow.BackgroundTransparency = 0.95
outerGlow.BorderSizePixel = 0
outerGlow.Parent = hub
local outerGlowCorner = Instance.new("UICorner")
outerGlowCorner.CornerRadius = UDim.new(0, 28)
outerGlowCorner.Parent = outerGlow

-- Glass panel
local glassPanel = Instance.new("Frame")
glassPanel.Size = UDim2.new(1, 0, 1, 0)
glassPanel.BackgroundColor3 = C.glass
glassPanel.BackgroundTransparency = 0.94
glassPanel.BorderSizePixel = 0
glassPanel.Parent = hub
local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 24)
glassCorner.Parent = glassPanel

-- Title Bar
local title = Instance.new("Frame")
title.Size = UDim2.new(1, 0, 0, 54)
title.BackgroundColor3 = C.dark
title.BackgroundTransparency = 0.2
title.BorderSizePixel = 0
title.Parent = hub

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 24)
titleCorner.Parent = title

local titleGlass = Instance.new("Frame")
titleGlass.Size = UDim2.new(1, 0, 1, 0)
titleGlass.BackgroundColor3 = C.glass
titleGlass.BackgroundTransparency = 0.94
titleGlass.BorderSizePixel = 0
titleGlass.Parent = title
local titleGlassCorner = Instance.new("UICorner")
titleGlassCorner.CornerRadius = UDim.new(0, 24)
titleGlassCorner.Parent = titleGlass

-- Accent line
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.BackgroundColor3 = C.primary
accentLine.BorderSizePixel = 0
accentLine.Parent = title

-- Title icon
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 42, 1, 0)
icon.Position = UDim2.new(0, 16, 0, 0)
icon.BackgroundTransparency = 1
icon.Text = "🔷"
icon.TextColor3 = C.primary
icon.TextSize = 24
icon.Font = Enum.Font.GothamBold
icon.TextXAlignment = Enum.TextXAlignment.Center
icon.Parent = title

local ttl = Instance.new("TextLabel")
ttl.Size = UDim2.new(0, 170, 1, 0)
ttl.Position = UDim2.new(0, 62, 0, 0)
ttl.BackgroundTransparency = 1
ttl.Text = "ReddieHub"
ttl.TextColor3 = C.text
ttl.TextSize = 20
ttl.Font = Enum.Font.GothamBold
ttl.TextXAlignment = Enum.TextXAlignment.Left
ttl.Parent = title

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 65, 1, 0)
version.Position = UDim2.new(0, 180, 0, 0)
version.BackgroundTransparency = 1
version.Text = "v25.0"
version.TextColor3 = C.primaryGlow
version.TextSize = 13
version.Font = Enum.Font.GothamBold
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = title

-- Close button
local closeB = Instance.new("TextButton")
closeB.Size = UDim2.new(0, 36, 0, 36)
closeB.Position = UDim2.new(1, -46, 0.5, -18)
closeB.BackgroundColor3 = C.panel
closeB.BackgroundTransparency = 0.2
closeB.Text = "✕"
closeB.TextColor3 = C.dim
closeB.TextSize = 16
closeB.Font = Enum.Font.GothamBold
closeB.BorderSizePixel = 0
closeB.Parent = title

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeB
addCrystalStroke(closeB, 1.5)

closeB.MouseEnter:Connect(function()
    closeB.BackgroundColor3 = C.primary
    closeB.BackgroundTransparency = 0.3
    closeB.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
closeB.MouseLeave:Connect(function()
    closeB.BackgroundColor3 = C.panel
    closeB.BackgroundTransparency = 0.2
    closeB.TextColor3 = C.dim
end)
closeB.MouseButton1Click:Connect(function()
    hub.Visible = false
end)

-- Drag hub
local hubDragging = false
local hubDragOff = Vector2.new(0, 0)

pcall(function()
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            mouse.X = input.Position.X
            mouse.Y = input.Position.Y
        end
    end)
end)

pcall(function()
    title.InputBegan:Connect(function(i)
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
-- OPEN/CLOSE BUTTON - FIXED
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 70, 0, 70)
toggleBtn.Position = UDim2.new(1, -80, 0, 10)
toggleBtn.BackgroundColor3 = C.primary
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🔷"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 35
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

-- Glow ring
local glowRing = Instance.new("Frame")
glowRing.Size = UDim2.new(1.3, 0, 1.3, 0)
glowRing.Position = UDim2.new(-0.15, 0, -0.15, 0)
glowRing.BackgroundColor3 = C.primary
glowRing.BackgroundTransparency = 0.85
glowRing.BorderSizePixel = 0
glowRing.Parent = toggleBtn
local glowRingCorner = Instance.new("UICorner")
glowRingCorner.CornerRadius = UDim.new(0, 26)
glowRingCorner.Parent = glowRing

-- Corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 20)
toggleCorner.Parent = toggleBtn

-- Strokes
addCrystalStroke(toggleBtn, 2.5)
addGlowStroke(toggleBtn, 3)

-- Glass overlay
local toggleGlass = Instance.new("Frame")
toggleGlass.Size = UDim2.new(1, 0, 1, 0)
toggleGlass.BackgroundColor3 = C.glass
toggleGlass.BackgroundTransparency = 0.9
toggleGlass.BorderSizePixel = 0
toggleGlass.Parent = toggleBtn
local toggleGlassCorner = Instance.new("UICorner")
toggleGlassCorner.CornerRadius = UDim.new(0, 20)
toggleGlassCorner.Parent = toggleGlass

-- Pulse animation
task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.05
            pcall(function()
                glowRing.Size = UDim2.new(1.3 * scale, 0, 1.3 * scale, 0)
                glowRing.Position = UDim2.new(-0.15 * scale, 0, -0.15 * scale, 0)
                glowRing.BackgroundTransparency = 0.8 + math.sin(t * math.pi * 2) * 0.05
            end)
            task.wait(0.016)
        end
    end
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

-- Toggle button click - FIXED
toggleBtn.MouseButton1Click:Connect(function()
    hub.Visible = not hub.Visible
    if hub.Visible then
        pcall(function()
            hub:TweenSize(UDim2.new(0, 620, 0, 560), "Out", "Back", 0.5, true)
        end)
        toggleBtn.Text = "🟢"
        toggleBtn.BackgroundColor3 = C.green
        toggleBtn.BackgroundTransparency = 0.1
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        toggleBtn.Text = "🔷"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.1
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- ==================================================
-- TABS
-- ==================================================

local tabC = Instance.new("Frame")
tabC.Size = UDim2.new(1, -20, 0, 38)
tabC.Position = UDim2.new(0, 10, 0, 58)
tabC.BackgroundTransparency = 1
tabC.BorderSizePixel = 0
tabC.Parent = hub

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -115)
content.Position = UDim2.new(0, 10, 0, 102)
content.BackgroundColor3 = C.panel
content.BackgroundTransparency = 0.1
content.BorderSizePixel = 0
content.ClipsDescendants = true
content.Parent = hub

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 14)
contentCorner.Parent = content
addCrystalStroke(content, 1.5)

local contentGlass = Instance.new("Frame")
contentGlass.Size = UDim2.new(1, 0, 1, 0)
contentGlass.BackgroundColor3 = C.glass
contentGlass.BackgroundTransparency = 0.94
contentGlass.BorderSizePixel = 0
contentGlass.Parent = content
local contentGlassCorner = Instance.new("UICorner")
contentGlassCorner.CornerRadius = UDim.new(0, 14)
contentGlassCorner.Parent = contentGlass

local tabNames = {"🏃 Move", "📍 Tele", "🎯 Lock", "👁️ ESP", "🎮 Tools", "📦 Skybox", "🔤 Font"}
local tabBtns = {}
local tabPages = {}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 84, 0, 34)
    btn.Position = UDim2.new(0, (i-1)*88, 0, 0)
    btn.BackgroundColor3 = C.panel
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = C.dim
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = tabC
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    addCrystalStroke(btn, 1.2)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = C.primary
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content
    
    local pl = Instance.new("UIListLayout")
    pl.Padding = UDim.new(0, 6)
    pl.SortOrder = Enum.SortOrder.LayoutOrder
    pl.Parent = page
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 2)
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
-- UI HELPERS
-- ==================================================

local function section(parent, text)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 28)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.Parent = parent
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -6, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "✦ " .. text
    l.TextColor3 = C.primaryGlow
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Position = UDim2.new(0, 6, 0, 0)
    l.Parent = s
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1.5)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = C.primary
    line.BackgroundTransparency = 0.3
    line.BorderSizePixel = 0
    line.Parent = s
    
    return s
end

local function label(parent, text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.dim
    l.TextSize = 12
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function toggle(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 36)
    f.BackgroundColor3 = C.panelLight
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCrystalStroke(f, 1.2)
    
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
    l.Size = UDim2.new(1, -60, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 13
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 48, 0, 26)
    btn.Position = UDim2.new(1, -56, 0.5, -13)
    btn.BackgroundColor3 = default and C.primary or Color3.fromRGB(40, 40, 50)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = f
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 13)
    btnCorner.Parent = btn
    addCrystalStroke(btn, 1)
    
    local circ = Instance.new("Frame")
    circ.Size = UDim2.new(0, 20, 0, 20)
    circ.Position = default and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 4, 0.5, -10)
    circ.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circ.BorderSizePixel = 0
    circ.Parent = btn
    local circCorner = Instance.new("UICorner")
    circCorner.CornerRadius = UDim.new(0, 10)
    circCorner.Parent = circ
    
    local state = default or false
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and C.primary or Color3.fromRGB(40, 40, 50)
        pcall(function()
            circ:TweenPosition(state and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 4, 0.5, -10), "Out", "Quad", 0.12, true)
        end)
        pcall(cb, state)
    end)
    
    return {get = function() return state end, set = function(v) state = v end}
end

local function inputBox(parent, placeholder)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 36)
    f.BackgroundColor3 = C.panelLight
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCrystalStroke(f, 1.2)
    
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
    i.Size = UDim2.new(1, -14, 1, 0)
    i.Position = UDim2.new(0, 8, 0, 0)
    i.BackgroundTransparency = 1
    i.PlaceholderText = placeholder
    i.PlaceholderColor3 = Color3.fromRGB(80, 80, 95)
    i.Text = ""
    i.TextColor3 = C.text
    i.TextSize = 13
    i.Font = Enum.Font.GothamSemibold
    i.TextXAlignment = Enum.TextXAlignment.Left
    i.ClearTextOnFocus = false
    i.Parent = f
    return i
end

local function button(parent, text, cb, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 36)
    b.BackgroundColor3 = color or C.primaryDark
    b.BackgroundTransparency = 0.05
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.Parent = parent
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 10)
    bCorner.Parent = b
    addCrystalStroke(b, 1.5)
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
        b.BackgroundColor3 = C.primary
        b.BackgroundTransparency = 0.1
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = color or C.primaryDark
        b.BackgroundTransparency = 0.05
    end)
    return b
end

local function slider(parent, text, min, max, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.BackgroundColor3 = C.panelLight
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCrystalStroke(f, 1.2)
    
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
    l.Size = UDim2.new(1, -16, 0, 22)
    l.Position = UDim2.new(0, 12, 0, 2)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. tostring(def)
    l.TextColor3 = C.text
    l.TextSize = 13
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -24, 0, 5)
    bg.Position = UDim2.new(0, 12, 0, 32)
    bg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
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
    
    local val = def
    local valueInput = Instance.new("TextBox")
    valueInput.Size = UDim2.new(0, 52, 0, 24)
    valueInput.Position = UDim2.new(1, -60, 0, 0)
    valueInput.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
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

local function colorPicker(parent, text, default, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 36)
    f.BackgroundColor3 = C.panelLight
    f.BackgroundTransparency = 0.1
    f.BorderSizePixel = 0
    f.Parent = parent
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 10)
    fCorner.Parent = f
    addCrystalStroke(f, 1.2)
    
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
    l.Size = UDim2.new(0, 74, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.text
    l.TextSize = 13
    l.Font = Enum.Font.GothamSemibold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
    
    local colorBtn = Instance.new("TextButton")
    colorBtn.Size = UDim2.new(0, 32, 0, 26)
    colorBtn.Position = UDim2.new(0, 88, 0.5, -13)
    colorBtn.BackgroundColor3 = default
    colorBtn.BorderSizePixel = 0
    colorBtn.Parent = f
    local colorCorner = Instance.new("UICorner")
    colorCorner.CornerRadius = UDim.new(0, 5)
    colorCorner.Parent = colorBtn
    addCrystalStroke(colorBtn, 1)
    
    local colorValue = default
    local colors = {
        Color3.fromRGB(0, 200, 255),
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(255, 45, 45),
        Color3.fromRGB(0, 220, 80),
        Color3.fromRGB(255, 215, 0),
        Color3.fromRGB(180, 50, 255),
    }
    
    colorBtn.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 190, 0, 42)
        menu.Position = UDim2.new(0, 88, 0, 36)
        menu.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        menu.BorderSizePixel = 0
        menu.ClipsDescendants = true
        menu.Parent = f
        local menuCorner = Instance.new("UICorner")
        menuCorner.CornerRadius = UDim.new(0, 8)
        menuCorner.Parent = menu
        addCrystalStroke(menu, 1)
        local menuLayout = Instance.new("UIListLayout")
        menuLayout.Padding = UDim.new(0, 5)
        menuLayout.FillDirection = Enum.FillDirection.Horizontal
        menuLayout.Parent = menu
        
        for _, color in ipairs(colors) do
            local cBtn = Instance.new("TextButton")
            cBtn.Size = UDim2.new(0, 28, 0, 28)
            cBtn.BackgroundColor3 = color
            cBtn.BorderSizePixel = 0
            cBtn.Parent = menu
            local cCorner = Instance.new("UICorner")
            cCorner.CornerRadius = UDim.new(0, 5)
            cCorner.Parent = cBtn
            cBtn.MouseButton1Click:Connect(function()
                colorValue = color
                colorBtn.BackgroundColor3 = color
                menu:Destroy()
                pcall(cb, color)
            end)
        end
    end)
    
    return {get = function() return colorValue end}
end

-- ==================================================
-- SMART TELEPORT
-- ==================================================

local function findPlayer(input)
    input = input:lower():gsub("^%s+", ""):gsub("%s+$", "")
    if input == "" then return nil end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        local name = plr.Name:lower()
        local display = plr.DisplayName and plr.DisplayName:lower() or ""
        if name == input or display == input or name:find(input, 1, true) or display:find(input, 1, true) then
            return plr
        end
    end
    return nil
end

-- ==================================================
-- CAMLOCK
-- ==================================================

local camlockEnabled = false
local camlockTarget = nil
local camlockSmoothness = 8
local camlockBodyPart = "Head"
local camlockVisible = true

local function getCamlockSmoothness()
    return math.abs(camlockSmoothness)
end

local function getCamlockOffset()
    if camlockSmoothness < 0 then
        return camlockSmoothness
    end
    return 0
end

local camlockFrame = Instance.new("Frame")
camlockFrame.Size = UDim2.new(0, 85, 0, 85)
camlockFrame.Position = UDim2.new(0, 12, 0, 45)
camlockFrame.BackgroundColor3 = C.dark
camlockFrame.BackgroundTransparency = 0.05
camlockFrame.BorderSizePixel = 0
camlockFrame.ClipsDescendants = true
camlockFrame.Parent = screenGui

local camlockCorner = Instance.new("UICorner")
camlockCorner.CornerRadius = UDim.new(0, 18)
camlockCorner.Parent = camlockFrame

addCrystalStroke(camlockFrame, 2.5)
addGlowStroke(camlockFrame, 3)

local camlockGlass = Instance.new("Frame")
camlockGlass.Size = UDim2.new(1, 0, 1, 0)
camlockGlass.BackgroundColor3 = C.glass
camlockGlass.BackgroundTransparency = 0.9
camlockGlass.BorderSizePixel = 0
camlockGlass.Parent = camlockFrame
local camlockGlassCorner = Instance.new("UICorner")
camlockGlassCorner.CornerRadius = UDim.new(0, 18)
camlockGlassCorner.Parent = camlockGlass

local camlockGlow = Instance.new("Frame")
camlockGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
camlockGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
camlockGlow.BackgroundColor3 = C.primary
camlockGlow.BackgroundTransparency = 0.9
camlockGlow.BorderSizePixel = 0
camlockGlow.Parent = camlockFrame
local camlockGlowCorner = Instance.new("UICorner")
camlockGlowCorner.CornerRadius = UDim.new(0, 20)
camlockGlowCorner.Parent = camlockGlow

local camlockDragging = false
local camlockDragOff = Vector2.new(0, 0)

pcall(function()
    camlockFrame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            camlockDragging = true
            camlockDragOff = Vector2.new(mouse.X - camlockFrame.AbsolutePosition.X, mouse.Y - camlockFrame.AbsolutePosition.Y)
        end
    end)
end)

pcall(function()
    UserInputService.InputChanged:Connect(function(i)
        if camlockDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            pcall(function()
                camlockFrame.Position = UDim2.new(0, mouse.X - camlockDragOff.X, 0, mouse.Y - camlockDragOff.Y)
            end)
        end
    end)
end)

pcall(function()
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            camlockDragging = false
        end
    end)
end)

local camlockBtn = Instance.new("TextButton")
camlockBtn.Size = UDim2.new(1, 0, 1, 0)
camlockBtn.BackgroundTransparency = 1
camlockBtn.Text = "🔒"
camlockBtn.TextColor3 = C.dim
camlockBtn.TextSize = 38
camlockBtn.Font = Enum.Font.GothamBold
camlockBtn.Parent = camlockFrame

local statusDot = Instance.new("Frame")
statusDot.Size = UDim2.new(0, 10, 0, 10)
statusDot.Position = UDim2.new(0.5, -5, 1, -8)
statusDot.BackgroundColor3 = C.dim
statusDot.BorderSizePixel = 0
statusDot.Parent = camlockFrame
local statusDotCorner = Instance.new("UICorner")
statusDotCorner.CornerRadius = UDim.new(0, 5)
statusDotCorner.Parent = statusDot

local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(0, 100, 0, 14)
targetLabel.Position = UDim2.new(0.5, -50, 1, 4)
targetLabel.BackgroundTransparency = 1
targetLabel.Text = ""
targetLabel.TextColor3 = C.dim
targetLabel.TextSize = 9
targetLabel.Font = Enum.Font.GothamSemibold
targetLabel.TextXAlignment = Enum.TextXAlignment.Center
targetLabel.Parent = camlockFrame

-- CAMLOCK POPUP
local camlockPopup = Instance.new("Frame")
camlockPopup.Size = UDim2.new(0, 200, 0, 85)
camlockPopup.Position = UDim2.new(0.5, -100, 0.02, 12)
camlockPopup.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
camlockPopup.BackgroundTransparency = 0.1
camlockPopup.BorderSizePixel = 0
camlockPopup.Visible = false
camlockPopup.Parent = screenGui

local camlockPopupCorner = Instance.new("UICorner")
camlockPopupCorner.CornerRadius = UDim.new(0, 12)
camlockPopupCorner.Parent = camlockPopup
addCrystalStroke(camlockPopup, 2)
addGlowStroke(camlockPopup, 2.5)

local camlockPopupGlass = Instance.new("Frame")
camlockPopupGlass.Size = UDim2.new(1, 0, 1, 0)
camlockPopupGlass.BackgroundColor3 = C.glass
camlockPopupGlass.BackgroundTransparency = 0.9
camlockPopupGlass.BorderSizePixel = 0
camlockPopupGlass.Parent = camlockPopup
local camlockPopupGlassCorner = Instance.new("UICorner")
camlockPopupGlassCorner.CornerRadius = UDim.new(0, 12)
camlockPopupGlassCorner.Parent = camlockPopupGlass

local popupAvatar = Instance.new("ImageLabel")
popupAvatar.Size = UDim2.new(0, 40, 0, 40)
popupAvatar.Position = UDim2.new(0, 8, 0.5, -20)
popupAvatar.BackgroundTransparency = 1
popupAvatar.Parent = camlockPopup
local popupAvatarCorner = Instance.new("UICorner")
popupAvatarCorner.CornerRadius = UDim.new(0, 8)
popupAvatarCorner.Parent = popupAvatar

local popupName = Instance.new("TextLabel")
popupName.Size = UDim2.new(1, -56, 0, 18)
popupName.Position = UDim2.new(0, 56, 0, 6)
popupName.BackgroundTransparency = 1
popupName.Text = ""
popupName.TextColor3 = C.text
popupName.TextSize = 13
popupName.Font = Enum.Font.GothamBold
popupName.TextXAlignment = Enum.TextXAlignment.Left
popupName.Parent = camlockPopup

local popupHealthBarBg = Instance.new("Frame")
popupHealthBarBg.Size = UDim2.new(1, -64, 0, 6)
popupHealthBarBg.Position = UDim2.new(0, 56, 0, 28)
popupHealthBarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
popupHealthBarBg.BorderSizePixel = 0
popupHealthBarBg.Parent = camlockPopup
local popupHealthBarBgCorner = Instance.new("UICorner")
popupHealthBarBgCorner.CornerRadius = UDim.new(0, 3)
popupHealthBarBgCorner.Parent = popupHealthBarBg

local popupHealthFill = Instance.new("Frame")
popupHealthFill.Size = UDim2.new(1, 0, 1, 0)
popupHealthFill.BackgroundColor3 = C.green
popupHealthFill.BorderSizePixel = 0
popupHealthFill.Parent = popupHealthBarBg
local popupHealthFillCorner = Instance.new("UICorner")
popupHealthFillCorner.CornerRadius = UDim.new(0, 3)
popupHealthFillCorner.Parent = popupHealthFill

local popupHealthText = Instance.new("TextLabel")
popupHealthText.Size = UDim2.new(1, -64, 0, 14)
popupHealthText.Position = UDim2.new(0, 56, 0, 36)
popupHealthText.BackgroundTransparency = 1
popupHealthText.Text = "100%"
popupHealthText.TextColor3 = C.dim
popupHealthText.TextSize = 9
popupHealthText.Font = Enum.Font.GothamSemibold
popupHealthText.TextXAlignment = Enum.TextXAlignment.Left
popupHealthText.Parent = camlockPopup

local popupDistText = Instance.new("TextLabel")
popupDistText.Size = UDim2.new(0, 50, 0, 14)
popupDistText.Position = UDim2.new(1, -56, 0, 36)
popupDistText.BackgroundTransparency = 1
popupDistText.Text = "0m"
popupDistText.TextColor3 = C.dim
popupDistText.TextSize = 9
popupDistText.Font = Enum.Font.GothamSemibold
popupDistText.TextXAlignment = Enum.TextXAlignment.Right
popupDistText.Parent = camlockPopup

-- TRACER
local tracerFrame = Instance.new("Frame")
tracerFrame.Size = UDim2.new(0, 0, 0, 0)
tracerFrame.BackgroundColor3 = C.primary
tracerFrame.BackgroundTransparency = 0.4
tracerFrame.BorderSizePixel = 0
tracerFrame.Visible = false
tracerFrame.Parent = screenGui

local tracerGlow = Instance.new("Frame")
tracerGlow.Size = UDim2.new(0, 0, 0, 0)
tracerGlow.BackgroundColor3 = C.primary
tracerGlow.BackgroundTransparency = 0.7
tracerGlow.BorderSizePixel = 0
tracerGlow.Visible = false
tracerGlow.Parent = screenGui

local offsetLabel = Instance.new("TextLabel")
offsetLabel.Size = UDim2.new(0, 60, 0, 14)
offsetLabel.Position = UDim2.new(0.5, -30, 0, -16)
offsetLabel.BackgroundTransparency = 1
offsetLabel.Text = "S:8"
offsetLabel.TextColor3 = C.primaryGlow
offsetLabel.TextSize = 9
offsetLabel.Font = Enum.Font.GothamBold
offsetLabel.TextXAlignment = Enum.TextXAlignment.Center
offsetLabel.Visible = false
offsetLabel.Parent = camlockFrame

local function getNearestPlayer()
    local camera = Workspace.CurrentCamera
    if not camera then return nil end
    
    local viewportSize = camera.ViewportSize
    local centerX = viewportSize.X / 2
    local centerY = viewportSize.Y / 2
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local char = plr.Character
            if char and char:FindFirstChild(camlockBodyPart) then
                local part = char[camlockBodyPart]
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(centerX, centerY)).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = plr
                    end
                end
            end
        end
    end
    
    return nearest
end

camlockBtn.MouseButton1Click:Connect(function()
    camlockEnabled = not camlockEnabled
    
    if camlockEnabled then
        camlockTarget = getNearestPlayer()
        if camlockTarget then
            camlockBtn.Text = "🔒"
            camlockBtn.TextColor3 = C.green
            camlockFrame.BackgroundColor3 = C.green
            camlockFrame.BackgroundTransparency = 0.03
            statusDot.BackgroundColor3 = C.green
            targetLabel.Text = camlockTarget.Name
            targetLabel.TextColor3 = C.green
            camlockPopup.Visible = true
            popupName.Text = camlockTarget.DisplayName or camlockTarget.Name
            local avatarId = camlockTarget.UserId
            popupAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. avatarId .. "&w=150&h=150"
            offsetLabel.Visible = true
            if camlockSmoothness < 0 then
                offsetLabel.Text = "O:" .. string.format("%+.1f", camlockSmoothness)
                offsetLabel.TextColor3 = C.red
            else
                offsetLabel.Text = "S:" .. tostring(math.floor(camlockSmoothness))
                offsetLabel.TextColor3 = C.green
            end
            notify("🔒 Locked: " .. camlockTarget.Name, 2)
        else
            camlockBtn.Text = "❌"
            camlockBtn.TextColor3 = C.gold
            statusDot.BackgroundColor3 = C.gold
            targetLabel.Text = "No target"
            targetLabel.TextColor3 = C.gold
            notify("⚠️ No target found!", 2)
            camlockEnabled = false
            camlockBtn.Text = "🔒"
            camlockBtn.TextColor3 = C.dim
            camlockFrame.BackgroundColor3 = C.dark
            camlockFrame.BackgroundTransparency = 0.05
            statusDot.BackgroundColor3 = C.dim
            targetLabel.Text = ""
            camlockPopup.Visible = false
            offsetLabel.Visible = false
        end
    else
        camlockBtn.Text = "🔒"
        camlockBtn.TextColor3 = C.dim
        camlockFrame.BackgroundColor3 = C.dark
        camlockFrame.BackgroundTransparency = 0.05
        statusDot.BackgroundColor3 = C.dim
        targetLabel.Text = ""
        camlockTarget = nil
        camlockPopup.Visible = false
        tracerFrame.Visible = false
        tracerGlow.Visible = false
        offsetLabel.Visible = false
        notify("🔓 Camlock disabled", 2)
    end
end)

coroutine.wrap(function()
    while task.wait(0.3) do
        if camlockEnabled then
            if camlockTarget and camlockTarget.Character and camlockTarget.Character:FindFirstChild("HumanoidRootPart") then
                local char = camlockTarget.Character
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local health = humanoid.Health
                    local maxHealth = humanoid.MaxHealth
                    local percent = math.clamp(health / maxHealth, 0, 1)
                    popupHealthFill.Size = UDim2.new(percent, 0, 1, 0)
                    popupHealthFill.BackgroundColor3 = percent > 0.5 and C.green or (percent > 0.25 and C.gold or C.red)
                    popupHealthText.Text = math.floor(percent * 100) .. "%"
                end
                local playerChar = player.Character
                if playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - playerChar.HumanoidRootPart.Position).Magnitude
                    popupDistText.Text = math.floor(dist) .. "m"
                end
            else
                local newTarget = getNearestPlayer()
                if newTarget then
                    camlockTarget = newTarget
                    targetLabel.Text = newTarget.Name
                    targetLabel.TextColor3 = C.green
                    popupName.Text = newTarget.DisplayName or newTarget.Name
                    local avatarId = newTarget.UserId
                    popupAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. avatarId .. "&w=150&h=150"
                else
                    camlockEnabled = false
                    camlockBtn.Text = "🔒"
                    camlockBtn.TextColor3 = C.dim
                    camlockFrame.BackgroundColor3 = C.dark
                    camlockFrame.BackgroundTransparency = 0.05
                    statusDot.BackgroundColor3 = C.dim
                    targetLabel.Text = ""
                    camlockPopup.Visible = false
                    tracerFrame.Visible = false
                    tracerGlow.Visible = false
                    offsetLabel.Visible = false
                    notify("❌ Target lost!", 2)
                end
            end
        end
    end
end)()

local function updateTracer()
    if not camlockEnabled or not camlockTarget then
        tracerFrame.Visible = false
        tracerGlow.Visible = false
        return
    end
    
    pcall(function()
        local camera = Workspace.CurrentCamera
        if not camera then return end
        
        local targetChar = camlockTarget.Character
        if not targetChar then return end
        
        local targetPart = targetChar:FindFirstChild(camlockBodyPart)
        if not targetPart then return end
        
        local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
        if not onScreen then 
            tracerFrame.Visible = false
            tracerGlow.Visible = false
            return 
        end
        
        local viewportSize = camera.ViewportSize
        local centerX = viewportSize.X / 2
        local centerY = viewportSize.Y / 2
        
        local dx = screenPos.X - centerX
        local dy = screenPos.Y - centerY
        local dist = math.sqrt(dx * dx + dy * dy)
        
        if dist > 10 then
            local angle = math.atan2(dy, dx)
            local length = math.min(dist, 200)
            
            tracerFrame.Visible = true
            tracerFrame.Size = UDim2.new(0, length, 0, 2)
            tracerFrame.Position = UDim2.new(0, centerX + (dx/dist) * 10, 0, centerY + (dy/dist) * 10)
            tracerFrame.Rotation = math.deg(angle)
            tracerFrame.BackgroundColor3 = C.primary
            tracerFrame.BackgroundTransparency = 0.3 + math.sin(tick() * 3) * 0.1
            
            tracerGlow.Visible = true
            tracerGlow.Size = UDim2.new(0, length, 0, 6)
            tracerGlow.Position = UDim2.new(0, centerX + (dx/dist) * 10 - 2, 0, centerY + (dy/dist) * 10 - 2)
            tracerGlow.Rotation = math.deg(angle)
            tracerGlow.BackgroundColor3 = C.primary
            tracerGlow.BackgroundTransparency = 0.7 + math.sin(tick() * 3 + 1) * 0.1
        else
            tracerFrame.Visible = false
            tracerGlow.Visible = false
        end
    end)
end

RunService.RenderStepped:Connect(updateTracer)

RunService.RenderStepped:Connect(function()
    if not camlockEnabled or not camlockTarget then return end
    
    pcall(function()
        local targetChar = camlockTarget.Character
        local playerChar = player.Character
        if not targetChar or not playerChar then return end
        
        local targetPart = targetChar:FindFirstChild(camlockBodyPart)
        if not targetPart then return end
        
        local camera = Workspace.CurrentCamera
        if not camera then return end
        
        local currentPos = camera.CFrame.Position
        local targetPos = targetPart.Position
        
        local offset = getCamlockOffset()
        if offset ~= 0 then
            local direction = (targetPos - currentPos).Unit
            targetPos = targetPos + direction * offset
        end
        
        local smoothFactor = 1 / getCamlockSmoothness()
        
        if getCamlockSmoothness() <= 1 then
            camera.CFrame = CFrame.lookAt(currentPos, targetPos)
        else
            local currentDir = camera.CFrame.LookVector
            local direction = (targetPos - currentPos).Unit
            local newDir = currentDir:Lerp(direction, math.min(smoothFactor, 1))
            camera.CFrame = CFrame.lookAt(currentPos, currentPos + newDir * 10)
        end
    end)
end)

-- ==================================================
-- PERFECT VIEWER
-- ==================================================

local viewingTarget = false
local viewTarget = nil
local viewCoroutine = nil

local function startViewing(target)
    if viewCoroutine then
        coroutine.close(viewCoroutine)
        viewCoroutine = nil
    end
    
    viewTarget = target
    viewingTarget = true
    
    viewCoroutine = coroutine.create(function()
        while viewingTarget and viewTarget and viewTarget.Character do
            pcall(function()
                local camera = Workspace.CurrentCamera
                local targetChar = viewTarget.Character
                if camera and targetChar and targetChar:FindFirstChild("Head") then
                    local headPos = targetChar.Head.Position
                    local currentPos = camera.CFrame.Position
                    local targetCFrame = CFrame.lookAt(currentPos, headPos)
                    camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.12)
                end
            end)
            task.wait(0.016)
        end
    end)
    
    coroutine.resume(viewCoroutine)
end

local function stopViewing()
    viewingTarget = false
    viewTarget = nil
    if viewCoroutine then
        coroutine.close(viewCoroutine)
        viewCoroutine = nil
    end
end

-- ==================================================
-- VISUALS
-- ==================================================

local visualsBrightness = 1
local visualsContrast = 1
local visualsSaturation = 1.2
local visualsBloom = 0.6
local visualsColorTemp = 0
local visualsExposure = 0.6

local function applyVisuals()
    pcall(function()
        Lighting.Brightness = visualsBrightness
        
        local tempOffset = visualsColorTemp * 0.3
        local r = math.clamp(1 + tempOffset, 0.5, 1.5)
        local b = math.clamp(1 - tempOffset, 0.5, 1.5)
        Lighting.Ambient = Color3.fromRGB(
            127 * visualsSaturation * r,
            127 * visualsSaturation,
            127 * visualsSaturation * b
        )
        
        Lighting.ExposureCompensation = (visualsBloom * 2 - 1) * 0.8
        Lighting.OutdoorAmbient = Color3.fromRGB(
            127 * (visualsContrast * 0.5 + 0.5),
            127 * (visualsContrast * 0.5 + 0.5),
            127 * (visualsContrast * 0.5 + 0.5)
        )
        Lighting.ColorShift_Top = Color3.fromRGB(
            255 * (visualsExposure * 0.5 + 0.3),
            255 * (visualsExposure * 0.2 + 0.2),
            255 * (visualsExposure * 0.5 + 0.3)
        )
    end)
end

-- ==================================================
-- FLOATING BUTTONS SYSTEM
-- ==================================================

local floatingEnabled = false
local floatingButtons = {}
local stepButtons = {}

local function createFloatingButtons()
    -- Forward button
    local fwdBtn = Instance.new("TextButton")
    fwdBtn.Size = UDim2.new(0, 50, 0, 50)
    fwdBtn.Position = UDim2.new(0.5, -25, 0.35, 0)
    fwdBtn.BackgroundColor3 = C.primary
    fwdBtn.BackgroundTransparency = 0.1
    fwdBtn.Text = "↑"
    fwdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fwdBtn.TextSize = 30
    fwdBtn.Font = Enum.Font.GothamBold
    fwdBtn.BorderSizePixel = 0
    fwdBtn.Visible = false
    fwdBtn.Parent = screenGui
    
    local fwdCorner = Instance.new("UICorner")
    fwdCorner.CornerRadius = UDim.new(0, 14)
    fwdCorner.Parent = fwdBtn
    addCrystalStroke(fwdBtn, 2)
    addGlowStroke(fwdBtn, 2)
    
    -- Backward button
    local bwdBtn = Instance.new("TextButton")
    bwdBtn.Size = UDim2.new(0, 50, 0, 50)
    bwdBtn.Position = UDim2.new(0.5, -25, 0.45, 0)
    bwdBtn.BackgroundColor3 = C.secondary
    bwdBtn.BackgroundTransparency = 0.1
    bwdBtn.Text = "↓"
    bwdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    bwdBtn.TextSize = 30
    bwdBtn.Font = Enum.Font.GothamBold
    bwdBtn.BorderSizePixel = 0
    bwdBtn.Visible = false
    bwdBtn.Parent = screenGui
    
    local bwdCorner = Instance.new("UICorner")
    bwdCorner.CornerRadius = UDim.new(0, 14)
    bwdCorner.Parent = bwdBtn
    addCrystalStroke(bwdBtn, 2)
    addGlowStroke(bwdBtn, 2)
    
    -- Left button
    local lftBtn = Instance.new("TextButton")
    lftBtn.Size = UDim2.new(0, 50, 0, 50)
    lftBtn.Position = UDim2.new(0.45, -25, 0.4, 0)
    lftBtn.BackgroundColor3 = C.accent
    lftBtn.BackgroundTransparency = 0.1
    lftBtn.Text = "←"
    lftBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    lftBtn.TextSize = 30
    lftBtn.Font = Enum.Font.GothamBold
    lftBtn.BorderSizePixel = 0
    lftBtn.Visible = false
    lftBtn.Parent = screenGui
    
    local lftCorner = Instance.new("UICorner")
    lftCorner.CornerRadius = UDim.new(0, 14)
    lftCorner.Parent = lftBtn
    addCrystalStroke(lftBtn, 2)
    addGlowStroke(lftBtn, 2)
    
    -- Right button
    local rgtBtn = Instance.new("TextButton")
    rgtBtn.Size = UDim2.new(0, 50, 0, 50)
    rgtBtn.Position = UDim2.new(0.55, -25, 0.4, 0)
    rgtBtn.BackgroundColor3 = C.green
    rgtBtn.BackgroundTransparency = 0.1
    rgtBtn.Text = "→"
    rgtBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    rgtBtn.TextSize = 30
    rgtBtn.Font = Enum.Font.GothamBold
    rgtBtn.BorderSizePixel = 0
    rgtBtn.Visible = false
    rgtBtn.Parent = screenGui
    
    local rgtCorner = Instance.new("UICorner")
    rgtCorner.CornerRadius = UDim.new(0, 14)
    rgtCorner.Parent = rgtBtn
    addCrystalStroke(rgtBtn, 2)
    addGlowStroke(rgtBtn, 2)
    
    -- Up button
    local upBtn = Instance.new("TextButton")
    upBtn.Size = UDim2.new(0, 50, 0, 50)
    upBtn.Position = UDim2.new(0.5, -25, 0.3, 0)
    upBtn.BackgroundColor3 = C.blue
    upBtn.BackgroundTransparency = 0.1
    upBtn.Text = "⤊"
    upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    upBtn.TextSize = 30
    upBtn.Font = Enum.Font.GothamBold
    upBtn.BorderSizePixel = 0
    upBtn.Visible = false
    upBtn.Parent = screenGui
    
    local upCorner = Instance.new("UICorner")
    upCorner.CornerRadius = UDim.new(0, 14)
    upCorner.Parent = upBtn
    addCrystalStroke(upBtn, 2)
    addGlowStroke(upBtn, 2)
    
    -- Down button
    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0, 50, 0, 50)
    downBtn.Position = UDim2.new(0.5, -25, 0.5, 0)
    downBtn.BackgroundColor3 = C.purple
    downBtn.BackgroundTransparency = 0.1
    downBtn.Text = "⤋"
    downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    downBtn.TextSize = 30
    downBtn.Font = Enum.Font.GothamBold
    downBtn.BorderSizePixel = 0
    downBtn.Visible = false
    downBtn.Parent = screenGui
    
    local downCorner = Instance.new("UICorner")
    downCorner.CornerRadius = UDim.new(0, 14)
    downCorner.Parent = downBtn
    addCrystalStroke(downBtn, 2)
    addGlowStroke(downBtn, 2)
    
    stepButtons = {fwdBtn, bwdBtn, lftBtn, rgtBtn, upBtn, downBtn}
    
    -- Draggable functionality for all buttons
    for _, btn in ipairs(stepButtons) do
        local dragging = false
        local dragOff = Vector2.new(0, 0)
        
        btn.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragOff = Vector2.new(mouse.X - btn.AbsolutePosition.X, mouse.Y - btn.AbsolutePosition.Y)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(i)
            if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                pcall(function()
                    btn.Position = UDim2.new(0, mouse.X - dragOff.X, 0, mouse.Y - dragOff.Y)
                end)
            end
        end)
        
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end
    
    -- Button click functions
    fwdBtn.MouseButton1Click:Connect(function()
        teleportForward(teleportSteps)
        notify("⬆️ Forward " .. teleportSteps .. " steps!", 1)
    end)
    
    bwdBtn.MouseButton1Click:Connect(function()
        teleportForward(-teleportSteps)
        notify("⬇️ Backward " .. teleportSteps .. " steps!", 1)
    end)
    
    lftBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local rightVec = root.CFrame.RightVector
                    local newPos = root.Position - rightVec * teleportSteps
                    local tween = TweenService:Create(root, TweenInfo.new(0.05), {CFrame = CFrame.new(newPos)})
                    tween:Play()
                    tween.Completed:Wait()
                    notify("⬅️ Left " .. teleportSteps .. " steps!", 1)
                end
            end
        end)
    end)
    
    rgtBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local rightVec = root.CFrame.RightVector
                    local newPos = root.Position + rightVec * teleportSteps
                    local tween = TweenService:Create(root, TweenInfo.new(0.05), {CFrame = CFrame.new(newPos)})
                    tween:Play()
                    tween.Completed:Wait()
                    notify("➡️ Right " .. teleportSteps .. " steps!", 1)
                end
            end
        end)
    end)
    
    upBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local newPos = root.Position + Vector3.new(0, teleportSteps, 0)
                    local tween = TweenService:Create(root, TweenInfo.new(0.05), {CFrame = CFrame.new(newPos)})
                    tween:Play()
                    tween.Completed:Wait()
                    notify("⤊ Up " .. teleportSteps .. " steps!", 1)
                end
            end
        end)
    end)
    
    downBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local newPos = root.Position - Vector3.new(0, teleportSteps, 0)
                    local tween = TweenService:Create(root, TweenInfo.new(0.05), {CFrame = CFrame.new(newPos)})
                    tween:Play()
                    tween.Completed:Wait()
                    notify("⤋ Down " .. teleportSteps .. " steps!", 1)
                end
            end
        end)
    end)
    
    return stepButtons
end

-- Create floating buttons
local floatingBtns = createFloatingButtons()

-- Toggle floating buttons
local function toggleFloating(state)
    floatingEnabled = state
    for _, btn in ipairs(floatingBtns) do
        btn.Visible = state
    end
end

-- ==================================================
-- SKYBOX CHANGER
-- ==================================================

local function changeSkybox(assetId)
    pcall(function()
        local sky = Lighting:FindFirstChild("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        
        -- Load skybox from asset
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
-- FONT CHANGER
-- ==================================================

local function changeFont(fontName)
    pcall(function()
        -- Change font for all text in the game
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                pcall(function()
                    if fontName == "Minecraft" then
                        obj.Font = Enum.Font.Arcade
                    elseif fontName == "Gotham" then
                        obj.Font = Enum.Font.GothamBold
                    elseif fontName == "Comic Sans" then
                        obj.Font = Enum.Font.ComicSans
                    elseif fontName == "Arial" then
                        obj.Font = Enum.Font.Arial
                    elseif fontName == "Roboto" then
                        obj.Font = Enum.Font.SourceSans
                    elseif fontName == "Times New Roman" then
                        obj.Font = Enum.Font.ArialBold -- Roblox doesn't have Times New Roman
                    elseif fontName == "Sci-Fi" then
                        obj.Font = Enum.Font.SciFi
                    elseif fontName == "Fantasy" then
                        obj.Font = Enum.Font.Fantasy
                    elseif fontName == "Code" then
                        obj.Font = Enum.Font.Code
                    elseif fontName == "Verdana" then
                        obj.Font = Enum.Font.Arcade -- Roblox doesn't have Verdana
                    end
                end)
            end
        end
        notify("🔤 Font changed to: " .. fontName, 2)
    end)
end

-- ==================================================
-- TAB 1: MOVEMENT (Original content)
-- ==================================================

local p1 = tabPages[1]
section(p1, "Speed & Jump")
label(p1, "Click button to inject Mooze Mob script", C.gold)
label(p1, "Includes Speed, Jump, and more features", C.gold)
button(p1, "🚀 Inject Mooze Mob", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/19mdSkibidi/19sMooze-Mobile-Rework/refs/heads/main/Mooze%20Mob'))()
        notify("✅ Mooze Mob injected successfully!", 3)
    end)
end, C.blue)

section(p1, "FLOATING CONTROLS")
local floatToggle = toggle(p1, "Enable Floating Buttons", false, function(s)
    toggleFloating(s)
    notify(s and "🌀 Floating buttons enabled" or "🌀 Floating buttons disabled", 2)
end)

section(p1, "STEP CONTROL")
local stepsSlider2 = slider(p1, "Step Count", 1, 200, 50, function(v)
    teleportSteps = math.floor(v)
end)

-- ==================================================
-- TAB 2: TELEPORT (Original)
-- ==================================================

local p2 = tabPages[2]
section(p2, "Smart Teleport")
label(p2, "Partial names work!", C.gold)
local tpIn = inputBox(p2, "Username")

local viewBtn = button(p2, "👁️ View", function()
    if viewingTarget then
        stopViewing()
        viewBtn.Text = "👁️ View"
        notify("👁️ View disabled", 2)
        return
    end
    
    local target = findPlayer(tpIn.Text)
    if not target then 
        notify("❌ Not found!", 3) 
        return 
    end
    
    startViewing(target)
    viewBtn.Text = "👁️ Unview"
    notify("👁️ Viewing: " .. target.Name, 2)
end, C.blue)

button(p2, "📍 Teleport", function()
    local target = findPlayer(tpIn.Text)
    if not target then 
        notify("❌ Not found!", 3) 
        return 
    end
    pcall(function()
        local c = target.Character
        local mc = player.Character
        if c and c:FindFirstChild("HumanoidRootPart") and mc and mc:FindFirstChild("HumanoidRootPart") then
            mc.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            notify("✅ Teleported to: " .. target.Name, 2)
        end
    end)
end)

button(p2, "🪑 Headsit", function()
    local target = findPlayer(tpIn.Text)
    if not target then notify("❌ Not found!", 3) return end
    pcall(function()
        local c = target.Character
        local mc = player.Character
        if c and c:FindFirstChild("Head") and mc and mc:FindFirstChild("HumanoidRootPart") then
            mc.HumanoidRootPart.CFrame = c.Head.CFrame * CFrame.new(0, 1.5, 0)
            local h = mc:FindFirstChildOfClass("Humanoid")
            if h then h.Sit = true end
            notify("🪑 Headsit on: " .. target.Name, 2)
        end
    end)
end)
button(p2, "ℹ️ Info", function()
    local target = findPlayer(tpIn.Text)
    if not target then notify("❌ Not found!", 3) return end
    local age = target.AccountAge
    notify(string.format("👤 %s\n🆔 %d\n📅 Age: %d days", target.Name, target.UserId, age), 5)
end)

-- ==================================================
-- TAB 3: CAMLOCK (Original)
-- ==================================================

local p3 = tabPages[3]
section(p3, "Camlock Settings")
label(p3, "Positive = Smoothness | Negative = Offset", C.gold)
label(p3, "PC Keybind: Q", C.gold)

-- Combined Smoothness/Offset input
local comboFrame = Instance.new("Frame")
comboFrame.Size = UDim2.new(1, 0, 0, 34)
comboFrame.BackgroundColor3 = C.panelLight
comboFrame.BackgroundTransparency = 0.1
comboFrame.BorderSizePixel = 0
comboFrame.Parent = p3
local comboCorner = Instance.new("UICorner")
comboCorner.CornerRadius = UDim.new(0, 8)
comboCorner.Parent = comboFrame
addCrystalStroke(comboFrame, 1.2)

local comboLabel = Instance.new("TextLabel")
comboLabel.Size = UDim2.new(0, 100, 1, 0)
comboLabel.Position = UDim2.new(0, 10, 0, 0)
comboLabel.BackgroundTransparency = 1
comboLabel.Text = "Smooth/Offset:"
comboLabel.TextColor3 = C.text
comboLabel.TextSize = 12
comboLabel.Font = Enum.Font.GothamSemibold
comboLabel.TextXAlignment = Enum.TextXAlignment.Left
comboLabel.Parent = comboFrame

local comboInput = Instance.new("TextBox")
comboInput.Size = UDim2.new(0, 80, 0, 24)
comboInput.Position = UDim2.new(0, 110, 0.5, -12)
comboInput.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
comboInput.Text = "8"
comboInput.TextColor3 = C.text
comboInput.TextSize = 12
comboInput.Font = Enum.Font.GothamSemibold
comboInput.TextXAlignment = Enum.TextXAlignment.Center
comboInput.BorderSizePixel = 0
comboInput.Parent = comboFrame
local comboInputCorner = Instance.new("UICorner")
comboInputCorner.CornerRadius = UDim.new(0, 5)
comboInputCorner.Parent = comboInput

comboInput.FocusLost:Connect(function()
    local num = tonumber(comboInput.Text)
    if num then
        camlockSmoothness = num
        if num < 0 then
            offsetLabel.Text = "O:" .. string.format("%+.1f", num)
            offsetLabel.TextColor3 = C.red
            notify("📏 Offset set to: " .. string.format("%+.1f", num), 2)
        else
            offsetLabel.Text = "S:" .. tostring(math.floor(num))
            offsetLabel.TextColor3 = C.green
            notify("📏 Smoothness set to: " .. tostring(math.floor(num)), 2)
        end
    end
end)

label(p3, "Body Part: " .. camlockBodyPart)

local bpFrame = Instance.new("Frame")
bpFrame.Size = UDim2.new(1, 0, 0, 28)
bpFrame.BackgroundColor3 = C.panelLight
bpFrame.BackgroundTransparency = 0.1
bpFrame.BorderSizePixel = 0
bpFrame.Parent = p3
local bpCorner = Instance.new("UICorner")
bpCorner.CornerRadius = UDim.new(0, 8)
bpCorner.Parent = bpFrame
addCrystalStroke(bpFrame, 1.2)

local bpLabel = Instance.new("TextLabel")
bpLabel.Size = UDim2.new(0, 65, 1, 0)
bpLabel.Position = UDim2.new(0, 10, 0, 0)
bpLabel.BackgroundTransparency = 1
bpLabel.Text = "Body Part:"
bpLabel.TextColor3 = C.text
bpLabel.TextSize = 12
bpLabel.Font = Enum.Font.GothamSemibold
bpLabel.TextXAlignment = Enum.TextXAlignment.Left
bpLabel.Parent = bpFrame

local bpBtn = Instance.new("TextButton")
bpBtn.Size = UDim2.new(0, 80, 0, 22)
bpBtn.Position = UDim2.new(0, 78, 0.5, -11)
bpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
bpBtn.BorderSizePixel = 0
bpBtn.Text = camlockBodyPart .. " ▼"
bpBtn.TextColor3 = C.text
bpBtn.TextSize = 10
bpBtn.Font = Enum.Font.GothamSemibold
bpBtn.Parent = bpFrame
local bpBtnCorner = Instance.new("UICorner")
bpBtnCorner.CornerRadius = UDim.new(0, 5)
bpBtnCorner.Parent = bpBtn
addCrystalStroke(bpBtn, 1)

local bodyParts = {"Head", "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart"}
local bpMenu = nil
bpBtn.MouseButton1Click:Connect(function()
    if bpMenu then bpMenu:Destroy() bpMenu = nil return end
    bpMenu = Instance.new("Frame")
    bpMenu.Size = UDim2.new(0, 80, 0, #bodyParts * 22 + 6)
    bpMenu.Position = UDim2.new(0, 78, 0, 28)
    bpMenu.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    bpMenu.BorderSizePixel = 0
    bpMenu.ClipsDescendants = true
    bpMenu.Parent = bpFrame
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 5)
    menuCorner.Parent = bpMenu
    addCrystalStroke(bpMenu, 1)
    local menuLayout = Instance.new("UIListLayout")
    menuLayout.Padding = UDim.new(0, 2)
    menuLayout.Parent = bpMenu
    for _, part in ipairs(bodyParts) do
        local partBtn = Instance.new("TextButton")
        partBtn.Size = UDim2.new(1, 0, 0, 20)
        partBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        partBtn.Text = part
        partBtn.TextColor3 = C.text
        partBtn.TextSize = 9
        partBtn.Font = Enum.Font.GothamSemibold
        partBtn.BorderSizePixel = 0
        partBtn.Parent = bpMenu
        partBtn.MouseButton1Click:Connect(function()
            camlockBodyPart = part
            bpBtn.Text = part .. " ▼"
            bpMenu:Destroy()
            bpMenu = nil
            notify("🎯 Body part: " .. part, 2)
        end)
    end
end)

label(p3, "Status: " .. (camlockEnabled and "✅ Active" or "❌ Inactive"))
label(p3, "Target: " .. (camlockTarget and camlockTarget.Name or "None"))
button(p3, "🔄 Reset", function()
    camlockEnabled = false
    camlockTarget = nil
    camlockBtn.Text = "🔒"
    camlockBtn.TextColor3 = C.dim
    camlockFrame.BackgroundColor3 = C.dark
    camlockFrame.BackgroundTransparency = 0.05
    statusDot.BackgroundColor3 = C.dim
    targetLabel.Text = ""
    camlockPopup.Visible = false
    tracerFrame.Visible = false
    tracerGlow.Visible = false
    offsetLabel.Visible = false
    notify("🔄 Camlock reset", 2)
end)
button(p3, "🎯 Force Lock", function()
    local target = getNearestPlayer()
    if target then
        camlockTarget = target
        camlockEnabled = true
        camlockBtn.Text = "🔒"
        camlockBtn.TextColor3 = C.green
        camlockFrame.BackgroundColor3 = C.green
        camlockFrame.BackgroundTransparency = 0.03
        statusDot.BackgroundColor3 = C.green
        targetLabel.Text = target.Name
        targetLabel.TextColor3 = C.green
        camlockPopup.Visible = true
        popupName.Text = target.DisplayName or target.Name
        local avatarId = target.UserId
        popupAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. avatarId .. "&w=150&h=150"
        offsetLabel.Visible = true
        if camlockSmoothness < 0 then
            offsetLabel.Text = "O:" .. string.format("%+.1f", camlockSmoothness)
            offsetLabel.TextColor3 = C.red
        else
            offsetLabel.Text = "S:" .. tostring(math.floor(camlockSmoothness))
            offsetLabel.TextColor3 = C.green
        end
        notify("🔒 Locked: " .. target.Name, 2)
    else
        notify("❌ No target near crosshair!", 2)
    end
end)
button(p3, "👁️ Show/Hide Camlock", function()
    camlockVisible = not camlockVisible
    camlockFrame.Visible = camlockVisible
    if not camlockVisible then
        camlockPopup.Visible = false
        tracerFrame.Visible = false
        tracerGlow.Visible = false
        offsetLabel.Visible = false
    elseif camlockEnabled and camlockTarget then
        camlockPopup.Visible = true
        offsetLabel.Visible = true
    end
    notify(camlockVisible and "👁️ Camlock shown" or "👁️ Camlock hidden", 2)
end)

-- ==================================================
-- TAB 4: ESP (Original)
-- ==================================================

local p4 = tabPages[4]
section(p4, "Premium ESP")

local espEnabled = false
local espObjects = {}
local espConnections = {}
local espColor = C.primary
local espBoxTransparency = 0.6

local function createPremiumESP(char, plr)
    if not char or espObjects[plr] then return end
    if espObjects[plr] then
        pcall(function() espObjects[plr]:Destroy() end)
        espObjects[plr] = nil
    end
    
    local espGroup = Instance.new("Model")
    espGroup.Name = "ESP_" .. plr.Name
    espGroup.Parent = char
    
    local healthBar = Instance.new("BillboardGui")
    healthBar.Size = UDim2.new(0, 60, 0, 4)
    healthBar.Adornee = char:FindFirstChild("Head")
    healthBar.StudsOffset = Vector3.new(0, 2.5, 0)
    healthBar.MaxDistance = 350
    healthBar.Parent = espGroup
    
    local healthBg = Instance.new("Frame")
    healthBg.Size = UDim2.new(1, 0, 1, 0)
    healthBg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    healthBg.BackgroundTransparency = 0.2
    healthBg.BorderSizePixel = 0
    healthBg.Parent = healthBar
    local healthBgCorner = Instance.new("UICorner")
    healthBgCorner.CornerRadius = UDim.new(0, 2)
    healthBgCorner.Parent = healthBg
    
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = C.green
    healthFill.BackgroundTransparency = 0.05
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBg
    local healthFillCorner = Instance.new("UICorner")
    healthFillCorner.CornerRadius = UDim.new(0, 2)
    healthFillCorner.Parent = healthFill
    
    local nameLabel = Instance.new("BillboardGui")
    nameLabel.Size = UDim2.new(0, 80, 0, 10)
    nameLabel.Adornee = char:FindFirstChild("Head")
    nameLabel.StudsOffset = Vector3.new(0, 3.4, 0)
    nameLabel.MaxDistance = 350
    nameLabel.Parent = espGroup
    local nameBg = Instance.new("Frame")
    nameBg.Size = UDim2.new(1, 0, 1, 0)
    nameBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    nameBg.BackgroundTransparency = 0.15
    nameBg.BorderSizePixel = 0
    nameBg.Parent = nameLabel
    local nameBgCorner = Instance.new("UICorner")
    nameBgCorner.CornerRadius = UDim.new(0, 3)
    nameBgCorner.Parent = nameBg
    local nameText = Instance.new("TextLabel")
    nameText.Size = UDim2.new(1, 0, 1, 0)
    nameText.BackgroundTransparency = 1
    nameText.Text = plr.Name
    nameText.TextColor3 = Color3.fromRGB(220, 220, 230)
    nameText.TextSize = 7
    nameText.Font = Enum.Font.GothamBold
    nameText.TextStrokeTransparency = 0.5
    nameText.Parent = nameBg
    
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(2.4, 3.6, 1.1)
    box.Adornee = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    box.ZIndex = 0
    box.AlwaysOnTop = true
    box.Color3 = espColor
    box.Transparency = espBoxTransparency
    box.Parent = espGroup
    
    local distLabel = Instance.new("BillboardGui")
    distLabel.Size = UDim2.new(0, 30, 0, 8)
    distLabel.Adornee = char:FindFirstChild("Head")
    distLabel.StudsOffset = Vector3.new(0, -1.5, 0)
    distLabel.MaxDistance = 350
    distLabel.Parent = espGroup
    local distText = Instance.new("TextLabel")
    distText.Size = UDim2.new(1, 0, 1, 0)
    distText.BackgroundTransparency = 1
    distText.Text = "0m"
    distText.TextColor3 = Color3.fromRGB(150, 150, 170)
    distText.TextSize = 6
    distText.Font = Enum.Font.GothamSemibold
    distText.TextStrokeTransparency = 0.6
    distText.Parent = distLabel
    
    local connection = RunService.RenderStepped:Connect(function()
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local playerChar = player.Character
        if not playerChar or not playerChar:FindFirstChild("HumanoidRootPart") then return end
        local dist = (char.HumanoidRootPart.Position - playerChar.HumanoidRootPart.Position).Magnitude
        distText.Text = math.floor(dist) .. "m"
        local scale = math.clamp(1 / (dist / 35 + 1), 0.2, 1)
        box.Size = Vector3.new(2.4 * scale, 3.6 * scale, 1.1 * scale)
        box.Transparency = espBoxTransparency + (1 - scale) * 0.15
    end)
    table.insert(espConnections, connection)
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local healthConnection = humanoid.HealthChanged:Connect(function(health)
            local maxHealth = humanoid.MaxHealth
            local percent = math.clamp(health / maxHealth, 0, 1)
            healthFill.Size = UDim2.new(percent, 0, 1, 0)
            healthFill.BackgroundColor3 = percent > 0.5 and C.green or (percent > 0.25 and C.gold or C.red)
        end)
        table.insert(espConnections, healthConnection)
    end
    
    espObjects[plr] = espGroup
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
    if not espEnabled then
        removeESP()
        return
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                if not espObjects[plr] then
                    createPremiumESP(char, plr)
                end
            else
                if espObjects[plr] then
                    pcall(function() espObjects[plr]:Destroy() end)
                    espObjects[plr] = nil
                end
            end
        end
    end
end

local function onPlayerAdded(plr)
    if espEnabled then
        task.wait(0.3)
        updateESP()
    end
end

local function onPlayerRemoving(plr)
    if espObjects[plr] then
        pcall(function() espObjects[plr]:Destroy() end)
        espObjects[plr] = nil
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

section(p4, "ESP Controls")
local espToggle = toggle(p4, "Enable ESP", false, function(s)
    espEnabled = s
    if s then
        updateESP()
        notify("👁️ ESP enabled", 2)
    else
        removeESP()
        notify("👁️ ESP disabled", 2)
    end
end)
label(p4, "ESP Color:")
local espColorPicker = colorPicker(p4, "Color", C.primary, function(color)
    espColor = color
    removeESP()
    if espEnabled then
        updateESP()
    end
end)
label(p4, "Box Transparency: " .. math.floor(espBoxTransparency * 100) .. "%")
local espTransSlider = slider(p4, "Transparency", 0.2, 0.9, espBoxTransparency, function(v)
    espBoxTransparency = v
    removeESP()
    if espEnabled then
        updateESP()
    end
end)
label(p4, "✨ Features:", C.gold)
label(p4, "• Clean Box ESP")
label(p4, "• Health bars")
label(p4, "• Dynamic scaling")
label(p4, "• Distance tracker")
label(p4, "• Auto-updates for new players", C.green)
button(p4, "🔄 Refresh", function()
    removeESP()
    if espEnabled then
        updateESP()
        notify("🔄 Refreshed", 2)
    end
end)

coroutine.wrap(function()
    while task.wait(0.5) do
        if espEnabled then
            updateESP()
        end
    end
end)()

-- ==================================================
-- TAB 5: TOOLS (Original)
-- ==================================================

local p5 = tabPages[5]

section(p5, "Emotes Hub")
label(p5, "Click to open Emotes Hub", C.gold)
button(p5, "🎭 Open Emotes Hub", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
        notify("✅ Emotes Hub opened!", 2)
    end)
end, C.purple)

section(p5, "Visuals (Premium)")
label(p5, "Adjust brightness, contrast, saturation, bloom", C.gold)
local brightSlider = slider(p5, "Brightness", 0.1, 2, 1, function(v)
    visualsBrightness = v
    applyVisuals()
end)
local contrastSlider = slider(p5, "Contrast", 0.1, 2, 1, function(v)
    visualsContrast = v
    applyVisuals()
end)
local satSlider = slider(p5, "Saturation", 0.1, 2, 1.2, function(v)
    visualsSaturation = v
    applyVisuals()
end)
local bloomSlider = slider(p5, "Bloom", 0, 1, 0.6, function(v)
    visualsBloom = v
    applyVisuals()
end)
local tempSlider = slider(p5, "Color Temp (Warm/Cool)", -1, 1, 0, function(v)
    visualsColorTemp = v
    applyVisuals()
end)
local expSlider = slider(p5, "Exposure", 0, 1, 0.6, function(v)
    visualsExposure = v
    applyVisuals()
end)
button(p5, "🔄 Reset Visuals", function()
    visualsBrightness = 1
    visualsContrast = 1
    visualsSaturation = 1.2
    visualsBloom = 0.6
    visualsColorTemp = 0
    visualsExposure = 0.6
    applyVisuals()
    notify("🔄 Visuals reset", 2)
end)

section(p5, "Macro")
button(p5, "▶️ Execute Macro", function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-shiftlock-50258"))()
        notify("✅ Macro executed!", 2)
    end)
end)

-- ==================================================
-- TAB 6: SKYBOX CHANGER
-- ==================================================

local p6 = tabPages[6]
section(p6, "SKYBOX CHANGER")

local skyboxes = {
    {"🌤️ Cartoon Skybox", 136513869855798},
    {"🔴 Red Skybox", 136055162054954},
    {"🚀 Space Skybox", 230057424},
}

for _, skybox in ipairs(skyboxes) do
    button(p6, skybox[1], function()
        changeSkybox(skybox[2])
    end, C.primary)
end

button(p6, "🔄 Reset Skybox", function()
    resetSkybox()
end, C.red)

-- ==================================================
-- TAB 7: FONT CHANGER
-- ==================================================

local p7 = tabPages[7]
section(p7, "FONT CHANGER")

local fonts = {
    "Minecraft",
    "Gotham",
    "Comic Sans",
    "Arial",
    "Roboto",
    "Times New Roman",
    "Sci-Fi",
    "Fantasy",
    "Code",
    "Verdana",
}

for _, font in ipairs(fonts) do
    button(p7, "🔤 " .. font, function()
        changeFont(font)
    end, C.secondary)
end

-- ==================================================
-- TAB 6: STATS (Original)
-- ==================================================

local p6_stats = tabPages[6] -- Actually this is tab 6 but we added skybox as tab 6, so stats is now tab 8
-- We'll fix this by using the correct page
local p8 = tabPages[6] -- Stats is now at index 6 (since we have 7 tabs total, stats is still 6)

section(p8, "Performance")
local fpsL = label(p8, "⚡ FPS: 0", C.gold)
local pingL = label(p8, "📡 Ping: 0 ms", C.gold)
local memL = label(p8, "💾 Memory: 0 MB", C.gold)

local function getPing()
    local ping = 0
    pcall(function()
        local stats = game:GetService("Stats")
        if stats and stats.Network and stats.Network.ServerStatsItem then
            local item = stats.Network.ServerStatsItem["Data Ping"]
            if item then
                ping = tonumber(item:GetValueString():match("%d+")) or 0
            end
        end
    end)
    return math.floor(ping)
end

coroutine.wrap(function()
    local times = {}
    local last = os.clock()
    while task.wait(0.3) do
        pcall(function()
            local now = os.clock()
            local dt = now - last
            last = now
            table.insert(times, dt)
            if #times > 20 then table.remove(times, 1) end
            local avg = 0
            for _, t in ipairs(times) do avg = avg + t end
            avg = math.max(avg / #times, 0.0001)
            local fps = math.floor(1 / avg)
            local ping = getPing()
            local mem = math.floor(collectgarbage("count") / 1024)
            fpsL.Text = "⚡ FPS: " .. fps
            pingL.Text = "📡 Ping: " .. ping .. " ms"
            memL.Text = "💾 Memory: " .. mem .. " MB"
        end)
    end
end)()

-- Footer
local ft = Instance.new("Frame")
ft.Size = UDim2.new(1, -8, 0, 22)
ft.Position = UDim2.new(0, 4, 1, -24)
ft.BackgroundTransparency = 1
ft.BorderSizePixel = 0
ft.Parent = content
local ftText = Instance.new("TextLabel")
ftText.Size = UDim2.new(1, 0, 1, 0)
ftText.BackgroundTransparency = 1
ftText.Text = "🔷 ReddieHub v25.0 • Made by aliiiwyddd"
ftText.TextColor3 = C.dim
ftText.TextSize = 10
ftText.Font = Enum.Font.GothamSemibold
ftText.TextXAlignment = Enum.TextXAlignment.Center
ftText.Parent = ft

-- ==================================================
-- PC KEYBINDS
-- ==================================================

function setupKeybinds()
    pcall(function()
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.RightShift then
                hub.Visible = not hub.Visible
                if hub.Visible then
                    pcall(function()
                        hub:TweenSize(UDim2.new(0, 620, 0, 560), "Out", "Back", 0.5, true)
                    end)
                    toggleBtn.Text = "🟢"
                    toggleBtn.BackgroundColor3 = C.green
                    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                else
                    toggleBtn.Text = "🔷"
                    toggleBtn.BackgroundColor3 = C.primary
                    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end)
    end)
    
    pcall(function()
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Q then
                camlockBtn.MouseButton1Click:Fire()
            end
        end)
    end)
    
    print("✅ PC Keybinds: RightShift=Open, Q=Camlock")
end

print("==========================================")
print("✅ ReddieHub v25.0 - ULTIMATE PREMIUM EDITION")
print("📋 Features:")
print("   🔷 Crystal/Snowflake Theme")
print("   🎯 Camlock - Positive=Smooth, Negative=Offset")
print("   👁️ Perfect Viewer")
print("   📊 Camlock Popup with Stats")
print("   📍 Perfect Tracer Line")
print("   👁️ ESP - Auto-updates")
print("   🎨 Premium Visuals")
print("   🎭 Emotes Hub")
print("   🌤️ Skybox Changer")
print("   🔤 Font Changer")
print("   🌀 Floating Step Buttons")
print("   ⌨️ PC Keybinds: RightShift=Open, Q=Camlock")
print("   💎 Best GUI Ever")
print("==========================================")

end) -- End of pcall

-- If there was an error, print it
if not success then
    print("❌ ReddieHub Error: " .. tostring(err))
    warn("Error loading ReddieHub: " .. tostring(err))
end