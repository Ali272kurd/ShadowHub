-- ==================================================
-- REDDIEHUB v23.0 - ULTIMATE PREMIUM EDITION
-- 2-Button Teleport System - Rainbow Style
-- Move Forward • Teleport to Chosen
-- ==================================================

-- Safety pcall for all operations
local success, err = pcall(function()

print("Loading ReddieHub v23.0...")

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

task.wait(0.5)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
if not player then
    repeat task.wait() until Players.LocalPlayer
    player = Players.LocalPlayer
end

repeat task.wait() until player and player.Character
print("Player loaded!")

-- ==================================================
-- PREMIUM COLORS - Reddie Theme
-- ==================================================

local C = {
    primary = Color3.fromRGB(220, 10, 30),
    primaryDark = Color3.fromRGB(160, 5, 20),
    primaryGlow = Color3.fromRGB(255, 30, 50),
    secondary = Color3.fromRGB(0, 180, 255),
    accent = Color3.fromRGB(255, 200, 0),
    dark = Color3.fromRGB(4, 4, 8),
    bg = Color3.fromRGB(8, 8, 14),
    panel = Color3.fromRGB(12, 12, 20),
    panelLight = Color3.fromRGB(20, 20, 32),
    text = Color3.fromRGB(245, 245, 250),
    dim = Color3.fromRGB(160, 160, 180),
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
            Title = "🔴 ReddieHub",
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
-- RAINBOW STROKE HELPER
-- ==================================================

local function addRainbowStroke(obj, thickness, speed)
    thickness = thickness or 3
    speed = speed or 1
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness
    stroke.Transparency = 0.15
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    
    -- Glow stroke
    local glowStroke = Instance.new("UIStroke")
    glowStroke.Thickness = thickness * 2.5
    glowStroke.Transparency = 0.7
    glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glowStroke.Parent = obj
    
    task.spawn(function()
        local hue = 0
        while stroke and stroke.Parent do
            hue = (hue + 0.01 * speed) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            pcall(function()
                stroke.Color = color
                glowStroke.Color = color
                stroke.Transparency = 0.1 + math.sin(hue * math.pi * 2) * 0.05
                glowStroke.Transparency = 0.65 + math.sin(hue * math.pi * 2) * 0.05
            end)
            task.wait(0.016)
        end
    end)
    
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
-- LOADING SCREEN - Reddie Style
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

-- Animated wave background
local waveBg = Instance.new("Frame")
waveBg.Size = UDim2.new(2, 0, 2, 0)
waveBg.Position = UDim2.new(-0.5, 0, -0.5, 0)
waveBg.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
waveBg.BorderSizePixel = 0
waveBg.Parent = loadingBg

local waveGrad = Instance.new("UIGradient")
waveGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 0, 0)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(5, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(5, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 0, 0)),
})
waveGrad.Rotation = 45
waveGrad.Parent = waveBg

-- Animate waves
task.spawn(function()
    local angle = 0
    while loadingBg and loadingBg.Parent do
        angle = (angle + 0.15) % 360
        pcall(function()
            waveGrad.Rotation = angle
            waveBg.Size = UDim2.new(2 + math.sin(angle * 0.008) * 0.3, 0, 2 + math.cos(angle * 0.008) * 0.3, 0)
        end)
        task.wait(0.016)
    end
end)

-- Title
local glitchTitle = Instance.new("TextLabel")
glitchTitle.Size = UDim2.new(0, 500, 0, 65)
glitchTitle.Position = UDim2.new(0.5, -250, 0.2, 0)
glitchTitle.BackgroundTransparency = 1
glitchTitle.Text = "REDDIEHUB"
glitchTitle.TextColor3 = C.primaryGlow
glitchTitle.TextSize = 48
glitchTitle.Font = Enum.Font.GothamBold
glitchTitle.TextXAlignment = Enum.TextXAlignment.Center
glitchTitle.TextStrokeTransparency = 0.2
glitchTitle.Parent = loadingBg

