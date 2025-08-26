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
        MaxDistance = 99999,
        TargetFPS = 60,
        AutoCleanup = {
            Enabled = false,
            Interval = 5.55
        }
    },
    Skeletons = {
        Enabled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1,
        IgnoreTeamCheck = false,
        MaxDistance = 99999,
        TargetFPS = 60
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
        JumpSpeed = 32,
        JumpHeight = 25,
        MovementThreshold = 0.3
    },
    Chams = {
   		Enabled = false,
   		EnemyColor = Color3.fromRGB(255, 0, 0),
   		TeamColor = Color3.fromRGB(0, 255, 0),
   		Transparency = 0.5,
  		VisibilityMode = "ThroughWalls",
  		OutlineEnabled = false,
  		OutlineColor = Color3.fromRGB(255, 255, 255),
  		OutlineThickness = 2,
 		Material = Enum.Material.Plastic,
 		RainbowEnabled = false,
		RainbowSpeed = 1,
 		PulseEnabled = false,
  		PulseSpeed = 1,
  		PulseMinTransparency = 0.3,
  		PulseMaxTransparency = 0.7
    }
}

-- Service caching
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Menu (Kavo UI)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/refs/heads/main/source.lua"))()
local Window = Library.CreateLib("t.me/amyr_softikk", "DarkTheme")

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
SkeletonsSection:NewSlider("Max Distance", "Skeletons render distance", 99999, 100, Settings.Skeletons.MaxDistance, function(value)
    Settings.Skeletons.MaxDistance = value
end)
SkeletonsSection:NewSlider("Target FPS", "Skeletons refresh rate", 60, 30, Settings.Skeletons.TargetFPS, function(value)
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
    "Plastic", "SmoothPlastic", "Neon", "Glass", "Metal", "Wood", "WoodPlanks", "Marble", "Granite", "Brick", "Pebble", "CobbleStone", "Sand", "Fabric", "Foil", "Asphalt", "Basalt", "Concrete", "CorrodedMetal", "DiamondPlate", "ForceField", "Grass", "Ground", "Ice", "LeafyGrass", "Limestone", "Mud", "Pavement", "Rock", "Salt", "Sandstone", "Slate", "Snow", "Water"
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
MiscSection:NewSlider("Max Distance", "ESP render distance", 99999, 100, Settings.ESP.MaxDistance, function(value)
    Settings.ESP.MaxDistance = value
end)
MiscSection:NewSlider("Target FPS", "ESP refresh rate", 60, 30, Settings.ESP.TargetFPS, function(value)
    Settings.ESP.TargetFPS = value
end)

-- Bunny Hop
local BHopSettings = {
    Enabled = false,
    GroundSpeed = 20,
    JumpSpeed = 32,
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
    
    local rootPart = character:FindFirstChild("Head")
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
local aimbotEnabled = false -- включен/выключен
local aimRadius = 333 -- радиус действия аимбота
local aimKey = Enum.KeyCode.E -- клавиша переключения

-- круг зоны аимбота
local aimCircle = Drawing.new("Circle")
aimCircle.Visible = true
aimCircle.Transparency = 0.5
aimCircle.Color = Color3.new(1, 0, 0) -- красный (выкл)
aimCircle.Thickness = 3.33
aimCircle.Radius = aimRadius

-- обновление позиции круга
local function updateAimCircle()
    local mousePosition = UserInputService:GetMouseLocation()
    aimCircle.Position = mousePosition
end

-- поиск ближайшего врага
local function getClosestEnemy()
    local closestPlayer = nil
    local shortestDistance = aimRadius

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer
            and player.Team ~= localPlayer.Team -- враг
            and player.Character
            and player.Character:FindFirstChild("Head")
            and player.Character:FindFirstChildOfClass("Humanoid")
        then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid.Health > 0 then -- жив
                local Head = player.Character.Head
                local screenPosition = camera:WorldToViewportPoint(Head.Position)

                -- считаем расстояние до курсора (даже если враг за спиной)
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

-- наведение камеры на врага
local function aimAtTarget(target)
    if target
        and target.Character
        and target.Character:FindFirstChild("Head")
        and target.Character:FindFirstChildOfClass("Humanoid")
        and target.Character:FindFirstChildOfClass("Humanoid").Health > 0
    then
        local Head = target.Character.Head
        camera.CFrame = CFrame.new(camera.CFrame.Position, Head.Position)
    end
end

-- обновление аимбота (каждый кадр)
RunService.RenderStepped:Connect(function()
    updateAimCircle()

    if aimbotEnabled then
        local target = getClosestEnemy()
        aimAtTarget(target)
    end
end)

-- переключение клавишей
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == aimKey then
        aimbotEnabled = not aimbotEnabled
        aimCircle.Color = aimbotEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0) -- зелёный/красный
        print("Аимбот " .. (aimbotEnabled and "включен" or "выключен"))
    end
end)

-- Настройки легит-аима I
local iAimbotEnabled = false
local iAimKey = Enum.KeyCode.I
local iAimCircle = Drawing.new("Circle")
iAimCircle.Visible = true
iAimCircle.Transparency = 0.5
iAimCircle.Color = Color3.new(1,0,0) -- красный по умолчанию (выкл)
iAimCircle.Thickness = 3.33
iAimCircle.Radius = 456

local smoothness = 0.001 -- плавность движения камеры

-- Проверка прямой видимости с учётом простреливаемых материалов
local function isVisible(part)
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
    raycastParams.IgnoreWater = true

    local ray = workspace:Raycast(origin, direction, raycastParams)
    if ray then
        -- Если луч попал в часть игрока — видим
        if ray.Instance:IsDescendantOf(part.Parent) then
            return true
        end
        -- Если часть простреливаемая (ThinWall, Glass и т.д.), тоже считаем видимой
        local penetrableMaterials = {
   		Enum.Material.Glass,
    	Enum.Material.Wood,
    	Enum.Material.WoodPlanks,
    	Enum.Material.Metal,
    	Enum.Material.CorrodedMetal, 
		Enum.Material.ForceField, 
		Enum.Material.SmoothPlastic
        }
        if table.find(penetrableMaterials, ray.Instance.Material) then
            return true
        end
        return false
    end
    return true
end


RunService.RenderStepped:Connect(function()
    iAimCircle.Position = UserInputService:GetMouseLocation()

    if iAimbotEnabled then
        local target = getClosestEnemy() -- используем твою функцию поиска ближайшего игрока
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local part = target.Character:FindFirstChild("Head")
            if isVisible(part) then
                local rootPos = part.Position
                local camPos = camera.CFrame.Position
                local newCFrame = CFrame.new(camPos, camPos:Lerp(rootPos, smoothness))
                camera.CFrame = newCFrame
            end
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == iAimKey then
        iAimbotEnabled = not iAimbotEnabled
        iAimCircle.Color = iAimbotEnabled and Color3.new(1,1,0) or Color3.new(1,0,0) -- включён = жёлтый, выключен = красный
        print("Легит-аим I " .. (iAimbotEnabled and "включен" or "выключен"))
    end
end)


-- Настройки триггер-бота
local triggerEnabled = false
local triggerKey = Enum.KeyCode.H
local hitParts = {"Head", "UpperTorso", "Head"}

