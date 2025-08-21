--[[
  Ultra Hybrid ESP for Roblox
  Features:
  - Max distance 999999999999
  - 144 FPS rendering
  - English menu
  - Auto-cleanup system
  - Optimized performance
  - Simplified menu sections
  - Skeletons, Tracers, Aimbot, Bunny Hop, and Chams
--]]

-- Settings
local Settings = {
    ESP = {
        Enabled = false,
        Box = true,
        HealthBar = true,
        Name = true,
        TeamCheck = true,
        Font = Drawing.Fonts.UI,
        TextSize = 18,
        BoxColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
        MaxDistance = 999999999999,
        TargetFPS = 144,
        AutoCleanup = {
            Enabled = false,
            Interval = 0.25
        }
    },
    Skeletons = {
        Enabled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1,
        IgnoreTeamCheck = false,
        MaxDistance = 999999999999,
        TargetFPS = 144
    },
    Tracers = {
        Enabled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1,
        From = "Bottom" -- "Center" or "Bottom"
    },
    Aimbot = {
        Enabled = false,
        Radius = 999,
        Key = Enum.KeyCode.E
    },
    BHop = {
        Enabled = false,
        GroundSpeed = 20,
        JumpSpeed = 200,
        JumpHeight = 25,
        MovementThreshold = 0.1
    },
    Chams = {
        Enabled = false,
        EnemyColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
        Transparency = 0.5,
        VisibilityMode = "ThroughWalls",
        OutlineEnabled = true,
        OutlineColor = Color3.fromRGB(255, 255, 255),
        OutlineThickness = 1,
        Material = Enum.Material.Neon
    }
}

-- Service caching
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Menu (Kavo UI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("t.me/amyr_softikk", "LightTheme")

-- Menu toggle
UserInputService.InputBegan:Connect(function(input, _)
    if input.KeyCode == Enum.KeyCode.Insert then
        Library:ToggleUI()
    end
end)

-- Menu setup with simplified sections
local RageTab = Window:NewTab("Rage")
local LegitTab = Window:NewTab("Legit")
local VisualsTab = Window:NewTab("Visuals")
local MiscTab = Window:NewTab("Misc")

-- Rage settings

-- Legit settings
local LegitSection = LegitTab:NewSection("Legitbot Settings")
-- Add legit features here...

-- Visuals settings
local VisualsSection = VisualsTab:NewSection("ESP Settings")
VisualsSection:NewToggle("Enable ESP", "Toggle ESP", function(state)
    Settings.ESP.Enabled = state
    if not state then ClearAllESP() end
end)
VisualsSection:NewToggle("Show Box", "Toggle 2D Box", function(state)
    Settings.ESP.Box = state
    UpdateAllESP()
end)
VisualsSection:NewToggle("Show Health", "Toggle health bar", function(state)
    Settings.ESP.HealthBar = state
    UpdateAllESP()
end)
VisualsSection:NewToggle("Show Names", "Toggle player names", function(state)
    Settings.ESP.Name = state
    UpdateAllESP()
end)
VisualsSection:NewToggle("Team Check", "Ignore teammates", function(state)
    Settings.ESP.TeamCheck = state
    UpdateAllESP()
end)
VisualsSection:NewButton("Clear ESP", "Remove all ESP objects", ClearAllESP)

-- Skeletons settings
local SkeletonsSection = VisualsTab:NewSection("Skeletons")
SkeletonsSection:NewToggle("Enable Skeletons", "Enable/disable skeletons", function(state)
    Settings.Skeletons.Enabled = state
    if not state then ClearAllSkeletons() end
end)
SkeletonsSection:NewColorPicker("Skeleton Color", "Color of skeleton lines", Settings.Skeletons.Color, function(color)
    Settings.Skeletons.Color = color
    UpdateAllSkeletons()
end)
SkeletonsSection:NewSlider("Skeleton Thickness", "Line thickness (1-5)", 5, 1, Settings.Skeletons.Thickness, function(value)
    Settings.Skeletons.Thickness = value
    UpdateAllSkeletons()
end)
SkeletonsSection:NewToggle("Skeletons on Teammates", "Show skeletons on teammates", function(state)
    Settings.Skeletons.IgnoreTeamCheck = state
    UpdateAllSkeletons()
end)
SkeletonsSection:NewSlider("Max Distance", "Skeletons render distance", 999999999999, 100, Settings.Skeletons.MaxDistance, function(value)
    Settings.Skeletons.MaxDistance = value
end)
SkeletonsSection:NewSlider("Target FPS", "Skeletons refresh rate", 144, 30, Settings.Skeletons.TargetFPS, function(value)
    Settings.Skeletons.TargetFPS = value
end)
SkeletonsSection:NewButton("Clear Skeletons", "Remove all skeleton objects", ClearAllSkeletons)

-- Tracers settings
local TracersSection = VisualsTab:NewSection("Tracers")
TracersSection:NewToggle("Enable Tracers", "Enable/disable tracers", function(state)
    Settings.Tracers.Enabled = state
    if not state then ClearAllTracers() end
end)
TracersSection:NewColorPicker("Tracer Color", "Color of tracers", Settings.Tracers.Color, function(color)
    Settings.Tracers.Color = color
    UpdateAllTracers()
end)
TracersSection:NewSlider("Tracer Thickness", "Thickness (1-5)", 5, 1, Settings.Tracers.Thickness, function(value)
    Settings.Tracers.Thickness = value
    UpdateAllTracers()
end)
TracersSection:NewDropdown("Tracer Origin", "Start point", {"Bottom", "Center"}, function(value)
    Settings.Tracers.From = value
    UpdateAllTracers()
end)
TracersSection:NewButton("Clear Tracers", "Remove all tracer objects", ClearAllTracers)

-- Chams settings
local ChamsSection = VisualsTab:NewSection("Chams Settings")
ChamsSection:NewToggle("Enable Chams", "Enable/disable Chams", function(state)
    Settings.Chams.Enabled = state
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Chams",
        Text = state and "Enabled" or "Disabled",
        Duration = 3
    })
end)
ChamsSection:NewColorPicker("Enemy Color", "Color for enemies", Settings.Chams.EnemyColor, function(color)
    Settings.Chams.EnemyColor = color
end)
ChamsSection:NewColorPicker("Team Color", "Color for teammates", Settings.Chams.TeamColor, function(color)
    Settings.Chams.TeamColor = color
end)
ChamsSection:NewSlider("Transparency", "Chams transparency (0-1)", 1, 0, Settings.Chams.Transparency, function(value)
    Settings.Chams.Transparency = value
end)
ChamsSection:NewDropdown("Visibility Mode", "How to display Chams", {"ThroughWalls", "Always"}, function(value)
    Settings.Chams.VisibilityMode = value
end)
ChamsSection:NewToggle("Enable Outline", "Enable/disable outline", function(state)
    Settings.Chams.OutlineEnabled = state
end)
ChamsSection:NewColorPicker("Outline Color", "Outline color", Settings.Chams.OutlineColor, function(color)
    Settings.Chams.OutlineColor = color
end)
ChamsSection:NewSlider("Outline Thickness", "Outline thickness (0-5)", 5, 0, Settings.Chams.OutlineThickness, function(value)
    Settings.Chams.OutlineThickness = value
end)
ChamsSection:NewDropdown("Material", "Select material", {
    "Plastic", "Metal", "Neon", "Glass", "ForceField", "SmoothPlastic"
}, function(value)
    Settings.Chams.Material = Enum.Material[value]
end)

-- Misc settings
local MiscSection = MiscTab:NewSection("Performance")
MiscSection:NewToggle("Auto Cleanup", "Automatically clear ESP", function(state)
    Settings.ESP.AutoCleanup.Enabled = state
end)
MiscSection:NewSlider("Cleanup Interval", "Seconds between cleanups", 1, 0.1, Settings.ESP.AutoCleanup.Interval, function(val)
    Settings.ESP.AutoCleanup.Interval = val
end)
MiscSection:NewSlider("Max Distance", "ESP render distance", 999999999999, 100, Settings.ESP.MaxDistance, function(value)
    Settings.ESP.MaxDistance = value
end)
MiscSection:NewSlider("Target FPS", "ESP refresh rate", 144, 30, Settings.ESP.TargetFPS, function(value)
    Settings.ESP.TargetFPS = value
end)

-- Bunny Hop
local BHopSettings = {
    Enabled = false,
    GroundSpeed = 20,
    JumpSpeed = 200,
    JumpHeight = 25,
    MovementThreshold = 0.1
}

local MiscSection = MiscTab:NewSection("Bunny Hop")
MiscSection:NewToggle("BHop", "Enable bunny hop", function(state)
    BHopSettings.Enabled = state
    if state then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "BHop",
            Text = "Enabled! Hold SPACE to jump",
            Duration = 3
        })
    end
    print("[BHop] Enabled set to: " .. tostring(BHopSettings.Enabled))
end)

MiscSection:NewSlider("Speed", "Ground speed", 50, 10, BHopSettings.GroundSpeed, function(value)
    BHopSettings.GroundSpeed = value
    BHopSettings.JumpSpeed = value * 10
end)

MiscSection:NewSlider("Jump Height", "Jump height", 50, 10, BHopSettings.JumpHeight, function(value)
    BHopSettings.JumpHeight = value
end)

local function PreciseBHop()
    if not BHopSettings.Enabled then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local camera = workspace.CurrentCamera
    local lookVector = camera.CFrame.LookVector
    lookVector = Vector3.new(lookVector.X, 0, lookVector.Z).Unit
    
    local rightVector = camera.CFrame.RightVector
    rightVector = Vector3.new(rightVector.X, 0, rightVector.Z).Unit
    
    local forwardAmount = 0
    local backwardAmount = 0
    local rightAmount = 0
    local leftAmount = 0
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then forwardAmount = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then backwardAmount = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then rightAmount = 1 end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then leftAmount = 1 end
    
    local moveDirection = (lookVector * (forwardAmount - backwardAmount) + rightVector * (rightAmount - leftAmount))
    if moveDirection.Magnitude > BHopSettings.MovementThreshold then
        moveDirection = moveDirection.Unit
    else
        moveDirection = Vector3.new(0, 0, 0)
    end
    
    local onGround = humanoid.FloorMaterial ~= Enum.Material.Air
    local spacePressed = UserInputService:IsKeyDown(Enum.KeyCode.Space)
    
    if onGround and not spacePressed then
        if moveDirection.Magnitude > BHopSettings.MovementThreshold then
            local currentVelocity = rootPart.Velocity
            local newVelocity = moveDirection * BHopSettings.GroundSpeed
            rootPart.Velocity = Vector3.new(newVelocity.X, currentVelocity.Y, newVelocity.Z)
        end
        return
    end
    
    if onGround and spacePressed and moveDirection.Magnitude > BHopSettings.MovementThreshold then
        humanoid.JumpPower = BHopSettings.JumpHeight
        humanoid.Jump = true
        
        local currentVelocity = rootPart.Velocity
        local newVelocity = moveDirection * BHopSettings.GroundSpeed
        rootPart.Velocity = Vector3.new(newVelocity.X, currentVelocity.Y, newVelocity.Z)
    elseif not onGround and moveDirection.Magnitude > BHopSettings.MovementThreshold then
        local currentVelocity = rootPart.Velocity
        local newVelocity = moveDirection * BHopSettings.JumpSpeed
        rootPart.Velocity = Vector3.new(newVelocity.X, currentVelocity.Y, newVelocity.Z)
    end
