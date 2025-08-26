-- ╔══════════════════════════════════════════════════════════════╗
-- ║                    AMYR_SOFTIKK THEME LOADER                 ║
-- ║                    Free Edition v3.1 (Improved)              ║
-- ║                    t.me/amyr_softikk                         ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")

-- Variables
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    warn("AMYR Cheat Loader: Must run on client!")
    return
end

-- Configuration
local WATERMARK_TEXT = "ᴀᴍʏʀ_sᴏꜰᴛɪᴋᴋ | ᴛ.ᴍᴇ/ᴀᴍʏʀ_sᴏꜰᴛɪᴋᴋ"
local PHOTO_URL = "https://cdn4.telesco.pe/file/JLc0o5FG5L6rHhZW_UJ8P02UfNvDVPWsdf9uCNGZXTJsJEp5CCM5FAloYkCA8Dm2HgL7F0dq2z7y7nwMEdHIQaTNXEuudGilhuO31NRrxjJnUMPdF_1DAHgzsI8eUzanQqUs21TzmuuOkpYWWFRi3YEfsmo7igfrUOKgBJO1RPgVmQV4Wx6D26yzC3xdC8ztIuO5dwir5fsgqlRb9mFTRp4tMGpXAR9jRjsQHd9Cc7FtrBuX1-R-y3RktOrR0JunBtZqRArmfWB6kM2Fr08J1Msn25pAmpUlyA3IISu7-Z-zHBLm7Vp1DkP5jaA8t2bs7wE6Q7-SHSxPaZeTOGJC3Q.jpg"  -- External; won't load directly. Use placeholder.
local GITHUB_REPO = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/loader_version.txt"
local PLACEHOLDER_IMAGE = "rbxassetid://1847902752"  -- Replace with actual Roblox asset ID if uploaded