-- Проверка прямой видимости с учётом простреливаемых материалов
local function isVisible(part)
    local origin = workspace.CurrentCamera.CFrame.Position
    local direction = (part.Position - origin).Unit * (part.Position - origin).Magnitude
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
    raycastParams.IgnoreWater = true

    local ray = workspace:Raycast(origin, direction, raycastParams)
    if ray then
        -- Если луч попал в часть игрока — видим
        if ray.Instance:IsDescendantOf(part.Parent) then
            return true
        end
        -- Если часть простреливаемая (ThinWall, Glass и т.д.), тоже считаем видимой
        local penetrableMaterials = {
   		Enum.Material.Glass,
    	Enum.Material.Wood,
    	Enum.Material.WoodPlanks,
    	Enum.Material.Metal,
    	Enum.Material.CorrodedMetal, 
		Enum.Material.ForceField, 
		Enum.Material.SmoothPlastic
        }
        if table.find(penetrableMaterials, ray.Instance.Material) then
            return true
        end
        return false
    end
    return true
end




-- Триггер-бот
local function triggerBot()
    if not triggerEnabled then return end
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Team ~= localPlayer.Team and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                for _, partName in ipairs(hitParts) do
                    local part = player.Character:FindFirstChild(partName)
                    if part then
                        local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                            if dist <= 6 and isVisible(part) then
                                -- firebullet если доступно
                                local tool = localPlayer.Character:FindFirstChild("EquippedTool")
                                local clientGui = localPlayer.PlayerGui:FindFirstChild("Client")
                                if clientGui and tool and game.ReplicatedStorage.Weapons:FindFirstChild(tool.Value) then
                                    local fireFunc = getsenv(clientGui).firebullet
                                    if typeof(fireFunc) == "function" then
                                        fireFunc()
                                        task.wait(game.ReplicatedStorage.Weapons[tool.Value].FireRate.Value)
                                        return
                                    end
                                end
                                -- fallback на мышь
                                mouse1press()
                                task.wait(0.001)
                                mouse1release()
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Добавляем RenderStepped для триггер-бота отдельно, не трогая аим
RunService.RenderStepped:Connect(function()
    if triggerEnabled then
        triggerBot()
    end
end)