end

RunService.RenderStepped:Connect(function()
    pcall(PreciseBHop)
end)
-- Object management
local ESPObjects = {}
local ActiveRenderConnections = {}
local SkeletonObjects = {}
local SkeletonRenderConnections = {}
local TracerObjects = {}


-- Clear all ESP objects
function ClearAllESP()
    for _, connection in pairs(ActiveRenderConnections) do
        connection:Disconnect()
    end
    ActiveRenderConnections = {}
    for _, obj in pairs(ESPObjects) do
        if obj.Box then obj.Box:Remove() end
        if obj.HealthBar then obj.HealthBar:Remove() end
        if obj.NameTag then obj.NameTag:Remove() end
    end
    ESPObjects = {}
    collectgarbage()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ESP",
        Text = "ESP cleared!",
        Duration = 1
    })
end

-- Clear all skeleton objects
function ClearAllSkeletons()
    for _, connection in pairs(SkeletonRenderConnections) do
        connection:Disconnect()
    end
    SkeletonRenderConnections = {}
    for _, obj in pairs(SkeletonObjects) do
        for _, skeletonData in pairs(obj) do
            skeletonData.Line:Remove()
        end
    end
    SkeletonObjects = {}
    collectgarbage()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Skeletons",
        Text = "Skeletons cleared!",
        Duration = 1
    })
end

-- Clear all tracer objects
function ClearAllTracers()
    for _, tracer in pairs(TracerObjects) do
        tracer:Remove()
    end
    TracerObjects = {}
    collectgarbage()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Tracers",
        Text = "Tracers cleared!",
        Duration = 1
    })
end

-- Update all ESP visibility
function UpdateAllESP()
    for _, data in pairs(ESPObjects) do
        if data.Box then data.Box.Visible = Settings.ESP.Box end
        if data.HealthBar then data.HealthBar.Visible = Settings.ESP.HealthBar end
        if data.NameTag then data.NameTag.Visible = Settings.ESP.Name end
    end
end

-- Update all skeletons visibility
function UpdateAllSkeletons()
    for _, data in pairs(SkeletonObjects) do
        for _, skeletonData in pairs(data) do
            skeletonData.Line.Color = Settings.Skeletons.Color
            skeletonData.Line.Thickness = Settings.Skeletons.Thickness
            skeletonData.Line.Visible = Settings.Skeletons.Enabled and skeletonData.Line.Visible
        end
    end
end

-- Update all tracers visibility
function UpdateAllTracers()
    for _, tracer in pairs(TracerObjects) do
        tracer.Color = Settings.Tracers.Color
        tracer.Thickness = Settings.Tracers.Thickness
        tracer.Visible = Settings.Tracers.Enabled and tracer.Visible
    end
end

-- Optimized ESP, Skeletons, and Tracers update
local function UpdateESP()
    if not (Settings.ESP.Enabled or Settings.Skeletons.Enabled or Settings.Tracers.Enabled) then return end

    local cameraPos = CurrentCamera.CFrame.Position
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
                local humanoid = character.Humanoid
                local rootPart = character.HumanoidRootPart
                local playerId = tostring(player.UserId)

                -- Distance check
                local distance = (cameraPos - rootPart.Position).Magnitude
                if distance > Settings.ESP.MaxDistance or (Settings.Skeletons.Enabled and distance > Settings.Skeletons.MaxDistance) then
                    if ESPObjects[playerId] then
                        if ESPObjects[playerId].Box then ESPObjects[playerId].Box.Visible = false end
                        if ESPObjects[playerId].HealthBar then ESPObjects[playerId].HealthBar.Visible = false end
                        if ESPObjects[playerId].NameTag then ESPObjects[playerId].NameTag.Visible = false end
                    end
                    if SkeletonObjects[playerId] then
                        for _, skeletonData in pairs(SkeletonObjects[playerId]) do
                            skeletonData.Line.Visible = false
                        end
                    end
                    if TracerObjects[playerId] then
                        TracerObjects[playerId].Visible = false
                    end
                    continue
                end

                -- Team check
                local isTeammate = Settings.ESP.TeamCheck and (player.Team == LocalPlayer.Team)
                local boxColor = isTeammate and Settings.ESP.TeamColor or Settings.ESP.BoxColor

                -- Screen position
                local screenPos, onScreen = CurrentCamera:WorldToViewportPoint(rootPart.Position)
                if not onScreen then
                    if ESPObjects[playerId] then
                        if ESPObjects[playerId].Box then ESPObjects[playerId].Box.Visible = false end
                        if ESPObjects[playerId].HealthBar then ESPObjects[playerId].HealthBar.Visible = false end
                        if ESPObjects[playerId].NameTag then ESPObjects[playerId].NameTag.Visible = false end
                    end
                    if SkeletonObjects[playerId] then
                        for _, skeletonData in pairs(SkeletonObjects[playerId]) do
                            skeletonData.Line.Visible = false
                        end
                    end
                    if TracerObjects[playerId] then
                        TracerObjects[playerId].Visible = false
                    end
                    continue
                end

                -- ESP objects
                if Settings.ESP.Enabled and not ESPObjects[playerId] then
                    ESPObjects[playerId] = {
                        Box = Settings.ESP.Box and Drawing.new("Square"),
                        HealthBar = Settings.ESP.HealthBar and Drawing.new("Line"),
                        NameTag = Settings.ESP.Name and Drawing.new("Text")
                    }
                    if ESPObjects[playerId].Box then
                        ESPObjects[playerId].Box.Thickness = 2
                        ESPObjects[playerId].Box.Filled = false
                    end
                    if ESPObjects[playerId].NameTag then
                        ESPObjects[playerId].NameTag.Font = Settings.ESP.Font
                        ESPObjects[playerId].NameTag.Size = Settings.ESP.TextSize
                    end
                    local connection
                    connection = RunService.RenderStepped:Connect(function()
                        if not character or not rootPart then
                            connection:Disconnect()
                            ActiveRenderConnections[playerId] = nil
                            return
                        end
                        local newScreenPos = CurrentCamera:WorldToViewportPoint(rootPart.Position)
                        local newDistance = (CurrentCamera.CFrame.Position - rootPart.Position).Magnitude
                        local newBoxSize = Vector2.new(300 / math.sqrt(newDistance), 400 / math.sqrt(newDistance))
                        if ESPObjects[playerId].Box then
                            ESPObjects[playerId].Box.Position = Vector2.new(newScreenPos.X - newBoxSize.X/2, newScreenPos.Y - newBoxSize.Y/2)
                            ESPObjects[playerId].Box.Size = newBoxSize
                        end
                        if ESPObjects[playerId].HealthBar then
                            ESPObjects[playerId].HealthBar.From = Vector2.new(newScreenPos.X - newBoxSize.X/2 - 5, newScreenPos.Y - newBoxSize.Y/2)
                            ESPObjects[playerId].HealthBar.To = Vector2.new(
                                newScreenPos.X - newBoxSize.X/2 - 5,
                                newScreenPos.Y + newBoxSize.Y/2 - (newBoxSize.Y * (humanoid.Health / humanoid.MaxHealth)))
                        end
                        if ESPObjects[playerId].NameTag then
                            ESPObjects[playerId].NameTag.Position = Vector2.new(newScreenPos.X, newScreenPos.Y - newBoxSize.Y/2 - 20)
                        end
                    end)
                    ActiveRenderConnections[playerId] = connection
                end

                if ESPObjects[playerId] then
                    if ESPObjects[playerId].Box then
                        ESPObjects[playerId].Box.Visible = Settings.ESP.Box and not isTeammate
                        ESPObjects[playerId].Box.Color = boxColor
                    end
                    if ESPObjects[playerId].HealthBar then
                        ESPObjects[playerId].HealthBar.Visible = Settings.ESP.HealthBar and not isTeammate
                        ESPObjects[playerId].HealthBar.Color = Color3.fromRGB(0, 255, 0)
                    end
                    if ESPObjects[playerId].NameTag then
                        ESPObjects[playerId].NameTag.Visible = Settings.ESP.Name and not isTeammate
                        ESPObjects[playerId].NameTag.Text = player.Name
                        ESPObjects[playerId].NameTag.Color = Color3.fromRGB(255, 255, 255)
                    end
                end

                -- Skeleton objects
                if Settings.Skeletons.Enabled and not SkeletonObjects[playerId] then
                    SkeletonObjects[playerId] = {}
                    local bones = {
                        {"neck", character:FindFirstChild("UpperTorso") and "UpperTorso" or "Torso"},
                        {character:FindFirstChild("UpperTorso") and "UpperTorso" or "Torso", character:FindFirstChild("LowerTorso") and "LowerTorso" or "Left Leg"},
                        {character:FindFirstChild("LowerTorso") and "LowerTorso" or "Torso", character:FindFirstChild("LeftUpperLeg") and "LeftUpperLeg" or "Right Leg"},
                        {character:FindFirstChild("LowerTorso") and "LowerTorso" or "Torso", character:FindFirstChild("RightUpperLeg") and "RightUpperLeg" or "Left Arm"},
                        {character:FindFirstChild("UpperTorso") and "UpperTorso" or "Torso", character:FindFirstChild("LeftUpperArm") and "LeftUpperArm" or "Right Arm"}
                    }
                    for _, bone in pairs(bones) do
                        local line = Drawing.new("Line")
                        line.Thickness = Settings.Skeletons.Thickness
                        line.Color = Settings.Skeletons.Color
                        line.Visible = false
                        table.insert(SkeletonObjects[playerId], {Line = line, Bone = bone})
                    end
                    local connection
                    connection = RunService.RenderStepped:Connect(function()
                        if not character or not rootPart or humanoid.Health <= 0 then
                            connection:Disconnect()
                            SkeletonRenderConnections[playerId] = nil
                            if SkeletonObjects[playerId] then
                                for _, skeletonData in pairs(SkeletonObjects[playerId]) do
                                    skeletonData.Line:Remove()
                                end
                                SkeletonObjects[playerId] = nil
                            end
                            return
                        end
                        local shouldShowSkeleton = Settings.Skeletons.IgnoreTeamCheck or not isTeammate
                        for _, skeletonData in pairs(SkeletonObjects[playerId]) do
                            local line = skeletonData.Line
                            local bone = skeletonData.Bone
                            local part1 = character:FindFirstChild(bone[1])
                            local part2 = character:FindFirstChild(bone[2])
                            if part1 and part2 then
                                local pos1, onScreen1 = CurrentCamera:WorldToViewportPoint(part1.Position)
                                local pos2, onScreen2 = CurrentCamera:WorldToViewportPoint(part2.Position)
                                if onScreen1 and onScreen2 and shouldShowSkeleton then
                                    line.From = Vector2.new(pos1.X, pos1.Y)
                                    line.To = Vector2.new(pos2.X, pos2.Y)
                                    line.Visible = true
                                else
                                    line.Visible = false
                                end
                            else
                                line.Visible = false
                            end
                        end
                    end)
                    SkeletonRenderConnections[playerId] = connection
                end

                -- Tracer objects
                if Settings.Tracers.Enabled and not TracerObjects[playerId] then
                    TracerObjects[playerId] = Drawing.new("Line")
                end
                if TracerObjects[playerId] then
                    local tracerFrom = Settings.Tracers.From == "Center" and
                        Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2) or
                        Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
                    TracerObjects[playerId].From = tracerFrom
                    TracerObjects[playerId].To = Vector2.new(screenPos.X, screenPos.Y)
                    TracerObjects[playerId].Color = Settings.Tracers.Color
                    TracerObjects[playerId].Thickness = Settings.Tracers.Thickness
                    TracerObjects[playerId].Visible = Settings.Tracers.Enabled and not isTeammate
                end

            elseif ESPObjects[playerId] or SkeletonObjects[playerId] or TracerObjects[playerId] then
                if ActiveRenderConnections[playerId] then
                    ActiveRenderConnections[playerId]:Disconnect()
                    ActiveRenderConnections[playerId] = nil
                end
                if SkeletonRenderConnections[playerId] then
                    SkeletonRenderConnections[playerId]:Disconnect()
                    SkeletonRenderConnections[playerId] = nil
                end
                if ESPObjects[playerId] then
                    if ESPObjects[playerId].Box then ESPObjects[playerId].Box:Remove() end
                    if ESPObjects[playerId].HealthBar then ESPObjects[playerId].HealthBar:Remove() end
                    if ESPObjects[playerId].NameTag then ESPObjects[playerId].NameTag:Remove() end
                    ESPObjects[playerId] = nil
                end
                if SkeletonObjects[playerId] then
                    for _, skeletonData in pairs(SkeletonObjects[playerId]) do
                        skeletonData.Line:Remove()
                    end
                    SkeletonObjects[playerId] = nil
                end
                if TracerObjects[playerId] then
                    TracerObjects[playerId]:Remove()
                    TracerObjects[playerId] = nil
                end
            end
        end
    end
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local aimbotEnabled = false -- Флаг для активации/деактивации аимбота
local aimRadius = 333 -- Радиус зоны, в которой работает аимбот
local aimKey = Enum.KeyCode.E -- Клавиша для активации аимбота