task.spawn(function()
    local glitch = false
    while loadingBg and loadingBg.Parent do
        task.wait(math.random(2, 4))
        glitch = not glitch
        if glitch then
            pcall(function()
                glitchTitle.Text = "R3DDI3HUB"
                glitchTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
                glitchTitle.TextSize = 54
            end)
        else
            pcall(function()
                glitchTitle.Text = "REDDIEHUB"
                glitchTitle.TextColor3 = C.primaryGlow
                glitchTitle.TextSize = 48
            end)
        end
        task.wait(0.06)
        pcall(function()
            glitchTitle.Text = "REDDIEHUB"
            glitchTitle.TextColor3 = C.primaryGlow
            glitchTitle.TextSize = 48
        end)
    end
end)

-- Subtitle
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0, 400, 0, 28)
subTitle.Position = UDim2.new(0.5, -200, 0.2, 72)
subTitle.BackgroundTransparency = 1
subTitle.Text = ">> TELEPORT SYSTEM <<"
subTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
subTitle.TextSize = 16
subTitle.Font = Enum.Font.Code
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.Parent = loadingBg

-- Avatar
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 120, 0, 120)
avatar.Position = UDim2.new(0.5, -60, 0.42, -60)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=420&h=420"
avatar.Parent = loadingBg
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 20)
avatarCorner.Parent = avatar
local avatarStroke = Instance.new("UIStroke")
avatarStroke.Thickness = 3
avatarStroke.Color = C.primaryGlow
avatarStroke.Transparency = 0.1
avatarStroke.Parent = avatar

-- Name
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(0, 300, 0, 28)
nameLabel.Position = UDim2.new(0.5, -150, 0.42, 68)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.Name
nameLabel.TextColor3 = C.text
nameLabel.TextSize = 22
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Center
nameLabel.TextStrokeTransparency = 0.2
nameLabel.Parent = loadingBg

-- TikTok
local tiktokLabel = Instance.new("TextLabel")
tiktokLabel.Size = UDim2.new(0, 300, 0, 22)
tiktokLabel.Position = UDim2.new(0.5, -150, 0.42, 98)
tiktokLabel.BackgroundTransparency = 1
tiktokLabel.Text = "📱 Follow TikTok: .vfsv"
tiktokLabel.TextColor3 = C.primaryGlow
tiktokLabel.TextSize = 14
tiktokLabel.Font = Enum.Font.GothamBold
tiktokLabel.TextXAlignment = Enum.TextXAlignment.Center
tiktokLabel.Parent = loadingBg

-- Loading bar
local loadContainer = Instance.new("Frame")
loadContainer.Size = UDim2.new(0, 350, 0, 12)
loadContainer.Position = UDim2.new(0.5, -175, 0.7, 0)
loadContainer.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
loadContainer.BorderSizePixel = 0
loadContainer.Parent = loadingBg
local loadContainerCorner = Instance.new("UICorner")
loadContainerCorner.CornerRadius = UDim.new(0, 6)
loadContainerCorner.Parent = loadContainer

local loadFill = Instance.new("Frame")
loadFill.Size = UDim2.new(0, 0, 1, 0)
loadFill.BorderSizePixel = 0
loadFill.Parent = loadContainer
local loadFillCorner = Instance.new("UICorner")
loadFillCorner.CornerRadius = UDim.new(0, 6)
loadFillCorner.Parent = loadFill
local loadGradient = Instance.new("UIGradient")
loadGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 30, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 0)),
})
loadGradient.Parent = loadFill

-- Percentage
local loadPercent = Instance.new("TextLabel")
loadPercent.Size = UDim2.new(0, 80, 0, 25)
loadPercent.Position = UDim2.new(0.5, -40, 0.7, 26)
loadPercent.BackgroundTransparency = 1
loadPercent.Text = "0%"
loadPercent.TextColor3 = C.primaryGlow
loadPercent.TextSize = 22
loadPercent.Font = Enum.Font.GothamBold
loadPercent.TextXAlignment = Enum.TextXAlignment.Center
loadPercent.Parent = loadingBg

-- Loading subtitle
local loadingSub = Instance.new("TextLabel")
loadingSub.Size = UDim2.new(0, 400, 0, 20)
loadingSub.Position = UDim2.new(0.5, -200, 0.7, 55)
loadingSub.BackgroundTransparency = 1
loadingSub.Text = "> Initializing..."
loadingSub.TextColor3 = Color3.fromRGB(0, 255, 0)
loadingSub.TextSize = 13
loadingSub.Font = Enum.Font.Code
loadingSub.TextXAlignment = Enum.TextXAlignment.Center
loadingSub.Parent = loadingBg