-- Переключение клавиш
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == triggerKey then
        triggerEnabled = not triggerEnabled
        print("Триггер-бот " .. (triggerEnabled and "включен" or "выключен"))
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
local FOV_TWEEN_TIME = 0.9 -- Время анимации FOV
local FOV_MAX = 250 -- Макс FOV при беге
local FOV_MIN = 180 -- Стандартный FOV
local STAMINA_MAX = 999 -- Максимум стамины
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
FOVSection:NewSlider("Min FOV", "Стандартный FOV (70-120)", 180, 120, FOV_MIN, function(value)
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

-- Улучшенная версия Anti-Aim для Kavo UI
-- Оптимизация производительности и стабильности

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera

-- Улучшенная загрузка игры
local function waitForGameLoad()
    repeat 
        RunService.Heartbeat:Wait() 
    until game:IsLoaded()
    
    repeat 
        RunService.Heartbeat:Wait() 
    until LocalPlayer.PlayerGui:FindFirstChild("GUI")
end

waitForGameLoad()

-- Улучшенное получение cbClient
local cbClient = nil
local function getCbClient()
    local success, result = pcall(function()
        if getsenv and LocalPlayer.PlayerGui:FindFirstChild("Client") then
            return getsenv(LocalPlayer.PlayerGui.Client)
        end
        return nil
    end)
    return success and result or nil
end

cbClient = getCbClient()

-- UI Creation (assuming Window is defined from a UI library like Rayfield or Kavo)
local AntiAimTab = Window:NewTab("Anti-Aim")
local AntiAimSection = AntiAimTab:NewSection("Anti-Aim Settings")

-- Улучшенные настройки
local AntiAimSettings = {
    Enabled = false,
    Pitch = "Default",
    Yaw = "Default", 
    YawStrength = 50,
    RemoveHeadHitbox = false,
    DisableWhileClimbing = false,
    SmoothRotation = true,
    RotationSpeed = 15,
    AntiResolver = false,
    JitterMode = false,
    ManualKeys = {
        Forward = nil,
        Left = nil,
        Right = nil, 
        Backward = nil,
        Spin = nil
    }
}

-- Кэширование для производительности
local bodyGyroCache = {}
local lastRotation = tick()
local currentBodyGyro = nil
local currentBodyAngular = nil

-- Улучшенные функции
local function IsAlive(plr)
    plr = plr or LocalPlayer
    return plr and plr.Character and plr.Character:FindFirstChild("Humanoid") 
           and plr.Character.Humanoid.Health > 0 
           and plr.Character:FindFirstChild("UpperTorso")
end

local function GetTeam(plr)
    return plr.Team and Teams:FindFirstChild(plr.Team.Name)
end

-- Оптимизированная функция поворота с сглаживанием
local function RotatePlayer(targetCFrame, smooth)
    if not IsAlive() then return end
    
    local character = LocalPlayer.Character
    local upperTorso = character.UpperTorso
    
    -- Очистка старого BodyGyro
    if currentBodyGyro then
        currentBodyGyro:Destroy()
        currentBodyGyro = nil
    end
    
    -- Создание нового BodyGyro
    local gyro = Instance.new('BodyGyro')
    gyro.D = smooth and 500 or 0
    gyro.P = AntiAimSettings.YawStrength * 100
    gyro.MaxTorque = Vector3.new(0, AntiAimSettings.YawStrength * 1000, 0) -- Increased for better control
    gyro.Parent = upperTorso
    
    if smooth and AntiAimSettings.SmoothRotation then
        -- Плавный поворот с использованием TweenService
        local currentCFrame = upperTorso.CFrame
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(gyro, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        
        tween.Completed:Connect(function()
            if gyro.Parent then
                gyro:Destroy()
            end
        end)
        
        currentBodyGyro = gyro
    else
        gyro.CFrame = targetCFrame
        
        -- Автоматическая очистка через небольшой промежуток времени
        game:GetService("Debris"):AddItem(gyro, 0.03)
    end
end

-- Улучшенный Jitter режим
local jitterAngles = {45, 90, 180, 270}
local jitterIndex = 1

local function getJitterAngle()
    jitterIndex = (jitterIndex % #jitterAngles) + 0.000001
    return jitterAngles[jitterIndex]
end

-- Главный цикл Anti-Aim с оптимизацией
local AntiAimConnection = nil

local function startAntiAim()
    if AntiAimConnection then
        AntiAimConnection:Disconnect()
    end
    
    AntiAimConnection = RunService.Heartbeat:Connect(function()
        if not AntiAimSettings.Enabled or not IsAlive() then return end
        
        -- Проверка лазания (оптимизированная)
        if AntiAimSettings.DisableWhileClimbing then
            cbClient = cbClient or getCbClient()
            if cbClient and cbClient.climbing then return end
        end
        
        -- Удаление головы (оптимизированное)
        if AntiAimSettings.RemoveHeadHitbox then
            local character = LocalPlayer.Character
            for _, partName in ipairs({"HeadHB", "FakeHead"}) do
                local part = character:FindFirstChild(partName)
                if part then part:Destroy() end
            end
            
            local head = character:FindFirstChild("Head")
            if head and head.Transparency ~= 1 then
                head.Transparency = 1
            end
        end
        
        -- Логика поворота (улучшенная)
        local humanoid = LocalPlayer.Character.Humanoid
        local character = LocalPlayer.Character
        local upperTorso = character.UpperTorso
        local shouldRotate = table.find({"Forward", "Backward", "Left", "Right", "Spin"}, AntiAimSettings.Yaw)
        
        if shouldRotate then
            humanoid.AutoRotate = false
            
            local cameraRotation = CurrentCamera.CFrame - CurrentCamera.CFrame.Position  -- Rotation part only
            local yawOffset = 0
            local useGyro = true
            local targetCFrame
            
            -- Define yaw offsets
            local yawOffsets = {
                Forward = 45,
                Backward = 180,
                Left = 90,
                Right = -90
            }
            
            if AntiAimSettings.Yaw == "Spin" then
                if AntiAimSettings.JitterMode then
                    -- Jitter spin with gyro
                    yawOffset = getJitterAngle()
                    useGyro = true
                else
                    -- Continuous spin with BodyAngularVelocity
                    useGyro = false
                    if not currentBodyAngular then
                        currentBodyAngular = Instance.new("BodyAngularVelocity")
                        currentBodyAngular.MaxTorque = Vector3.new(0, math.huge, 0)
                        currentBodyAngular.P = 3000
                        currentBodyAngular.Parent = upperTorso
                    end
                    -- Update angular velocity every frame to reflect slider changes
                    currentBodyAngular.AngularVelocity = Vector3.new(0, math.rad(AntiAimSettings.RotationSpeed * 10), 0)  -- Multiplied by 10 for faster spin
                end
            else
                yawOffset = yawOffsets[AntiAimSettings.Yaw] or 0
                useGyro = true
            end
            
            -- Apply anti-resolver randomization if enabled
            if AntiAimSettings.AntiResolver then
                yawOffset = yawOffset + math.random(-45, 45)  -- Small randomization for desync
            end
            
            if useGyro then
                -- Cleanup angular if active
                if currentBodyAngular then
                    currentBodyAngular:Destroy()
                    currentBodyAngular = nil
                end
                
                -- Calculate target CFrame with offset
                targetCFrame = CFrame.new(upperTorso.Position) * cameraRotation * CFrame.Angles(0, math.rad(yawOffset), 0)
                RotatePlayer(targetCFrame, AntiAimSettings.SmoothRotation)
            end
        elseif humanoid.AutoRotate == false then
            humanoid.AutoRotate = true
            
            -- Cleanup effectors
            if currentBodyGyro then
                currentBodyGyro:Destroy()
                currentBodyGyro = nil
            end
            if currentBodyAngular then
                currentBodyAngular:Destroy()
                currentBodyAngular = nil
            end
        end
    end)
end

local function stopAntiAim()
    if AntiAimConnection then
        AntiAimConnection:Disconnect()
        AntiAimConnection = nil
    end
    
    if currentBodyGyro then
        currentBodyGyro:Destroy()
        currentBodyGyro = nil
    end
    
    if currentBodyAngular then
        currentBodyAngular:Destroy()
        currentBodyAngular = nil
    end
    
    if IsAlive() then
        LocalPlayer.Character.Humanoid.AutoRotate = true
    end
end

-- UI Elements (улучшенные)
AntiAimSection:NewToggle("Enabled", "Enable/Disable Anti-Aim", function(val)
    AntiAimSettings.Enabled = val
    
    if val then
        startAntiAim()
    else
        stopAntiAim()
    end
end)

AntiAimSection:NewDropdown("Pitch", "Select pitch mode", {"Default", "Up", "Down", "Boneless", "Random"}, function(val)
    AntiAimSettings.Pitch = val
end)

AntiAimSection:NewDropdown("Yaw", "Select yaw mode", {"Default", "Forward", "Backward", "Left", "Right", "Spin"}, function(val)
    AntiAimSettings.Yaw = val
end)

AntiAimSection:NewSlider("Yaw Strength", "Yaw strength", 100, 0, function(val)
    AntiAimSettings.YawStrength = val
end)

AntiAimSection:NewSlider("Rotation Speed", "Rotation speed for spin mode", 1000, 25, function(val)  -- Increased max to 100 for more range
    AntiAimSettings.RotationSpeed = val
end)

AntiAimSection:NewToggle("Smooth Rotation", "Enable smooth rotation", function(val)
    AntiAimSettings.SmoothRotation = val
end)

AntiAimSection:NewToggle("Jitter Mode", "Enable jitter for spin mode", function(val)
    AntiAimSettings.JitterMode = val
end)

AntiAimSection:NewToggle("Remove Head Hitbox", "Remove head hitbox", function(val)
    AntiAimSettings.RemoveHeadHitbox = val
end)

AntiAimSection:NewToggle("Disable While Climbing", "Disable while climbing", function(val)
    AntiAimSettings.DisableWhileClimbing = val
end)

AntiAimSection:NewToggle("Anti-Resolver", "Enable anti-resolver", function(val)
    AntiAimSettings.AntiResolver = val
end)

-- Manual Controls
local ManualSection = AntiAimTab:NewSection("Manual Controls")

local manualKeys = {
    {"Manual Forward", "Forward"},
    {"Manual Left", "Left"},
    {"Manual Right", "Right"},
    {"Manual Backward", "Backward"},
    {"Manual Spin", "Spin"}
}

for _, keyData in ipairs(manualKeys) do
    ManualSection:NewKeybind(keyData[1], "Manual " .. keyData[2]:lower(), Enum.KeyCode.Unknown, function()
        if not UserInputService:GetFocusedTextBox() then 
            AntiAimSettings.Yaw = keyData[2]
        end
    end)
end

-- Улучшенный Pitch Hook
local function setupPitchHook()
    local success, error = pcall(function()
        if not hookmetamethod or not getnamecallmethod then return end
        
        local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if not checkcaller() and method == "FireServer" and self.Name == "ControlTurn" 
               and AntiAimSettings.Enabled and AntiAimSettings.Pitch ~= "Default" then
                
                local pitchValues = {
                    Up = 1,
                    Down = -1, 
                    Boneless = -5,
                    Random = math.random() > 0.5 and 1 or -1
                }
                
                local pitchValue = pitchValues[AntiAimSettings.Pitch]
                if pitchValue then
                    args[1] = AntiAimSettings.AntiResolver and pitchValue * math.random(0.8, 1.2) or pitchValue
                end
            end
            
            return oldNamecall(self, unpack(args))
        end)
    end)
    
    if not success then
        warn("Не удалось установить pitch hook: " .. tostring(error))
    end
end

setupPitchHook()

-- Cleanup при выходе
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        stopAntiAim()
    end
end)

--rapid
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

-- Вкладки
local WeatherTab = Window:NewTab("Weather")
local SkyboxTab = Window:NewTab("Skyboxes")
local OtherTab = Window:NewTab("Other")

-- Weather
local WeatherSection = WeatherTab:NewSection("Effects")

-- Слайдер для FogStart
WeatherSection:NewSlider("Fog Start", "Distance where fog starts", 0, 0, function(v)
    game.Lighting.FogStart = v
end)

-- Слайдер для FogEnd
WeatherSection:NewSlider("Fog End", "Distance where fog ends", 1000, 50, function(v)
    game.Lighting.FogEnd = v
end)

-- Color3 пикер для цвета тумана
WeatherSection:NewColorPicker("Fog Color", "Choose fog color", game.Lighting.FogColor, function(c)
    game.Lighting.FogColor = c
end)

-- Enable Rain
WeatherSection:NewButton("Enable Rain", "Add rain particles", function()
    if not game.Workspace:FindFirstChild("RainPart") then
        local part = Instance.new("Part")
        part.Name = "RainPart"
        part.Size = Vector3.new(1,1,1)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.Position = game.Players.LocalPlayer.Character.Head.Position + Vector3.new(0, 50, 0)
        part.Parent = game.Workspace

        local emitter = Instance.new("ParticleEmitter", part)
        emitter.Texture = "rbxassetid://241876605"
        emitter.Rate = 500
        emitter.Lifetime = NumberRange.new(1,2)
        emitter.Speed = NumberRange.new(40,60)
        emitter.VelocitySpread = 180
    end
end)

-- Disable Rain
WeatherSection:NewButton("Disable Rain", "Remove rain particles", function()
    if game.Workspace:FindFirstChild("RainPart") then
        game.Workspace.RainPart:Destroy()
    end
end)

-- Skyboxes
local SkyboxSection = SkyboxTab:NewSection("Skyboxes")
local skyboxes = {
    {name = "Galaxy", id = "rbxassetid://10258337305"},
    {name = "Starry Night", id = "rbxassetid://12064107"},
    {name = "Sunset", id = "rbxassetid://12064131"},
    {name = "Night Sky", id = "rbxassetid://12064152"},
    {name = "Thunderstorm", id = "rbxassetid://12064121"},
}

local function setSkybox(id)
    -- Удаляем старые Sky
    for _,v in pairs(game.Lighting:GetChildren()) do
        if v:IsA("Sky") then
            v:Destroy()
        end
    end
    local sky = Instance.new("Sky")
    sky.SkyboxBk = id
    sky.SkyboxDn = id
    sky.SkyboxFt = id
    sky.SkyboxLf = id
    sky.SkyboxRt = id
    sky.SkyboxUp = id
    sky.Parent = game.Lighting
end

for _, skybox in ipairs(skyboxes) do
    SkyboxSection:NewButton(skybox.name, "Set skybox: " .. skybox.name, function()
        setSkybox(skybox.id)
    end)
end

-- Other
local OtherSection = OtherTab:NewSection("Miscellaneous")
OtherSection:NewButton("Day", "Set daytime", function()
    game.Lighting.ClockTime = 14
end)
OtherSection:NewButton("Night", "Set night time", function()
    game.Lighting.ClockTime = 0
end)
OtherSection:NewSlider("Time of Day", "Adjust time of day", 24, 0, function(v)
    game.Lighting.ClockTime = v
end)

-- Очистка при выходе персонажа
game.Players.LocalPlayer.CharacterRemoving:Connect(function()
    if game.Workspace:FindFirstChild("RainPart") then
        game.Workspace.RainPart:Destroy()
    end
end)

-- Third Person для Kavo UI Library

-- Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CurrentCamera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- Переменные для третьего лица
local ThirdPersonEnabled = false
local ThirdPersonDistance = 10
local ThirdPersonKeybind = Enum.KeyCode.V

-- Helper function
local function IsAlive(plr)
	if plr and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end
	return false
end

-- Функция включения/выключения третьего лица
local function ToggleThirdPerson(enabled)
	ThirdPersonEnabled = enabled
	
	if enabled then
		-- Включаем третье лицо
		RunService:BindToRenderStep("ThirdPerson", 100, function()
			if LocalPlayer.CameraMinZoomDistance ~= ThirdPersonDistance then
				LocalPlayer.CameraMinZoomDistance = ThirdPersonDistance
				LocalPlayer.CameraMaxZoomDistance = ThirdPersonDistance
				if workspace:FindFirstChild("ThirdPerson") then
					workspace.ThirdPerson.Value = true
				end
			end
		end)
	else
		-- Выключаем третье лицо
		RunService:UnbindFromRenderStep("ThirdPerson")
		if IsAlive(LocalPlayer) then
			wait()
			if workspace:FindFirstChild("ThirdPerson") then
				workspace.ThirdPerson.Value = false
			end
			LocalPlayer.CameraMinZoomDistance = 0
			LocalPlayer.CameraMaxZoomDistance = 0
		end
	end
end

-- Создаем вкладку Visuals
local VisualsSection = VisualsTab:NewSection("Visuals")
local ThirdPersonSection = VisualsTab:NewSection("Third Person")

-- Toggle для включения третьего лица
ThirdPersonSection:NewToggle("Enable Third Person", "Включить/выключить режим третьего лица", function(state)
    ToggleThirdPerson(state)
end)

-- Слайдер для дистанции
ThirdPersonSection:NewSlider("Distance", "Дистанция камеры от персонажа", 50, 10, function(s)
    ThirdPersonDistance = s
    -- Обновляем дистанцию если третье лицо включено
    if ThirdPersonEnabled then
        LocalPlayer.CameraMinZoomDistance = s
        LocalPlayer.CameraMaxZoomDistance = s
    end
end)

-- Keybind для быстрого переключения
ThirdPersonSection:NewKeybind("Toggle Keybind", "Клавиша для переключения", Enum.KeyCode.V, function()
	if UserInputService:GetFocusedTextBox() == nil then
		ThirdPersonEnabled = not ThirdPersonEnabled
		ToggleThirdPerson(ThirdPersonEnabled)
	end
end)


-- Альтернативный способ без hooks (более совместимый)
local function AlternativeThirdPerson(enabled, distance)
	if enabled then
		-- Простой способ через изменение свойств камеры
		spawn(function()
			while ThirdPersonEnabled and IsAlive(LocalPlayer) do
				LocalPlayer.CameraMode = Enum.CameraMode.Classic
				LocalPlayer.CameraMinZoomDistance = distance or 10
				LocalPlayer.CameraMaxZoomDistance = distance or 10
				wait(0.1)
			end
		end)
	else
		LocalPlayer.CameraMode = Enum.CameraMode.Classic
		LocalPlayer.CameraMinZoomDistance = 0.5
		LocalPlayer.CameraMaxZoomDistance = 400
	end
end

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")

-- Get LocalPlayer
local LocalPlayer = Players.LocalPlayer

-- Create Sections
local VisualsTabCategoryViewmodel = VisualsTab:NewSection("Viewmodel")
local VisualsTabCategoryOthers = VisualsTab:NewSection("Others")
local OtherTabCategoryMain = MiscTab:NewSection("Main")

-- Get WeaponsViewmodels
local WeaponsViewmodels = workspace.Camera:FindFirstChild("Arms") or workspace:FindFirstChild("WeaponsViewmodels") or workspace.Camera

-- Helper function for safe execution
local function SafeCall(func)
    local success, error = pcall(func)
    if not success then
        warn("Error executing function: " .. tostring(error))
    end
end

-- Arms Color/Material/Transparency
VisualsTabCategoryViewmodel:NewColorPicker("Arms Color", "Arms Color", Color3.fromRGB(255, 255, 255), function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name == "Right Arm" or v.Name == "Left Arm") then
                v.Color = val
            end
        end
    end)