-- Создание визуального круга зоны аимбота
local aimCircle = Drawing.new("Circle")
aimCircle.Visible = true
aimCircle.Transparency = 0.5
aimCircle.Color = Color3.new(1, 0, 0) -- Красный цвет
aimCircle.Thickness = 3.33
aimCircle.Radius = aimRadius

-- Функция для обновления позиции круга зоны
local function updateAimCircle()
    local mousePosition = UserInputService:GetMouseLocation()
    aimCircle.Position = mousePosition
end

-- Функция для нахождения ближайшего игрока
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = aimRadius

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoidRootPart = character.HumanoidRootPart
            local screenPosition, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position)

            if onScreen then
                local mousePosition = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - mousePosition).Magnitude

                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end

-- Функция для наведения камеры на игрока
local function aimAtTarget(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = target.Character.HumanoidRootPart
        camera.CFrame = CFrame.new(camera.CFrame.Position, humanoidRootPart.Position)
    end
end

-- Постоянное обновление аимбота и круга зоны
RunService.RenderStepped:Connect(function()
    updateAimCircle()

    if aimbotEnabled then
        local target = getClosestPlayer()
        aimAtTarget(target)
    end
end)

-- Переключение аимбота с помощью клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == aimKey then
        aimbotEnabled = not aimbotEnabled
        aimCircle.Color = aimbotEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0) -- Меняем цвет круга
        print("Аимбот " .. (aimbotEnabled and "включен" or "выключен"))
    end
end)

-- Chams logic
local function ApplyChams()
    if not Settings.Chams.Enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("ChamsHighlight") then
                player.Character.ChamsHighlight:Destroy()
            end
        end
        return
    end
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local character = player.Character
        if not character then continue end
        local isTeammate = Settings.ESP.TeamCheck and (player.Team == LocalPlayer.Team)
        if Settings.ESP.TeamCheck and isTeammate and Settings.Chams.VisibilityMode == "ThroughWalls" then
            if character:FindFirstChild("ChamsHighlight") then
                character.ChamsHighlight:Destroy()
            end
            continue
        end
        local highlight = character:FindFirstChild("ChamsHighlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "ChamsHighlight"
            highlight.Parent = character
        end
        highlight.FillColor = isTeammate and

Settings.Chams.TeamColor or Settings.Chams.EnemyColor
        highlight.FillTransparency = Settings.Chams.Transparency
        highlight.OutlineColor = Settings.Chams.OutlineColor
        highlight.OutlineTransparency = Settings.Chams.OutlineEnabled and 0 or 1
        highlight.DepthMode = Settings.Chams.VisibilityMode == "ThroughWalls" and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Settings.Chams.Material
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    pcall(ApplyChams)
end)

-- Auto-cleanup system
local function AutoCleanupLoop()
    while task.wait(Settings.ESP.AutoCleanup.Interval) do
        if Settings.ESP.AutoCleanup.Enabled then
            ClearAllESP()
            ClearAllSkeletons()
            ClearAllTracers()
            print("[Auto-Cleanup] ESP, Skeletons, and Tracers cleared (interval: "..Settings.ESP.AutoCleanup.Interval.."s)")
        end
    end
end
task.spawn(AutoCleanupLoop)

-- Main render loop
local lastUpdate = 0
RunService.RenderStepped:Connect(function()
    local currentTime = os.clock()
    if currentTime - lastUpdate >= (1 / Settings.ESP.TargetFPS) then
        pcall(UpdateESP)
        lastUpdate = currentTime
    end
end)

local Lighting = game:GetService("Lighting")

local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local transparencyLevel = 0.5 -- Значение для полупрозрачности
local wallsTransparent = false -- Флаг состояния прозрачности

-- Функция для установки прозрачности стен
local function setWallsTransparency(transparency)
    for _, object in ipairs(Workspace:GetDescendants()) do
        if object:IsA("BasePart") then
            object.Transparency = transparency
        end
    end
    print("Состояние прозрачности обновлено: ", transparency)
end

-- Функция для переключения состояния прозрачности
local function toggleWallsTransparency()
    wallsTransparent = not wallsTransparent
    if wallsTransparent then
        setWallsTransparency(transparencyLevel) -- Делаем стены полупрозрачными
        print("Стены стали полупрозрачными.")
    else
        setWallsTransparency(0) -- Возвращаем стены к обычному состоянию
        print("Прозрачность стен отключена.")
    end
end

-- Привязка к клавише для активации/деактивации
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.P then -- Клавиша "P"
        toggleWallsTransparency()
    end
end)

-- Функция для активации ночного режима
local function enableNightMode()
    Lighting.Ambient = Color3.fromRGB(25, 50, 100) -- Темные тона для окружения
    Lighting.Brightness = 0.6 -- Уменьшаем яркость
    Lighting.OutdoorAmbient = Color3.fromRGB(30, 60, 120) -- Освещенность снаружи карты
    Lighting.FogColor = Color3.fromRGB(30, 30, 30) -- Цвет тумана
    Lighting.FogEnd = 350 -- Устанавливаем предел видимости
    Lighting.FogStart = 0 -- Старт тумана
    Lighting.TimeOfDay = "06:00:00" -- Устанавливаем время на ночь
    Lighting.StarCount = 100 -- Увеличиваем количество звезд на небе
end

-- Функция для активации дневного режима
local function enableDayMode()
    Lighting.Ambient = Color3.fromRGB(200, 200, 200) -- Светлые тона для окружения
    Lighting.Brightness = 2 -- Нормальная яркость
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200) -- Освещенность снаружи карты
    Lighting.FogColor = Color3.fromRGB(255, 255, 255) -- Цвет тумана
    Lighting.FogEnd = 1000 -- Увеличиваем видимость
    Lighting.FogStart = 100 -- Старт тумана
    Lighting.TimeOfDay = "12:00:00" -- Устанавливаем время на день
    Lighting.StarCount = 0 -- Убираем звезды
end

-- Добавление кнопки для переключения между ночным и дневным режимом
local UserInputService = game:GetService("UserInputService")
local toggle = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.N and not gameProcessed then
        toggle = not toggle
        if toggle then
            enableNightMode()  -- Включаем ночной режим
        else
            enableDayMode()  -- Включаем дневной режим
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Переменные для состояния анти-AFK
local antiAFKEnabled = false

-- Создаем GUI для отображения надписи
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiAFK_GUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 300, 0, 50)
TextLabel.Position = UDim2.new(0.5, -150, 0, 50)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 30
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Anti AFK"
TextLabel.Visible = false
TextLabel.Parent = ScreenGui