-- Theme Database
local themes = {
    { name = "Ocean Theme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20OceanTheme", desc = "Calm blue oceanic visuals" },
    { name = "Light Theme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20LightTheme", desc = "Bright and minimalistic design" },
    { name = "Midnight Theme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20Midnight", desc = "Dark night sky aesthetics" },
    { name = "Dark Theme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20DarkTheme", desc = "Classic dark mode" },
    { name = "BloodTheme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20BloodTheme", desc = "Intense red blood-inspired design" },
    { name = "GrapeTheme", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20GrapeTheme", desc = "Rich purple grape-inspired visuals" },
    { name = "Sentinel", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20Sentinel", desc = "Guardian-inspired theme" },
    { name = "Serpent", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20Serpent", desc = "Sly serpent-themed design" },
    { name = "Synapse", url = "https://raw.githubusercontent.com/amyrka238/amyr_soft/refs/heads/main/hvh/v2/Counter-Blox%20Synapse", desc = "Neural network-inspired visuals" }
}

-- Performance Monitor
local performanceStats = {
    fps = 0,
    ping = 0,
    memory = 0
}

-- Create GUI with maximum overlay priority
local function createScreenGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AMYR_CheatLoader_Free_" .. tick()
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 2147483647
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
    local success = pcall(function()
        screenGui.Parent = CoreGui
    end)
    
    if not success then
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        warn("AMYR Cheat Loader: CoreGui access denied, using PlayerGui fallback.")
    end
    
    return screenGui
end

-- Notification System (Improved: Added clipboard copy support, better error handling)
local NotificationSystem = {}
NotificationSystem.notifications = {}

function NotificationSystem:Show(title, message, type, duration, clipboardText)
    duration = duration or 4
    type = type or "info"
    
    local colors = {
        success = {Color3.fromRGB(76, 175, 80), "✓"},
        error = {Color3.fromRGB(244, 67, 54), "✗"},
        warning = {Color3.fromRGB(255, 193, 7), "⚠"},
        info = {Color3.fromRGB(33, 150, 243), "ℹ"}
    }
    
    local color, icon = unpack(colors[type] or colors.info)
    
    local notifGui = createScreenGui()
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 350, 0, 80)
    notification.Position = UDim2.new(1, 0, 0, 20 + #self.notifications * 90)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    notification.BorderSizePixel = 0
    notification.ZIndex = 2147483647
    notification.Parent = notifGui
    
    table.insert(self.notifications, notification)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 2
    stroke.Parent = notification
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }
    gradient.Rotation = 45
    gradient.Parent = notification
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 50, 1, 0)
    iconLabel.Position = UDim2.new(0, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = color
    iconLabel.TextSize = 24
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.ZIndex = 2147483647
    iconLabel.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 0, 30)
    titleLabel.Position = UDim2.new(0, 50, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 2147483647
    titleLabel.Parent = notification
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -60, 0, 25)
    messageLabel.Position = UDim2.new(0, 50, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    messageLabel.TextSize = 12
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.ZIndex = 2147483647
    messageLabel.Parent = notification
    
    -- Entrance animation
    notification.Position = UDim2.new(1, 370, 0, 20 + (#self.notifications - 1) * 90)
    local entranceTween = TweenService:Create(notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -370, 0, 20 + (#self.notifications - 1) * 90)}
    )
    entranceTween:Play()
    
    -- Play sound (with error handling)
    local successSound, sound = pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://".. (type == "success" and "9112804515" or "9112804647")
        s.Volume = 0.5
        s.Parent = SoundService
        s:Play()
        return s
    end)
    if not successSound then
        warn("Failed to play notification sound: " .. tostring(sound))
    end
    
    -- Clipboard copy if provided
    if clipboardText then
        local successClip, clipErr = pcall(setclipboard, clipboardText)
        if successClip then
            messageLabel.Text = message .. " (Скопировано в буфер обмена)"
        else
            warn("Clipboard copy failed: " .. tostring(clipErr))
            NotificationSystem:Show("Ошибка буфера", "Не удалось скопировать в буфер обмена.", "error", 3)
        end
    end
    
    -- Auto-remove
    spawn(function()
        wait(duration)
        local fadeTween = TweenService:Create(notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        )
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            local exitTween = TweenService:Create(notification,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Position = UDim2.new(1, 0, 0, notification.Position.Y.Offset)}
            )
            exitTween:Play()
            exitTween.Completed:Connect(function()
                notifGui:Destroy()
                if sound then sound:Destroy() end
                for i, v in ipairs(self.notifications) do
                    if v == notification then
                        table.remove(self.notifications, i)
                        break
                    end
                end
            end)
        end)
    end)
end

-- Animation Engine (Improved: Added more effects, optimized)
local AnimationEngine = {}

function AnimationEngine:Create(obj, info, properties, callback)
    local tween = TweenService:Create(obj, info, properties)
    tween:Play()
    if callback then
        tween.Completed:Connect(callback)
    end
    return tween
end

function AnimationEngine:Bounce(obj, scale, duration)
    scale = scale or 1.1
    duration = duration or 0.15
    
    local original = obj.Size
    self:Create(obj, 
        TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = original * scale},
        function()
            self:Create(obj,
                TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = original}
            )
        end
    )
end

function AnimationEngine:GlowPulse(obj, color1, color2, duration)
    duration = duration or 2
    local glow = Instance.new("UIStroke")
    glow.Color = color1
    glow.Thickness = 3
    glow.Transparency = 0.3
    glow.Parent = obj
    
    spawn(function()
        while glow.Parent do
            self:Create(glow,
                TweenInfo.new(duration/2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = color2, Transparency = 0.7}
            ):Wait()
            self:Create(glow,
                TweenInfo.new(duration/2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = color1, Transparency = 0.3}
            ):Wait()
        end
    end)
    
    return glow
end

function AnimationEngine:ShakeEffect(obj, intensity, duration)
    intensity = intensity or 5
    duration = duration or 0.5
    
    local originalPos = obj.Position
    spawn(function()
        local steps = duration * 60
        for i = 1, steps do
            if not obj.Parent then break end
            obj.Position = originalPos + UDim2.new(0, math.random(-intensity, intensity), 0, math.random(-intensity, intensity))
            RunService.Heartbeat:Wait()
        end
        if obj.Parent then
            obj.Position = originalPos
        end
    end)
end