end)

VisualsTabCategoryViewmodel:NewSlider("Arms Transparency", "Arms Transparency", 100, 0, function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name == "Right Arm" or v.Name == "Left Arm") then
                v.Transparency = val / 100
            end
        end
    end)
end)

VisualsTabCategoryViewmodel:NewDropdown("Arms Material", "Arms Material", {"SmoothPlastic", "Neon", "ForceField", "Metal", "Wood", "Concrete"}, function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name == "Right Arm" or v.Name == "Left Arm") then
                v.Material = Enum.Material[val]
            end
        end
    end)
end)

-- Gloves Color/Material/Transparency
VisualsTabCategoryViewmodel:NewColorPicker("Gloves Color", "Gloves Color", Color3.fromRGB(255, 255, 255), function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and not table.find({"Right Arm", "Left Arm", "Flash"}, v.Name) and v.Transparency ~= 1 then
                v.Color = val
            end
        end
    end)
end)

VisualsTabCategoryViewmodel:NewSlider("Gloves Transparency", "Gloves Transparency", 100, 0, function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and not table.find({"Right Arm", "Left Arm", "Flash"}, v.Name) and v.Transparency ~= 1 then
                v.Transparency = val / 100
            end
        end
    end)
end)

VisualsTabCategoryViewmodel:NewDropdown("Gloves Material", "Gloves Material", {"SmoothPlastic", "Neon", "ForceField", "Metal", "Wood", "Concrete"}, function(val)
    SafeCall(function()
        for i, v in pairs(WeaponsViewmodels:GetDescendants()) do
            if v:IsA("BasePart") and not table.find({"Right Arm", "Left Arm", "Flash"}, v.Name) and v.Transparency ~= 1 then
                v.Material = Enum.Material[val]
            end
        end
    end)
end)