-- Функция для включения анти-AFK
local function enableAntiAFK()
    antiAFKEnabled = true
    TextLabel.Visible = true  -- Показываем надпись "Anti AFK"

    -- Устанавливаем соединение для предотвращения AFK (например, имитируем движение)
    RunService.RenderStepped:Connect(function()
        if antiAFKEnabled then
            -- Имитация действия, чтобы игрок не ушел в AFK
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

-- Функция для выключения анти-AFK
local function disableAntiAFK()
    antiAFKEnabled = false
    TextLabel.Visible = false  -- Скрываем надпись "Anti AFK"
end

-- Переключение анти-AFK с помощью клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.J and not gameProcessed then
        if antiAFKEnabled then
            disableAntiAFK()  -- Выключаем анти-AFK
        else
            enableAntiAFK()  -- Включаем анти-AFK
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local teleportKey = Enum.KeyCode.B -- Клавиша для телепортации

-- Функция для телепортации за спину случайного игрока
local function teleportBehindRandomPlayer()
    local allPlayers = Players:GetPlayers()
    local targetPlayer

    -- Убираем локального игрока из списка
    repeat
        targetPlayer = allPlayers[math.random(1, #allPlayers)]
    until targetPlayer ~= localPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        if character and character:FindFirstChild("HumanoidRootPart") then
            local localHumanoidRootPart = character.HumanoidRootPart

            -- Вычисляем позицию позади игрока
            local behindPosition = targetHumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, 3)) -- Телепортируемся на 3 единицы позади
            localHumanoidRootPart.CFrame = CFrame.new(behindPosition)

            print("Телепортировались за спину к игроку:", targetPlayer.Name)
        end
    else
        print("Не удалось найти подходящего игрока для телепортации!")
    end
endighting.FogColor = Color3.fromRGB(30, 30, 30) -- Цвет тумана
    Lighting.FogEnd = 350 -- Устанавливаем предел видимости
    Lighting.FogStart = 0 -- Старт тумана
    Lighting.TimeOfDay = "06:00:00" -- Устанавливаем время на ночь
    Lighting.StarCount = 100 -- Увеличиваем количество звезд на небе
end

-- Функция для активации дневного режима
local function enableDayMode()
    Lighting.Ambient = Color3.fromRGB(200, 200, 200) -- Светлые тона для окружения
    Lighting.Brightness = 2 -- Нормальная яркость
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200) -- Освещенность снаружи карты
    Lighting.FogColor = Color3.fromRGB(255, 255, 255) -- Цвет тумана
    Lighting.FogEnd = 1000 -- Увеличиваем видимость
    Lighting.FogStart = 100 -- Старт тумана
    Lighting.TimeOfDay = "12:00:00" -- Устанавливаем время на день
    Lighting.StarCount = 0 -- Убираем звезды
end

-- Добавление кнопки для переключения между ночным и дневным режимом
local UserInputService = game:GetService("UserInputService")
local toggle = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.N and not gameProcessed then
        toggle = not toggle
        if toggle then
            enableNightMode()  -- Включаем ночной режим
        else
            enableDayMode()  -- Включаем дневной режим
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Переменные для состояния анти-AFK
local antiAFKEnabled = false

-- Создаем GUI для отображения надписи
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiAFK_GUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 300, 0, 50)
TextLabel.Position = UDim2.new(0.5, -150, 0, 50)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 30
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Anti AFK"
TextLabel.Visible = false
TextLabel.Parent = ScreenGui

-- Функция для включения анти-AFK
local function enableAntiAFK()
    antiAFKEnabled = true
    TextLabel.Visible = true  -- Показываем надпись "Anti AFK"

    -- Устанавливаем соединение для предотвращения AFK (например, имитируем движение)
    RunService.RenderStepped:Connect(function()
        if antiAFKEnabled then
            -- Имитация действия, чтобы игрок не ушел в AFK
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

-- Функция для выключения анти-AFK
local function disableAntiAFK()
    antiAFKEnabled = false
    TextLabel.Visible = false  -- Скрываем надпись "Anti AFK"
end

-- Переключение анти-AFK с помощью клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.J and not gameProcessed then
        if antiAFKEnabled then
            disableAntiAFK()  -- Выключаем анти-AFK
        else
            enableAntiAFK()  -- Включаем анти-AFK
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local teleportKey = Enum.KeyCode.B -- Клавиша для телепортации

-- Функция для телепортации за спину случайного игрока
local function teleportBehindRandomPlayer()
    local allPlayers = Players:GetPlayers()
    local targetPlayer

    -- Убираем локального игрока из списка
    repeat
        targetPlayer = allPlayers[math.random(1, #allPlayers)]
    until targetPlayer ~= localPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        if character and character:FindFirstChild("HumanoidRootPart") then
            local localHumanoidRootPart = character.HumanoidRootPart

            -- Вычисляем позицию позади игрока
            local behindPosition = targetHumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, 3)) -- Телепортируемся на 3 единицы позади
            localHumanoidRootPart.CFrame = CFrame.new(behindPosition)

            print("Телепортировались за спину к игроку:", targetPlayer.Name)
        end
    else
        print("Не удалось найти подходящего игрока для телепортации!")
    end
endighting.FogColor = Color3.fromRGB(30, 30, 30) -- Цвет тумана
    Lighting.FogEnd = 350 -- Устанавливаем предел видимости
    Lighting.FogStart = 0 -- Старт тумана
    Lighting.TimeOfDay = "06:00:00" -- Устанавливаем время на ночь
    Lighting.StarCount = 100 -- Увеличиваем количество звезд на небе
end

-- Функция для активации дневного режима
local function enableDayMode()
    Lighting.Ambient = Color3.fromRGB(200, 200, 200) -- Светлые тона для окружения
    Lighting.Brightness = 2 -- Нормальная яркость
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200) -- Освещенность снаружи карты
    Lighting.FogColor = Color3.fromRGB(255, 255, 255) -- Цвет тумана
    Lighting.FogEnd = 1000 -- Увеличиваем видимость
    Lighting.FogStart = 100 -- Старт тумана
    Lighting.TimeOfDay = "12:00:00" -- Устанавливаем время на день
    Lighting.StarCount = 0 -- Убираем звезды
end

-- Добавление кнопки для переключения между ночным и дневным режимом
local UserInputService = game:GetService("UserInputService")
local toggle = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.N and not gameProcessed then
        toggle = not toggle
        if toggle then
            enableNightMode()  -- Включаем ночной режим
        else
            enableDayMode()  -- Включаем дневной режим
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Переменные для состояния анти-AFK
local antiAFKEnabled = false

-- Создаем GUI для отображения надписи
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiAFK_GUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(0, 300, 0, 50)
TextLabel.Position = UDim2.new(0.5, -150, 0, 50)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 30
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Anti AFK"
TextLabel.Visible = false
TextLabel.Parent = ScreenGui

-- Функция для включения анти-AFK
local function enableAntiAFK()
    antiAFKEnabled = true
    TextLabel.Visible = true  -- Показываем надпись "Anti AFK"

    -- Устанавливаем соединение для предотвращения AFK (например, имитируем движение)
    RunService.RenderStepped:Connect(function()
        if antiAFKEnabled then
            -- Имитация действия, чтобы игрок не ушел в AFK
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end)
end

-- Функция для выключения анти-AFK
local function disableAntiAFK()
    antiAFKEnabled = false
    TextLabel.Visible = false  -- Скрываем надпись "Anti AFK"
end

-- Переключение анти-AFK с помощью клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.J and not gameProcessed then
        if antiAFKEnabled then
            disableAntiAFK()  -- Выключаем анти-AFK
        else
            enableAntiAFK()  -- Включаем анти-AFK
        end
    end
end)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local teleportKey = Enum.KeyCode.B -- Клавиша для телепортации

-- Функция для телепортации за спину случайного игрока
local function teleportBehindRandomPlayer()
    local allPlayers = Players:GetPlayers()
    local targetPlayer

    -- Убираем локального игрока из списка
    repeat
        targetPlayer = allPlayers[math.random(1, #allPlayers)]
    until targetPlayer ~= localPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")

    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")

        if character and character:FindFirstChild("HumanoidRootPart") then
            local localHumanoidRootPart = character.HumanoidRootPart

            -- Вычисляем позицию позади игрока
            local behindPosition = targetHumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, 3)) -- Телепортируемся на 3 единицы позади
            localHumanoidRootPart.CFrame = CFrame.new(behindPosition)

            print("Телепортировались за спину к игроку:", targetPlayer.Name)
        end
    else
        print("Не удалось найти подходящего игрока для телепортации!")
    end
end

-- High Jump function
local highJumpEnabled = false
local function toggleHighJump()
    highJumpEnabled = not highJumpEnabled
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        if highJumpEnabled then
            humanoid.JumpPower = 100 -- Даём тебе прыгать, как ебаный кенгуру!
            humanoid.UseJumpPower = true
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "High Jump",
                Text = "Врубил, прыгай до небес, братишка!",
                Duration = 2
            })
        else
            humanoid.JumpPower = 50 -- Возвращаем стандартный прыжок
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "High Jump",
                Text = "Вырубил, прыгай как лох теперь!",
                Duration = 2
            })
        end
    end
end
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space and not gameProcessed and highJumpEnabled then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- Прыгай, братишка!
        end
    end
end)

-- Invisibility function
local invisEnabled = false
local function toggleInvisibility()
    invisEnabled = not invisEnabled
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if invisEnabled then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1 -- Стань невидимым, как ебаный ниндзя!
                    part.CanCollide = false -- Сквозь стены, как призрак!
                end
            end
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Invisibility",
                Text = "Врубил, ты теперь невидимый, братишка!",
                Duration = 2
            })
        else
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0 -- Вернули видимость, пиздец тебе!
                    part.CanCollide = true -- Теперь опять твёрдый, как кирпич!
                end
            end
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Invisibility",
                Text = "Вырубил, тебя опять видно, братишка!",
                Duration = 2
            })
        end
    end
end

-- Speed Hack function
local speedHackEnabled = false
local function toggleSpeedHack()
    speedHackEnabled = not speedHackEnabled
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        if speedHackEnabled then
            humanoid.WalkSpeed = 100 -- Беги, как ебаный Флеш!
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Speed Hack",
                Text = "Врубил, носись как угорелый, братишка!",
                Duration = 2
            })
        else
            humanoid.WalkSpeed = 16 -- Стандартная скорость, как у лохов!
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Speed Hack",
                Text = "Вырубил, ходи как черепаха, братишка!",
                Duration = 2
            })
        end
    end