function AnimationEngine:ParticleEffect(obj)
    local success, emitter = pcall(function()
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxassetid://243660364"
        particleEmitter.Lifetime = NumberRange.new(1, 2)
        particleEmitter.Rate = 20
        particleEmitter.Speed = NumberRange.new(5, 10)
        particleEmitter.Parent = obj
        return particleEmitter
    end)
    if not success then
        warn("Particle effect failed: " .. tostring(emitter))
    end
    return success and emitter or nil
end

-- Performance monitoring (Improved: More robust error handling)
spawn(function()
    while true do
        local success = pcall(function()
            performanceStats.fps = math.floor(1 / RunService.RenderStepped:Wait())
            if Stats.Network.ServerStatsItem and Stats.Network.ServerStatsItem["Data Ping"] then
                performanceStats.ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end
            performanceStats.memory = math.floor(Stats:GetTotalMemoryUsageMb())
        end)
        if not success then
            warn("Performance stats update failed.")
        end
        wait(1)
    end
end)

-- Safe HTTP Get (Unchanged, but used everywhere)
local function safeHttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    return success, result
end

-- Auto-update checker (Improved: Handle network errors)
local function checkForUpdate(currentVersion)
    local success, versionText = safeHttpGet(GITHUB_REPO)
    if success then
        if versionText and versionText ~= currentVersion then
            NotificationSystem:Show("Обновление!", "Доступна новая версия! Загрузи с GitHub.", "warning", 5)
        end
    else
        NotificationSystem:Show("Ошибка сети", "Не удалось проверить обновления.", "error", 3)
    end
end

-- Theme loading (Matched to robust: Destroy GUI, pcall loadstring(HttpGet()))
local function loadTheme(theme, button, screenGui)
    screenGui:Destroy()
    local ok, res = pcall(function()
        return loadstring(game:HttpGet(theme.url))()
    end)
    if not ok then
        warn("AMYR Cheat Loader: failed to load theme:", res)
        NotificationSystem:Show("Ошибка!", "Не удалось загрузить тему: " .. tostring(res), "error", 4, theme.url)
    end
end

-- Watermark: outline + animated gradient (чётко + переливание)
local watermarkGui = createScreenGui()

-- Общие параметры
local WATERMARK_TEXT = "ᴀᴍʏʀ_sᴏꜰᴛɪᴋᴋ | ᴛ.ᴍᴇ/ᴀᴍʏʀ_sᴏꜰᴛɪᴋᴋ"
local SIZE = UDim2.new(0, 350, 0, 40)
local POS = UDim2.new(1, -370, 1, -60)
local Z_MAIN = 2147483647

-- Нижний слой: плотный чёрный контур / тень для читаемости (усилен для +25% чёткости)
local outline = Instance.new("TextLabel")
outline.Name = "WatermarkOutline"
outline.Size = SIZE
outline.Position = POS
outline.BackgroundTransparency = 1
outline.Text = WATERMARK_TEXT
outline.TextColor3 = Color3.fromRGB(8, 8, 10) -- почти чёрный
outline.TextSize = 25 -- увеличено для большей чёткости (~25% больше)
outline.Font = Enum.Font.GothamBold
outline.TextXAlignment = Enum.TextXAlignment.Right
outline.ZIndex = Z_MAIN - 1
outline.Parent = watermarkGui

local outlineStroke = Instance.new("UIStroke")
outlineStroke.Thickness = 5        -- усиленный плотный контур
outlineStroke.Color = Color3.fromRGB(0, 0, 0)
outlineStroke.Transparency = 0
outlineStroke.Parent = outline

-- Верхний слой: градиент + тонкая обводка + glow
local main = Instance.new("TextLabel")
main.Name = "WatermarkMain"
main.Size = SIZE
main.Position = POS
main.BackgroundTransparency = 1
main.Text = WATERMARK_TEXT
main.TextColor3 = Color3.fromRGB(255, 255, 255) -- базовый (градиент наложится)
main.TextSize = 25 -- увеличено для большей чёткости (~25% больше)
main.Font = Enum.Font.GothamBold
main.TextXAlignment = Enum.TextXAlignment.Right
main.ZIndex = Z_MAIN
main.Parent = watermarkGui