-- Camera FOV
VisualsTabCategoryViewmodel:NewSlider("Camera FOV", "Camera FOV", 120, 1, function(val)
    SafeCall(function()
        workspace.Camera.FieldOfView = val
    end)
end)

-- Visual Effects Removal
local RemoveEffects = {
    Scope = false,
    Flash = false,
    Smoke = false,
    BulletHoles = false,
    Blood = false
}

-- Remove Scope
VisualsTabCategoryOthers:NewToggle("Remove Scope", "Remove Scope", function(val)
    RemoveEffects.Scope = val
    SafeCall(function()
        local gui = LocalPlayer.PlayerGui:FindFirstChild("GUI")
        if gui and gui:FindFirstChild("Crosshairs") then
            local crosshairs = gui.Crosshairs
            if val then
                -- Hide scope elements
                if crosshairs:FindFirstChild("Scope") then
                    crosshairs.Scope.ImageTransparency = 1
                    if crosshairs.Scope:FindFirstChild("Scope") then
                        crosshairs.Scope.Scope.ImageTransparency = 1
                        crosshairs.Scope.Scope.Size = UDim2.new(2, 0, 2, 0)
                        crosshairs.Scope.Scope.Position = UDim2.new(-0.5, 0, -0.5, 0)
                        if crosshairs.Scope.Scope:FindFirstChild("Blur") then
                            crosshairs.Scope.Scope.Blur.ImageTransparency = 1
                            if crosshairs.Scope.Scope.Blur:FindFirstChild("Blur") then
                                crosshairs.Scope.Scope.Blur.Blur.ImageTransparency = 1
                            end
                        end
                    end
                end
                -- Hide crosshair frames
                for i = 1, 4 do
                    local frame = crosshairs:FindFirstChild("Frame" .. i)
                    if frame then
                        frame.Transparency = 1
                    end
                end
            else
                -- Show scope elements
                if crosshairs:FindFirstChild("Scope") then
                    crosshairs.Scope.ImageTransparency = 0
                    if crosshairs.Scope:FindFirstChild("Scope") then
                        crosshairs.Scope.Scope.ImageTransparency = 0
                        crosshairs.Scope.Scope.Size = UDim2.new(1, 0, 1, 0)
                        crosshairs.Scope.Scope.Position = UDim2.new(0, 0, 0, 0)
                        if crosshairs.Scope.Scope:FindFirstChild("Blur") then
                            crosshairs.Scope.Scope.Blur.ImageTransparency = 0
                            if crosshairs.Scope.Scope.Blur:FindFirstChild("Blur") then
                                crosshairs.Scope.Scope.Blur.Blur.ImageTransparency = 0
                            end
                        end
                    end
                end
                -- Show crosshair frames
                for i = 1, 4 do
                    local frame = crosshairs:FindFirstChild("Frame" .. i)
                    if frame then
                        frame.Transparency = 0
                    end
                end
            end
        end
    end)
end)

-- Remove Flash
VisualsTabCategoryOthers:NewToggle("Remove Flash", "Remove Flash", function(val)
    RemoveEffects.Flash = val
    SafeCall(function()
        local blnd = LocalPlayer.PlayerGui:FindFirstChild("Blnd")
        if blnd then
            blnd.Enabled = not val
        end
    end)
end)

-- Remove Smoke
VisualsTabCategoryOthers:NewToggle("Remove Smoke", "Remove Smoke", function(val)
    RemoveEffects.Smoke = val
    SafeCall(function()
        if val then
            local rayIgnore = workspace:FindFirstChild("Ray_Ignore")
            if rayIgnore then
                local smokes = rayIgnore:FindFirstChild("Smokes")
                if smokes then
                    for i, v in pairs(smokes:GetChildren()) do
                        if v.Name == "Smoke" then
                            v:Destroy()
                        end
                    end
                end
            end
        end
    end)
end)

-- Remove Bullet Holes
VisualsTabCategoryOthers:NewToggle("Remove Bullet Holes", "Remove Bullet Holes", function(val)
    RemoveEffects.BulletHoles = val
    SafeCall(function()
        if val then
            local debris = workspace:FindFirstChild("Debris")
            if debris then
                for i, v in pairs(debris:GetChildren()) do
                    if v.Name == "Bullet" then
                        v:Destroy()
                    end
                end
            end
        end
    end)
end)

-- Remove Blood
VisualsTabCategoryOthers:NewToggle("Remove Blood", "Remove Blood", function(val)
    RemoveEffects.Blood = val
    SafeCall(function()
        if val then
            local debris = workspace:FindFirstChild("Debris")
            if debris then
                for i, v in pairs(debris:GetChildren()) do
                    if v.Name == "SurfaceGui" then
                        v:Destroy()
                    end
                end
            end
        end
    end)
end)

-- Effect Removal Connections
SafeCall(function()
    local rayIgnore = workspace:FindFirstChild("Ray_Ignore")
    if rayIgnore then
        local smokes = rayIgnore:FindFirstChild("Smokes")
        if smokes then
            smokes.ChildAdded:Connect(function(child)
                if child.Name == "Smoke" and RemoveEffects.Smoke then
                    task.wait()
                    child:Destroy()
                end
            end)
        end
    end
end)

SafeCall(function()
    local debris = workspace:FindFirstChild("Debris")
    if debris then
        debris.ChildAdded:Connect(function(child)
            if child.Name == "Bullet" and RemoveEffects.BulletHoles then
                task.wait()
                child:Destroy()
            elseif child.Name == "SurfaceGui" and RemoveEffects.Blood then
                task.wait()
                child:Destroy()
            end
        end)
    end
end)

-- Bullet Tracers
local BulletTracersEnabled = false
local BulletTracersColor = Color3.fromRGB(255, 0, 0)
local BulletTracersConnection

VisualsTabCategoryOthers:NewColorPicker("Bullet Tracers Color", "Bullet Tracers Color", Color3.fromRGB(255, 0, 0), function(val)
    BulletTracersColor = val
end)

