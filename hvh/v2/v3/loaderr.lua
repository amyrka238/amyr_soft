--[[
    ╔════════════════════════════════════════╗
    ║   FEMBOY MASCOT - GITHUB LOADER       ║
    ║   Version: 2.0 (2026)                 ║
    ║   Author: amyrka238                   ║
    ║   Repo: amyr_soft                     ║
    ╚════════════════════════════════════════╝
]]

print("♥ FEMBOY MASCOT - INITIALIZING... ♥")

-- ═══════════════════════════════════════
-- ПРОВЕРКА ЭКСПЛОИТА
-- ═══════════════════════════════════════
local executor = identifyexecutor and identifyexecutor() or "Unknown"
print("🎮 Executor:", executor)

-- Проверка HttpGet
local canHttp = pcall(function()
    game:HttpGet("https://google.com", true)
end)

if not canHttp then
    warn("❌ HttpGet blocked! Your executor doesn't support external loading.")
    warn("⚠️ Use Xeno, Wave, or Electron instead.")
    return
end

print("✅ HttpGet supported!")

-- ═══════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════
-- НАСТРОЙКИ
-- ═══════════════════════════════════════
local CONFIG = {
    -- GitHub
    github_user = "amyrka238",
    github_repo = "amyr_soft",
    github_branch = "main",
    github_path = "hvh/v2/v3/1.lua",
    
    -- Визуал
    enabled = true,
    size = 150,
    position_x = 0.5,  -- Center X (0-1)
    position_y = 0.85, -- Bottom (0-1)
    
    -- Эффекты
    rainbow = true,
    rainbow_speed = 0.003,
    breathing = true,
    breathing_speed = 1.5,
    breathing_intensity = 0.15,
    bounce = true,
    bounce_speed = 2.0,
    bounce_height = 15,
    
    -- Glow
    glow_enabled = true,
    glow_size = 1.5,
    glow_transparency = 0.7,
    
    -- Outline
    outline_thickness = 4,
    outline_color = Color3.fromRGB(0, 0, 0),
}

-- ═══════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════
local hue = 0
local breathTime = 0
local bounceTime = 0
local BASE64_IMAGE = nil
local imageLoaded = false

-- ═══════════════════════════════════════
-- ЗАГРУЗКА С GITHUB
-- ═══════════════════════════════════════
local function buildGitHubURL()
    return string.format(
        "https://raw.githubusercontent.com/%s/%s/refs/heads/%s/%s",
        CONFIG.github_user,
        CONFIG.github_repo,
        CONFIG.github_branch,
        CONFIG.github_path
    )
end