-- Тонкая чёткая обводка у верхнего слоя (поддерживает неон)
local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2.6
mainStroke.Color = Color3.fromRGB(0, 200, 255)
mainStroke.Transparency = 0.05
mainStroke.Parent = main

-- Градиент для верхнего слоя (несколько контрольных точек — чтобы не было "одного синего")
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 200)),  -- циан
    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 200, 255)),  -- голубой
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(120, 120, 255)), -- мягкий синий
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(200, 80, 255)),  -- фиолетово-розовый
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 40, 220))   -- фиолетовый
}
gradient.Rotation = 0
gradient.Parent = main

-- Мягкий glow (анимируемый через AnimationEngine, но с небольшим разбросом)
AnimationEngine:GlowPulse(main, Color3.fromRGB(0, 200, 255), Color3.fromRGB(200, 80, 255), 3)

-- Анимация градиента: плавное смещение Offset, чтобы не было резкого "залива"
task.spawn(function()
    -- плавный цикл туда-сюда (более натурально, чем бесконечный сбег)
    local dir = 1
    local pos = 0
    while main.Parent do
        pos = pos + dir * 0.0025         -- скорость; уменьшай для медленнее
        if pos >= 1 then dir = -1; pos = 1 end
        if pos <= 0 then dir = 1; pos = 0 end
        gradient.Offset = Vector2.new(pos, 0)
        RunService.RenderStepped:Wait()
    end
end)

-- Toggle: при Delete скрываем оба слоя (плавно)
local visible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Delete then
        visible = not visible
        AnimationEngine:Create(main, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = visible and 0 or 1})
        AnimationEngine:Create(outline, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency = visible and 0 or 1})
        AnimationEngine:Create(mainStroke, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Transparency = visible and 0.05 or 1})
        AnimationEngine:Create(outlineStroke, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Transparency = visible and 0 or 1})
    end
end)


-- [Остальная часть кода до buildUI остается без изменений]

