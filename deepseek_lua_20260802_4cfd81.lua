-- ==================================================
-- RTXRRR v5.0 - ULTIMATE VISUAL ENHANCER (MACLIB EDITION)
-- Powered by MacLib • Terminal Style • 90s Aesthetic
-- Font Changer • Skybox Changer • FPS Boost • Ultra HDR • ESP • Crosshair
-- ==================================================

-- Load MacLib
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/maclib/main/maclib.lua"))()

print("Loading RTXRRR v5.0...")

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
-- CREATE MAIN WINDOW
-- ==================================================

local Window = MacLib:Window({
    Title = "⚡ RTXRRR v5.0",
    Subtitle = ">> TERMINAL EDITION // VISUAL ENHANCER",
    Size = UDim2.fromOffset(500, 550),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.RightControl,
    AcrylicBlur = true,
})

-- Global Settings
Window:GlobalSetting({
    Name = "UI Blur",
    Default = true,
    Callback = function(bool)
        Window:SetAcrylicBlurState(bool)
    end,
})

Window:GlobalSetting({
    Name = "Notifications",
    Default = true,
    Callback = function(bool)
        Window:SetNotificationsState(bool)
    end,
})

Window:GlobalSetting({
    Name = "Show User Info",
    Default = true,
    Callback = function(bool)
        Window:SetUserInfoState(bool)
    end,
})

-- ==================================================
-- TAB GROUP & TABS
-- ==================================================

local TabGroup = Window:TabGroup()

local tabs = {
    Fonts = TabGroup:Tab({ Name = "FONTS", Image = "rbxassetid://18821914323" }),
    Skybox = TabGroup:Tab({ Name = "SKYBOX", Image = "rbxassetid://10734950309" }),
    FPS = TabGroup:Tab({ Name = "FPS", Image = "rbxassetid://18821914323" }),
    HDR = TabGroup:Tab({ Name = "HDR", Image = "rbxassetid://18821914323" }),
    ESP = TabGroup:Tab({ Name = "ESP", Image = "rbxassetid://18821914323" }),
}

-- ==================================================
-- TAB 1: FONTS
-- ==================================================

local fontSection = tabs.Fonts:Section({ Side = "Left" })

fontSection:Header({ Text = "FONT CHANGER - 8 FONTS" })

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
end

local function changeFont(fontName)
    currentFont = fontName
    applyFontToAll()
    notify("🔤 Font changed to: " .. fontName, 2)
end

for _, font in ipairs(fontList) do
    fontSection:Button({
        Name = "[ " .. font .. " ]",
        Callback = function()
            changeFont(font)
        end,
    })
end

fontSection:Button({
    Name = "[ RESET FONT ]",
    Callback = function()
        currentFont = nil
        applyFontToAll()
        notify("🔄 Font reset!", 2)
    end,
})

-- ==================================================
-- TAB 2: SKYBOX
-- ==================================================

local skyboxSection = tabs.Skybox:Section({ Side = "Left" })

skyboxSection:Header({ Text = "SKYBOX CHANGER" })

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

for _, skybox in ipairs(skyboxList) do
    skyboxSection:Button({
        Name = "[ " .. skybox[1] .. " ]",
        Callback = function()
            changeSkybox(skybox[2])
        end,
    })
end

skyboxSection:Button({
    Name = "[ RESET SKYBOX ]",
    Callback = function()
        resetSkybox()
    end,
})

-- ==================================================
-- TAB 3: FPS BOOST
-- ==================================================

local fpsSection = tabs.FPS:Section({ Side = "Left" })

fpsSection:Header({ Text = "FPS BOOST SETTINGS" })

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
        
        Workspace.CurrentCamera.MaxDistance = fpsSettings.resolution
    end)
end

fpsSection:Toggle({
    Name = "Disable Shadows",
    Default = false,
    Callback = function(s)
        fpsSettings.noShadows = s
        applyFPSBoost()
    end,
})

fpsSection:Toggle({
    Name = "Remove Grass",
    Default = false,
    Callback = function(s)
        fpsSettings.noGrass = s
        applyFPSBoost()
    end,
})

fpsSection:Toggle({
    Name = "Gray Sky",
    Default = false,
    Callback = function(s)
        fpsSettings.graySky = s
        applyFPSBoost()
    end,
})

fpsSection:Toggle({
    Name = "Gray Players",
    Default = false,
    Callback = function(s)
        fpsSettings.noClothes = s
        applyFPSBoost()
    end,
})

fpsSection:Toggle({
    Name = "Disable Fog",
    Default = false,
    Callback = function(s)
        fpsSettings.noFog = s
        applyFPSBoost()
    end,
})

fpsSection:Toggle({
    Name = "Low Graphics",
    Default = false,
    Callback = function(s)
        fpsSettings.lowGraphics = s
        applyFPSBoost()
    end,
})