end

-- Add buttons to MiscTab
MiscSection:NewButton("High Jump", "Прыгай выше неба, братишка!", toggleHighJump)
MiscSection:NewButton("Invisibility", "Стань невидимым, как ниндзя!", toggleInvisibility)
MiscSection:NewButton("Speed Hack", "Бегай быстрее ветра, братишка!", toggleSpeedHack)

-- Silent Aim function (увеличиваем моделки и хитбоксы противников)
local silentAimEnabled = false
local originalSizes = {} -- Храним оригинальные размеры моделек
local scaleFactor = 10 -- По умолчанию в 5 раз, как ты хотел

local function toggleSilentAim()
    silentAimEnabled = not silentAimEnabled
    if silentAimEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        originalSizes[part] = part.Size
                        part.Size = part.Size * scaleFactor
                        part.Massless = true -- Чтобы физика не ломалась
                    end
                end
            end
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Silent Aim",
            Text = "Моделки выросли в " .. scaleFactor .. " раз, мочи всех!",
            Duration = 2
        })
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and originalSizes[part] then
                        part.Size = originalSizes[part]
                        part.Massless = false
                    end
                end
            end
        end
        originalSizes = {}
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Silent Aim",
            Text = "Всё вернул как было, братишка!",
            Duration = 2
        })
    end
end

-- Добавляем кнопки и слайдер в RageTab
local RageSection = RageTab:NewSection("Silent Aim")
RageSection:NewToggle("Enable Silent Aim", "Раздувает врагов", function(state)
    toggleSilentAim()
end)
RageSection:NewSlider("Scale Factor", "На сколько раздувать (1-10)", 10, 1, scaleFactor, function(value)
    scaleFactor = value
    if silentAimEnabled then
        toggleSilentAim() -- Вырубаем
        toggleSilentAim() -- Врубаем с новым масштабом
    end
end)

-- FOV and Sprint Mechanic
local fovSprintEnabled = false
local FOV_TWEEN_TIME = 0.2 -- Время анимации FOV
local FOV_MAX = 150 -- Макс FOV при беге
local FOV_MIN = 120 -- Стандартный FOV
local STAMINA_MAX = 130 -- Максимум стамины
local STAMINA_CONSUME = 5 -- Потребление стамины в секунду
local STAMINA_REGEN = 10 -- Реген стамины в секунду
local STAMINA_WAIT = 1 -- Задержка перед регеном

local currentStamina = STAMINA_MAX
local isRunning = false
local sprintSpeed = 28 -- Скорость бега
local walkSpeed = 16 -- Скорость ходьбы

local function startRunning()
    if not isRunning and currentStamina > 0 and fovSprintEnabled then
        isRunning = true
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = sprintSpeed
        end
        local camera = workspace.CurrentCamera
        local fovTweenInfo = TweenInfo.new(FOV_TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local fovTween = game:GetService("TweenService"):Create(camera, fovTweenInfo, {FieldOfView = FOV_MAX})
        fovTween:Play()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Sprint",
            Text = "Беги, братишка! FOV врублен на " .. FOV_MAX .. "!",
            Duration = 2
        })
    end
end

local function stopRunning()
    if isRunning then
        isRunning = false
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
        end
        local camera = workspace.CurrentCamera
        local fovTweenInfo = TweenInfo.new(FOV_TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local fovTween = game:GetService("TweenService"):Create(camera, fovTweenInfo, {FieldOfView = FOV_MIN})
        fovTween:Play()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Sprint",
            Text = "Бег вырублен, FOV вернулся на " .. FOV_MIN .. "!",
            Duration = 2
        })
    end
end

-- Управление бегом (Shift)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.LeftShift then
        startRunning()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.LeftShift then
        stopRunning()
        wait(STAMINA_WAIT)
        currentStamina = math.min(currentStamina + STAMINA_REGEN * STAMINA_WAIT, STAMINA_MAX)
    end
end)

-- Обновление стамины
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    if isRunning then
        currentStamina = currentStamina - STAMINA_CONSUME * deltaTime
        if currentStamina <= 0 then
            stopRunning()
            wait(STAMINA_WAIT)
            currentStamina = 0
        end
    else
        currentStamina = math.min(currentStamina + STAMINA_REGEN * deltaTime, STAMINA_MAX)
    end
end)

-- Добавляем секцию в MiscTab
local FOVSection = MiscTab:NewSection("FOV & Sprint")
FOVSection:NewToggle("Enable FOV Sprint", "Включает бег с изменением FOV", function(state)
    fovSprintEnabled = state
    if not state then
        stopRunning()
        currentStamina = STAMINA_MAX
        local camera = workspace.CurrentCamera
        camera.FieldOfView = FOV_MIN
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FOV Sprint",
            Text = "Вырубил, всё по дефолту, братишка!",
            Duration = 2
        })
    end
end)
FOVSection:NewSlider("Max FOV", "Максимальный FOV при беге (120-180)", 180, 120, FOV_MAX, function(value)
    FOV_MAX = value
    if isRunning then
        local camera = workspace.CurrentCamera
        local fovTweenInfo = TweenInfo.new(FOV_TWEEN_TIME, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local fovTween = game:GetService("TweenService"):Create(camera, fovTweenInfo, {FieldOfView = FOV_MAX})
        fovTween:Play()
    end
end)
FOVSection:NewSlider("Min FOV", "Стандартный FOV (70-120)", 120, 70, FOV_MIN, function(value)
    FOV_MIN = value
    if not isRunning then
        local camera = workspace.CurrentCamera
        camera.FieldOfView = FOV_MIN
    end
end)
FOVSection:NewSlider("Sprint Speed", "Скорость бега (16-50)", 50, 16, sprintSpeed, function(value)
    sprintSpeed = value
    if isRunning then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = sprintSpeed
        end
    end
end)

-- Services (Assuming these are already defined in your main script)
-- If not, uncomment: local Players = game:GetService("Players"); local UserInputService = game:GetService("UserInputService"); local RunService = game:GetService("RunService"); local LocalPlayer = Players.LocalPlayer

-- Anti-Aim Variables
local antiAimEnabled = false
local antiAimMode = "Spinbot"
local spinSpeed = 128 -- Макс. скорость вращения (градусы на кадр), как в твоём коде
local spinDirection = "Right" -- Направление вращения (Right/Left)
local jitterAngle = 45 -- Макс. угол дергания
local staticAngle = -90
local randomAngle = 90 -- Макс. угол для рандома
local lbyOffset = 60
local updateInterval = 0.03 -- Синхронизировано с твоим wait(0.03) для 32 FPS
local fakeLagEnabled = false
local fakeLagMode = "Static"
local fakeLagTicks = 14
local fakeLagAdaptiveMin = 5
local fakeLagAdaptiveMax = 20
local fakeDuckEnabled = false
local fakeDuckInterval = 0.05
local onShotEnabled = false
local manualDirection = "Left"
local fakePingEnabled = false
local cameraMode = "ThirdPerson"
local cameraDistance = 5
local maxCameraDistance = 10
local minCameraDistance = 2

local chokedPackets = 0
local maxChoke = fakeLagTicks
local fakeDuckState = false
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Character Tracking for Post-Death
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    wait(0.1) -- Даём время загрузиться
end)

-- Utility: Get closest enemy
local function getClosestEnemy()
    local closestEnemy = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestEnemy = player
                shortestDistance = distance
            end
        end
    end
    return closestEnemy, shortestDistance
end

-- Anti-Aim Logic
local function updateAntiAim()
    while antiAimEnabled do
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then
            wait(0.1) -- Ждём возрождения
            continue
        end
        local humanoidRootPart = character.HumanoidRootPart
        local humanoid = character.Humanoid
        local newCFrame = humanoidRootPart.CFrame
        local jitterOffset = 0

        -- Fake Lag Logic
        if fakeLagEnabled then
            if fakeLagMode == "Static" then
                maxChoke = fakeLagTicks
            elseif fakeLagMode == "Adaptive" then
                local _, distance = getClosestEnemy()
                maxChoke = distance and math.clamp(fakeLagAdaptiveMin + (fakeLagAdaptiveMax - fakeLagAdaptiveMin) * (distance / 100), fakeLagAdaptiveMin, fakeLagAdaptiveMax) or fakeLagAdaptiveMin
            elseif fakeLagMode == "Random" then
                maxChoke = math.random(fakeLagAdaptiveMin, fakeLagAdaptiveMax)
            end
            chokedPackets = (chokedPackets + 1) % (maxChoke + 1)
        else
            chokedPackets = 0
        end

        -- Anti-Aim Modes (Радикальная разница включено/выключено)
        if antiAimEnabled then
            if antiAimMode == "Spinbot" then
                local directionMultiplier = (spinDirection == "Right") and 1 or -1
                local baseAngle = tick() * spinSpeed * directionMultiplier
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(baseAngle), 0)
                if jitterAngle > 0 then
                    jitterOffset = math.random(-jitterAngle * 2, jitterAngle * 2) -- Усиленный джитер при включении
                    newCFrame = newCFrame * CFrame.Angles(0, math.rad(jitterOffset), math.rad(math.random(-10, 10)))
                end
            elseif antiAimMode == "Jitter" then
                jitterOffset = math.random(-jitterAngle * 3, jitterAngle * 3) -- Усиленный хаос при включении
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(jitterOffset), math.rad(math.random(-20, 20)))
            elseif antiAimMode == "Static" then
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(staticAngle * 2), 0) -- Удвоенный угол
            elseif antiAimMode == "Random" then
                local randomOffset = math.random(-randomAngle * 2, randomAngle * 2)
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(randomOffset), 0)
            elseif antiAimMode == "Freestanding" then
                local enemy = getClosestEnemy()
                if enemy and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                    local direction = (enemy.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Unit
                    local angle = math.atan2(direction.X, direction.Z)
                    newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, -angle + math.rad(180), math.rad(math.random(-30, 30)))
                end
            elseif antiAimMode == "LBYBreaker" then
                local lbyAngle = (tick() % 2 < 1) and lbyOffset * 1.5 or -lbyOffset * 1.5 -- Усиленный оффсет
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(lbyAngle), 0)
            elseif antiAimMode == "Manual" then
                local manualAngle = manualDirection == "Left" and 180 or (manualDirection == "Right" and -180 or (manualDirection == "Back" and 360 or 0))
                newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(manualAngle), 0)
            end
        else
            -- Без анти-эйма: минимальное движение для заметной разницы
            newCFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(0), 0)
        end

        -- Apply CFrame with Fake Lag
        if chokedPackets == 0 then
            humanoidRootPart.CFrame = newCFrame
        end
        RunService.RenderStepped:Wait() -- Синхронизация с твоей логикой
    end