local loadingMessages = {
    "> Initializing...",
    "> Loading modules...",
    "> Bypassing security...",
    "> Decrypting data...",
    "> Injecting payload...",
    "> System ready."
}

-- ==================================================
-- MOVABLE RAINBOW BUTTONS
-- ==================================================

-- Create button container frame (movable parent)
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(0, 220, 0, 120)
buttonContainer.Position = UDim2.new(0.5, -110, 0.35, 0)
buttonContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
buttonContainer.BackgroundTransparency = 0.3
buttonContainer.BorderSizePixel = 0
buttonContainer.ClipsDescendants = true
buttonContainer.Visible = false
buttonContainer.Parent = screenGui

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 16)
containerCorner.Parent = buttonContainer

-- Rainbow border for container
addRainbowStroke(buttonContainer, 2, 0.8)

-- Glass effect
local containerGlass = Instance.new("Frame")
containerGlass.Size = UDim2.new(1, 0, 1, 0)
containerGlass.BackgroundColor3 = C.glass
containerGlass.BackgroundTransparency = 0.92
containerGlass.BorderSizePixel = 0
containerGlass.Parent = buttonContainer
local containerGlassCorner = Instance.new("UICorner")
containerGlassCorner.CornerRadius = UDim.new(0, 16)
containerGlassCorner.Parent = containerGlass

-- Draggable functionality
local containerDragging = false
local containerDragOff = Vector2.new(0, 0)

pcall(function()
    buttonContainer.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            containerDragging = true
            containerDragOff = Vector2.new(mouse.X - buttonContainer.AbsolutePosition.X, mouse.Y - buttonContainer.AbsolutePosition.Y)
        end
    end)
end)

pcall(function()
    UserInputService.InputChanged:Connect(function(i)
        if containerDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            pcall(function()
                buttonContainer.Position = UDim2.new(0, mouse.X - containerDragOff.X, 0, mouse.Y - containerDragOff.Y)
            end)
        end
    end)
end)

pcall(function()
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            containerDragging = false
        end
    end)
end)

-- BUTTON 1: MOVE FORWARD
local moveBtn = Instance.new("TextButton")
moveBtn.Size = UDim2.new(0, 190, 0, 44)
moveBtn.Position = UDim2.new(0.5, -95, 0, 10)
moveBtn.BackgroundColor3 = C.primary
moveBtn.BackgroundTransparency = 0.1
moveBtn.Text = "🚀 MOVE FORWARD"
moveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
moveBtn.TextSize = 16
moveBtn.Font = Enum.Font.GothamBold
moveBtn.BorderSizePixel = 0
moveBtn.Parent = buttonContainer

local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(0, 12)
moveCorner.Parent = moveBtn

-- Rainbow border for move button
addRainbowStroke(moveBtn, 2.5, 1.2)

-- Glass overlay
local moveGlass = Instance.new("Frame")
moveGlass.Size = UDim2.new(1, 0, 1, 0)
moveGlass.BackgroundColor3 = C.glass
moveGlass.BackgroundTransparency = 0.92
moveGlass.BorderSizePixel = 0
moveGlass.Parent = moveBtn
local moveGlassCorner = Instance.new("UICorner")
moveGlassCorner.CornerRadius = UDim.new(0, 12)
moveGlassCorner.Parent = moveGlass

-- Glow ring
local moveGlow = Instance.new("Frame")
moveGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
moveGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
moveGlow.BackgroundColor3 = C.primary
moveGlow.BackgroundTransparency = 0.9
moveGlow.BorderSizePixel = 0
moveGlow.Parent = moveBtn
local moveGlowCorner = Instance.new("UICorner")
moveGlowCorner.CornerRadius = UDim.new(0, 14)
moveGlowCorner.Parent = moveGlow

-- Hover effects
moveBtn.MouseEnter:Connect(function()
    moveBtn.BackgroundColor3 = C.primary
    moveBtn.BackgroundTransparency = 0.05
    moveGlow.BackgroundTransparency = 0.8
end)
moveBtn.MouseLeave:Connect(function()
    moveBtn.BackgroundColor3 = C.primary
    moveBtn.BackgroundTransparency = 0.1
    moveGlow.BackgroundTransparency = 0.9
end)