VisualsTabCategoryOthers:NewToggle("Bullet Tracers", "Bullet Tracers", function(val)
    BulletTracersEnabled = val
    
    if val then
        SafeCall(function()
            local events = ReplicatedStorage:FindFirstChild("Events")
            if events then
                local bulletTracer = events:FindFirstChild("BulletTracer")
                if bulletTracer then
                    BulletTracersConnection = bulletTracer:Connect(function(start, finish)
                        if BulletTracersEnabled then
                            local Tracer = Instance.new("Part")
                            Tracer.Name = "BulletTracer"
                            Tracer.Anchored = true
                            Tracer.CanCollide = false
                            Tracer.Size = Vector3.new(0.1, 0.1, (start - finish).Magnitude)
                            Tracer.CFrame = CFrame.new(start, finish) * CFrame.new(0, 0, -(start - finish).Magnitude / 2)
                            Tracer.Color = BulletTracersColor
                            Tracer.Material = Enum.Material.Neon
                            Tracer.Parent = workspace
                            Debris:AddItem(Tracer, 1)
                        end
                    end)
                end
            end
        end)
    else
        if BulletTracersConnection then
            BulletTracersConnection:Disconnect()
            BulletTracersConnection = nil
        end
    end
end)

-- Bullet Impacts
local BulletImpactsEnabled = false
local BulletImpactsColor = Color3.fromRGB(255, 0, 0)
local BulletImpactsConnection

VisualsTabCategoryOthers:NewColorPicker("Bullet Impacts Color", "Bullet Impacts Color", Color3.fromRGB(255, 0, 0), function(val)
    BulletImpactsColor = val
end)

VisualsTabCategoryOthers:NewToggle("Bullet Impacts", "Bullet Impacts", function(val)
    BulletImpactsEnabled = val
    
    if val then
        SafeCall(function()
            local events = ReplicatedStorage:FindFirstChild("Events")
            if events then
                local hitPart = events:FindFirstChild("HitPart")
                if hitPart then
                    BulletImpactsConnection = hitPart:Connect(function(HitPart, Hit, Normal, Material)
                        if BulletImpactsEnabled then
                            local Impact = Instance.new("Part")
                            Impact.Name = "BulletImpact"
                            Impact.Anchored = true
                            Impact.CanCollide = false
                            Impact.Size = Vector3.new(0.2, 0.2, 0.2)
                            Impact.CFrame = CFrame.new(Hit)
                            Impact.Color = BulletImpactsColor
                            Impact.Material = Enum.Material.Neon
                            Impact.Parent = workspace
                            Debris:AddItem(Impact, 0.5)
                        end
                    end)
                end
            end
        end)
    else
        if BulletImpactsConnection then
            BulletImpactsConnection:Disconnect()
            BulletImpactsConnection = nil
        end
    end
end)

-- Ultimate Fake Lag Script (Integrated Version with Local Table)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Local Player & Character
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Fake Lag Table
local FakeLag = {
    enabled = false,
    delayMs = 100,
    method = 1,
    autoRandom = false,

    resetCharacter = function(self)
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if hrp then hrp.Anchored = false hrp.Velocity = Vector3.zero hrp.AssemblyAngularVelocity = Vector3.zero end
        if hum then hum.WalkSpeed=16 hum.JumpPower=50 hum.Sit=false hum.Jump=false hum.PlatformStand=false end
    end,

    startAutoRandom = function(self)
        task.spawn(function()
            while self.autoRandom do
                if self.enabled then
                    self.delayMs = math.random(0,1000)
                end
                task.wait(0.5)
            end
        end)
    end,

    methods = {}, -- will populate below

    start = function(self)
        task.spawn(function()
            while self.enabled do
                pcall(function()
                    local fn = self.methods[self.method]
                    if fn then fn(self) end
                end)
                if self.method==1 then task.wait(0.05)
                elseif self.method==2 then task.wait(0.03+math.random()*0.07)
                elseif self.method==3 then task.wait((humanoidRootPart.Velocity.Magnitude>2) and 0.01 or 0.08)
                elseif self.method==4 then task.wait(0.07)
                elseif self.method==5 then RunService.RenderStepped:Wait() end
            end
        end)
    end
}

-- Populate methods with self reference
FakeLag.methods = {
    function(self)
        local hrp = humanoidRootPart
        if hrp then hrp.Anchored=true task.wait(self.delayMs/1000) if hrp.Parent then hrp.Anchored=false end end
    end,
    function(self)
        local hrp = humanoidRootPart
        if hrp then local d=(self.delayMs*(0.5+math.random()))/1000 hrp.Anchored=true task.wait(d) if hrp.Parent then hrp.Anchored=false end end
    end,
    function(self)
        local hrp = humanoidRootPart
        if hrp then local m=hrp.Velocity.Magnitude>2 local d=(m and self.delayMs*0.3 or self.delayMs*1.8)/1000 hrp.Anchored=true task.wait(d) if hrp.Parent then hrp.Anchored=false end end
    end,
    function(self)
        local hrp = humanoidRootPart
        if hrp then hrp.Anchored=true task.wait(0.4) if hrp.Parent then hrp.Anchored=false end end
    end,
    function(self)
        pcall(function()
            local ev=ReplicatedStorage:FindFirstChild("DefaultSoundEvents")
            if ev and ev:FindFirstChild("AddCharacterLoadedEvent") then
                for _=1,math.random(10,30) do ev.AddCharacterLoadedEvent:FireServer() end
            end
        end)
    end
}

-- UI Integration
if RageTab then
    local RageSection = RageTab:NewSection("Fake Lag")
    RageSection:NewToggle("Enable Fake Lag","Toggle fake lag (O key)",function(state) FakeLag.enabled=state if state then FakeLag:start() else FakeLag:resetCharacter() end end)
    RageSection:NewSlider("Lag Delay (ms)","1-1000ms",1000,1,function(val) FakeLag.delayMs=val end)
    RageSection:NewDropdown("Lag Method","Choose method",{"Static","Random","Adaptive","GUI Style","Event Spam"},function(opt) local map={Static=1,Random=2,Adaptive=3,["GUI Style"]=4,["Event Spam"]=5} FakeLag.method=map[opt] or 1 end)
    RageSection:NewToggle("Auto Random Delay","Auto change delay every 0.5s",function(state) FakeLag.autoRandom=state if state then FakeLag:startAutoRandom() end end)
    RageSection:NewButton("Emergency Stop","Stop all lag",function() FakeLag.enabled=false FakeLag.autoRandom=false FakeLag:resetCharacter() end)
    RageSection:NewButton("Reset Character","Reset character",function() FakeLag:resetCharacter() end)
end

-- Keybind
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode==Enum.KeyCode.O then
        FakeLag.enabled=not FakeLag.enabled
        if FakeLag.enabled then FakeLag:start() else FakeLag:resetCharacter() end
    end
end)

-- Character respawn
LocalPlayer.CharacterAdded:Connect(function(newChar)
    character=newChar
    humanoidRootPart=newChar:WaitForChild("HumanoidRootPart")
    humanoid=newChar:WaitForChild("Humanoid")
    task.wait(1)
    if FakeLag.enabled then FakeLag:start() end
end)

-- Cleanup on exit
LocalPlayer.CharacterRemoving:Connect(function()
    FakeLag.enabled=false
    FakeLag.autoRandom=false
    FakeLag:resetCharacter()
end)

-- AntiVoteKick - защита от кика голосованием

-- Настройки AntiVoteKick
local AntiVoteKickSettings = {
    Enabled = false,
    AutoRejoin = true,
    ShowNotifications = true
}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Переменные
local VoteKickConnection = nil