local function loadImageFromGitHub()
    local url = buildGitHubURL()
    print("📥 Loading from:", url)
    
    local success, result = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if not success then
        warn("❌ Failed to load from GitHub!")
        warn("Error:", result)
        return false
    end
    
    print("✅ Downloaded:", #result, "bytes")
    
    -- Парсим Base64
    local base64Data = result:match("data:image/[^;]+;base64,(.+)")
    
    if base64Data then
        BASE64_IMAGE = base64Data:gsub("%s+", "")
        imageLoaded = true
        print("✅ Base64 parsed! Size:", #BASE64_IMAGE, "chars")
        return true
    else
        -- Fallback: весь файл это Base64
        BASE64_IMAGE = result:gsub("%s+", "")
        imageLoaded = true
        print("✅ Raw Base64 loaded! Size:", #BASE64_IMAGE, "chars")
        return true
    end
end

-- Загружаем
local loadSuccess = loadImageFromGitHub()

if not loadSuccess then
    warn("⚠️ Failed to load image, using placeholder...")
end

-- ═══════════════════════════════════════
-- GUI CREATION
-- ═══════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FemboyMascot_" .. HttpService:GenerateGUID(false)
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Anti-detection
local function setupParent()
    if gethui then
        return gethui()
    elseif get_hidden_gui then
        return get_hidden_gui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        return game:GetService("CoreGui")
    else
        return game:GetService("CoreGui")
    end
end

pcall(function()
    ScreenGui.Parent = setupParent()
end)

if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

print("📺 GUI Parent:", ScreenGui.Parent:GetFullName())

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, CONFIG.size, 0, CONFIG.size)
MainFrame.BackgroundTransparency = 1
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(CONFIG.position_x, 0, CONFIG.position_y, 0)
MainFrame.Parent = ScreenGui

-- Glow Effect
local Glow = Instance.new("Frame")
Glow.Name = "Glow"
Glow.Size = UDim2.new(CONFIG.glow_size, 0, CONFIG.glow_size, 0)
Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
Glow.AnchorPoint = Vector2.new(0.5, 0.5)
Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glow.BackgroundTransparency = CONFIG.glow_transparency
Glow.BorderSizePixel = 0
Glow.ZIndex = 0
Glow.Visible = CONFIG.glow_enabled
Glow.Parent = MainFrame

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(1, 0)
GlowCorner.Parent = Glow

-- Image Label
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "Image"
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.BackgroundTransparency = 1
ImageLabel.ScaleType = Enum.ScaleType.Fit
ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Parent = MainFrame

-- Set Image
if imageLoaded and BASE64_IMAGE then
    local dataURI = "data:image/jpeg;base64," .. BASE64_IMAGE
    
    local imgSuccess = pcall(function()
        ImageLabel.Image = dataURI
    end)
    
    if imgSuccess then
        print("✅ Image displayed successfully!")
    else
        warn("⚠️ data: URI not supported by executor")
        ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        
        -- Info Label
        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Size = UDim2.new(1, 0, 0, 25)
        InfoLabel.Position = UDim2.new(0, 0, 1, 5)
        InfoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        InfoLabel.BackgroundTransparency = 0.3
        InfoLabel.BorderSizePixel = 0
        InfoLabel.Text = string.format("%.1fKB", #BASE64_IMAGE / 1024)
        InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        InfoLabel.TextSize = 10
        InfoLabel.Font = Enum.Font.GothamBold
        InfoLabel.Parent = MainFrame
        
        local InfoCorner = Instance.new("UICorner")
        InfoCorner.CornerRadius = UDim.new(0.2, 0)
        InfoCorner.Parent = InfoLabel
    end
else
    warn("❌ No image loaded!")
    ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

-- Corner
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.15, 0)
Corner.Parent = ImageLabel

-- Outline
local Outline = Instance.new("UIStroke")
Outline.Thickness = CONFIG.outline_thickness
Outline.Color = CONFIG.outline_color
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Outline.Parent = ImageLabel

-- ═══════════════════════════════════════
-- UTILITIES
-- ═══════════════════════════════════════
local function HSVToRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    else r, g, b = v, p, q
    end
    
    return Color3.fromRGB(r * 255, g * 255, b * 255)
end

local function getColor()
    if CONFIG.rainbow then
        hue = (hue + CONFIG.rainbow_speed) % 1.0
        return HSVToRGB(hue, 1, 1)
    end
    return Color3.fromRGB(255, 255, 255)
end

-- ═══════════════════════════════════════
-- UPDATE LOOP
-- ═══════════════════════════════════════
RunService.RenderStepped:Connect(function(deltaTime)
    if not CONFIG.enabled then
        MainFrame.Visible = false
        return
    end
    
    MainFrame.Visible = true
    
    -- Screen Size
    local screenSize = workspace.CurrentCamera.ViewportSize
    
    -- Position
    local x = screenSize.X * CONFIG.position_x
    local y = screenSize.Y * CONFIG.position_y
    
    -- Bounce Effect
    if CONFIG.bounce then
        bounceTime = bounceTime + (CONFIG.bounce_speed * deltaTime)
        local bounceOffset = math.abs(math.sin(bounceTime)) * CONFIG.bounce_height
        y = y - bounceOffset
    end
    
    MainFrame.Position = UDim2.new(0, x, 0, y)
    
    -- Breathing Effect
    local size = CONFIG.size
    if CONFIG.breathing then
        breathTime = breathTime + (CONFIG.breathing_speed * deltaTime)
        local breathMultiplier = 1 + (math.sin(breathTime) * CONFIG.breathing_intensity)
        size = size * breathMultiplier
    end
    
    MainFrame.Size = UDim2.new(0, size, 0, size)
    
    -- Rainbow Effect
    local color = getColor()
    ImageLabel.ImageColor3 = color
    Glow.BackgroundColor3 = color
    Outline.Color = color
end)

-- ═══════════════════════════════════════
-- KEYBINDS
-- ═══════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F6 then
        CONFIG.enabled = not CONFIG.enabled
        print("♥ Femboy:", CONFIG.enabled and "ENABLED" or "DISABLED")
        
    elseif input.KeyCode == Enum.KeyCode.F7 then
        CONFIG.rainbow = not CONFIG.rainbow
        print("🌈 Rainbow:", CONFIG.rainbow and "ON" or "OFF")
        
    elseif input.KeyCode == Enum.KeyCode.F8 then
        print("🔄 Reloading image from GitHub...")
        loadImageFromGitHub()
        
    elseif input.KeyCode == Enum.KeyCode.F9 then
        CONFIG.glow_enabled = not CONFIG.glow_enabled
        Glow.Visible = CONFIG.glow_enabled
        print("✨ Glow:", CONFIG.glow_enabled and "ON" or "OFF")
        
    elseif input.KeyCode == Enum.KeyCode.F10 then
        CONFIG.bounce = not CONFIG.bounce
        print("⬆️ Bounce:", CONFIG.bounce and "ON" or "OFF")
    end
end)

-- ═══════════════════════════════════════
-- GLOBAL API
-- ═══════════════════════════════════════
_G.FemboyMascot = {
    -- Controls
    toggle = function()
        CONFIG.enabled = not CONFIG.enabled
        return CONFIG.enabled
    end,
    
    enable = function()
        CONFIG.enabled = true
    end,
    
    disable = function()
        CONFIG.enabled = false
    end,
    
    destroy = function()
        ScreenGui:Destroy()
        print("♥ Femboy destroyed")
    end,
    
    -- Settings
    setSize = function(size)
        CONFIG.size = size
    end,
    
    setPosition = function(x, y)
        CONFIG.position_x = x
        CONFIG.position_y = y
    end,
    
    setRainbow = function(enabled)
        CONFIG.rainbow = enabled
    end,
    
    setRainbowSpeed = function(speed)
        CONFIG.rainbow_speed = speed
    end,
    
    setBounce = function(enabled)
        CONFIG.bounce = enabled
    end,
    
    setGlow = function(enabled)
        CONFIG.glow_enabled = enabled
        Glow.Visible = enabled
    end,
    
    -- Info
    reload = function()
        return loadImageFromGitHub()
    end,
    
    getImageSize = function()
        return BASE64_IMAGE and #BASE64_IMAGE or 0
    end,
    
    getConfig = function()
        return CONFIG
    end,
    
    isLoaded = function()
        return imageLoaded
    end,
}

-- ═══════════════════════════════════════
-- FINAL
-- ═══════════════════════════════════════
print("♥ FEMBOY MASCOT LOADED ♥")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🎮 Executor:", executor)
print("🖼️  Image:", imageLoaded and "LOADED ✅" or "FAILED ❌")
if imageLoaded then
    print("📊 Size:", string.format("%.1fKB", #BASE64_IMAGE / 1024))
end
print("━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("⌨️  CONTROLS:")
print("  F6  - Toggle On/Off")
print("  F7  - Toggle Rainbow")
print("  F8  - Reload Image")
print("  F9  - Toggle Glow")
print("  F10 - Toggle Bounce")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📝 API: _G.FemboyMascot")
print("♥ Enjoy! ♥")