-- MOVE FORWARD FUNCTION
moveBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = player.Character
        if not char then
            notify("❌ Character not found!", 2)
            return
        end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then
            notify("❌ HumanoidRootPart not found!", 2)
            return
        end
        
        -- Get direction player is facing
        local lookVector = root.CFrame.LookVector
        local newPos = root.Position + lookVector * 50 -- 50 steps forward
        
        -- Teleport
        root.CFrame = CFrame.new(newPos)
        notify("🚀 Teleported 50 steps forward!", 2)
    end)
end)

-- BUTTON 2: TELEPORT TO CHOSEN
local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0, 190, 0, 44)
teleportBtn.Position = UDim2.new(0.5, -95, 0, 64)
teleportBtn.BackgroundColor3 = C.secondary
teleportBtn.BackgroundTransparency = 0.1
teleportBtn.Text = "📍 TELEPORT TO CHOSEN"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.TextSize = 16
teleportBtn.Font = Enum.Font.GothamBold
teleportBtn.BorderSizePixel = 0
teleportBtn.Parent = buttonContainer

local teleCorner = Instance.new("UICorner")
teleCorner.CornerRadius = UDim.new(0, 12)
teleCorner.Parent = teleportBtn

-- Rainbow border for teleport button
addRainbowStroke(teleportBtn, 2.5, 1.2)

-- Glass overlay
local teleGlass = Instance.new("Frame")
teleGlass.Size = UDim2.new(1, 0, 1, 0)
teleGlass.BackgroundColor3 = C.glass
teleGlass.BackgroundTransparency = 0.92
teleGlass.BorderSizePixel = 0
teleGlass.Parent = teleportBtn
local teleGlassCorner = Instance.new("UICorner")
teleGlassCorner.CornerRadius = UDim.new(0, 12)
teleGlassCorner.Parent = teleGlass

-- Glow ring
local teleGlow = Instance.new("Frame")
teleGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
teleGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
teleGlow.BackgroundColor3 = C.secondary
teleGlow.BackgroundTransparency = 0.9
teleGlow.BorderSizePixel = 0
teleGlow.Parent = teleportBtn
local teleGlowCorner = Instance.new("UICorner")
teleGlowCorner.CornerRadius = UDim.new(0, 14)
teleGlowCorner.Parent = teleGlow

-- Hover effects
teleportBtn.MouseEnter:Connect(function()
    teleportBtn.BackgroundColor3 = C.secondary
    teleportBtn.BackgroundTransparency = 0.05
    teleGlow.BackgroundTransparency = 0.8
end)
teleportBtn.MouseLeave:Connect(function()
    teleportBtn.BackgroundColor3 = C.secondary
    teleportBtn.BackgroundTransparency = 0.1
    teleGlow.BackgroundTransparency = 0.9
end)

-- ==================================================
-- CHOOSE BUTTON - Appears when Teleport to Chosen is clicked
-- ==================================================

local chooseContainer = Instance.new("Frame")
chooseContainer.Size = UDim2.new(0, 180, 0, 50)
chooseContainer.Position = UDim2.new(0.5, -90, 0.55, 0)
chooseContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chooseContainer.BackgroundTransparency = 0.3
chooseContainer.BorderSizePixel = 0
chooseContainer.ClipsDescendants = true
chooseContainer.Visible = false
chooseContainer.Parent = screenGui

local chooseCorner = Instance.new("UICorner")
chooseCorner.CornerRadius = UDim.new(0, 12)
chooseCorner.Parent = chooseContainer
addRainbowStroke(chooseContainer, 2, 0.6)

local chooseGlass = Instance.new("Frame")
chooseGlass.Size = UDim2.new(1, 0, 1, 0)
chooseGlass.BackgroundColor3 = C.glass
chooseGlass.BackgroundTransparency = 0.92
chooseGlass.BorderSizePixel = 0
chooseGlass.Parent = chooseContainer
local chooseGlassCorner = Instance.new("UICorner")
chooseGlassCorner.CornerRadius = UDim.new(0, 12)
chooseGlassCorner.Parent = chooseGlass