-- Функция защиты от кика
local function SetupAntiVoteKick()
    if VoteKickConnection then
        VoteKickConnection:Disconnect()
    end
    
    -- Ищем события голосования
    local events = ReplicatedStorage:FindFirstChild("Events")
    if not events then return end
    
    local sendMsg = events:FindFirstChild("SendMsg")
    if sendMsg then
        VoteKickConnection = sendMsg.OnClientEvent:Connect(function(message)
            if not AntiVoteKickSettings.Enabled then return end
            
            local msg = string.split(tostring(message), " ")
            
            -- Проверяем, что это голосование против нас
            if #msg >= 12 and Players:FindFirstChild(msg[1]) and msg[7] == "1" and msg[12] == LocalPlayer.Name then
                if AntiVoteKickSettings.ShowNotifications then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "AntiVoteKick",
                        Text = "Обнаружено голосование! Защищаемся...",
                        Duration = 3
                    })
                end
                
                if AntiVoteKickSettings.AutoRejoin then
                    -- Телепортируемся в тот же сервер (перезаходим)
                    task.wait(0.5)
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                else
                    -- Просто показываем уведомление
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "AntiVoteKick",
                        Text = "Голосование заблокировано!",
                        Duration = 3
                    })
                end
            end
        end)
    end
    
    -- Дополнительная защита через Vote event
    local voteEvent = events:FindFirstChild("Vote")
    if voteEvent then
        -- Хукаем FireServer для Vote
        local oldFireServer
        oldFireServer = hookfunction(voteEvent.FireServer, function(self, ...)
            local args = {...}
            if AntiVoteKickSettings.Enabled and args[1] == LocalPlayer.Name then
                -- Блокируем голосование против себя
                if AntiVoteKickSettings.ShowNotifications then
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "AntiVoteKick",
                        Text = "Заблокировано голосование против вас!",
                        Duration = 2
                    })
                end
                return -- Не отправляем запрос
            end
            return oldFireServer(self, ...)
        end)
    end
end

-- Интеграция в UI (добавить в MiscTab)
local AntiVoteKickSection = MiscTab:NewSection("Anti Vote Kick")

AntiVoteKickSection:NewToggle("Enable Anti Vote Kick", "Защита от кика голосованием", function(state)
    AntiVoteKickSettings.Enabled = state
    if state then
        SetupAntiVoteKick()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AntiVoteKick",
            Text = "Защита включена!",
            Duration = 2
        })
    else
        if VoteKickConnection then
            VoteKickConnection:Disconnect()
            VoteKickConnection = nil
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AntiVoteKick", 
            Text = "Защита выключена!",
            Duration = 2
        })
    end
end)

AntiVoteKickSection:NewToggle("Auto Rejoin", "Автоперезаход при кике", function(state)
    AntiVoteKickSettings.AutoRejoin = state
end)

AntiVoteKickSection:NewToggle("Show Notifications", "Показывать уведомления", function(state)
    AntiVoteKickSettings.ShowNotifications = state
end)

AntiVoteKickSection:NewButton("Test Protection", "Тестировать защиту", function()
    if AntiVoteKickSettings.Enabled then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AntiVoteKick Test",
            Text = "Защита работает корректно!",
            Duration = 2
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AntiVoteKick Test",
            Text = "Сначала включи защиту!",
            Duration = 2
        })
    end
end)

-- Инициализация при загрузке
task.spawn(function()
    task.wait(2) -- Ждем загрузки игры
    if AntiVoteKickSettings.Enabled then
        SetupAntiVoteKick()
    end
end)

-- KillSound - звук при убийстве

-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

-- Настройки KillSound
local KillSoundSettings = {
    Enabled = false,
    SoundId = "",
    Volume = 3,
    PlayOnHeadshot = false,
    CustomSounds = {
        "131961136", -- Quake
        "160442087", -- CS:GO
        "1843230001", -- COD
        "131961136" -- Default
    }
}

-- Переменные
local lastKillCount = 0
local KillConnection = nil

-- Функция проигрывания звука
local function PlayKillSound(soundId)
    if soundId == "" then return end
    
    local sound = Instance.new("Sound")
    sound.Parent = SoundService
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = KillSoundSettings.Volume
    
    local success = pcall(function()
        sound:Play()
    end)
    
    if success then
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        
        -- Удаляем звук через 5 секунд на случай если не проиграется
        game:GetService("Debris"):AddItem(sound, 5)
    else
        sound:Destroy()
    end
end

-- Функция отслеживания убийств
local function SetupKillTracking()
    if KillConnection then
        KillConnection:Disconnect()
    end
    
    -- Отслеживаем изменения в статистике убийств
    local status = LocalPlayer:FindFirstChild("Status")
    if status then
        local kills = status:FindFirstChild("Kills")
        if kills then
            -- Инициализируем начальное количество
            lastKillCount = kills.Value
            
            KillConnection = kills.Changed:Connect(function(newValue)
                if KillSoundSettings.Enabled and newValue > lastKillCount and KillSoundSettings.SoundId ~= "" then
                    PlayKillSound(KillSoundSettings.SoundId)
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Kill!",
                        Text = "Убийство! Звук проигран!",
                        Duration = 1
                    })
                end
                lastKillCount = newValue
            end)
        end
    end
    
    -- Альтернативный способ через leaderstats
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            local kills = leaderstats:FindFirstChild("Kills") or leaderstats:FindFirstChild("KOs")
            if kills then
                lastKillCount = kills.Value
                kills.Changed:Connect(function(newValue)
                    if KillSoundSettings.Enabled and newValue > lastKillCount and KillSoundSettings.SoundId ~= "" then
                        PlayKillSound(KillSoundSettings.SoundId)
                    end
                    lastKillCount = newValue
                end)
            end
        end
    end)
end

-- Интеграция в UI (добавить в MiscTab)
local KillSoundSection = MiscTab:NewSection("Kill Sound")

KillSoundSection:NewToggle("Enable Kill Sound", "Звук при убийстве", function(state)
    KillSoundSettings.Enabled = state
    if state then
        SetupKillTracking()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kill Sound",
            Text = "Включен! Установи ID звука!",
            Duration = 2
        })
    else
        if KillConnection then
            KillConnection:Disconnect()
            KillConnection = nil
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kill Sound",
            Text = "Выключен!",
            Duration = 2
        })
    end
end)

KillSoundSection:NewTextBox("Sound ID", "Введи ID звука", function(text)
    KillSoundSettings.SoundId = text
    if text ~= "" then
        -- Тестовое проигрывание
        PlayKillSound(text)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kill Sound",
            Text = "ID установлен: " .. text,
            Duration = 2
        })
    end
end)

KillSoundSection:NewSlider("Volume", "Громкость звука", 10, 0, KillSoundSettings.Volume, function(value)
    KillSoundSettings.Volume = value
end)

-- Предустановленные звуки
KillSoundSection:NewButton("Quake Sound", "ID: 131961136", function()
    KillSoundSettings.SoundId = "131961136"
    PlayKillSound("131961136")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kill Sound",
        Text = "Установлен Quake звук!",
        Duration = 2
    })
end)

KillSoundSection:NewButton("CS:GO Sound", "ID: 160442087", function()
    KillSoundSettings.SoundId = "160442087"
    PlayKillSound("160442087")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kill Sound",
        Text = "Установлен CS:GO звук!",
        Duration = 2
    })
end)

KillSoundSection:NewButton("COD Sound", "ID: 1843230001", function()
    KillSoundSettings.SoundId = "1843230001"
    PlayKillSound("1843230001")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kill Sound",
        Text = "Установлен COD звук!",
        Duration = 2
    })
end)