fpsSection:Slider({
    Name = "Render Distance",
    Default = 1080,
    Minimum = 250,
    Maximum = 2500,
    DisplayMethod = "Value",
    Precision = 0,
    Callback = function(v)
        fpsSettings.resolution = math.floor(v)
        applyFPSBoost()
    end,
})

fpsSection:Button({
    Name = "[ RESET FPS ]",
    Callback = function()
        fpsSettings.noShadows = false
        fpsSettings.noGrass = false
        fpsSettings.graySky = false
        fpsSettings.noClothes = false
        fpsSettings.noFog = false
        fpsSettings.lowGraphics = false
        fpsSettings.resolution = 1080
        applyFPSBoost()
        notify("🔄 FPS reset!", 2)
    end,
})

-- ==================================================
-- TAB 4: ULTRA HDR
-- ==================================================

local hdrSection = tabs.HDR:Section({ Side = "Left" })

hdrSection:Header({ Text = "ULTRA HDR SETTINGS" })

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

hdrSection:Toggle({
    Name = "Enable Ultra HDR",
    Default = false,
    Callback = function(s)
        hdrEnabled = s
        applyHDR()
    end,
})

hdrSection:Slider({
    Name = "Brightness",
    Default = 1.5,
    Minimum = 0.1,
    Maximum = 3.0,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(v)
        hdrBright = v
        if hdrEnabled then applyHDR() end
    end,
})

hdrSection:Slider({
    Name = "Contrast",
    Default = 1.8,
    Minimum = 0.1,
    Maximum = 3.0,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(v)
        hdrContrast = v
        if hdrEnabled then applyHDR() end
    end,
})

hdrSection:Slider({
    Name = "Saturation",
    Default = 2.0,
    Minimum = 0.1,
    Maximum = 3.0,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(v)
        hdrSat = v
        if hdrEnabled then applyHDR() end
    end,
})

hdrSection:Slider({
    Name = "Bloom",
    Default = 1.5,
    Minimum = 0,
    Maximum = 3.0,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(v)
        hdrBloom = v
        if hdrEnabled then applyHDR() end
    end,
})

hdrSection:Slider({
    Name = "Exposure",
    Default = 1.0,
    Minimum = 0,
    Maximum = 2.0,
    DisplayMethod = "Value",
    Precision = 1,
    Callback = function(v)
        hdrExposure = v
        if hdrEnabled then applyHDR() end
    end,
})

hdrSection:Button({
    Name = "[ RESET HDR ]",
    Callback = function()
        hdrEnabled = false
        hdrBright = 1.5
        hdrContrast = 1.8
        hdrSat = 2.0
        hdrBloom = 1.5
        hdrExposure = 1.0
        applyHDR()
        notify("🔄 HDR reset!", 2)
    end,
})

-- ==================================================
-- TAB 5: ESP & CROSSHAIR
-- ==================================================

local espSection = tabs.ESP:Section({ Side = "Left" })

espSection:Header({ Text = "ESP & CROSSHAIR" })

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

espSection:Toggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(s)
        espEnabled = s
        if s then
            createESP()
            notify("👁️ ESP enabled", 2)
        else
            removeESP()
            notify("👁️ ESP disabled", 2)
        end
    end,
})

espSection:Colorpicker({
    Name = "ESP Color",
    Default = C.primary,
    Callback = function(color)
        espColor = color
        if espEnabled then updateESP()
    end,
})

espSection:Header({ Text = "CROSSHAIR" })

local crosshairInput = espSection:Input({
    Name = "Crosshair ID",
    Placeholder = "Enter Image ID...",
    AcceptedCharacters = "All",
})

espSection:Button({
    Name = "[ SET CROSSHAIR ]",
    Callback = function()
        local id = crosshairInput:GetInput()
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
    end,
})

espSection:Button({
    Name = "[ RESET CROSSHAIR ]",
    Callback = function()
        pcall(function()
            local crosshair = CoreGui:FindFirstChild("Crosshair")
            if crosshair then crosshair:Destroy()
            notify("🔄 Crosshair reset!", 2)
        end)
    end,
})

-- ==================================================
-- HOOK FONT CHANGER FOR NEW ELEMENTS
-- ==================================================

coroutine.wrap(function()
    while true do
        task.wait(0.5)
        if currentFont then
            applyFontToAll()
        end
    end
end)()

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

-- ==================================================
-- SELECT FIRST TAB
-- ==================================================

tabs.Fonts:Select()

print("==========================================")
print("✅ RTXRRR v5.0 - MACLIB EDITION")
print("📋 Features:")
print("   🔤 8 Font Changer")
print("   🌤️ 10+ Skybox Changer")
print("   ⚡ FPS Boost - All Settings")
print("   🎨 Ultra HDR")
print("   👁️ ESP - Box Line")
print("   🎯 Crosshair Changer")
print("   💻 Terminal Style")
print("==========================================")
print("✅ Press Right Control to open/close the menu!")