-- Choose button
local chooseBtn = Instance.new("TextButton")
chooseBtn.Size = UDim2.new(1, 0, 1, 0)
chooseBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
chooseBtn.BackgroundTransparency = 0.1
chooseBtn.Text = "✅ CHOOSE THIS POSITION"
chooseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
chooseBtn.TextSize = 14
chooseBtn.Font = Enum.Font.GothamBold
chooseBtn.BorderSizePixel = 0
chooseBtn.Parent = chooseContainer

local chooseBtnCorner = Instance.new("UICorner")
chooseBtnCorner.CornerRadius = UDim.new(0, 12)
chooseBtnCorner.Parent = chooseBtn
addRainbowStroke(chooseBtn, 2, 1.5)

local chooseBtnGlass = Instance.new("Frame")
chooseBtnGlass.Size = UDim2.new(1, 0, 1, 0)
chooseBtnGlass.BackgroundColor3 = C.glass
chooseBtnGlass.BackgroundTransparency = 0.92
chooseBtnGlass.BorderSizePixel = 0
chooseBtnGlass.Parent = chooseBtn
local chooseBtnGlassCorner = Instance.new("UICorner")
chooseBtnGlassCorner.CornerRadius = UDim.new(0, 12)
chooseBtnGlassCorner.Parent = chooseBtnGlass

-- State variables
local chosenPosition = nil
local isChosen = false

-- TELEPORT TO CHOSEN BUTTON CLICK - Shows choose container
teleportBtn.MouseButton1Click:Connect(function()
    -- Show the choose container
    chooseContainer.Visible = true
    
    -- Get current position
    pcall(function()
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                chosenPosition = root.Position
                chooseBtn.Text = "✅ CHOOSE THIS POSITION"
                chooseBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                chooseBtn.BackgroundTransparency = 0.1
                isChosen = false
                notify("📍 Position captured! Click 'Choose' to save.", 2)
            end
        end
    end)
end)

-- CHOOSE BUTTON CLICK - Saves position
chooseBtn.MouseButton1Click:Connect(function()
    if chosenPosition then
        isChosen = not isChosen
        
        if isChosen then
            chooseBtn.Text = "✅ POSITION CHOSEN!"
            chooseBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
            chooseBtn.BackgroundTransparency = 0.1
            notify("✅ Position chosen! Click 'Teleport to Chosen' to go there.", 2)
            
            -- Hide choose container after a moment
            task.wait(1.5)
            chooseContainer.Visible = false
        else
            chooseBtn.Text = "✅ CHOOSE THIS POSITION"
            chooseBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            chooseBtn.BackgroundTransparency = 0.1
            isChosen = false
            notify("🔄 Position unchosen!", 2)
        end
    else
        notify("❌ No position captured! Click 'Teleport to Chosen' first.", 2)
    end
end)

-- TELEPORT TO CHOSEN - Teleports to saved position
teleportBtn.MouseButton2Click:Connect(function() -- Right click to teleport to chosen
    if not chosenPosition or not isChosen then
        notify("⚠️ No position chosen! Click the button then choose a position.", 3)
        return
    end
    
    pcall(function()
        local char = player.Character
        if not char then
            notify("❌ Character not found!", 2)
            return
        end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then
            notify("❌ HumanoidRootPart not found!", 2)
            return
        end
        
        root.CFrame = CFrame.new(chosenPosition)
        notify("📍 Teleported to chosen position!", 2)
    end)
end)

-- Also left click on the button while chosen teleports
local originalTeleClick = teleportBtn.MouseButton1Click
teleportBtn.MouseButton1Click:Connect(function()
    if isChosen and chosenPosition then
        pcall(function()
            local char = player.Character
            if not char then
                notify("❌ Character not found!", 2)
                return
            end
            
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                notify("❌ HumanoidRootPart not found!", 2)
                return
            end
            
            root.CFrame = CFrame.new(chosenPosition)
            notify("📍 Teleported to chosen position!", 2)
        end)
    else
        -- Show the choose container to select position
        chooseContainer.Visible = true
        
        pcall(function()
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    chosenPosition = root.Position
                    chooseBtn.Text = "✅ CHOOSE THIS POSITION"
                    chooseBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
                    chooseBtn.BackgroundTransparency = 0.1
                    isChosen = false
                    notify("📍 Position captured! Click 'Choose' to save.", 2)
                end
            end
        end)
    end
end)