KillSoundSection:NewButton("Test Sound", "Протестировать текущий звук", function()
    if KillSoundSettings.SoundId ~= "" then
        PlayKillSound(KillSoundSettings.SoundId)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kill Sound",
            Text = "Сначала установи ID звука!",
            Duration = 2
        })
    end
end)

-- HitSound - звук при попадании

-- Services
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

-- Настройки HitSound
local HitSoundSettings = {
    Enabled = false,
    SoundId = "",
    Volume = 2,
    HeadshotSoundId = "",
    HeadshotVolume = 4,
    DifferentHeadshotSound = false
}

-- Переменные
local lastDamage = 0
local DamageConnection = nil
local HeadshotConnection = nil

-- Функция проигрывания звука
local function PlayHitSound(soundId, volume)
    if soundId == "" then return end
    
    local sound = Instance.new("Sound")
    sound.Parent = SoundService
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = volume or HitSoundSettings.Volume
    
    local success = pcall(function()
        sound:Play()
    end)
    
    if success then
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        game:GetService("Debris"):AddItem(sound, 3)
    else
        sound:Destroy()
    end
end

-- Функция отслеживания попаданий
local function SetupHitTracking()
    if DamageConnection then
        DamageConnection:Disconnect()
    end
    if HeadshotConnection then
        HeadshotConnection:Disconnect()
    end
    
    -- Отслеживаем общий урон
    local additionals = LocalPlayer:FindFirstChild("Additionals")
    if additionals then
        local totalDamage = additionals:FindFirstChild("TotalDamage")
        if totalDamage then
            lastDamage = totalDamage.Value
            
            DamageConnection = totalDamage.Changed:Connect(function(newValue)
                if HitSoundSettings.Enabled and newValue > lastDamage and HitSoundSettings.SoundId ~= "" then
                    PlayHitSound(HitSoundSettings.SoundId, HitSoundSettings.Volume)
                end
                lastDamage = newValue
            end)
        end
        
        -- Отслеживаем хедшоты (если есть отдельный счетчик)
        local headshots = additionals:FindFirstChild("Headshots")
        if headshots and HitSoundSettings.DifferentHeadshotSound then
            local lastHeadshots = headshots.Value
            
            HeadshotConnection = headshots.Changed:Connect(function(newValue)
                if HitSoundSettings.Enabled and newValue > lastHeadshots and HitSoundSettings.HeadshotSoundId ~= "" then
                    PlayHitSound(HitSoundSettings.HeadshotSoundId, HitSoundSettings.HeadshotVolume)
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Headshot!",
                        Text = "Отличный выстрел в голову!",
                        Duration = 1
                    })
                end
                lastHeadshots = newValue
            end)
        end
    end
    
    -- Альтернативный способ через события
    local events = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if events then
        local damageEvent = events:FindFirstChild("Damage") or events:FindFirstChild("Hit")
        if damageEvent then
            damageEvent.OnClientEvent:Connect(function(damage, isHeadshot)
                if HitSoundSettings.Enabled then
                    if isHeadshot and HitSoundSettings.DifferentHeadshotSound and HitSoundSettings.HeadshotSoundId ~= "" then
                        PlayHitSound(HitSoundSettings.HeadshotSoundId, HitSoundSettings.HeadshotVolume)
                    elseif HitSoundSettings.SoundId ~= "" then
                        PlayHitSound(HitSoundSettings.SoundId, HitSoundSettings.Volume)
                    end
                end
            end)
        end
    end
end

-- Интеграция в UI (добавить в MiscTab)
local HitSoundSection = MiscTab:NewSection("Hit Sound")

HitSoundSection:NewToggle("Enable Hit Sound", "Звук при попадании", function(state)
    HitSoundSettings.Enabled = state
    if state then
        SetupHitTracking()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hit Sound",
            Text = "Включен! Установи ID звука!",
            Duration = 2
        })
    else
        if DamageConnection then
            DamageConnection:Disconnect()
            DamageConnection = nil
        end
        if HeadshotConnection then
            HeadshotConnection:Disconnect()
            HeadshotConnection = nil
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hit Sound",
            Text = "Выключен!",
            Duration = 2
        })
    end
end)

HitSoundSection:NewTextBox("Hit Sound ID", "Введи ID звука попадания", function(text)
    HitSoundSettings.SoundId = text
    if text ~= "" then
        PlayHitSound(text, HitSoundSettings.Volume)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hit Sound",
            Text = "ID установлен: " .. text,
            Duration = 2
        })
    end
end)

HitSoundSection:NewSlider("Hit Volume", "Громкость обычных попаданий", 10, 0, HitSoundSettings.Volume, function(value)
    HitSoundSettings.Volume = value
end)

HitSoundSection:NewToggle("Different Headshot Sound", "Отдельный звук для хедшотов", function(state)
    HitSoundSettings.DifferentHeadshotSound = state
end)

HitSoundSection:NewTextBox("Headshot Sound ID", "ID звука хедшота", function(text)
    HitSoundSettings.HeadshotSoundId = text
    if text ~= "" then
        PlayHitSound(text, HitSoundSettings.HeadshotVolume)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Headshot Sound",
            Text = "ID хедшота: " .. text,
            Duration = 2
        })
    end
end)

HitSoundSection:NewSlider("Headshot Volume", "Громкость хедшотов", 10, 0, HitSoundSettings.HeadshotVolume, function(value)
    HitSoundSettings.HeadshotVolume = value
end)

-- Предустановленные звуки
HitSoundSection:NewButton("Quake Hit", "ID: 131961136", function()
    HitSoundSettings.SoundId = "131961136"
    PlayHitSound("131961136", HitSoundSettings.Volume)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hit Sound",
        Text = "Установлен Quake звук!",
        Duration = 2
    })
end)

HitSoundSection:NewButton("CS:GO Hit", "ID: 160442087", function()
    HitSoundSettings.SoundId = "160442087"
    PlayHitSound("160442087", HitSoundSettings.Volume)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hit Sound",
        Text = "Установлен CS:GO звук!",
        Duration = 2
    })
end)

HitSoundSection:NewButton("Headshot Bell", "ID: 160715357", function()
    HitSoundSettings.HeadshotSoundId = "160715357"
    PlayHitSound("160715357", HitSoundSettings.HeadshotVolume)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Headshot Sound",
        Text = "Установлен звук хедшота!",
        Duration = 2
    })
end)

HitSoundSection:NewButton("Test Hit Sound", "Тест обычного звука", function()
    if HitSoundSettings.SoundId ~= "" then
        PlayHitSound(HitSoundSettings.SoundId, HitSoundSettings.Volume)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Hit Sound",
            Text = "Сначала установи ID звука!",
            Duration = 2
        })
    end
end)

HitSoundSection:NewButton("Test Headshot Sound", "Тест звука хедшота", function()
    if HitSoundSettings.HeadshotSoundId ~= "" then
        PlayHitSound(HitSoundSettings.HeadshotSoundId, HitSoundSettings.HeadshotVolume)
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Headshot Sound",
            Text = "Сначала установи ID звука хедшота!",
            Duration = 2
        })
    end
end)

-- Инициализация
task.spawn(function()
    task.wait(3)
    if HitSoundSettings.Enabled then
        SetupHitTracking()
    end
end)

-- Инициализация
task.spawn(function()
    task.wait(3) -- Ждем загрузки игры
    if KillSoundSettings.Enabled then
        SetupKillTracking()
    end
end)

-- Cleanup on exit
LocalPlayer.CharacterRemoving:Connect(function()
    ClearAllESP()
    ClearAllSkeletons()
    ClearAllTracers()
end)