-- Main UI Builder
local function buildUI()
    local screenGui = createScreenGui()
    
    -- Performance HUD (без изменений)
    local perfHUD = Instance.new("Frame")
    perfHUD.Name = "PerformanceHUD"
    perfHUD.Size = UDim2.new(0, 180, 0, 90)
    perfHUD.Position = UDim2.new(0, 20, 0, 20)
    perfHUD.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    perfHUD.BackgroundTransparency = 0.3
    perfHUD.BorderSizePixel = 0
    perfHUD.Visible = false
    perfHUD.ZIndex = 2147483647
    perfHUD.Parent = screenGui
    
    local hudCorner = Instance.new("UICorner")
    hudCorner.CornerRadius = UDim.new(0, 8)
    hudCorner.Parent = perfHUD
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, -10, 0, 25)
    fpsLabel.Position = UDim2.new(0, 5, 0, 5)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: Calculating..."
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.TextSize = 12
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.ZIndex = 2147483647
    fpsLabel.Parent = perfHUD
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, -10, 0, 25)
    pingLabel.Position = UDim2.new(0, 5, 0, 30)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "PING: Calculating..."
    pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    pingLabel.TextSize = 12
    pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextXAlignment = Enum.TextXAlignment.Left
    pingLabel.ZIndex = 2147483647
    pingLabel.Parent = perfHUD
    
    local memLabel = Instance.new("TextLabel")
    memLabel.Size = UDim2.new(1, -10, 0, 25)
    memLabel.Position = UDim2.new(0, 5, 0, 55)
    memLabel.BackgroundTransparency = 1
    memLabel.Text = "RAM: Calculating..."
    memLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
    memLabel.TextSize = 12
    memLabel.Font = Enum.Font.GothamBold
    memLabel.TextXAlignment = Enum.TextXAlignment.Left
    memLabel.ZIndex = 2147483647
    memLabel.Parent = perfHUD
    
    spawn(function()
        while perfHUD.Parent do
            pcall(function()
                fpsLabel.Text = "FPS: " .. performanceStats.fps
                pingLabel.Text = "PING: " .. (performanceStats.ping > 0 and performanceStats.ping .. "ms" or "N/A")
                memLabel.Text = "RAM: " .. performanceStats.memory .. "MB"
                
                fpsLabel.TextColor3 = performanceStats.fps >= 240 and Color3.fromRGB(0, 255, 0) or (performanceStats.fps >= 30 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0))
                pingLabel.TextColor3 = performanceStats.ping < 240 and Color3.fromRGB(0, 255, 0) or (performanceStats.ping < 100 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0))
            end)
            wait(1)
        end
    end)
    
    -- Make HUD draggable with bounds
    local draggingHUD = false
    local dragStartHUD, startPosHUD
    perfHUD.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingHUD = true
            dragStartHUD = input.Position
            startPosHUD = perfHUD.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingHUD and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartHUD
            local newPos = UDim2.new(startPosHUD.X.Scale, startPosHUD.X.Offset + delta.X, startPosHUD.Y.Scale, startPosHUD.Y.Offset + delta.Y)
            -- Clamp to screen
            local screenSize = screenGui.AbsoluteSize
            local hudSize = perfHUD.AbsoluteSize
            local clampedX = math.clamp(newPos.X.Offset, 0, screenSize.X - hudSize.X)
            local clampedY = math.clamp(newPos.Y.Offset, 0, screenSize.Y - hudSize.Y)
            perfHUD.Position = UDim2.new(0, clampedX, 0, clampedY)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingHUD = false
        end
    end)
    
    -- Fullscreen overlay
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 2147483646
    overlay.Parent = screenGui
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center initially
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.ZIndex = 2147483647
    mainFrame.Parent = overlay
    
    -- Ensure mainFrame stays within screen bounds on creation
    local screenSize = screenGui.AbsoluteSize
    local frameSize = mainFrame.AbsoluteSize
    local halfWidth = frameSize.X / 2
    local halfHeight = frameSize.Y / 2
    local clampedX = math.clamp(mainFrame.Position.X.Offset, halfWidth, screenSize.X - halfWidth)
    local clampedY = math.clamp(mainFrame.Position.Y.Offset, halfHeight, screenSize.Y - halfHeight)
    mainFrame.Position = UDim2.new(0.5, clampedX, 0.5, clampedY)
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 20)
    mainCorner.Parent = mainFrame
    
    local bgGradient = Instance.new("UIGradient")
    bgGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
    }
    bgGradient.Rotation = 45
    bgGradient.Parent = mainFrame
    
    AnimationEngine:GlowPulse(mainFrame, Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 255), 4)
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 120)
    header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    header.BorderSizePixel = 0
    header.ZIndex = 2147483647
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 20)
    headerCorner.Parent = header
    
    local mainTitle = Instance.new("TextLabel")
    mainTitle.Size = UDim2.new(1, -140, 0, 40)
    mainTitle.Position = UDim2.new(0, 20, 0, 15)
    mainTitle.BackgroundTransparency = 1
    mainTitle.Text = "AMYR Cheat LOADER"
    mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainTitle.TextSize = 28
    mainTitle.Font = Enum.Font.GothamBold
    mainTitle.TextXAlignment = Enum.TextXAlignment.Left
    mainTitle.ZIndex = 2147483647
    mainTitle.Parent = header
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -140, 0, 20)
    subtitle.Position = UDim2.new(0, 20, 0, 55)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Free Edition v3.1 (Improved)"
    subtitle.TextColor3 = Color3.fromRGB(0, 255, 255)
    subtitle.TextSize = 14
    subtitle.Font = Enum.Font.GothamSemibold
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.ZIndex = 2147483647
    subtitle.Parent = header
    
    local description = Instance.new("TextLabel")
    description.Size = UDim2.new(1, -140, 0, 15)
    description.Position = UDim2.new(0, 20, 0, 75)
    description.BackgroundTransparency = 1
    description.Text = "Выберите тему для загрузки (улучшенное меню)"
    description.TextColor3 = Color3.fromRGB(150, 150, 150)
    description.TextSize = 12
    description.Font = Enum.Font.Gotham
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.ZIndex = 2147483647
    description.Parent = header
    
    -- Telegram frame
    local tgFrame = Instance.new("Frame")
    tgFrame.Size = UDim2.new(0, 200, 0, 30)
    tgFrame.Position = UDim2.new(0, 20, 0, 90)
    tgFrame.BackgroundTransparency = 1
    tgFrame.Parent = header
    
    local photoLabel = Instance.new("ImageLabel")
    photoLabel.Size = UDim2.new(0, 30, 0, 30)
    photoLabel.Position = UDim2.new(0, 0, 0, 0)
    photoLabel.BackgroundTransparency = 1
    photoLabel.Image = PLACEHOLDER_IMAGE
    photoLabel.ZIndex = 2147483647
    photoLabel.Parent = tgFrame
    
    local tgLabel = Instance.new("TextButton")
    tgLabel.Size = UDim2.new(0, 170, 0, 30)
    tgLabel.Position = UDim2.new(0, 35, 0, 0)
    tgLabel.BackgroundTransparency = 1
    tgLabel.Text = "t.me/amyr_softikk"
    tgLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    tgLabel.TextSize = 14
    tgLabel.Font = Enum.Font.GothamBold
    tgLabel.ZIndex = 2147483647
    tgLabel.Parent = tgFrame
    
    tgLabel.MouseButton1Click:Connect(function()
        NotificationSystem:Show("Telegram", "Ссылка скопирована в буфер обмена!", "info", 3, "https://t.me/amyr_softikk")
    end)
    
    -- Performance toggle
    local perfToggle = Instance.new("TextButton")
    perfToggle.Size = UDim2.new(0, 100, 0, 30)
    perfToggle.Position = UDim2.new(1, -220, 0, 15)
    perfToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    perfToggle.Text = "FPS HUD"
    perfToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    perfToggle.TextSize = 12
    perfToggle.Font = Enum.Font.GothamBold
    perfToggle.ZIndex = 2147483647
    perfToggle.Parent = header
    
    local perfCorner = Instance.new("UICorner")
    perfCorner.CornerRadius = UDim.new(0, 8)
    perfCorner.Parent = perfToggle
    
    perfToggle.MouseButton1Click:Connect(function()
        perfHUD.Visible = not perfHUD.Visible
        AnimationEngine:Bounce(perfToggle)
    end)
    
    -- Reset position button (Fixed)
    local resetButton = Instance.new("TextButton")
    resetButton.Size = UDim2.new(0, 100, 0, 30)
    resetButton.Position = UDim2.new(1, -120, 0, 15)
    resetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    resetButton.Text = "Сброс позиции"
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 12
    resetButton.Font = Enum.Font.GothamBold
    resetButton.ZIndex = 2147483647
    resetButton.Parent = header
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 8)
    resetCorner.Parent = resetButton
    
    resetButton.MouseButton1Click:Connect(function()
        -- Dynamically calculate center position
        local screenSize = screenGui.AbsoluteSize
        local frameSize = mainFrame.AbsoluteSize
        local centerX = screenSize.X / 2 - frameSize.X / 2
        local centerY = screenSize.Y / 2 - frameSize.Y / 2
        mainFrame.Position = UDim2.new(0.5, centerX, 0.5, centerY)
        print("Reset position to:", mainFrame.Position) -- Debug output
        AnimationEngine:Bounce(resetButton)
    end)
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -60, 0, 60)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    closeButton.Text = "—"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.ZIndex = 2147483647
    closeButton.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 20)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        AnimationEngine:Create(mainFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)},
            function()
                screenGui:Destroy()
            end
        )
    end)
    
    -- Content area with scrolling
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -40, 1, -160)
    content.Position = UDim2.new(0, 20, 0, 140)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 10 -- Увеличена толщина ползунка для удобства
    content.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255) -- Яркий цвет ползунка
    content.ScrollingDirection = Enum.ScrollingDirection.Y
    content.ZIndex = 2147483647
    content.CanvasSize = UDim2.new(0, 0, 0, #themes * 100 + 20)
    content.Parent = mainFrame
    
    -- Search bar
    local searchBar = Instance.new("TextBox")
    searchBar.Size = UDim2.new(1, -140, 0, 30)
    searchBar.Position = UDim2.new(0, 20, 0, 95)
    searchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    searchBar.Text = "Поиск тем..."
    searchBar.TextColor3 = Color3.fromRGB(150, 150, 150)
    searchBar.TextSize = 14
    searchBar.Font = Enum.Font.Gotham
    searchBar.ZIndex = 2147483647
    searchBar.Parent = header
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchBar
    
    -- Theme buttons
local colors = {
    Color3.fromRGB(64, 128, 200),   -- Ocean Theme (Calm blue oceanic visuals)
    Color3.fromRGB(220, 220, 220),  -- Light Theme (Bright and minimalistic design)
    Color3.fromRGB(60, 80, 140),    -- Midnight Theme (Dark night sky aesthetics)
    Color3.fromRGB(40, 40, 40),     -- Dark Theme (Classic dark mode)
    Color3.fromRGB(139, 0, 0),      -- BloodTheme (Intense red blood-inspired design)
    Color3.fromRGB(40, 40, 40),     -- DarkTheme (Classic dark mode, повторение для консистентности)
    Color3.fromRGB(106, 90, 205),   -- GrapeTheme (Rich purple grape-inspired visuals)
    Color3.fromRGB(220, 220, 220),  -- LightTheme (Bright and minimalistic design, повторение)
    Color3.fromRGB(60, 80, 140),    -- Midnight (Dark night sky aesthetics, повторение)
    Color3.fromRGB(64, 128, 200),   -- OceanTheme (Calm blue oceanic visuals, повторение)
    Color3.fromRGB(128, 128, 128),  -- Sentinel (Guardian-inspired theme)
    Color3.fromRGB(34, 139, 34),    -- Serpent (Sly serpent-themed design)
    Color3.fromRGB(75, 0, 130)      -- Synapse (Neural network-inspired visuals)
}
    
    local function updateThemes(filter)
        filter = filter:lower()
        local yOffset = 0
        for _, child in ipairs(content:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        for i, theme in ipairs(themes) do
            if theme.name:lower():find(filter) or theme.desc:lower():find(filter) or filter == "" or filter == "поиск тем..." then
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1, -20, 0, 80)
                button.Position = UDim2.new(0, 10, 0, yOffset)
                button.BackgroundColor3 = colors[i] or Color3.fromRGB(64, 128, 200)
                button.Text = theme.name
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.TextSize = 18
                button.Font = Enum.Font.GothamBold
                button.AutoButtonColor = false
                button.ZIndex = 2147483647
                button.Parent = content
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 15)
                btnCorner.Parent = button
                
                local btnStroke = Instance.new("UIStroke")
                btnStroke.Color = Color3.fromRGB(255, 255, 255)
                btnStroke.Thickness = 2
                btnStroke.Transparency = 0.8
                btnStroke.Parent = button
                
                local descLabel = Instance.new("TextLabel")
                descLabel.Size = UDim2.new(1, -20, 0, 30)
                descLabel.Position = UDim2.new(0, 10, 0, 40)
                descLabel.BackgroundTransparency = 1
                descLabel.Text = theme.desc
                descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                descLabel.TextSize = 12
                descLabel.Font = Enum.Font.Gotham
                descLabel.TextXAlignment = Enum.TextXAlignment.Left
                descLabel.TextWrapped = true
                descLabel.ZIndex = 2147483647
                descLabel.Parent = button
                
                AnimationEngine:GlowPulse(button, colors[i] or Color3.fromRGB(64, 128, 200), Color3.fromRGB(255, 255, 255), 3)
                
                button.MouseEnter:Connect(function()
                    AnimationEngine:Create(button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, -15, 0, 85),
                            BackgroundColor3 = (colors[i] or Color3.fromRGB(64, 128, 200)):Lerp(Color3.fromRGB(255, 255, 255), 0.2)
                        }
                    )
                    AnimationEngine:ParticleEffect(button)
                end)
                
                button.MouseLeave:Connect(function()
                    AnimationEngine:Create(button,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, -20, 0, 80),
                            BackgroundColor3 = colors[i] or Color3.fromRGB(64, 128, 200)
                        }
                    )
                end)
                
                button.MouseButton1Click:Connect(function()
                    loadTheme(theme, button, screenGui)
                end)
                
                -- Entrance animation
                button.Position = UDim2.new(-1, 0, 0, yOffset)
                AnimationEngine:Create(button,
                    TweenInfo.new(0.5 + i * 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0, 10, 0, yOffset)}
                )
                
                yOffset = yOffset + 100
            end
        end
        content.CanvasSize = UDim2.new(0, 0, 0, math.max(yOffset, content.AbsoluteSize.Y)) -- Ensure CanvasSize is sufficient
    end
    
    updateThemes("")
    
    searchBar.FocusLost:Connect(function()
        updateThemes(searchBar.Text)
    end)
    
    searchBar.Focused:Connect(function()
        if searchBar.Text == "Поиск тем..." then
            searchBar.Text = ""
        end
    end)
    
    -- Draggable main frame with improved bounds
    local dragging = false
    local dragStart, startPos, lastDelta = nil, nil, Vector2.new(0, 0)
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            -- Clamp to screen (accounting for AnchorPoint 0.5,0.5)
            local screenSize = screenGui.AbsoluteSize
            local frameSize = mainFrame.AbsoluteSize
            local halfWidth = frameSize.X / 2
            local halfHeight = frameSize.Y / 2
            local clampedX = math.clamp(newPos.X.Offset, halfWidth, screenSize.X - halfWidth)
            local clampedY = math.clamp(newPos.Y.Offset, halfHeight, screenSize.Y - halfHeight)
            mainFrame.Position = UDim2.new(0.5, clampedX, 0.5, clampedY)
            lastDelta = delta
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            spawn(function()
                local inertia = lastDelta / 10
                while math.abs(inertia.X) > 0.1 or math.abs(inertia.Y) > 0.1 do
                    local newPos = mainFrame.Position + UDim2.new(0, inertia.X, 0, inertia.Y)
                    local screenSize = screenGui.AbsoluteSize
                    local frameSize = mainFrame.AbsoluteSize
                    local halfWidth = frameSize.X / 2
                    local halfHeight = frameSize.Y / 2
                    local clampedX = math.clamp(newPos.X.Offset, halfWidth, screenSize.X - halfWidth)
                    local clampedY = math.clamp(newPos.Y.Offset, halfHeight, screenSize.Y - halfHeight)
                    mainFrame.Position = UDim2.new(0.5, clampedX, 0.5, clampedY)
                    inertia = inertia * 0.95
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    end)
    
    -- Entrance animations
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1
    
    AnimationEngine:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5})
    AnimationEngine:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 600)})
    
    -- Welcome
    wait(1)
    NotificationSystem:Show("Добро пожаловать!", "Улучшенный AMYR Cheat Loader запущен! Delete - watermark, F1 - HUD, F2 - меню.", "info", 3)
    
    print("AMYR Cheat Loader Free: Initialized successfully!")
    
    checkForUpdate("v3.1")