end

-- Fake Duck Logic
local function updateFakeDuck()
    while fakeDuckEnabled do
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            fakeDuckState = not fakeDuckState
            humanoid.HipHeight = fakeDuckState and 0.5 or 2
        end
        task.wait(fakeDuckInterval)
    end
end

-- OnShot Anti-Aim Logic
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 and onShotEnabled and antiAimEnabled then
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            local randomOffset = math.random(-180, 180) -- Усиленный рандом при выстреле
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(0, math.rad(randomOffset), 0)
        end
    end
end)

-- Fake Ping Logic
local function updateFakePing()
    while fakePingEnabled do
        if character and character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = character.HumanoidRootPart
            humanoidRootPart.Position = humanoidRootPart.Position + Vector3.new(math.random(-0.2, 0.2), 0, math.random(-0.2, 0.2))
        end
        task.wait(math.random(0.1, 0.3))
    end
end

-- Camera Control
local function toggleCameraMode()
    cameraMode = (cameraMode == "ThirdPerson") and "FirstPerson" or "ThirdPerson"
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.CameraOffset = (cameraMode == "FirstPerson") and Vector3.new(0, 0, 0) or Vector3.new(0, 1.5, cameraDistance)
    end
    game.StarterGui:SetCore("SendNotification", {Title = "Camera", Text = "Switched to " .. cameraMode .. "!", Duration = 2})
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.Equals and cameraMode == "ThirdPerson" then
            cameraDistance = math.max(minCameraDistance, cameraDistance - 1)
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                humanoid.CameraOffset = Vector3.new(0, 1.5, cameraDistance)
            end
            game.StarterGui:SetCore("SendNotification", {Title = "Camera", Text = "Zoomed in! Distance: " .. cameraDistance, Duration = 1})
        elseif input.KeyCode == Enum.KeyCode.Minus and cameraMode == "ThirdPerson" then
            cameraDistance = math.min(maxCameraDistance, cameraDistance + 1)
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character.Humanoid
                humanoid.CameraOffset = Vector3.new(0, 1.5, cameraDistance)
            end
            game.StarterGui:SetCore("SendNotification", {Title = "Camera", Text = "Zoomed out! Distance: " .. cameraDistance, Duration = 1})
        end
    end
end)

-- UI (Assuming RageTab and MiscTab are defined)
local AntiAimSection = RageTab:NewSection("Anti-Aim")
AntiAimSection:NewToggle("Enable Anti-Aim", "Включает анти-эйм", function(state)
    antiAimEnabled = state
    if state then
        spinSpeed = 128 -- Устанавливаем максимальную скорость из твоего кода
        jitterAngle = 45
        randomAngle = 90
        lbyOffset = 60
        task.spawn(updateAntiAim)
        game.StarterGui:SetCore("SendNotification", {Title = "Anti-Aim", Text = "Включено! Скорость Spinbot: " .. spinSpeed .. "°/frame!", Duration = 2})
    else
        game.StarterGui:SetCore("SendNotification", {Title = "Anti-Aim", Text = "Выключено! Движение остановлено.", Duration = 2})
    end
end)
AntiAimSection:NewDropdown("Anti-Aim Mode", "Выбери режим", {"Spinbot", "Jitter", "Static", "Random", "Freestanding", "LBYBreaker", "Manual"}, function(value)
    antiAimMode = value
end)
AntiAimSection:NewDropdown("Spin Direction", "Направление вращения", {"Right", "Left"}, function(value) spinDirection = value end)
AntiAimSection:NewSlider("Spin Speed", "Скорость вращения (макс. 128)", 128, 50, function(value) spinSpeed = value end)
AntiAimSection:NewSlider("Jitter Angle", "Угол дергания (макс. 45)", 45, 10, function(value) jitterAngle = value end)
AntiAimSection:NewSlider("Static Angle", "Фиксированный угол", 180, -180, function(value) staticAngle = value end)
AntiAimSection:NewSlider("Random Angle", "Макс. рандом угол (макс. 90)", 90, 0, function(value) randomAngle = value end)
AntiAimSection:NewSlider("LBY Offset", "LBY оффсет (макс. 60)", 60, 0, function(value) lbyOffset = value end)

local FakeLagSection = RageTab:NewSection("Fake Lag")
FakeLagSection:NewToggle("Enable Fake Lag", "Включает фейк-лаги", function(state) fakeLagEnabled = state end)
FakeLagSection:NewDropdown("Fake Lag Mode", "Режим фейк-лага", {"Static", "Adaptive", "Random"}, function(value) fakeLagMode = value end)
FakeLagSection:NewSlider("Static Fake Lag", "Чокнутые пакеты (макс. 14)", 14, 1, function(value) fakeLagTicks = value end)
FakeLagSection:NewSlider("Adaptive Min Lag", "Мин. лаг (макс. 5)", 5, 1, function(value) fakeLagAdaptiveMin = value end)
FakeLagSection:NewSlider("Adaptive Max Lag", "Макс. лаг (макс. 20)", 20, 1, function(value) fakeLagAdaptiveMax = math.max(value, fakeLagAdaptiveMin) end)

local OnShotSection = RageTab:NewSection("OnShot Anti-Aim")
OnShotSection:NewToggle("OnShot Anti-Aim", "Анти-эйм при выстреле", function(state) onShotEnabled = state end)

local MiscSection = MiscTab:NewSection("Misc Features")
MiscSection:NewToggle("Fake Duck", "Фейк приседания", function(state)
    fakeDuckEnabled = state
    if state then task.spawn(updateFakeDuck) end
end)
MiscSection:NewSlider("Fake Duck Interval", "Скорость приседания", 0.2, 0.01, function(value) fakeDuckInterval = value end)
MiscSection:NewToggle("Fake Ping", "Имитация лага", function(state)
    fakePingEnabled = state
    if state then task.spawn(updateFakePing) end
end)
MiscSection:NewDropdown("Manual Direction", "Направление мануального AA", {"Left", "Right", "Back"}, function(value) manualDirection = value end)

local CameraSection = MiscTab:NewSection("Camera Control")
CameraSection:NewButton("Toggle Camera Mode", "Switch between First/Third Person", toggleCameraMode)
CameraSection:NewLabel("Use + to zoom in, - to zoom out (Third Person)")
CameraSection:NewSlider("Camera Distance", "Расстояние камеры (2-10)", 10, 2, function(value) cameraDistance = value end)

-- Anti-Aim Variables
local antiAimEnabled = false
local rotationSpeed = 128 -- Rotation speed in degrees per frame (from your original script)
local Settings = Settings or {} -- Ensure Settings table exists
Settings.AntiAim = {
    Enabled = false,
    RotationSpeed = 128,
    MaxDistance = 999999999999, -- Match ESP max distance
    TargetFPS = 144, -- Match ESP target FPS
    TeamCheck = true, -- Ignore teammates
    AutoCleanup = {Enabled = false, Interval = 0.25} -- Match ESP auto-cleanup
}

-- Character Tracking
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

-- Anti-Aim Logic
local function updateAntiAim()
    if not Settings.AntiAim.Enabled then return end
    local lastUpdate = 0
    while Settings.AntiAim.Enabled do
        local currentTime = os.clock()
        if currentTime - lastUpdate >= (1 / Settings.AntiAim.TargetFPS) then
            if character and humanoidRootPart and character:FindFirstChild("Humanoid") then
                local cameraPos = CurrentCamera.CFrame.Position
                local distance = (cameraPos - humanoidRootPart.Position).Magnitude
                if distance <= Settings.AntiAim.MaxDistance then
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Settings.AntiAim.RotationSpeed), 0)
                end
            end
            lastUpdate = currentTime
        end
        RunService.Heartbeat:Wait() -- Smooth frame-based updates
    end
end

-- Auto-Cleanup for Anti-Aim
local function autoCleanupAntiAim()
    while task.wait(Settings.AntiAim.AutoCleanup.Interval) do
        if Settings.AntiAim.AutoCleanup.Enabled and not Settings.AntiAim.Enabled then
            Settings.AntiAim.Enabled = false
            print("[Auto-Cleanup] Anti-Aim cleared (interval: " .. Settings.AntiAim.AutoCleanup.Interval .. "s)")
        end
    end
end
task.spawn(autoCleanupAntiAim)

-- Anti-Aim UI (Rage Tab)
local AntiAimSection = RageTab:NewSection("Anti-Aim")
AntiAimSection:NewToggle("Enable Anti-Aim", "Toggles character rotation", function(state)
    Settings.AntiAim.Enabled = state
    if state then
        task.spawn(updateAntiAim)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Anti-Aim",
            Text = "Enabled! Rotation speed: " .. Settings.AntiAim.RotationSpeed .. "°/frame",
            Duration = 2
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Anti-Aim",
            Text = "Disabled!",
            Duration = 2
        })
    end
end)
AntiAimSection:NewSlider("Rotation Speed", "Speed of rotation (degrees/frame)", 200, 50, Settings.AntiAim.RotationSpeed, function(value)
    Settings.AntiAim.RotationSpeed = value
end)

-- Keybind Toggle (H key, kept from original script)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        Settings.AntiAim.Enabled = not Settings.AntiAim.Enabled
        if Settings.AntiAim.Enabled then
            task.spawn(updateAntiAim)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Anti-Aim",
                Text = "Enabled via keybind! Rotation speed: " .. Settings.AntiAim.RotationSpeed .. "°/frame",
                Duration = 2
            })
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Anti-Aim",
                Text = "Disabled via keybind!",
                Duration = 2
            })
        end
    end
end)


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Weapon Modifications Settings
local WeaponMods = {
    RapidFire = {
        Enabled = false,
        FireRate = 0.001,
        OriginalFireRates = {}
    },
    InfiniteAmmo = {
        Enabled = false,
        OriginalAmmo = {},
        AmmoConnections = {}
    },
    NoRecoil = {
        Enabled = false,
        OriginalRecoil = {},
        RecoilConnections = {}
    },
    NoSpread = {
        Enabled = false,
        OriginalSpread = {},
        SpreadConnections = {}
    }
}