-- ==================================================
-- OPEN/CLOSE BUTTON
-- ==================================================

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 65, 0, 65)
toggleBtn.Position = UDim2.new(1, -75, 0, 10)
toggleBtn.BackgroundColor3 = C.primary
toggleBtn.BackgroundTransparency = 0.1
toggleBtn.Text = "🔴"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 32
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Visible = true
toggleBtn.Parent = screenGui

-- Glow ring
local toggleGlow = Instance.new("Frame")
toggleGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
toggleGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
toggleGlow.BackgroundColor3 = C.primary
toggleGlow.BackgroundTransparency = 0.85
toggleGlow.BorderSizePixel = 0
toggleGlow.Parent = toggleBtn
local toggleGlowCorner = Instance.new("UICorner")
toggleGlowCorner.CornerRadius = UDim.new(0, 24)
toggleGlowCorner.Parent = toggleGlow

-- Corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 18)
toggleCorner.Parent = toggleBtn

-- Rainbow border
addRainbowStroke(toggleBtn, 2.5, 1.5)

-- Glass overlay
local toggleGlass = Instance.new("Frame")
toggleGlass.Size = UDim2.new(1, 0, 1, 0)
toggleGlass.BackgroundColor3 = C.glass
toggleGlass.BackgroundTransparency = 0.92
toggleGlass.BorderSizePixel = 0
toggleGlass.Parent = toggleBtn
local toggleGlassCorner = Instance.new("UICorner")
toggleGlassCorner.CornerRadius = UDim.new(0, 18)
toggleGlassCorner.Parent = toggleGlass

-- Pulse animation
task.spawn(function()
    while toggleBtn and toggleBtn.Parent do
        for t = 0, 1, 0.03 do
            local scale = 1 + math.sin(t * math.pi * 2) * 0.05
            pcall(function()
                toggleGlow.Size = UDim2.new(1.3 * scale, 0, 1.3 * scale, 0)
                toggleGlow.Position = UDim2.new(-0.15 * scale, 0, -0.15 * scale, 0)
                toggleGlow.BackgroundTransparency = 0.8 + math.sin(t * math.pi * 2) * 0.05
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

-- Toggle visibility
toggleBtn.MouseButton1Click:Connect(function()
    buttonContainer.Visible = not buttonContainer.Visible
    if buttonContainer.Visible then
        toggleBtn.Text = "🟢"
        toggleBtn.BackgroundColor3 = C.green
        toggleBtn.BackgroundTransparency = 0.1
    else
        toggleBtn.Text = "🔴"
        toggleBtn.BackgroundColor3 = C.primary
        toggleBtn.BackgroundTransparency = 0.1
        chooseContainer.Visible = false
    end
end)

-- ==================================================
-- LOADING SCREEN PROGRESS
-- ==================================================

task.spawn(function()
    local msgIndex = 1
    for i = 0, 100 do
        pcall(function()
            loadFill.Size = UDim2.new(i/100, 0, 1, 0)
            loadPercent.Text = i .. "%"
        end)
        if i % 12 == 0 and msgIndex <= #loadingMessages then
            pcall(function()
                loadingSub.Text = loadingMessages[msgIndex]
            end)
            msgIndex = msgIndex + 1
        end
        task.wait(0.05)
    end
    
    task.wait(0.5)
    
    pcall(function()
        loadingScreenGui:Destroy()
    end)
    
    buttonContainer.Visible = false
    notify("🔴 ReddieHub v23.0 Loaded! Click 🔴 to open", 4)
    print("✅ Loading screen destroyed!")
end)

print("==========================================")
print("✅ ReddieHub v23.0 - 2-BUTTON TELEPORT SYSTEM")
print("📋 Features:")
print("   🔴 Classic Reddie Loading Screen")
print("   🌈 Rainbow Borders on EVERYTHING")
print("   📦 Movable Button Container")
print("   🚀 Move Forward - 50 steps")
print("   📍 Teleport to Chosen Position")
print("   ✅ Choose/Unchoose Position")
print("   💎 Best GUI Ever")
print("==========================================")

end)

-- If there was an error, print it
if not success then
    print("❌ ReddieHub Error: " .. tostring(err))
    warn("Error loading ReddieHub: " .. tostring(err))
end