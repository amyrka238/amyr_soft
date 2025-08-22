-------------------------------------------------------
-- Вкладка Weather
-------------------------------------------------------
local WeatherTab = Window:NewTab("Weather")
local WeatherSection = WeatherTab:NewSection("Эффекты")

-- Туман
WeatherSection:NewSlider("🌫️ Туман", "Регулировка FogEnd", 1000, 50, function(v)
    game.Lighting.FogEnd = v
end)

-- Дождь
WeatherSection:NewButton("🌧️ Включить дождь", "Добавить частицы дождя", function()
    if not game.Workspace:FindFirstChild("RainPart") then
        local part = Instance.new("Part", game.Workspace)
        part.Name = "RainPart"
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.Size = Vector3.new(1,1,1)
        part.Position = game.Players.LocalPlayer.Character.Head.Position + Vector3.new(0, 20, 0)

        local emitter = Instance.new("ParticleEmitter", part)
        emitter.Texture = "rbxassetid://241876605" -- текстура дождя
        emitter.Rate = 500
        emitter.Lifetime = NumberRange.new(1,2)
        emitter.Speed = NumberRange.new(40,60)
        emitter.VelocitySpread = 180
    end
end)

WeatherSection:NewButton("⛅ Выключить дождь", "Убрать дождь", function()
    if game.Workspace:FindFirstChild("RainPart") then
        game.Workspace.RainPart:Destroy()
    end
end)

-------------------------------------------------------
-- Вкладка Visual
-------------------------------------------------------
local VisualTab = Window:NewTab("Visual")
local VisualSection = VisualTab:NewSection("Внешний вид")

-- Скайбокс
VisualSection:NewButton("🌌 Ночной Skybox", "Заменить на звёздное небо", function()
    local sky = Instance.new("Sky")
    sky.Parent = game.Lighting
    sky.SkyboxBk = "rbxassetid://12064107"
    sky.SkyboxDn = "rbxassetid://12064152"
    sky.SkyboxFt = "rbxassetid://12064121"
    sky.SkyboxLf = "rbxassetid://12063984"
    sky.SkyboxRt = "rbxassetid://12064115"
    sky.SkyboxUp = "rbxassetid://12064131"
end)

VisualSection:NewButton("☁️ Стандартный Skybox", "Убрать кастомный sky", function()
    for _,v in pairs(game.Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
end)

-------------------------------------------------------
-- Вкладка Other
-------------------------------------------------------
local OtherTab = Window:NewTab("Other")
local OtherSection = OtherTab:NewSection("Прочее")

-- День / Ночь
OtherSection:NewButton("☀️ День", "Установить время дня", function()
    game.Lighting.ClockTime = 14 -- день
end)

OtherSection:NewButton("🌙 Ночь", "Установить ночь", function()
    game.Lighting.ClockTime = 0 -- ночь
end)

-- Слайдер для точного времени
OtherSection:NewSlider("⏰ Время суток", "Меняет Lighting.ClockTime", 24, 0, function(v)
    game.Lighting.ClockTime = v
end)