-- Hook weapon systems (встроен в основной код)
local weaponSystem = ReplicatedStorage:FindFirstChild("WeaponSystem") or 
                    ReplicatedStorage:FindFirstChild("Weapons") or
                    ReplicatedStorage:FindFirstChild("GunSystem")

if not weaponSystem then
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("weapon") or obj.Name:lower():find("gun") then
            weaponSystem = obj
            break
        end
    end
end

-- Utility Functions
local function isInSpreadFolder(inst)
    local p = inst.Parent
    while p do
        if tostring(p.Name):lower() == "spread" then
            return true
        end
        p = p.Parent
    end
    return false
end

local function isRecoilValue(inst)
    local name = tostring(inst.Name):lower()
    return name == "recoil" or name:find("recoil") or name:find("kick")
end

local function isSpreadValue(inst)
    local name = tostring(inst.Name):lower()
    return name == "spread" or name:find("spread") or name:find("accuracy") or name:find("deviation")
end

-- Cache original values for restoration
local function cacheOriginalValues()
    if not weaponSystem then return end
    
    for _, inst in pairs(weaponSystem:GetDescendants()) do
        if inst:IsA("NumberValue") or inst:IsA("IntValue") then
            local ok, val = pcall(function() return inst.Value end)
            if ok then
                -- Cache recoil values
                if isRecoilValue(inst) and not WeaponMods.NoRecoil.OriginalRecoil[inst] then
                    WeaponMods.NoRecoil.OriginalRecoil[inst] = val
                end
                
                -- Cache spread values  
                if isSpreadValue(inst) and not WeaponMods.NoSpread.OriginalSpread[inst] then
                    WeaponMods.NoSpread.OriginalSpread[inst] = val
                end
                
                -- Cache spread folder values
                if isInSpreadFolder(inst) and not WeaponMods.NoSpread.OriginalSpread[inst] then
                    WeaponMods.NoSpread.OriginalSpread[inst] = val
                end
            end
        end
    end
end

-- No Recoil Implementation
local function applyNoRecoil()
    if not WeaponMods.NoRecoil.Enabled then return end
    
    -- Method 1: Direct weapon system modification
    if weaponSystem then
        for _, weapon in pairs(weaponSystem:GetDescendants()) do
            if weapon:IsA("NumberValue") or weapon:IsA("IntValue") then
                if isRecoilValue(weapon) then
                    if not WeaponMods.NoRecoil.OriginalRecoil[weapon] then
                        WeaponMods.NoRecoil.OriginalRecoil[weapon] = weapon.Value
                    end
                    weapon.Value = 0
                    
                    -- Monitor for changes
                    local connection = weapon.Changed:Connect(function()
                        if WeaponMods.NoRecoil.Enabled and weapon.Value ~= 0 then
                            weapon.Value = 0
                        end
                    end)
                    table.insert(WeaponMods.NoRecoil.RecoilConnections, connection)
                end
            end
        end
    end
    
    -- Method 2: Character tool modification
    local character = LocalPlayer.Character
    if character then
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                for _, obj in pairs(tool:GetDescendants()) do
                    if (obj:IsA("NumberValue") or obj:IsA("IntValue")) and isRecoilValue(obj) then
                        if not WeaponMods.NoRecoil.OriginalRecoil[obj] then
                            WeaponMods.NoRecoil.OriginalRecoil[obj] = obj.Value
                        end
                        obj.Value = 0
                        
                        local connection = obj.Changed:Connect(function()
                            if WeaponMods.NoRecoil.Enabled and obj.Value ~= 0 then
                                obj.Value = 0
                            end
                        end)
                        table.insert(WeaponMods.NoRecoil.RecoilConnections, connection)
                    end
                end
            end
        end
    end
end

-- No Spread Implementation  
local function applyNoSpread()
    if not WeaponMods.NoSpread.Enabled then return end
    
    -- Method 1: Spread folder modification
    if weaponSystem then
        for _, obj in pairs(weaponSystem:GetDescendants()) do
            if (obj:IsA("NumberValue") or obj:IsA("IntValue")) then
                if isInSpreadFolder(obj) then
                    if not WeaponMods.NoSpread.OriginalSpread[obj] then
                        WeaponMods.NoSpread.OriginalSpread[obj] = obj.Value
                    end
                    obj.Value = 0
                    
                    local connection = obj.Changed:Connect(function()
                        if WeaponMods.NoSpread.Enabled and obj.Value ~= 0 then
                            obj.Value = 0
                        end
                    end)
                    table.insert(WeaponMods.NoSpread.SpreadConnections, connection)
                end
                
                -- Direct spread values
                if isSpreadValue(obj) then
                    if not WeaponMods.NoSpread.OriginalSpread[obj] then
                        WeaponMods.NoSpread.OriginalSpread[obj] = obj.Value
                    end
                    obj.Value = 0
                    
                    local connection = obj.Changed:Connect(function()
                        if WeaponMods.NoSpread.Enabled and obj.Value ~= 0 then
                            obj.Value = 0
                        end
                    end)
                    table.insert(WeaponMods.NoSpread.SpreadConnections, connection)
                end
            end
        end
    end
    
    -- Method 2: Character tool modification
    local character = LocalPlayer.Character
    if character then
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                for _, obj in pairs(tool:GetDescendants()) do
                    if (obj:IsA("NumberValue") or obj:IsA("IntValue")) then
                        if isSpreadValue(obj) or isInSpreadFolder(obj) then
                            if not WeaponMods.NoSpread.OriginalSpread[obj] then
                                WeaponMods.NoSpread.OriginalSpread[obj] = obj.Value
                            end
                            obj.Value = 0
                            
                            local connection = obj.Changed:Connect(function()
                                if WeaponMods.NoSpread.Enabled and obj.Value ~= 0 then
                                    obj.Value = 0
                                end
                            end)
                            table.insert(WeaponMods.NoSpread.SpreadConnections, connection)
                        end
                    end
                end
            end
        end
    end
end

-- Main loops for No Recoil and No Spread
local function noRecoilLoop()
    while true do
        if WeaponMods.NoRecoil.Enabled then
            -- Clear old connections
            for _, connection in pairs(WeaponMods.NoRecoil.RecoilConnections) do
                if connection then connection:Disconnect() end
            end
            WeaponMods.NoRecoil.RecoilConnections = {}
            
            applyNoRecoil()
        end
        wait(2)
    end
end

local function noSpreadLoop()
    while true do
        if WeaponMods.NoSpread.Enabled then
            -- Clear old connections
            for _, connection in pairs(WeaponMods.NoSpread.SpreadConnections) do
                if connection then connection:Disconnect() end
            end
            WeaponMods.NoSpread.SpreadConnections = {}
            
            applyNoSpread()
        end
        wait(2)
    end
end

-- Existing Rapid Fire Implementation (встроен в основной код)
local function rapidFireLoop()
    while true do
        if WeaponMods.RapidFire.Enabled then
            local character = LocalPlayer.Character
            if character then
                -- Метод 1: Модификация FireRate через ReplicatedStorage
                if weaponSystem then
                    for _, weapon in pairs(weaponSystem:GetChildren()) do
                        if weapon:FindFirstChild("FireRate") then
                            if not WeaponMods.RapidFire.OriginalFireRates[weapon.Name] then
                                WeaponMods.RapidFire.OriginalFireRates[weapon.Name] = weapon.FireRate.Value
                            end
                            weapon.FireRate.Value = WeaponMods.RapidFire.FireRate
                        end
                    end
                end
                
                -- Метод 2: Хук через Tool в Character
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") and tool:FindFirstChild("Gun") then
                        local gunScript = tool:FindFirstChild("GunScript") or tool:FindFirstChild("LocalScript")
                        if gunScript then
                            local fireRateValue = tool:FindFirstChild("FireRate") or tool.Gun:FindFirstChild("FireRate")
                            if fireRateValue and fireRateValue:IsA("NumberValue") then
                                if not WeaponMods.RapidFire.OriginalFireRates[tool.Name] then
                                    WeaponMods.RapidFire.OriginalFireRates[tool.Name] = fireRateValue.Value
                                end
                                fireRateValue.Value = WeaponMods.RapidFire.FireRate
                            end
                        end
                    end
                end
            end
        end
        wait(2)
    end
end