end

-- Build UI with error handling
local success, err = pcall(buildUI)
if not success then
    warn("AMYR Cheat Loader: Failed to build UI:", err)
    NotificationSystem:Show("Ошибка!", "Не удалось построить UI: " .. tostring(err), "error", 5)
end

-- Keyboard shortcuts (Unchanged)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        pcall(function()
            local gui = CoreGui:FindFirstChildWhichIsA("ScreenGui") or LocalPlayer.PlayerGui:FindFirstChildWhichIsA("ScreenGui")
            if gui then
                local hud = gui:FindFirstChild("PerformanceHUD")
                if hud then
                    hud.Visible = not hud.Visible
                end
            end
        end)
    elseif input.KeyCode == Enum.KeyCode.F2 then
        buildUI()
    end
end)

-- Auto-hint
spawn(function()
    wait(3)
    NotificationSystem:Show("Подсказка", "F1 - FPS HUD, F2 - открыть меню, Delete - watermark", "info", 4)
end)

-- Cleanup
game.Players.PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        pcall(function()
            for _, gui in pairs(CoreGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name:find("AMYR_CheatLoader_Free_") then
                    gui:Destroy()
                end
            end
            for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name:find("AMYR_CheatLoader_Free_") then
                    gui:Destroy()
                end
            end
            watermarkGui:Destroy()
        end)
    end
end)