-- Existing Infinite Ammo Implementation (встроен в основной код)
local function infiniteAmmoLoop()
    while true do
        if WeaponMods.InfiniteAmmo.Enabled then
            local character = LocalPlayer.Character
            if character then
                -- Очистить старые подключения
                for _, connection in pairs(WeaponMods.InfiniteAmmo.AmmoConnections) do
                    if connection then connection:Disconnect() end
                end
                WeaponMods.InfiniteAmmo.AmmoConnections = {}
                
                -- ВСЕ ВОЗМОЖНЫЕ НАИМЕНОВАНИЯ ПАТРОНОВ
                local ammoNames = {
                    -- Основные
                    "Ammo", "ammo", "AMMO",
                    -- Количество
                    "MaxAmmo", "maxammo", "MAXAMMO", "Max_Ammo", "MAX_AMMO",
                    "CurrentAmmo", "currentammo", "CURRENTAMMO", "Current_Ammo", "CURRENT_AMMO",
                    "AmmoCount", "ammocount", "AMMOCOUNT", "Ammo_Count", "AMMO_COUNT",
                }
                
                -- Поиск и хук всех ammo значений в инструментах
                for _, tool in pairs(character:GetChildren()) do
                    if tool:IsA("Tool") then
                        -- Рекурсивный поиск ammo значений
                        local function searchAmmoValues(parent, depth)
                            if depth > 8 then return end
                            
                            for _, child in pairs(parent:GetChildren()) do
                                if (child:IsA("IntValue") or child:IsA("NumberValue")) then
                                    -- Проверяем имя на совпадение с любым из вариантов
                                    local isAmmo = false
                                    for _, ammoName in pairs(ammoNames) do
                                        if child.Name == ammoName then
                                            isAmmo = true
                                            break
                                        end
                                    end
                                    
                                    if isAmmo then
                                        local key = tool.Name .. "_" .. child.Name
                                        if not WeaponMods.InfiniteAmmo.OriginalAmmo[key] then
                                            WeaponMods.InfiniteAmmo.OriginalAmmo[key] = child.Value
                                        end
                                        
                                        -- Постоянное восстановление через цикл (15 СЕКУНД)
                                        spawn(function()
                                            while WeaponMods.InfiniteAmmo.Enabled and tool.Parent == character and child.Parent do
                                                if child.Value < 999999 then
                                                    child.Value = 999999
                                                end
                                                wait(15)
                                            end
                                        end)
                                        
                                        -- Дополнительный хук на изменения
                                        local connection = child.Changed:Connect(function()
                                            if WeaponMods.InfiniteAmmo.Enabled and child.Value < 999999 then
                                                child.Value = 999999
                                            end
                                        end)
                                        table.insert(WeaponMods.InfiniteAmmo.AmmoConnections, connection)
                                    end
                                end
                                
                                searchAmmoValues(child, depth + 1)
                            end
                        end
                        
                        searchAmmoValues(tool, 0)
                    end
                end
                
                -- GUI патроны
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    for _, gui in pairs(playerGui:GetDescendants()) do
                        if gui:IsA("TextLabel") and (gui.Name:lower():find("ammo") or gui.Text:find("%d+/%d+")) then
                            spawn(function()
                                while WeaponMods.InfiniteAmmo.Enabled and gui.Parent do
                                    if gui.Text:find("%d+/%d+") then
                                        local maxAmmo = gui.Text:match("/%d+") or "/999999"
                                        gui.Text = "999999" .. maxAmmo
                                    elseif gui.Text:match("Ammo: %d+") then
                                        gui.Text = "Ammo: 999999"
                                    elseif gui.Text:match("AMMO %d+") then
                                        gui.Text = "AMMO 999999"
                                    end
                                    wait(15)
                                end
                            end)
                        end
                    end
                end
                
                -- Поиск в ReplicatedStorage и Workspace
                for _, location in pairs({ReplicatedStorage, Workspace}) do
                    for _, obj in pairs(location:GetDescendants()) do
                        if (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
                            for _, ammoName in pairs(ammoNames) do
                                if obj.Name == ammoName then
                                    local key = "Global_" .. obj.Name .. "_" .. obj:GetFullName()
                                    if not WeaponMods.InfiniteAmmo.OriginalAmmo[key] then
                                        WeaponMods.InfiniteAmmo.OriginalAmmo[key] = obj.Value
                                    end
                                    
                                    spawn(function()
                                        while WeaponMods.InfiniteAmmo.Enabled and obj.Parent do
                                            if obj.Value < 999999 then
                                                obj.Value = 999999
                                            end
                                            wait(15)
                                        end
                                    end)
                                    
                                    local connection = obj.Changed:Connect(function()
                                        if WeaponMods.InfiniteAmmo.Enabled and obj.Value < 999999 then
                                            obj.Value = 999999
                                        end
                                    end)
                                    table.insert(WeaponMods.InfiniteAmmo.AmmoConnections, connection)
                                    
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(2)
    end
end

-- Restore original values (встроено в основной код)
local function restoreValues()
    -- Restore Fire Rates
    if weaponSystem then
        for weaponName, originalValue in pairs(WeaponMods.RapidFire.OriginalFireRates) do
            local weapon = weaponSystem:FindFirstChild(weaponName)
            if weapon and weapon:FindFirstChild("FireRate") then
                weapon.FireRate.Value = originalValue
            end
        end
    end
    
    -- Restore Ammo
    for key, originalValue in pairs(WeaponMods.InfiniteAmmo.OriginalAmmo) do
        if key:find("Global_") then
            -- Глобальные значения
            local name = key:match("Global_(.+)_")
            for _, location in pairs({ReplicatedStorage, Workspace}) do
                for _, obj in pairs(location:GetDescendants()) do
                    if obj.Name == name and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
                        obj.Value = originalValue
                    end
                end
            end
        else
            -- Tool значения
            local toolName, valueName = key:match("(.+)_(.+)")
            if toolName and valueName and LocalPlayer.Character then
                local tool = LocalPlayer.Character:FindFirstChild(toolName)
                if tool then
                    for _, obj in pairs(tool:GetDescendants()) do
                        if obj.Name == valueName and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
                            obj.Value = originalValue
                        end
                    end
                end
            end
        end
    end
    
    -- Restore Recoil values
    for inst, originalValue in pairs(WeaponMods.NoRecoil.OriginalRecoil) do
        if inst and inst.Parent then
            pcall(function()
                inst.Value = originalValue
            end)
        end
    end
    
    -- Restore Spread values
    for inst, originalValue in pairs(WeaponMods.NoSpread.OriginalSpread) do
        if inst and inst.Parent then
            pcall(function()
                inst.Value = originalValue
            end)
        end
    end
    
    -- Disconnect all connections
    for _, connection in pairs(WeaponMods.InfiniteAmmo.AmmoConnections) do
        if connection then connection:Disconnect() end
    end
    WeaponMods.InfiniteAmmo.AmmoConnections = {}
    
    for _, connection in pairs(WeaponMods.NoRecoil.RecoilConnections) do
        if connection then connection:Disconnect() end
    end
    WeaponMods.NoRecoil.RecoilConnections = {}
    
    for _, connection in pairs(WeaponMods.NoSpread.SpreadConnections) do
        if connection then connection:Disconnect() end
    end
    WeaponMods.NoSpread.SpreadConnections = {}
end

-- Auto-update when character spawns or tool changes
LocalPlayer.CharacterAdded:Connect(function(character)
    -- Cache original values when character spawns
    wait(1)
    cacheOriginalValues()
    
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            wait(0.5)
            -- Запуск циклов обновления
            if WeaponMods.RapidFire.Enabled then
                spawn(rapidFireLoop)
            end
            if WeaponMods.InfiniteAmmo.Enabled then
                spawn(infiniteAmmoLoop)
            end
            if WeaponMods.NoRecoil.Enabled then
                spawn(noRecoilLoop)
            end
            if WeaponMods.NoSpread.Enabled then
                spawn(noSpreadLoop)
            end
        end
    end)
    
    character.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") then
            -- Обновление при удалении инструмента
        end
    end)
end)

-- Запуск основных циклов
spawn(rapidFireLoop)
spawn(infiniteAmmoLoop)
spawn(noRecoilLoop)
spawn(noSpreadLoop)

-- Cache original values at start
cacheOriginalValues()

-- UI Integration
local WeaponTab = Window:NewTab("Weapon")
local RapidFireSection = WeaponTab:NewSection("Rapid Fire")
local AmmoSection = WeaponTab:NewSection("Ammo")
local RecoilSection = WeaponTab:NewSection("Recoil & Spread")

-- Rapid Fire Controls
RapidFireSection:NewToggle("Enable Rapid Fire", "Стреляй как пулемёт!", function(state)
    WeaponMods.RapidFire.Enabled = state
    if state then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rapid Fire",
            Text = "Врубил! Стреляй как безумный!",
            Duration = 2
        })
    else
        restoreValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rapid Fire",
            Text = "Вырубил, стреляй как лох!",
            Duration = 2
        })
    end
end)

RapidFireSection:NewSlider("Fire Rate", "Скорость стрельбы (0.001-0.1)", 0.1, 0.001, WeaponMods.RapidFire.FireRate, function(value)
    WeaponMods.RapidFire.FireRate = value
end)

-- Infinite Ammo Controls
AmmoSection:NewToggle("Enable Infinite Ammo", "Бесконечные патроны!", function(state)
    WeaponMods.InfiniteAmmo.Enabled = state
    if state then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Infinite Ammo",
            Text = "Врубил! Патроны бесконечные!",
            Duration = 2
        })
    else
        restoreValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Infinite Ammo",
            Text = "Вырубил, считай патроны!",
            Duration = 2
        })
    end
end)

-- NEW: No Recoil Controls
RecoilSection:NewToggle("Enable No Recoil", "Убрать отдачу оружия!", function(state)
    WeaponMods.NoRecoil.Enabled = state
    if state then
        cacheOriginalValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Recoil",
            Text = "Врубил! Отдачи больше нет!",
            Duration = 2
        })
    else
        restoreValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Recoil",
            Text = "Вырубил, отдача вернулась!",
            Duration = 2
        })
    end
end)

-- NEW: No Spread Controls
RecoilSection:NewToggle("Enable No Spread", "Убрать разброс пуль!", function(state)
    WeaponMods.NoSpread.Enabled = state
    if state then
        cacheOriginalValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Spread",
            Text = "Врубил! Разброса больше нет!",
            Duration = 2
        })
    else
        restoreValues()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Spread",
            Text = "Вырубил, разброс вернулся!",
            Duration = 2
        })
    end
end)

-- Hotkeys (обновлены)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        WeaponMods.RapidFire.Enabled = not WeaponMods.RapidFire.Enabled
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Rapid Fire",
            Text = WeaponMods.RapidFire.Enabled and "Включен!" or "Выключен!",
            Duration = 1
        })
    elseif input.KeyCode == Enum.KeyCode.F2 then
        WeaponMods.InfiniteAmmo.Enabled = not WeaponMods.InfiniteAmmo.Enabled
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Infinite Ammo",
            Text = WeaponMods.InfiniteAmmo.Enabled and "Включен!" or "Выключен!",
            Duration = 1
        })
    elseif input.KeyCode == Enum.KeyCode.F3 then
        WeaponMods.NoRecoil.Enabled = not WeaponMods.NoRecoil.Enabled
        if not WeaponMods.NoRecoil.Enabled then restoreValues() end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Recoil",
            Text = WeaponMods.NoRecoil.Enabled and "Включен!" or "Выключен!",
            Duration = 1
        })
    elseif input.KeyCode == Enum.KeyCode.F4 then
        WeaponMods.NoSpread.Enabled = not WeaponMods.NoSpread.Enabled
        if not WeaponMods.NoSpread.Enabled then restoreValues() end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "No Spread",
            Text = WeaponMods.NoSpread.Enabled and "Включен!" or "Выключен!",
            Duration = 1
        })
    end
end)

-- Auto-detection and modification on tool equip
spawn(function()
    while true do
        if LocalPlayer.Character then
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") and tool.Parent == LocalPlayer.Character then
                    break
                end
            end
        end
        wait(3)
    end
end)

print("[Enhanced Weapon Mods] Loaded successfully!")
print("[Features] RapidFire | InfiniteAmmo | NoRecoil | NoSpread")
print("[Hotkeys] F1=RapidFire | F2=InfAmmo | F3=NoRecoil | F4=NoSpread")
print("[Status] All weapon modifications ready!")

-- Cleanup on exit
LocalPlayer.CharacterRemoving:Connect(function()
    ClearAllESP()
    ClearAllSkeletons()
    ClearAllTracers()
end)
