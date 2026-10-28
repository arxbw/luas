local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    CoreGui = game:GetService("CoreGui"),
    HttpService = game:GetService("HttpService"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = Services.UserInputService.TouchEnabled


local GlobalSettings = {
    ENABLE_XRAY = false,
    ENABLE_INFJUMP = false,
    ENABLE_SPEEDWALK = false,
    SPEEDWALK_VALUE = 50,
    ENABLE_SILENT_AIM = false,
    ENABLE_RAPID_FIRE = false,
    ENABLE_AIMBOT = false,
    UNLOCK_COSMETICS = false,
    ENABLE_NOCLIP = false,
    ENABLE_WEATHER = false,
    ENABLE_CROSSHAIR = false,
    ENABLE_SLIDE_BOOST = false,
    SLIDE_BOOST_SPEED = 100,
    ENABLE_FLY = false,
    FLY_SPEED = 50,
    ENABLE_THIRD_PERSON = false,
    ENABLE_STRETCH_RES = false,
    STRETCH_RES_VALUE = 0.81,
}

local AimbotConfig = {
    Enabled = false,
    FOV = 250,
    HitPart = "Head",
    ShowFOV = false,
    Smooth = 6,
    TeamCheck = false,
    VisibleCheck = true,
    Trigger = "Always On",
    Prediction = false,
    PredictionAmount = 0.12,
    CurrentTarget = nil,
    TargetPriority = "Cursor",
    FOVFill = false,
    FOVFillTransparency = 0.75,
    FOVFillColor1 = Color3.fromRGB(255, 50, 50),
    FOVFillColor2 = Color3.fromRGB(255, 205, 40),
    FOVFillRotation = 0,
    FOVFillAnimated = false,
    FOVFillSpeed = 1,
    FOVBorderColor1 = Color3.fromRGB(255, 50, 50),
    FOVBorderColor2 = Color3.fromRGB(255, 50, 50),
    FOVBorderThickness = 2,
    FOVBorderRotation = 0,
    FOVBorderSpin = false,
    FOVBorderSpinSpeed = 1,
}

local SilentAimConfig = {
    Enabled = false,
    FOV = 200,
    HitPart = "Head",
    ShowFOV = false,
    Chance = 100,
    VisibleCheck = true,
    TeamCheck = false,
    WallCheck = false,
    Prediction = false,
    PredictionAmount = 0.1,
    FOVFill = false,
    FOVFillTransparency = 0.75,
    FOVFillColor1 = Color3.fromRGB(50, 255, 50),
    FOVFillColor2 = Color3.fromRGB(40, 185, 255),
    FOVFillRotation = 0,
    FOVFillAnimated = false,
    FOVFillSpeed = 1,
    FOVBorderColor1 = Color3.fromRGB(50, 255, 50),
    FOVBorderColor2 = Color3.fromRGB(50, 255, 50),
    FOVBorderThickness = 2,
    FOVBorderRotation = 0,
    FOVBorderSpin = false,
    FOVBorderSpinSpeed = 1,
    FOVMode = "static",
    FOVSmoothness = 6,
    CurrentTarget = nil,
}


getgenv().Rivals = getgenv().Rivals or {
    Silent = {
        enabled = true
    },
    Fov = {
        Enabled = false,
        Fov = 150,
        Color = Color3.fromRGB(50, 255, 50)
    }
}

local Rivals = getgenv().Rivals

local function updateSilentAimFov()
    
end

local MehfilConfig = {
    Crosshair = {
        Color = Color3.fromRGB(0, 255, 150),
        Size = 15,
        Thickness = 2,
        Gap = 4,
        Spin = false,
        SpinSpeed = 2,
        Mode = "static",
        Smoothness = 6,
    },
    PostProcessing = {
        MotionBlur = false,
        MotionBlurIntensity = 0.5,
        Bloom = false,
        BloomIntensity = 0.5,
        BloomSize = 24,
        BloomThreshold = 0.8,
        SunRays = false,
        SunRaysIntensity = 0.5,
        SunRaysSpread = 0.5,
        ColorCorrection = false,
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new(1, 1, 1),
        CustomFog = false,
        FogColor = Color3.fromRGB(179, 179, 179),
        FogStart = 0,
        FogEnd = 500,
        CustomTime = false,
        Hour = 12,
        TimeBrightness = 2,
        ShadowSoftness = 0.5,
        Atmosphere = false,
        AtmosphereDensity = 0.3,
        AtmosphereHaze = 1,
        AtmosphereGlare = 0,
        AtmosphereOffset = 0.25,
        AtmosphereColor = Color3.new(1, 1, 1),
        AtmosphereDecay = Color3.new(0.5, 0.5, 0.5),
    },
}

local CrosshairCenterConfig = {
    FOVMode = "static",
    FOVSmoothness = 6,
    HitPart = "Head",
    CurrentTarget = nil,
}

local LunaraSnowConfig = {
    Color = Color3.fromRGB(255, 255, 255),
    Rate = 100,
    SpeedMin = 30,
    SpeedMax = 30,
    SizeMin = 0.33,
    SizeMax = 0.40,
    TransparencyMin = 0.74,
    TransparencyMax = 1,
    Spread = 180,
    Brightness = 1,
    LightEmission = 0.5,
    Glow = 0,
    SizeScale = 1,
}

local ViewModelConfig = {
    GunChams = false,
    ArmChams = false,
    GunOutline = false,
    ArmOutline = false,
    GunHighlight = false,
    ArmHighlight = false,
    DisableArms = false,
    GunColors = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
    ArmColors = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
    GunOutlineColors = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
    ArmOutlineColors = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
    GunHighlightTop = Color3.new(1, 1, 1),
    GunHighlightBottom = Color3.fromRGB(200, 200, 255),
    ArmHighlightTop = Color3.new(1, 1, 1),
    ArmHighlightBottom = Color3.fromRGB(200, 200, 255),
    GunMaterial = Enum.Material.Neon,
    ArmMaterial = Enum.Material.ForceField,
    GunHighlightMaterial = Enum.Material.Neon,
    ArmHighlightMaterial = Enum.Material.Neon,
    GunSpeed = 1,
    ArmSpeed = 1,
    GunTransparency = 0,
    ArmTransparency = 0,
    GunHighlightFillTransparency = 0,
    GunHighlightOutlineTransparency = 0,
    ArmHighlightFillTransparency = 0,
    ArmHighlightOutlineTransparency = 0,
    Viewport = false,
    OffsetX = 0,
    OffsetY = 0,
    OffsetZ = 0,
}

local CameraController = nil
task.spawn(function()
    while not CameraController do
        local ok, ctrl = pcall(function()
            return LocalPlayer.PlayerScripts:WaitForChild("Controllers", 5)
        end)
        if ok and ctrl then
            local cm = ctrl:FindFirstChild("CameraController")
            if cm and cm:IsA("ModuleScript") then
                local ok2, cc = pcall(require, cm)
                if ok2 then CameraController = cc end
            end
        end
        if not CameraController then task.wait(0.5) end
    end
    print("[NoksVIP] CameraController loaded")
end)

local AimbotEngine = {}
AimbotEngine.__index = AimbotEngine

function AimbotEngine.new(config)
    local self = setmetatable({}, AimbotEngine)
    self.Config = config
    self.VisibilityCache = {}
    self.CacheTTL = 0.12
    self.lockedTarget = nil
    self.smoothCF = nil
    return self
end

function AimbotEngine:IsPlayerAlive(plr)
    if not plr or not plr.Character then return false end
    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

function AimbotEngine:IsTargetVisible(targetPart)
    if not targetPart or not targetPart.Parent then return false end
    local myChar = LocalPlayer.Character
    local cam = workspace.CurrentCamera
    local vm = workspace:FindFirstChild("ViewModels")
    local origin = cam and cam.CFrame and cam.CFrame.Position or (myChar and myChar:FindFirstChild("HumanoidRootPart") and myChar:FindFirstChild("HumanoidRootPart").Position)
    if not origin then return true end
    
    local params = RaycastParams.new()
    local blacklist = {}
    if myChar then table.insert(blacklist, myChar) end
    if cam then table.insert(blacklist, cam) end
    if vm then table.insert(blacklist, vm) end
    params.FilterDescendantsInstances = blacklist
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.IgnoreWater = true
    local toTarget = targetPart.Position - origin
    if toTarget.Magnitude <= 0 then return true end
    local result = workspace:Raycast(origin, toTarget.Unit * toTarget.Magnitude, params)
    if result == nil then return true end
    -- FIX 100% WALL ONLY: vise avec arme ne bloque plus, seulement murs/obstacles
    if result.Instance:IsDescendantOf(targetPart.Parent) then return true end
    -- Si touche un autre joueur, ce n'est pas un mur -> visible
    for _, plr in ipairs(Services.Players:GetPlayers()) do
        if plr.Character and result.Instance:IsDescendantOf(plr.Character) then
            return true
        end
    end
    -- Sinon c'est un vrai mur/obstacle -> bloque
    return false
end


function AimbotEngine:GetAimbotScreenPoint()
    if IsMobile then
        
        return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        local loc = Services.UserInputService:GetMouseLocation()
        return Vector2.new(loc.X, loc.Y)
    end
end

function AimbotEngine:WorldToScreen(worldPos)
    local cam = Camera
    if not cam or not worldPos then return nil, false end
    local ok, v, onScreen = pcall(function()
        return cam:WorldToViewportPoint(worldPos)
    end)
    if not ok or not onScreen or v.Z <= 0 then return v, false end
    return Vector3.new(v.X, v.Y, v.Z), true
end

function AimbotEngine:GetUnstretchedCameraCFrame(cam)
    cam = cam or Camera
    if not cam then return nil end
    return cam.CFrame
end

function AimbotEngine:IsWithinFOV(part)
    if not part then return false end
    local mp = self:GetAimbotScreenPoint()
    if not mp then return false end
    local scr, on = self:WorldToScreen(part.Position)
    if not on then return false end
    local dx = scr.X - mp.X
    local dy = scr.Y - mp.Y
    local dist = math.sqrt(dx * dx + dy * dy)
    return dist <= self.Config.FOV / 2
end

function AimbotEngine:SelectTarget()
    local best, bestScore = nil, math.huge
    local mp = self:GetAimbotScreenPoint()
    if not mp then return nil end
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myPos = myRoot and myRoot.Position or Vector3.new()

    for _, p in pairs(Services.Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        if not self:IsPlayerAlive(p) then continue end

        if self.Config.TeamCheck then
            local theirTeam = p:GetAttribute("TeamID")
            local ourTeam = LocalPlayer:GetAttribute("TeamID")
            if theirTeam and ourTeam and theirTeam == ourTeam then continue end
        end

        local part = p.Character and p.Character:FindFirstChild(self.Config.HitPart)
        if not part or not part:IsDescendantOf(workspace) then continue end

        if not self:IsWithinFOV(part) then continue end

        if self.Config.VisibleCheck and myRoot then
            if not self:IsTargetVisible(part) then continue end
        end

        local scr, on = self:WorldToScreen(part.Position)
        if not on then continue end

        local score
        if self.Config.TargetPriority == "Cursor" then
            local dx = scr.X - mp.X
            local dy = scr.Y - mp.Y
            score = math.sqrt(dx * dx + dy * dy)
        else
            score = (part.Position - myPos).Magnitude
        end
        if score < bestScore then
            bestScore = score
            best = part
        end
    end
    return best
end

function AimbotEngine:GetLerpAlpha(dt)
    local smooth = math.max(1, tonumber(self.Config.Smooth) or 1)
    if smooth <= 1 then return 1 end
    local smoothness = math.clamp((smooth - 1) / 2, 0.1, 10)
    local speed = 6 / smoothness
    return math.clamp(speed * dt, 0, 1)
end

function AimbotEngine:ClearLock()
    self.lockedTarget = nil
    self.smoothCF = nil
    self.Config.CurrentTarget = nil
end

function AimbotEngine:Update(dt)
    if not self.Config.Enabled then
        self:ClearLock()
        return
    end

    if self.Config.Trigger == "Left Click" then
        if not Services.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            self:ClearLock()
            return
        end
    elseif self.Config.Trigger == "Right Click" then
        if not Services.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            self:ClearLock()
            return
        end
    end

    if not LocalPlayer.Character then
        self:ClearLock()
        return
    end

    local cam = Camera
    if not cam then return end

    if not CameraController then return end

    local bestTarget = self:SelectTarget()
    if bestTarget then
        if self.lockedTarget ~= bestTarget then
            self.lockedTarget = bestTarget
            self.smoothCF = self:GetUnstretchedCameraCFrame(cam) or cam.CFrame
        end
    else
        self:ClearLock()
        return
    end

    if not self.lockedTarget.Parent or not self.lockedTarget:IsDescendantOf(workspace) then
        self:ClearLock()
        return
    end

    local myChar = LocalPlayer.Character
    if not myChar then return end
    if not myChar:FindFirstChild("Head") then
        self:ClearLock()
        return
    end

    if not self.smoothCF then
        self.smoothCF = self:GetUnstretchedCameraCFrame(cam) or cam.CFrame
    end

    local targetPos = self.lockedTarget.Position
    -- FIX 100% AFK: prediction meme si cible immobile
    if self.Config.Prediction then
        local char = self.lockedTarget.Parent
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local vel = hrp and hrp.AssemblyLinearVelocity or self.lockedTarget.AssemblyLinearVelocity
        if vel then
            targetPos = targetPos + vel * self.Config.PredictionAmount
        end
    end

    local lookCF = CFrame.lookAt(cam.CFrame.Position, targetPos)
    local alpha = self:GetLerpAlpha(dt)
    self.smoothCF = self.smoothCF:Lerp(lookCF, alpha)

    if CameraController and CameraController.MimicRotation then
        pcall(function()
            CameraController:MimicRotation(self.smoothCF)
        end)
    end

    self.Config.CurrentTarget = self.lockedTarget
end


local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager.new(filename)
    local self = setmetatable({}, ConfigManager)
    self.Filename = filename or "noks_vip_config.json"
    return self
end

function ConfigManager:Save(data)
    if not writefile then return false end
    local ok, encoded = pcall(Services.HttpService.JSONEncode, Services.HttpService, data)
    if ok then
        pcall(writefile, self.Filename, encoded)
        return true
    end
    return false
end

function ConfigManager:Load()
    if not readfile or not isfile then return nil end
    local ok1, exists = pcall(isfile, self.Filename)
    if not ok1 or not exists then return nil end
    local ok2, raw = pcall(readfile, self.Filename)
    if not ok2 or not raw or raw == "" then return nil end
    local ok3, decoded = pcall(Services.HttpService.JSONDecode, Services.HttpService, raw)
    if ok3 then return decoded end
    return nil
end


local IOHandler = {}
IOHandler.__index = IOHandler

function IOHandler.new()
    local self = setmetatable({}, IOHandler)
    self.FOVGui = nil
    self.AimbotCircle = nil
    self.SilentCircle = nil
    self:CreateFOVCircles()
    return self
end

function IOHandler:CreateFOVCircles()
    if self.FOVGui then
        self.FOVGui:Destroy()
    end

    self.FOVGui = Instance.new("ScreenGui")
    self.FOVGui.Name = "NoksFOVCircle"
    self.FOVGui.Parent = Services.CoreGui
    self.FOVGui.ResetOnSpawn = false
    self.FOVGui.IgnoreGuiInset = true
    self.FOVGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    self.AimbotCircle = self:CreateCircle("AimbotCircle", Color3.fromRGB(255, 50, 50), false)
    self.SilentCircle = self:CreateCircle("SilentCircle", Color3.fromRGB(50, 255, 50), false)
end

function IOHandler:CreateCircle(name, color, visible)
    local circle = Instance.new("Frame")
    circle.Name = name
    circle.Parent = self.FOVGui
    circle.Size = UDim2.new(0, 0, 0, 0)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.BackgroundColor3 = Color3.new(1, 1, 1)
    circle.BackgroundTransparency = 1
    circle.BorderSizePixel = 0
    circle.Position = UDim2.new(0.5, 0, 0.5, 0)
    circle.Visible = visible

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    local stroke = Instance.new("UIStroke")
    stroke.Name = "Border"
    stroke.Thickness = 2
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 0.3
    stroke.Parent = circle

    local fillGradient = Instance.new("UIGradient")
    fillGradient.Name = "FillGradient"
    fillGradient.Color = ColorSequence.new(color, color)
    fillGradient.Rotation = 0
    fillGradient.Parent = circle

    local borderGradient = Instance.new("UIGradient")
    borderGradient.Name = "BorderGradient"
    borderGradient.Color = ColorSequence.new(color, color)
    borderGradient.Rotation = 0
    borderGradient.Parent = stroke

    return circle
end

function IOHandler:GetMuzzleScreenPosition()
    local vm = workspace:FindFirstChild("ViewModels")
    if not vm then return nil end
    local fp = vm:FindFirstChild("FirstPerson")
    if not fp then return nil end
    local pn = LocalPlayer.Name
    for _, model in ipairs(fp:GetChildren()) do
        if model:IsA("Model") and model.Name:find("^" .. pn) then
            local iv = model:FindFirstChild("ItemVisual")
            if iv then
                local body = iv:FindFirstChild("Body")
                if body then
                    local bp = body:FindFirstChild("BodyPrimary")
                    if bp then
                        local muzzle = bp:FindFirstChild("_muzzle")
                        if muzzle and muzzle:IsA("Attachment") and Camera then
                            local sp, on = Camera:WorldToViewportPoint(muzzle.WorldPosition)
                            if on then
                                return Vector2.new(sp.X, sp.Y)
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

function IOHandler:FindClosestEnemyScreenPoint(hitPartName)
    local cam = Camera
    if not cam then return nil end
    local viewport = cam.ViewportSize
    local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
    local bestPoint, bestDist = nil, math.huge
    local myTeam = LocalPlayer:GetAttribute("TeamID")
    for _, p in pairs(Services.Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        
        if myTeam then
            local theirTeam = p:GetAttribute("TeamID")
            if theirTeam and theirTeam == myTeam then continue end
        end
        local char = p.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local part = char:FindFirstChild(hitPartName or "Head")
        if not part then continue end
        local sp, on = cam:WorldToViewportPoint(part.Position)
        if not on or sp.Z <= 0 then continue end
        local dx = sp.X - center.X
        local dy = sp.Y - center.Y
        local dist = dx * dx + dy * dy
        if dist < bestDist then
            bestDist = dist
            bestPoint = Vector2.new(sp.X, sp.Y)
        end
    end
    return bestPoint
end

function IOHandler:GetCircleCenter(config, dt)
    dt = tonumber(dt) or 0.016
    local cam = Camera
    local viewport = cam and cam.ViewportSize or Vector2.new(1920, 1080)
    local center = Vector2.new(viewport.X / 2, viewport.Y / 2)

    if (config.FOVMode or "static") == "static" then
        return center
    end

    local goal = center
    if config.FOVMode == "follow muzzle" then
        local mp = self:GetMuzzleScreenPosition()
        if mp then goal = mp end
    elseif config.FOVMode == "enemy" then
        local t = config.CurrentTarget
        local pos = nil
        if t and t.Parent and t:IsDescendantOf(workspace) then
            local s, onScreen = AimbotInstance:WorldToScreen(t.Position)
            if onScreen and s then
                pos = Vector2.new(s.X, s.Y)
            end
        end
        if not pos then
            
            pos = self:FindClosestEnemyScreenPoint(config.HitPart)
        end
        if pos then goal = pos end
    end

    self.SmoothCenters = self.SmoothCenters or {}
    local sm = self.SmoothCenters[config]
    if not sm then
        sm = { pos = goal }
        self.SmoothCenters[config] = sm
    end
    local speed = math.clamp(tonumber(config.FOVSmoothness) or 6, 0.5, 30)
    local alpha = math.clamp(speed * dt, 0, 1)
    sm.pos = sm.pos:Lerp(goal, alpha)
    if (sm.pos - goal).Magnitude < 0.5 then
        sm.pos = goal
    end
    return sm.pos
end

function IOHandler:UpdateFOVCircles()
    if not self.FOVGui then
        self:CreateFOVCircles()
        return
    end

    local now = os.clock()
    local dt = math.clamp(now - (self._lastFOVUpdate or now), 0, 0.1)
    self._lastFOVUpdate = now


    local function updateCircle(circle, config, diameter, visible)
        local border = circle:FindFirstChild("Border")
        local fillGradient = circle:FindFirstChild("FillGradient")
        local borderGradient = border and border:FindFirstChild("BorderGradient")

        local center = self:GetCircleCenter(config, dt)
        circle.Position = UDim2.fromOffset(center.X, center.Y)
        circle.Size = UDim2.new(0, diameter, 0, diameter)
        circle.Visible = visible
        circle.BackgroundTransparency = config.FOVFill and config.FOVFillTransparency or 1

        if fillGradient then
            fillGradient.Color = ColorSequence.new(config.FOVFillColor1, config.FOVFillColor2)
            fillGradient.Rotation = config.FOVFillAnimated
                and ((config.FOVFillRotation + now * config.FOVFillSpeed * 36) % 360)
                or config.FOVFillRotation
        end

        if border then
            border.Thickness = config.FOVBorderThickness
        end
        if borderGradient then
            borderGradient.Color = ColorSequence.new(config.FOVBorderColor1, config.FOVBorderColor2)
            borderGradient.Rotation = config.FOVBorderSpin
                and ((config.FOVBorderRotation + now * config.FOVBorderSpinSpeed * 36) % 360)
                or config.FOVBorderRotation
        end
    end

    if self.AimbotCircle then
        updateCircle(self.AimbotCircle, AimbotConfig, AimbotConfig.FOV, AimbotConfig.ShowFOV and AimbotConfig.Enabled)
    end

    if self.SilentCircle then
        updateCircle(self.SilentCircle, SilentAimConfig, SilentAimConfig.FOV, SilentAimConfig.ShowFOV and SilentAimConfig.Enabled)
    end
end

function IOHandler:Destroy()
    if self.FOVGui then
        self.FOVGui:Destroy()
        self.FOVGui = nil
        self.AimbotCircle = nil
        self.SilentCircle = nil
    end
end


local Logger = {}
Logger.__index = Logger

function Logger.new(prefix)
    local self = setmetatable({}, Logger)
    self.Prefix = prefix or "[NoksVIP]"
    self.Enabled = false
    return self
end

function Logger:Log(level, message)
    if not self.Enabled then return end
    print(string.format("%s [%s] %s", self.Prefix, level, message))
end

function Logger:Info(msg) self:Log("INFO", msg) end
function Logger:Warn(msg) self:Log("WARN", msg) end
function Logger:Error(msg) self:Log("ERROR", msg) end


local ErrorHandler = {}
ErrorHandler.__index = ErrorHandler

function ErrorHandler.new(logger)
    local self = setmetatable({}, ErrorHandler)
    self.Logger = logger
    return self
end

function ErrorHandler:SafeCall(fn, ...)
    local ok, result = pcall(fn, ...)
    if not ok then
        if self.Logger then
            self.Logger:Error(tostring(result))
        end
    end
    return ok, result
end

function ErrorHandler:SafeWrap(fn)
    return function(...)
        return self:SafeCall(fn, ...)
    end
end


local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "Aevyx",
    Footer = "Aevyx",
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Main = Window:AddTab("Main", "user"),
    Ragebot = Window:AddTab("Ragebot", "crosshair"),
    Misc = Window:AddTab("Misc", "sliders"),
    Spoof = Window:AddTab("Spoof", "shield"),
    ESP = Window:AddTab("ESP", "scan"),
    Visuals = Window:AddTab("Visuals", "eye"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}


do
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local genv = getgenv()

local FakePosConfig = {
    FakePosition = false,
    FakePositionY = 5,
    FakePositionPanic = false,
    PanicPositionXMin = -8,
    PanicPositionXMax = 8,
    FakePositionWalk = false,
}

local GodOriginalPos = nil
local fake_position_owned = false

local function clear_position_desync()
    genv.GodOriginalPos = nil
    GodOriginalPos = nil
end

local function apply_fake_offset(cframe)
    local yOffset = tonumber(FakePosConfig.FakePositionY) or 0
    if not FakePosConfig.FakePosition or yOffset <= 0 then
        return cframe
    end
    return cframe - Vector3.new(0, yOffset, 0)
end

local function update_fake_position(character)
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if FakePosConfig.FakePositionWalk then
        if genv.GodOriginalPos then
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            root.CFrame = genv.GodOriginalPos
            genv.GodOriginalPos = nil
            GodOriginalPos = nil
            clear_position_desync()
            return
        end
    end

    if not genv.GodOriginalPos then
        genv.GodOriginalPos = root.CFrame
        GodOriginalPos = root.CFrame
    end

    local fakePos = genv.GodOriginalPos.Position - Vector3.new(0, FakePosConfig.FakePositionY or 0, 0)

    if FakePosConfig.FakePositionPanic then
        local minX = FakePosConfig.PanicPositionXMin or 0
        local maxX = FakePosConfig.PanicPositionXMax or 0
        if maxX < minX then minX, maxX = maxX, minX end
        local randomX = minX + math.random() * (maxX - minX)
        fakePos = fakePos + Vector3.new(randomX, 0, 0)
    end

    if (root.Position - fakePos).Magnitude > 0.5 then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
    end

    root.CFrame = CFrame.new(fakePos)
    fake_position_owned = true
end

local function enable_fake_position()
    FakePosConfig.FakePosition = true
    fake_position_owned = true
end

local function disable_fake_position()
    FakePosConfig.FakePosition = false
    fake_position_owned = false
    local character = LocalPlayer.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if root and genv.GodOriginalPos then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = genv.GodOriginalPos
    end
    clear_position_desync()
    genv.GodOriginalPos = nil
end

local MainScreenGui = Instance.new("ScreenGui")
MainScreenGui.Name = "RagebotStandalone"
MainScreenGui.ResetOnSpawn = false
MainScreenGui.IgnoreGuiInset = true
MainScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local guiParent = PlayerGui
if type(gethui) == "function" then
    local ok, hui = pcall(gethui)
    if ok and hui then guiParent = hui end
end
MainScreenGui.Parent = guiParent

local function addCorner(parent, radius)
    local corner = Instance.new('UICorner')
    corner.CornerRadius = radius or UDim.new(0, 5)
    corner.Parent = parent
    return corner
end

local function addBlur(parent)
    local blur = Instance.new('ImageLabel')
    blur.Name = 'Blur'
    blur.Size = UDim2.new(1, 89, 1, 52)
    blur.Position = UDim2.fromOffset(-48, -31)
    blur.BackgroundTransparency = 1
    blur.Image = "rbxassetid://74663567791967"
    blur.ScaleType = Enum.ScaleType.Slice
    blur.SliceCenter = Rect.new(52, 31, 261, 502)
    blur.ZIndex = -100
    blur.Parent = parent
    return blur
end

local Gradients = {}
local nextGradientUpdate = 0
local function addGradient(parent)
    local g = Instance.new('UIGradient')
    g.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 180, 255))
    table.insert(Gradients, g)
    g.Parent = parent
    return g
end

RunService.PreSimulation:Connect(function()
    local now = os.clock()
    if now < nextGradientUpdate then return end
    nextGradientUpdate = now + 1/15
    local t = tick() * 0.5
    for i = #Gradients, 1, -1 do
        local g = Gradients[i]
        if g.Parent then
            local p = (math.sin(t) + 1) * 0.5
            local c1 = Color3.fromRGB(255, 255, 255):Lerp(Color3.fromRGB(180, 180, 255), p)
            local c2 = Color3.fromRGB(180, 180, 255):Lerp(Color3.fromRGB(255, 255, 255), p)
            g.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, c1),
                ColorSequenceKeypoint.new(1, c2),
            })
        else
            table.remove(Gradients, i)
        end
    end
end)

local function makeDraggable(obj, window)
    obj.InputBegan:Connect(function(inputObj)
        if (inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
            and (inputObj.Position.Y - obj.AbsolutePosition.Y < 40 or window) then
            local startPos = obj.AbsolutePosition
            local inputStart = inputObj.Position
            local changed = UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
                    local delta = input.Position - inputStart
                    obj.Position = UDim2.fromOffset(startPos.X + delta.X, startPos.Y + delta.Y)
                end
            end)
            local ended = inputObj.Changed:Connect(function()
                if inputObj.UserInputState == Enum.UserInputState.End then
                    changed:Disconnect()
                    ended:Disconnect()
                end
            end)
        end
    end)
end

local NotifyList = Instance.new("Frame")
NotifyList.Name = "NotifyList"
NotifyList.Size = UDim2.fromScale(0.35, 1)
NotifyList.Position = UDim2.fromScale(1, 0)
NotifyList.AnchorPoint = Vector2.new(1, 0)
NotifyList.BackgroundTransparency = 1
NotifyList.Parent = MainScreenGui

local notifyLayout = Instance.new("UIListLayout")
notifyLayout.FillDirection = Enum.FillDirection.Vertical
notifyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifyLayout.VerticalAlignment = Enum.VerticalAlignment.Top
notifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifyLayout.Padding = UDim.new(0, 6)
notifyLayout.Parent = NotifyList

local function Notify(arg)
    local N = {
        Text = arg["Text"] or "None",
        Duration = arg["Duration"] or 2,
        Frame = Instance.new('Frame'),
        Status = false,
    }
    local NotifyFrame = N.Frame
    NotifyFrame.Size = UDim2.fromScale(0.9, 0.06)
    NotifyFrame.BackgroundTransparency = 1
    NotifyFrame.Parent = NotifyList
    local UIScale = Instance.new('UIScale', NotifyFrame)
    UIScale.Scale = 0
    local NotifyMain = Instance.new('Frame')
    NotifyMain.Name = "NotifyMain"
    NotifyMain.Size = UDim2.fromScale(1, 1)
    NotifyMain.Position = UDim2.fromScale(2, 0.2)
    NotifyMain.BackgroundTransparency = 0.3
    NotifyMain.BorderSizePixel = 0
    NotifyMain.ZIndex = -1
    NotifyMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    NotifyMain.Parent = NotifyFrame
    addBlur(NotifyMain)
    addCorner(NotifyMain)
    local NotifyText = Instance.new('TextButton')
    NotifyText.Size = UDim2.fromScale(1, 1)
    NotifyText.Text = N.Text
    NotifyText.Font = Enum.Font.BuilderSans
    NotifyText.BorderSizePixel = 0
    NotifyText.BackgroundTransparency = 1
    NotifyText.ZIndex = 10
    NotifyText.TextScaled = true
    NotifyText.TextXAlignment = Enum.TextXAlignment.Left
    NotifyText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifyText.Parent = NotifyMain
    local UIPadding = Instance.new('UIPadding')
    UIPadding.PaddingBottom = UDim.new(0.25, 0)
    UIPadding.PaddingLeft = UDim.new(0.1, 0)
    UIPadding.PaddingRight = UDim.new(0.1, 0)
    UIPadding.PaddingTop = UDim.new(0.25, 0)
    UIPadding.Parent = NotifyText
    local NotifyFill = Instance.new('Frame')
    NotifyFill.Size = UDim2.fromScale(0, 1)
    NotifyFill.BorderSizePixel = 0
    NotifyFill.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
    NotifyFill.Parent = NotifyMain
    addGradient(NotifyFill)
    addCorner(NotifyFill)
    addBlur(NotifyFill)
    TweenService:Create(NotifyMain, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Position = UDim2.fromScale(0, 0)}):Play()
    TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Scale = 1}):Play()
    TweenService:Create(NotifyFill, TweenInfo.new(N.Duration, Enum.EasingStyle.Linear), {Size = UDim2.fromScale(1, 1)}):Play()
    local function Delete()
        if N.Status then return end
        N.Status = true
        TweenService:Create(NotifyMain, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Position = UDim2.fromScale(2, 0.2)}):Play()
        task.wait(1)
        NotifyFrame:ClearAllChildren()
        NotifyFrame:Destroy()
    end
    N.Delete = Delete
    NotifyText.MouseButton1Click:Connect(Delete)
    task.delay(N.Duration, Delete)
    return N
end

local RagebotStatusMain = Instance.new("Frame")
RagebotStatusMain.Name = "RagebotStatus"
RagebotStatusMain.AnchorPoint = Vector2.new(0, 0)
RagebotStatusMain.Position = UDim2.new(0.5, -(MainScreenGui.AbsoluteSize.Y / 8.4), 0.08, 0)
RagebotStatusMain.Size = UDim2.new(0, MainScreenGui.AbsoluteSize.Y / 4.2, 0, MainScreenGui.AbsoluteSize.Y / 28)
RagebotStatusMain.BackgroundTransparency = 1
RagebotStatusMain.Visible = false
RagebotStatusMain.Parent = MainScreenGui

local RagebotStatusFrame = Instance.new("Frame")
RagebotStatusFrame.Size = UDim2.fromScale(1, 1)
RagebotStatusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
RagebotStatusFrame.BackgroundTransparency = 0.12
RagebotStatusFrame.BorderSizePixel = 0
RagebotStatusFrame.Parent = RagebotStatusMain

-- Black contour for ragebot status (requested)
local RagebotStatusStroke = Instance.new("UIStroke")
RagebotStatusStroke.Color = Color3.fromRGB(0, 0, 0)
RagebotStatusStroke.Thickness = 2
RagebotStatusStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
RagebotStatusStroke.Parent = RagebotStatusFrame

local RagebotStatusAccent = Instance.new("Frame")
RagebotStatusAccent.AnchorPoint = Vector2.new(0, 0.5)
RagebotStatusAccent.Position = UDim2.fromScale(0.035, 0.5)
RagebotStatusAccent.Size = UDim2.fromScale(0.022, 0.56)
RagebotStatusAccent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RagebotStatusAccent.Parent = RagebotStatusFrame
addGradient(RagebotStatusAccent)

local RagebotStatusText = Instance.new("TextLabel")
RagebotStatusText.BackgroundTransparency = 1
RagebotStatusText.Position = UDim2.fromScale(0.085, 0)
RagebotStatusText.Size = UDim2.fromScale(0.89, 1)
RagebotStatusText.Font = Enum.Font.BuilderSans
RagebotStatusText.Text = "Ragebot : void"
RagebotStatusText.TextColor3 = Color3.fromRGB(240, 240, 240)
RagebotStatusText.TextScaled = true
RagebotStatusText.TextXAlignment = Enum.TextXAlignment.Left
RagebotStatusText.TextYAlignment = Enum.TextYAlignment.Center
RagebotStatusText.Parent = RagebotStatusFrame

-- Contour noir pour le texte ragebot
local RagebotStatusTextStroke = Instance.new("UIStroke")
RagebotStatusTextStroke.Color = Color3.fromRGB(0, 0, 0)
RagebotStatusTextStroke.Thickness = 2
RagebotStatusTextStroke.Parent = RagebotStatusText

local RagebotStatusTextConstraint = Instance.new("UITextSizeConstraint")
RagebotStatusTextConstraint.MinTextSize = 8
RagebotStatusTextConstraint.MaxTextSize = 18
RagebotStatusTextConstraint.Parent = RagebotStatusText

addCorner(RagebotStatusFrame)
addCorner(RagebotStatusAccent, UDim.new(1, 0))
addBlur(RagebotStatusFrame)
makeDraggable(RagebotStatusMain, true)

local RagebotStatusScale = Instance.new("UIScale")
RagebotStatusScale.Scale = 0
RagebotStatusScale.Parent = RagebotStatusFrame

local RagebotStatusLastText = ""
local RagebotStatusVisible = false
local function setRagebotStatus(enabled, target, voiding)
    shared.RagebotActive = enabled
    local text = "Ragebot : void"
    if enabled and target and not voiding then
        text = "Ragebot : " .. (target.Name or "target")
    end
    if RagebotStatusLastText ~= text then
        RagebotStatusLastText = text
        RagebotStatusText.Text = text
    end
    if enabled ~= RagebotStatusVisible then
        RagebotStatusVisible = enabled
        RagebotStatusMain.Visible = true
        TweenService:Create(RagebotStatusScale, TweenInfo.new(0.18, Enum.EasingStyle.Exponential), {
            Scale = enabled and 1 or 0
        }):Play()
        if not enabled then
            task.delay(0.2, function()
                if not RagebotStatusVisible then
                    RagebotStatusMain.Visible = false
                end
            end)
        end
    end
end

MainScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    RagebotStatusMain.Size = UDim2.new(0, MainScreenGui.AbsoluteSize.Y / 4.2, 0, MainScreenGui.AbsoluteSize.Y / 28)
end)

local RagebotSettings = {
    on = false,
    targetMode = "Closest",
    autoSwitch = true,
    preferredWeapon = "primary",
    meleeSlot = 3,
    weaponSpecialize = true,
    weaponLock = true,
    onEmpty = "SwapOrReload",
    autoPriority = false,
    priorityAttackers = true,
    priorityVoided = true,
    sendNotification = false,
    prioritizedPlayer = nil,
    primarySlot = 1,
    secondarySlot = 2,
    acSpd = 0.015, -- AFK 0 latence
    shootDelay = 0,
    teleportDelay = 0.01, -- AFK colle dur
    orbitDist = 3,
    orbitHeight = 2,
    randomMovement = false,
    randomRefresh = 0.08,
    mode = "Teleport", -- Orbit removed per request, closer
    strafeSpeed = 5,
    undergroundDepth = 6,
    behindDist = 4,
    antiAim = false,
    hyper = false,
    useManipulation = true,
    voidSpam = false, -- OFF demandé
    voidHideTime = 0.25,
    voidShootTime = 0.03,
    shootAttempts = 1,
    otherMatchAvoidDistance = 1000,
    settleUntil = 0,
    dirBack = true,
    dirFront = false,
    dirLeft = true,
    dirRight = true,
    dirUp = true,
    dirDown = false,
    antiRagers = false, -- REMOVED per request
    hover = true,
    stick = false,
    voidOnReload = true,
    shotgunVoidTime = 5,
    antiKatanaDeflect = true,
    attackMode = "auto",
    lead = true,
}
local function markDirty() RagebotSettings.settleUntil = 0 end

local shootingRangeCache, shootingRangeChecked = false, 0
local function isShootingRange()
    local now = os.clock()
    if now - shootingRangeChecked < 0.5 then return shootingRangeCache end
    shootingRangeChecked = now
    local function matches(value)
        if value == nil then return false end
        local text = tostring(value):lower():gsub("[%s_%-]", "")
        return text:find("shootingrange", 1, true) ~= nil
            or text:find("firingrange", 1, true) ~= nil
            or text:find("사격장", 1, true) ~= nil
    end
    for _, object in ipairs({workspace, LocalPlayer}) do
        for _, attribute in ipairs({"Map", "MapName", "Mode", "GameMode", "Arena", "Environment", "EnvironmentName", "ShootingRange"}) do
            local value = object:GetAttribute(attribute)
            if (value == true and attribute == "ShootingRange") or matches(value) then
                shootingRangeCache = true
                return true
            end
        end
    end
    local character = LocalPlayer.Character
    local current = character
    while current and current ~= workspace do
        if matches(current.Name) then
            shootingRangeCache = true
            return true
        end
        current = current.Parent
    end
    shootingRangeCache = false
    return false
end

local Ragebot = {}
local rbState = {
    active = false,
    target = nil,
    conn = nil,
    ammoThread = nil,
    voidThread = nil,
    voidHbConn = nil,
    csyncHbConn = nil,
    voidExposed = false,
    voidTargetCF = nil,
    nextTeleportAt = 0,
    ammoActionAt = 0,
    hideOrbitUntil = 0,
    randPos = nil,
    randT = 0,
    lastFakePos = nil,
    csyncCF = nil,
    csyncLV = nil,
    csyncAV = nil,
    csyncLocalCF = nil,
    csyncLocalLV = nil,
    csyncLocalAV = nil,
    csyncWroteFake = false,
    noclipConn = nil,
    suspended = false,
    charAddedConn = nil,
    orbitRenderRunning = false,
    orbitClientCF = nil,
    csyncWarmedUp = false,
    lastTargetForCsync = nil,
    pendingFirstShot = false,
    lastFaceCF = nil,
    reloadVoidUntil = 0,
    wasBusy = false,
    equipAt = 0,
    lastWasLead = false,
    lastSetCsyncAt = 0,
}
getgenv().RB_Settings = RagebotSettings
getgenv().RB_State = rbState
local rbGen = 0
local rbDuelMod, rbInMatchT, rbInMatch = nil, 0, false
local rbTgtT = 0
local slotKey = { [1] = Enum.KeyCode.One, [2] = Enum.KeyCode.Two, [3] = Enum.KeyCode.Three, [4] = Enum.KeyCode.Four }

local util, enums, useItemRemote, fighterCtrl
pcall(function()
    util = require(ReplicatedStorage.Modules.Utility)
    enums = require(ReplicatedStorage.Modules.EnumLibrary)
    useItemRemote = ReplicatedStorage.Remotes.Replication.Fighter.UseItem
    fighterCtrl = require(LocalPlayer.PlayerScripts.Controllers.FighterController)
end)

local function getRoot(char) return char and char:FindFirstChild("HumanoidRootPart") end
local function getFighter()
    if fighterCtrl and rawget(fighterCtrl, 'LocalFighter') then return rawget(fighterCtrl, 'LocalFighter') end
    if fighterCtrl and fighterCtrl.GetFighter then
        local ok, f = pcall(fighterCtrl.GetFighter, fighterCtrl, LocalPlayer)
        if ok then return f end
    end
    return nil
end

local function hasKnifeViewModel(targetPlayer)
    if not targetPlayer then return false end
    local viewModels = workspace:FindFirstChild("ViewModels")
    if not viewModels then return false end
    local targetName = targetPlayer.Name
    for _, model in ipairs(viewModels:GetChildren()) do
        if model:IsA("Model")
           and string.find(model.Name, targetName, 1, true)
           and string.find(model.Name, "Knife", 1, true) then
            return true
        end
    end
    return false
end

local function triggerCsyncWarmup()
    rbState.csyncWarmedUp = false
    rbState.pendingFirstShot = true
    local myGenAtWarmup = rbGen
    task.spawn(function()
        for _ = 1, 2 do
            RunService.Heartbeat:Wait()
        end
        if rbState.active and rbGen == myGenAtWarmup then
            rbState.csyncWarmedUp = true
        end
    end)
end

local function itemObjectId(item)
    local data = rawget(item, 'Data')
    return data and rawget(data, 'ObjectID') or nil
end
local function itemInfo(item) return rawget(item, 'Info') end
local function itemType(item)
    local info = itemInfo(item)
    return info and rawget(info, 'Type') or nil
end
local function itemIsRaycast(item)
    local info = itemInfo(item)
    return info and rawget(info, 'IsRaycast') == true
end
local function itemName(item) return rawget(item, 'Name') or rawget(item, 'ItemName') end
local function itemAmmo(item)
    local data = rawget(item, 'Data')
    local ammo = data and rawget(data, 'Ammo')
    return type(ammo) == 'number' and ammo or 0
end
local function itemAmmoReserve(item)
    local data = rawget(item, 'Data')
    local reserve = data and rawget(data, 'AmmoReserve')
    if type(reserve) ~= 'number' then return math.huge end
    return reserve
end
local function itemIsReloading(item)
    local now = tick()
    local cooldown = rawget(item, '_reload_cooldown')
    if type(cooldown) == 'number' and now < cooldown then return true end
    local noAmmoCooldown = rawget(item, '_shoot_cooldown_no_ammo')
    return type(noAmmoCooldown) == 'number' and now < noAmmoCooldown
end
local function itemIsMagFull(item)
    local info = itemInfo(item)
    local maxAmmo = info and rawget(info, 'MaxAmmo')
    return type(maxAmmo) == 'number' and maxAmmo <= itemAmmo(item)
end
local function itemIsEquipped(item) return rawget(item, 'IsEquipped') end

local function equipItem(item, index)
    if itemIsEquipped(item) then return end
    local clientFighter = rawget(item, 'ClientFighter') or getFighter()
    if clientFighter and index and type(clientFighter.EquipItem) == 'function' then
        pcall(function() clientFighter:EquipItem(index) end)
    end
end

local function fireReload(objectId)
    if not useItemRemote or not enums or not objectId then return end
    local start = enums:ToEnum('StartReloading')
    local reload = enums:ToEnum('Reload')
    if not start or not reload then return end
    local payload = { ['\1'] = reload, ['\2'] = reload }
    pcall(function() useItemRemote:FireServer(objectId, start, payload, nil) end)
end

local function reloadItem(item)
    if itemIsReloading(item) or itemAmmoReserve(item) <= 0 or itemIsMagFull(item) then return end
    fireReload(itemObjectId(item))
end

local function itemCategory(slotIndex)
    if slotIndex == 1 then return 'Primary'
    elseif slotIndex == 2 then return 'Secondary'
    elseif slotIndex == 3 then return 'Melee' end
    return nil
end

local function isCategoryEnabled(category)
    if not RagebotSettings.weaponLock then return true end
    local pref = RagebotSettings.preferredWeapon or "primary"
    if pref == "melee" then return category == 'Melee' or category == 'Secondary' end
    if category == 'Primary' then return pref == "primary" end
    if category == 'Secondary' then return pref == "secondary" end
    if category == 'Melee' then return pref == "melee" end
    return false
end

local function getAction(fighter)
    if not fighter then return nil end
    local items = rawget(fighter, 'Items')
    if type(items) ~= 'table' then return nil end
    local onEmpty = RagebotSettings.onEmpty or 'SwapOrReload'
    local priorityList = (RagebotSettings.preferredWeapon == "melee")
        and { 'Melee', 'Secondary', 'Primary' }
        or { 'Primary', 'Secondary', 'Melee' }
    local bestAttack, bestAttackPri, bestAttackIndex = nil, math.huge, nil
    local bestSwap, bestSwapPri, bestSwapIndex = nil, math.huge, nil
    local anyEnabled = false
    for slotKeyIter, item in next, items do
        if type(item) == 'table' then
            local category = itemCategory(slotKeyIter)
            if category ~= nil and isCategoryEnabled(category) then
                anyEnabled = true
                local priority = table.find(priorityList, category) or math.huge
                if itemType(item) == 'Gun' and itemAmmo(item) == 0 then
                    if itemAmmoReserve(item) > 0 and priority < bestSwapPri then
                        if onEmpty == 'Reload' then
                            bestAttackPri = priority
                            bestAttack = item
                            bestAttackIndex = slotKeyIter
                        else
                            bestSwap = item
                            bestSwapPri = priority
                            bestSwapIndex = slotKeyIter
                        end
                    end
                elseif bestAttack == nil or priority < bestAttackPri then
                    bestAttackPri = priority
                    bestAttack = item
                    bestAttackIndex = slotKeyIter
                end
            end
        end
    end
    if not anyEnabled then return nil end
    if bestAttack == nil then
        if onEmpty == 'Swap' or bestSwap == nil then return nil end
        if itemIsEquipped(bestSwap) then
            return { type = 'Reload', item = bestSwap, itemType = itemType(bestSwap), index = bestSwapIndex }
        end
        return { type = 'Swap', item = bestSwap, itemType = itemType(bestSwap), index = bestSwapIndex }
    end
    local emptyGun = itemType(bestAttack) == 'Gun' and itemAmmo(bestAttack) == 0
    if not itemIsEquipped(bestAttack) then
        if RagebotSettings.preferredWeapon == "melee" then
            local equippedItem = rawget(fighter, 'EquippedItem')
            if equippedItem then
                local eqIndex = nil
                for slotKeyIter2, item2 in next, items do
                    if item2 == equippedItem then eqIndex = slotKeyIter2 break end
                end
                local eqCategory = eqIndex and itemCategory(eqIndex)
                if eqCategory and isCategoryEnabled(eqCategory) then
                    if itemType(equippedItem) == 'Gun' and itemAmmo(equippedItem) == 0
                        and itemAmmoReserve(equippedItem) > 0 then
                        return { type = 'Reload', item = equippedItem, itemType = itemType(equippedItem), index = eqIndex }
                    end
                    return { type = 'Attack', item = equippedItem, itemType = itemType(equippedItem), index = eqIndex }
                end
            end
        end
        return { type = 'Swap', item = bestAttack, itemType = itemType(bestAttack), index = bestAttackIndex }
    end
    if emptyGun then
        return { type = 'Reload', item = bestAttack, itemType = itemType(bestAttack), index = bestAttackIndex }
    end
    return { type = 'Attack', item = bestAttack, itemType = itemType(bestAttack), index = bestAttackIndex }
end

local function isTargetInvincible(entity)
    local data = entity and rawget(entity, 'Data')
    return data ~= nil and rawget(data, 'IsInvincible') == true
end
local function getEntityForPlayer(plr)
    local controller = fighterCtrl
    local objects = controller and rawget(controller, 'Objects')
    if type(objects) ~= 'table' then return nil end
    for _, fighter in ipairs(objects) do
        if rawget(fighter, 'Player') == plr then
            return rawget(fighter, 'Entity')
        end
    end
    return nil
end
local function isInvincible(plr)
    if not plr or plr == LocalPlayer then return true end
    local char = plr.Character
    local root = getRoot(char)
    if root then
        for _, obj in ipairs(root:GetChildren()) do
            if obj:IsA("Attachment") and obj.Name == "Attachment" then return true end
        end
    end
    if char and char:FindFirstChild("InvincibilityParticles", true) then return true end
    local entity = getEntityForPlayer(plr)
    return isTargetInvincible(entity)
end

local function scanWeapon(plr)
    local vms = workspace:FindFirstChild("ViewModels")
    if not vms then return "" end
    for _, model in ipairs(vms:GetChildren()) do
        if model:IsA("Model") then
            local sp = model.Name:find(" - ", 1, true)
            if sp and model.Name:sub(1, sp - 1) == plr.Name then
                return model.Name:sub(sp + 3):lower()
            end
        end
    end
    return ""
end
local function playerIsDead(plr)
    local char = plr and plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return not char or not hum or hum.Health <= 0 or not getRoot(char)
end
local function isKatana(plr) return scanWeapon(plr):find("katana", 1, true) ~= nil end
local function isRiotShield(plr)
    local w = scanWeapon(plr)
    return w:find("riot", 1, true) ~= nil or w:find("shield", 1, true) ~= nil
end

local function isOwnShotgun()
    local item = getFighter() and getFighter().EquippedItem
    local n = item and (rawget(item, "Name") or "") or ""
    return n:lower():find("shotgun", 1, true) ~= nil
end

local function getEnemyFighter(plr)
    local objects = fighterCtrl and rawget(fighterCtrl, "Objects")
    if type(objects) ~= "table" then return nil end
    for _, f in ipairs(objects) do
        if rawget(f, "Player") == plr then return f end
    end
    return nil
end

local function isKatanaDeflecting(plr)
    if not RagebotSettings.antiKatanaDeflect then return false end
    local f = getEnemyFighter(plr)
    local item = f and rawget(f, "EquippedItem")
    if type(item) ~= "table" or item.Name ~= "Katana" then return false end
    local now = tick()
    local ac = rawget(item, "_attack_cooldown")
    local dc = rawget(item, "_deflect_cooldown")
    local dh = rawget(item, "_deflect_hash")
    return type(ac) == "number" and ac > now and type(dc) == "number" and dc > now
        and type(dh) == "number" and dh % 2 == 1
end

-- ================= RAGEBOT DESTROYER (always on, no toggle) =================
local ragebotUsers = setmetatable({}, { __mode = "k" })
local lastRootPos = setmetatable({}, { __mode = "k" })

local function detectRagebotUser(plr)
    if not plr or plr == LocalPlayer then return false end
    local char = plr.Character
    local root = getRoot(char)
    if not root then
        lastRootPos[plr] = nil
        return false
    end
    local pos = root.Position
    if pos.Magnitude > 500000 then return true end
    local vel = root.AssemblyLinearVelocity
    if vel.Magnitude > 250 then return true end
    local last = lastRootPos[plr]
    lastRootPos[plr] = pos
    if last and (pos - last).Magnitude > 40 then return true end
    return false
end

local function updateRagebotDetections()
    local now = tick()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and not playerIsDead(plr) then
            if detectRagebotUser(plr) then
                ragebotUsers[plr] = now
            end
        end
    end
end
local function IsValidMatch(plr) return plr:GetAttribute("EnvironmentID") == LocalPlayer:GetAttribute("EnvironmentID") end
local function isNearOtherMatch(pos, ignorePlayer)
    local avoidDistance = RagebotSettings.otherMatchAvoidDistance or 1000
    if typeof(pos) ~= "Vector3" or avoidDistance <= 0 then return false end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr ~= ignorePlayer and not IsValidMatch(plr) then
            local otherRoot = getRoot(plr.Character)
            if otherRoot and (otherRoot.Position - pos).Magnitude <= avoidDistance then return true end
        end
    end
    return false
end
local function isSafeRagebotPos(pos, targetPlayer) return not isNearOtherMatch(pos, targetPlayer) end
local function shouldSkip(plr)
    if plr == LocalPlayer or playerIsDead(plr) then return true end
    if not IsValidMatch(plr) then return true end
    if isInvincible(plr) then return true end
    if isKatanaDeflecting(plr) then return true end
    local root = getRoot(plr.Character)
    if root and isNearOtherMatch(root.Position, plr) then return true end
    return root and root:FindFirstChild("TeammateLabel") ~= nil
end
local function getBestTarget()
    local root = getRoot(LocalPlayer.Character)
    if not root then return nil end
    if RagebotSettings.prioritizedPlayer then
        local prio = Players:FindFirstChild(RagebotSettings.prioritizedPlayer)
        if prio and not shouldSkip(prio) then return prio end
    end
    local best, bestV = nil, math.huge
    local useHP = RagebotSettings.targetMode == "Lowest Health"
    for _, plr in ipairs(Players:GetPlayers()) do
        if not shouldSkip(plr) then
            local char = plr.Character
            local tr = getRoot(char)
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local value = useHP and hum.Health or (tr.Position - root.Position).Magnitude
            if RagebotSettings.autoPriority then
                local isHacker = tr.Position.Magnitude > 1e6
                    or tr.AssemblyLinearVelocity.Magnitude > 500
                    or tr.Position.X ~= tr.Position.X
                if isHacker then value -= 3e9 end
                if RagebotSettings.priorityVoided and tr.Position.Magnitude > 1e6 then value -= 2e9 end
                if RagebotSettings.priorityAttackers and scanWeapon(plr) ~= "" then value -= 1e9 end
            end
            if ragebotUsers[plr] then value -= 5e9 end
            if value < bestV then bestV = value; best = plr end
        end
    end
    return best
end
local function hasValidTarget()
    return rbState.target and not playerIsDead(rbState.target) and not isInvincible(rbState.target)
end
local function updateRagebotStatus()
    local target = hasValidTarget() and rbState.target or nil
    local voiding = not target or ((RagebotSettings.mode == "Void" or RagebotSettings.mode == "Orbit") and not rbState.voidExposed)
    setRagebotStatus(rbState.active and RagebotSettings.on, target, voiding)
end
local function shouldShoot()
    if not hasValidTarget() then return false end
    if isKatana(rbState.target) then return false end
    if RagebotSettings.mode == "Void" and not rbState.voidExposed then return false end
    return true
end

local function forceEquipPreferred()
    if not hasValidTarget() then return end
    -- RAGEBOT DESTROYER: auto-knife a detected ragebot user orbiting you
    do
        local tgt = rbState.target
        local myRoot = getRoot(LocalPlayer.Character)
        if tgt and ragebotUsers[tgt] and myRoot then
            local tr = getRoot(tgt.Character)
            if tr and (tr.Position - myRoot.Position).Magnitude <= 8 then
                local f = getFighter()
                local items = f and rawget(f, 'Items')
                local meleeItem = type(items) == 'table' and items[3] or nil
                local meleeName = meleeItem and tostring(itemName(meleeItem) or ""):lower() or ""
                if meleeItem and meleeName:find("knife", 1, true) and rawget(f, 'EquippedItem') ~= meleeItem then
                    if tick() >= (rbState.equipAt or 0) then
                        rbState.equipAt = tick() + 0.3
                        equipItem(meleeItem, 3)
                    end
                end
                return
            end
        end
    end
    if not RagebotSettings.weaponLock then return end
    local pref = RagebotSettings.preferredWeapon
    if RagebotSettings.attackMode == "knife" then pref = "melee" end
    local want = (pref == "secondary" and 2) or (pref == "melee" and 3) or 1
    local f = getFighter()
    local items = f and rawget(f, 'Items')
    if type(items) ~= 'table' then return end
    local equipped = rawget(f, 'EquippedItem')
    if equipped and items[want] == equipped then return end
    local it = items[want]
    if not it then return end
    if itemType(it) == 'Gun' and itemAmmo(it) <= 0 then return end
    if tick() < (rbState.equipAt or 0) then return end
    rbState.equipAt = tick() + 0.4
    equipItem(it, want)
end

local function getEquippedSlot()
    local fighter = getFighter()
    local item = fighter and fighter.EquippedItem
    if not item then return nil end
    local slot = item.Get and item:Get("Slot")
    if slot then return tonumber(slot) end
    if fighter.Items then
        for k, v in pairs(fighter.Items) do
            if v == item then return k end
        end
    end
    return nil
end
local function applyWeaponRageProfile()
    if RagebotSettings.weaponSpecialize == false then return "default" end
    local slot = getEquippedSlot()
    local kind
    if slot == 3 then kind = "melee"
    elseif slot == 2 then kind = "secondary"
    else kind = "primary" end
    if kind == "primary" then
        RagebotSettings.mode = "Orbit"
        RagebotSettings.hyper = true
        RagebotSettings.orbitDist = 3.2
        RagebotSettings.orbitHeight = 2.2
        RagebotSettings.strafeSpeed = 6
        RagebotSettings.teleportDelay = 0.035
        RagebotSettings.behindDist = 3.5
        RagebotSettings.randomMovement = false
        RagebotSettings.dirBack = true
        RagebotSettings.dirFront = false
        RagebotSettings.dirLeft = true
        RagebotSettings.dirRight = true
    elseif kind == "secondary" then
        RagebotSettings.mode = "Teleport"
        RagebotSettings.hyper = false
        RagebotSettings.orbitDist = 2.6
        RagebotSettings.orbitHeight = 1.6
        RagebotSettings.strafeSpeed = 4
        RagebotSettings.teleportDelay = 0.028
        RagebotSettings.behindDist = 3.0
        RagebotSettings.randomMovement = true
        RagebotSettings.randomRefresh = 0.07
        RagebotSettings.dirBack = true
        RagebotSettings.dirFront = true
        RagebotSettings.dirLeft = true
        RagebotSettings.dirRight = true
    else
        RagebotSettings.mode = "Underground"
        RagebotSettings.hyper = true
        RagebotSettings.orbitDist = 1.6
        RagebotSettings.orbitHeight = 0.6
        RagebotSettings.strafeSpeed = 8
        RagebotSettings.teleportDelay = 0.02
        RagebotSettings.behindDist = 2.2
        RagebotSettings.undergroundDepth = 4
        RagebotSettings.randomMovement = false
        RagebotSettings.dirBack = true
        RagebotSettings.dirFront = false
        RagebotSettings.dirLeft = true
        RagebotSettings.dirRight = true
        RagebotSettings.dirDown = true
    end
    return kind
end

local function handleAmmo()
    local fighter = getFighter()
    if not fighter then return false end
    local action = getAction(fighter)
    if not action then return false end
    local now = tick()
    if now < (rbState.ammoActionAt or 0) then return true end
    if action.type == 'Swap' then
        equipItem(action.item, action.index)
        rbState.ammoActionAt = now + 0.3
        rbState.hideOrbitUntil = math.max(rbState.hideOrbitUntil or 0, now + 0.3)
        return true
    elseif action.type == 'Reload' then
        reloadItem(action.item)
        rbState.ammoActionAt = now + 0.5
        rbState.hideOrbitUntil = math.max(rbState.hideOrbitUntil or 0, now + 0.5)
        return true
    end
    return false
end

local function buildCameraData(fromPos, part, predictedPos)
    if not util or not part then return nil end
    local targetPos = predictedPos or part.Position
    if (fromPos - targetPos).Magnitude < 0.8 then
        fromPos = targetPos + Vector3.new(0, 2, -3)
    end
    if fromPos.Magnitude > 100000 or targetPos.Magnitude > 100000 then return nil end
    local look = CFrame.new(fromPos, targetPos)
    local data = {}
    data[utf8.char(1)] = {
        [utf8.char(0)] = util:EncodeCFrame(look),
        [utf8.char(1)] = util:EncodeCFrame(look),
        [utf8.char(2)] = part,
        [utf8.char(3)] = util:EncodeCFrame(part.CFrame:ToObjectSpace(CFrame.new(targetPos)))
    }
    return data
end

local function doFire(part)
    local fighter = getFighter()
    local item = fighter and fighter.EquippedItem
    if not item or not part then return false end
    if itemIsReloading(item) then return false end
    if itemAmmo(item) <= 0 then return false end

    -- FIX 100% 0 LATENCE SANS PREDICTION - 4 STUDS
    local cam = workspace.CurrentCamera
    local headPos = part.Position
    local predictedPos = headPos

    local fromPos = (rbState.csyncCF and rbState.csyncCF.Position) or (cam and cam.CFrame.Position) or headPos
    local dist = (fromPos - predictedPos).Magnitude
    if dist < 1.0 then
        fromPos = predictedPos + Vector3.new(0, 4, -0.5)
    end

    if fromPos.Magnitude > 100000 or predictedPos.Magnitude > 100000 then return false end
    if (fromPos - predictedPos).Magnitude < 1.0 then
        fromPos = predictedPos + Vector3.new(0, 2.5, -3)
    end
    local data = buildCameraData(fromPos, part, predictedPos)
    if not data then return false end

    local oid = itemObjectId(item)
    local shootEnum = enums and enums:ToEnum("StartShooting")
    if not oid or not shootEnum or not useItemRemote then return false end

    local attempts = math.max(1, math.floor(RagebotSettings.shootAttempts or 1))
    -- Unlimited shots as requested - no cap for pompe, user controls via slider
    if rbState.target and ragebotUsers[rbState.target] then attempts = math.max(attempts, 3) end

    if rbState.pendingFirstShot then
        rbState.pendingFirstShot = false
        local ok1 = pcall(function()
            useItemRemote:FireServer(oid, shootEnum, data, nil)
        end)
        task.wait(0.045)
        local ok2 = pcall(function()
            useItemRemote:FireServer(oid, shootEnum, data, nil)
        end)
        return ok1 or ok2
    end

    local anyFired = false
    for _ = 1, attempts do
        local ok = pcall(function()
            useItemRemote:FireServer(oid, shootEnum, data, nil)
        end)
        anyFired = anyFired or ok
    end
    return anyFired
end

local function isLobby()
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    local mainGui = gui and gui:FindFirstChild("MainGui")
    local mainFrame = mainGui and mainGui:FindFirstChild("MainFrame")
    local lobby = mainFrame and mainFrame:FindFirstChild("Lobby")
    local currency = lobby and lobby:FindFirstChild("Currency")
    return currency and currency.Visible == true
end
local function getDuel()
    if not rbDuelMod then
        local ps = LocalPlayer:FindFirstChild("PlayerScripts")
        local ct = ps and ps:FindFirstChild("Controllers")
        local dc = ct and ct:FindFirstChild("DuelController")
        if dc then
            local ok, mod = pcall(require, dc)
            if ok and mod then rbDuelMod = mod end
        end
    end
    if rbDuelMod and rbDuelMod.GetDuel then
        local ok, duel = pcall(rbDuelMod.GetDuel, rbDuelMod, LocalPlayer)
        if ok then return duel end
    end
end
local function isValidMatch()
    if isLobby() or isShootingRange() then return false end
    local char = LocalPlayer.Character
    local root = getRoot(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not root or not hum or hum.Health <= 0 then return false end
    if getDuel() ~= nil then return true end
    return getFighter() ~= nil
end
local function inMatch()
    local now = tick()
    if now - rbInMatchT < 0.25 then return rbInMatch end
    rbInMatchT = now
    rbInMatch = isValidMatch()
    return rbInMatch
end

local function undergroundPos(head, targetRoot)
    local depth = math.clamp(RagebotSettings.undergroundDepth or 6, 3, 8)
    local radius = math.clamp(RagebotSettings.orbitDist or 3, 1.25, 4)
    return head.Position - targetRoot.CFrame.LookVector * radius + Vector3.new(0, -depth, 0)
end
local function rnd() return math.random() * 2 - 1 end
local function rndDir()
    local a = math.random() * math.pi * 2
    return Vector3.new(math.cos(a), 0, math.sin(a))
end
local function getDirs(targetRoot)
    local dirs = {}
    local look = targetRoot.CFrame.LookVector
    local right = targetRoot.CFrame.RightVector
    if RagebotSettings.dirBack then table.insert(dirs, -look) end
    if RagebotSettings.dirFront then table.insert(dirs, look) end
    if RagebotSettings.dirLeft then table.insert(dirs, -right) end
    if RagebotSettings.dirRight then table.insert(dirs, right) end
    if #dirs == 0 then
        dirs[1] = -look
        dirs[2] = right
        dirs[3] = -right
    end
    return dirs
end
local function pickOffset(targetRoot, head)
    local dirs = getDirs(targetRoot)
    local dir = dirs[math.random(1, #dirs)]
    local radius = math.clamp(RagebotSettings.orbitDist or 3, 1.25, 5)
    local height = math.clamp(RagebotSettings.orbitHeight or 2, -2, 6)
    local pos = head.Position + dir * radius + Vector3.new(0, height, 0)
    if RagebotSettings.dirUp and math.random() < 0.2 then
        pos += Vector3.new(0, math.max(1, height), 0)
    elseif RagebotSettings.dirDown and math.random() < 0.15 then
        pos += Vector3.new(0, -math.max(1, math.min(3, RagebotSettings.undergroundDepth or 2)), 0)
    end
    return pos
end
local function setCsync(cf, pos, dt, targetRoot)
    rbState.csyncCF = cf
    -- FIX 100% 0 LATENCE ULTRA - suit ennemi chaque frame sans miss
    local enemyVel = targetRoot and targetRoot.AssemblyLinearVelocity or Vector3.zero
    local vel = Vector3.new(enemyVel.X, 0, enemyVel.Z)
    if vel.Magnitude > 110 then vel = vel.Unit * 110 end
    rbState.csyncLV = vel
    rbState.csyncAV = Vector3.zero
    rbState.lastFakePos = pos
    rbState.lastWasLead = true
    rbState.lastSetCsyncAt = tick()
    -- Force instant root CFrame pour 0 latence vraie
    pcall(function()
        local root = getRoot(LocalPlayer.Character)
        if root then
            root.CFrame = cf
            root.AssemblyLinearVelocity = Vector3.new(vel.X, root.AssemblyLinearVelocity.Y, vel.Z)
        end
    end)
end
local function clearCsyncTarget()
    rbState.csyncCF = nil
    rbState.csyncLV = nil
    rbState.csyncAV = nil
    rbState.lastFakePos = nil
end
local function isRagebotSettling() return os.clock() < (RagebotSettings.settleUntil or 0) end
local function restoreLocalRoot(root)
    if not root or not rbState.csyncLocalCF then return false end
    local liveVelocity = root.AssemblyLinearVelocity
    root.CFrame = rbState.csyncLocalCF
    if rbState.csyncLocalLV then
        root.AssemblyLinearVelocity = Vector3.new(rbState.csyncLocalLV.X, liveVelocity.Y, rbState.csyncLocalLV.Z)
    end
    if rbState.csyncLocalAV then root.AssemblyAngularVelocity = rbState.csyncLocalAV end
    return true
end
local function startCsync()
    if rbState.csyncHbConn then return end
    rbState.csyncHbConn = RunService.Heartbeat:Connect(function()
        local root = getRoot(LocalPlayer.Character)
        if not root then return end
        if rbState.csyncWroteFake and rbState.csyncLocalCF then restoreLocalRoot(root) end
        if isRagebotSettling() then
            rbState.csyncLocalCF = root.CFrame
            rbState.csyncLocalLV = root.AssemblyLinearVelocity
            rbState.csyncLocalAV = root.AssemblyAngularVelocity
            rbState.csyncWroteFake = false
            return
        end
        rbState.csyncLocalCF = root.CFrame
        rbState.csyncLocalLV = root.AssemblyLinearVelocity
        rbState.csyncLocalAV = root.AssemblyAngularVelocity
        if rbState.csyncCF then
            root.CFrame = rbState.csyncCF
            local fakeVelocity = rbState.csyncLV or Vector3.new(1.2,0,1.2)
            local localVelocity = rbState.csyncLocalLV or root.AssemblyLinearVelocity
            local finalY = localVelocity.Y
            if math.abs(finalY) < 0.5 then finalY = -1.5 end
            -- AFK: toujours une vélocité non nulle pour que le serveur réplique
            if fakeVelocity.Magnitude < 0.5 then fakeVelocity = Vector3.new(1.2,0,1.2) end
            root.AssemblyLinearVelocity = Vector3.new(fakeVelocity.X, finalY, fakeVelocity.Z)
            root.AssemblyAngularVelocity = rbState.csyncAV or rbState.csyncLocalAV or root.AssemblyAngularVelocity
            rbState.csyncWroteFake = true
        else
            rbState.csyncWroteFake = false
        end
    end)
    RunService:BindToRenderStep("RB_Csync", Enum.RenderPriority.Camera.Value - 1, function()
        local root = getRoot(LocalPlayer.Character)
        if not root or not rbState.csyncLocalCF then return end
        if rbState.csyncWroteFake and restoreLocalRoot(root) then rbState.csyncWroteFake = false end
    end)
end
local function stopCsync()
    if rbState.csyncHbConn then
        rbState.csyncHbConn:Disconnect()
        rbState.csyncHbConn = nil
    end
    RunService:UnbindFromRenderStep("RB_Csync")
    restoreLocalRoot(getRoot(LocalPlayer.Character))
    clearCsyncTarget()
    rbState.csyncLocalCF = nil
    rbState.csyncLocalLV = nil
    rbState.csyncLocalAV = nil
    rbState.csyncWroteFake = false
end
local function voidRand()
    local n
    repeat n = math.random(-2147483646, 2147483646) until n < -1147483646 or n > 1147483646
    return n
end
local function voidRandCF()
    return CFrame.new(voidRand(), voidRand(), voidRand()) * CFrame.Angles(math.pi, math.pi, math.pi)
end
local function setVoidCsync(cf, lv, av)
    rbState.csyncCF = cf
    rbState.csyncLV = lv or Vector3.zero
    rbState.csyncAV = av or Vector3.zero
    rbState.lastFakePos = nil
    rbState.lastWasLead = false
end
local function enterVoidState()
    rbState.voidTargetCF = nil
    rbState.voidExposed = false
    rbState.orbitClientCF = nil
    if not rbState.active or not RagebotSettings.on then
        clearCsyncTarget()
        updateRagebotStatus()
        return
    end
    if RagebotSettings.voidSpam then
        setVoidCsync(voidRandCF())
    else
        clearCsyncTarget()
    end
    updateRagebotStatus()
end
local function enableVoidCsync()
    if rbState.voidHbConn then return end
    startCsync()
    rbState.voidHbConn = RunService.Heartbeat:Connect(function()
        if isRagebotSettling() then
            rbState.voidTargetCF = nil
            rbState.voidExposed = false
            clearCsyncTarget()
            return
        end
        local targetCF = rbState.voidTargetCF
        if targetCF then
            setVoidCsync(targetCF, Vector3.zero, Vector3.zero)
        elseif RagebotSettings.voidSpam then
            setVoidCsync(voidRandCF())
        else
            clearCsyncTarget()
        end
    end)
end
local function disableVoidCsync()
    if rbState.voidHbConn then
        rbState.voidHbConn:Disconnect()
        rbState.voidHbConn = nil
    end
    rbState.voidTargetCF = nil
    rbState.voidThread = nil
    rbState.voidExposed = false
end
local function StartOrbitRenderFix()
    if rbState.orbitRenderRunning then return end
    rbState.orbitRenderRunning = true
    RunService:BindToRenderStep("RB_Orbit", Enum.RenderPriority.First.Value, function()
        if not rbState.orbitClientCF then return end
        local root = getRoot(LocalPlayer.Character)
        if root then root.CFrame = rbState.orbitClientCF end
    end)
end
local function StopOrbitRenderFix()
    if not rbState.orbitRenderRunning then return end
    RunService:UnbindFromRenderStep("RB_Orbit")
    rbState.orbitRenderRunning = false
    rbState.orbitClientCF = nil
end
local function enableNoclip()
    if rbState.noclipConn then return end
    rbState.noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
end
local function startAmmoLoop()
    if rbState.ammoThread then return end
    rbState.ammoThread = task.spawn(function()
        while rbState.active do
            if isShootingRange() then
                task.wait(0.1)
                continue
            end
            -- AFK FIX: tire toujours même sans bouger
            if not handleAmmo() and shouldShoot() then
                local tc = rbState.target and rbState.target.Character
                local head = tc and (tc:FindFirstChild("Head") or getRoot(tc))
                if head then
                    if RagebotSettings.shootDelay > 0 then task.wait(RagebotSettings.shootDelay) end
                    doFire(head)
                end
            end
            task.wait(math.max(0.01, RagebotSettings.acSpd))
        end
        rbState.ammoThread = nil
    end)
end

RunService.Heartbeat:Connect(function()
    if not FakePosConfig.FakePosition then return end
    if rbState.active then return end
    local character = LocalPlayer.Character
    if character then
        update_fake_position(character)
    end
end)

function Ragebot.Start()
    if rbState.active then return end
    RagebotSettings.on = true
    RagebotSettings.settleUntil = 0
    rbGen += 1
    local myGen = rbGen
    rbState.active = true
    rbState.suspended = isShootingRange()
    rbState.lastTargetForCsync = nil
    triggerCsyncWarmup()

    setRagebotStatus(true, nil, true)
    startAmmoLoop()
    if not rbState.suspended then
        enableNoclip()
        enableVoidCsync()
    end

    local aaPhase = 0
    local orbitAngle = math.random() * math.pi * 2

    rbState.conn = RunService.Stepped:Connect(function(_, dt)
        if not rbState.active or not RagebotSettings.on then
            if rbState.conn then
                rbState.conn:Disconnect()
                rbState.conn = nil
            end
            return
        end
        if isShootingRange() then
            if not rbState.suspended then
                rbState.suspended = true
                rbState.target = nil
                rbState.randPos = nil
                rbState.voidTargetCF = nil
                rbState.voidExposed = false
                if rbState.noclipConn then
                    rbState.noclipConn:Disconnect()
                    rbState.noclipConn = nil
                end
                stopCsync()
                disableVoidCsync()
                StopOrbitRenderFix()
                updateRagebotStatus()
            end
            return
        end
        if rbState.suspended then
            rbState.suspended = false
            enableNoclip()
            enableVoidCsync()
        end
        local root = getRoot(LocalPlayer.Character)
        if not root then return end
        if isRagebotSettling() then
            rbState.voidTargetCF = nil
            rbState.voidExposed = false
            rbState.orbitClientCF = nil
            clearCsyncTarget()
            updateRagebotStatus()
            return
        end
        if not inMatch() then
            clearCsyncTarget()
            rbState.target = nil
            if RagebotSettings.mode == "Orbit" and not RagebotSettings.lead then -- Orbit removed, force lead/teleport
                enterVoidState()
            else
                updateRagebotStatus()
            end
            return
        end
        local now = tick()
        updateRagebotDetections()
        if rbState.target and playerIsDead(rbState.target) then rbState.target = nil end
        if rbState.target and isInvincible(rbState.target) then
            clearCsyncTarget()
            if RagebotSettings.mode == "Orbit" and not RagebotSettings.lead then -- Orbit removed, force lead/teleport
                enterVoidState()
            else
                updateRagebotStatus()
            end
            return
        end
        if now - rbTgtT >= 0.05 and (RagebotSettings.autoSwitch or not rbState.target) then
            rbTgtT = now
            if RagebotSettings.autoSwitch then
                local target = getBestTarget()
                if target then
                    if RagebotSettings.sendNotification and rbState.target ~= target then
                        Notify({ Text = "prioritized " .. target.Name, Duration = 2 })
                    end
                    rbState.target = target
                end
            elseif not rbState.target then
                rbState.target = getBestTarget()
            end
        end
        if not rbState.target then
            clearCsyncTarget()
            if RagebotSettings.mode == "Orbit" and not RagebotSettings.lead then -- Orbit removed, force lead/teleport
                enterVoidState()
            else
                updateRagebotStatus()
            end
            return
        end

        if rbState.target ~= rbState.lastTargetForCsync then
            rbState.lastTargetForCsync = rbState.target
            triggerCsyncWarmup()
        end

        local tc = rbState.target.Character
        local tr = getRoot(tc)
        local head = tc and (tc:FindFirstChild("Head") or tr)
        if not tc or not tr or not head then
            rbState.target = nil
            updateRagebotStatus()
            return
        end
        if isNearOtherMatch(tr.Position, rbState.target) then
            rbState.target = nil
            rbState.randPos = nil
            if RagebotSettings.mode == "Orbit" and not RagebotSettings.lead then -- Orbit removed, force lead/teleport
                enterVoidState()
            else
                clearCsyncTarget()
                updateRagebotStatus()
            end
            return
        end
        updateRagebotStatus()
        forceEquipPreferred()
        local weaponKind = applyWeaponRageProfile()

        local equippedItem = getFighter() and getFighter().EquippedItem
        local equippedName = equippedItem and itemName(equippedItem) or ""
        local isKnife = equippedName:lower():find("knife", 1, true) ~= nil
        local useKnifePosition =
            weaponKind == "melee"
            or isKnife
            or hasKnifeViewModel(LocalPlayer)

        if RagebotSettings.mode == "Void" then return end
        local ammoBusy = handleAmmo()
        if ammoBusy and not rbState.wasBusy and isOwnShotgun() then
            rbState.reloadVoidUntil = math.max(rbState.reloadVoidUntil or 0, now + math.max(0, RagebotSettings.shotgunVoidTime or 5))
        end
        if ammoBusy then rbState.wasBusy = true else rbState.wasBusy = false end
        local function holdOrVoid()
            rbState.voidTargetCF = nil
            rbState.voidExposed = false
            rbState.orbitClientCF = nil
            if RagebotSettings.hover and rbState.lastFaceCF then
                rbState.voidExposed = true
                rbState.voidTargetCF = rbState.lastFaceCF
                local humHold = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humHold then pcall(function() humHold.PlatformStand = false end) end
            else
                enterVoidState()
            end
        end
        if RagebotSettings.voidOnReload and now < (rbState.reloadVoidUntil or 0) then
            holdOrVoid()
            updateRagebotStatus()
            return
        end
        if RagebotSettings.mode == "Orbit" and (now < (rbState.hideOrbitUntil or 0) or ammoBusy) then
            holdOrVoid()
            return
        end
        local isUnderground = RagebotSettings.mode == "Underground"
        local isShield = isRiotShield(rbState.target)
        local height = math.clamp(RagebotSettings.orbitHeight or 2, -2, 6)
        local radius = math.clamp(RagebotSettings.orbitDist or 3, 1.25, 5)
        local targetPos
        -- FIX 100% 0 LATENCE - 4 STUDS AU DESSUS TETE - SUIT SPRINT SANS MISS
        do
            local tp0 = tr.Position
            local spd = tr.AssemblyLinearVelocity.Magnitude
            if tp0.Magnitude > 500000 or spd > 250 then
                enterVoidState()
                updateRagebotStatus()
                return
            end
            -- 0 latence chaque frame, direct au dessus tete, meme si ennemi sprint
            -- On prend head.Position actuel, pas de prediction, pas de delai
            local currentHead = head.Position
            targetPos = currentHead + Vector3.new(0, 4, 0)
            -- Si ennemi sprint tres vite, on ajoute un micro lead lateral pour pas rater
            local hVel = Vector3.new(tr.AssemblyLinearVelocity.X, 0, tr.AssemblyLinearVelocity.Z)
            if hVel.Magnitude > 16 then
                -- Sprint detecte, on compense en restant pile au dessus (pas de prediction verticale)
                -- On garde targetPos pile au dessus pour 0 latence
                targetPos = currentHead + Vector3.new(0, 4, 0)
            end
        end
        -- antiRagers REMOVED (sert a rien)
        if not isSafeRagebotPos(targetPos, rbState.target) then
            rbState.randPos = nil
            if RagebotSettings.mode == "Orbit" and not RagebotSettings.lead then -- Orbit removed, force lead/teleport
                rbState.voidTargetCF = nil
                rbState.voidExposed = false
                rbState.orbitClientCF = nil
                enterVoidState()
            else
                clearCsyncTarget()
                updateRagebotStatus()
            end
            return
        end
        local faceCF = CFrame.new(targetPos, head.Position)
        if RagebotSettings.antiAim then
            aaPhase += dt * 20
            faceCF = CFrame.new(targetPos, head.Position) * CFrame.Angles(0, math.rad(math.sin(aaPhase) * 70), 0)
        end
        rbState.lastFaceCF = faceCF
        -- COLLE SERVEUR, VUE NORMALE, FORCE LEAD CHAQUE FRAME, AFK FIX
        rbState.voidExposed = true
        rbState.voidTargetCF = faceCF
        setCsync(faceCF, targetPos, dt, tr)
        updateRagebotStatus()

        if shouldShoot() then
            doFire(head)
            rbState.nextTeleportAt = now
        end
    end)

    if rbState.charAddedConn then rbState.charAddedConn:Disconnect() end
    rbState.charAddedConn = LocalPlayer.CharacterAdded:Connect(function()
        rbState.pendingFirstShot = false
        triggerCsyncWarmup()
        stopCsync()
        disableVoidCsync()
        StopOrbitRenderFix()
        rbState.target = nil
        clearCsyncTarget()
        rbState.lastTargetForCsync = nil
        rbState.csyncLocalCF = nil
        rbState.csyncLocalLV = nil
        rbState.csyncLocalAV = nil
        rbState.csyncWroteFake = false
        rbState.voidExposed = false
        rbState.hideOrbitUntil = 0
        if rbState.active then
            task.wait(0.5)
            if rbState.active then
                enableVoidCsync()
                triggerCsyncWarmup()
            end
        end
    end)
end

function Ragebot.Stop()
    rbGen += 1
    rbState.active = false
    RagebotSettings.on = false
    rbState.csyncWarmedUp = false
    rbState.pendingFirstShot = false
    rbState.lastTargetForCsync = nil
    setRagebotStatus(false)
    if rbState.conn then rbState.conn:Disconnect(); rbState.conn = nil end
    if rbState.noclipConn then rbState.noclipConn:Disconnect(); rbState.noclipConn = nil end
    if rbState.charAddedConn then rbState.charAddedConn:Disconnect(); rbState.charAddedConn = nil end
    rbState.target = nil
    rbState.voidExposed = false
    rbState.nextTeleportAt = 0
    rbState.ammoActionAt = 0
    rbState.hideOrbitUntil = 0
    rbState.randPos = nil
    rbState.randT = 0
    rbState.lastFakePos = nil
    rbState.lastFaceCF = nil
    rbState.reloadVoidUntil = 0
    rbState.wasBusy = false
    rbInMatchT = 0
    rbInMatch = false
    stopCsync()
    disableVoidCsync()
    StopOrbitRenderFix()
    local char = LocalPlayer.Character
    if char then
        local humStop = char:FindFirstChildOfClass("Humanoid")
        if humStop then pcall(function() humStop.PlatformStand = false end) end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end


    local RagebotGroup = Tabs.Ragebot:AddLeftGroupbox("Ragebot")
    local PriorityGroup = Tabs.Ragebot:AddRightGroupbox("Priority")

RagebotGroup:AddToggle("rb_enabled", {
    Text = "Enabled",
    Default = false,
    Callback = function(v)
        if v then Ragebot.Start() else Ragebot.Stop() end
        markDirty()
    end,
})

RagebotGroup:AddToggle("rb_voidspam", {
    Text = "void spam",
    Default = false,
    Callback = function(v) RagebotSettings.voidSpam = v; markDirty() end,
})
RagebotGroup:AddSlider("rb_hide", {
    Text = "hide",
    Min = 0,
    Max = 1,
    Default = 0.25,
    Rounding = 2,
    Suffix = "s",
    Compact = true,
    Callback = function(v) RagebotSettings.voidHideTime = v; markDirty() end,
})
RagebotGroup:AddSlider("rb_attack", {
    Text = "attack",
    Min = 0,
    Max = 1,
    Default = 0.03,
    Rounding = 2,
    Suffix = "s",
    Compact = true,
    Callback = function(v) RagebotSettings.voidShootTime = v; markDirty() end,
})

RagebotGroup:AddSlider("rb_attempts", {
    Text = "shoot attempts",
    Min = 1,
    Max = 10,
    Default = 1,
    Rounding = 0,
    Suffix = "x",
    Callback = function(v) RagebotSettings.shootAttempts = math.floor(v); markDirty() end,
})

-- antiRagers toggle fully removed

RagebotGroup:AddToggle("rb_stick", {
    Text = "stick to enemy",
    Default = false,
    Tooltip = "Glue exactly on top of the enemy and follow every move (v28 style) instead of orbiting",
    Callback = function(v) RagebotSettings.stick = v end,
})

-- lead removed
RagebotSettings.lead = true

RagebotGroup:AddToggle("rb_voidreload", {
    Text = "void while reloading",
    Default = true,
    Tooltip = "Go void (or hover) while reloading / switching weapons",
    Callback = function(v) RagebotSettings.voidOnReload = v end,
})

RagebotGroup:AddSlider("rb_shotgunvoid", {
    Text = "shotgun void time",
    Min = 0,
    Max = 30,
    Default = 5,
    Rounding = 0,
    Suffix = "s",
    Tooltip = "With a shotgun equipped, stay in void at least this long when reloading",
    Callback = function(v) RagebotSettings.shotgunVoidTime = v end,
})


RagebotGroup:AddDropdown("rb_prefwep", {
    Text = "preferred weapon",
    Values = {"primary", "secondary", "melee"},
    Default = 1,
    Multi = false,
    Callback = function(v)
        RagebotSettings.preferredWeapon = v
        if v == "primary" then
            RagebotSettings.primarySlot = 1
            RagebotSettings.secondarySlot = 2
        elseif v == "secondary" then
            RagebotSettings.primarySlot = 2
            RagebotSettings.secondarySlot = 1
        else
            RagebotSettings.primarySlot = 1
            RagebotSettings.secondarySlot = 2
        end
        markDirty()
    end,
})
RagebotGroup:AddDropdown("rb_attackmode", {
    Text = "attack mode",
    Values = {"auto", "gun", "knife"},
    Default = "auto",
    Tooltip = "auto = by weapon · gun = normal · knife = always 2 studs behind the enemy (backstab, no orbit)",
    Callback = function(v) RagebotSettings.attackMode = v end,
})

RagebotGroup:AddToggle("rb_weaponlock", {
    Text = "lock weapon",
    Default = true,
    Tooltip = "Forces the selected slot (prevents manual switching)",
    Callback = function(v) RagebotSettings.weaponLock = v; markDirty() end,
})
RagebotGroup:AddDropdown("rb_onempty", {
    Text = "on empty",
    Values = {"SwapOrReload", "Swap", "Reload"},
    Default = 1,
    Multi = false,
    Callback = function(v) RagebotSettings.onEmpty = v; markDirty() end,
})
RagebotGroup:AddToggle("rb_specialize", {
    Text = "weapon specialize",
    Default = true,
    Callback = function(v) RagebotSettings.weaponSpecialize = v; markDirty() end,
})

RagebotGroup:AddToggle("rb_fakepos", {
    Text = "fake position",
    Default = false,
    Tooltip = "Applies a fake position below the player to avoid getting hit",
    Callback = function(v)
        if v then enable_fake_position() else disable_fake_position() end
    end,
})
RagebotGroup:AddSlider("rb_fakepos_y", {
    Text = "fake pos y",
    Min = 1,
    Max = 20,
    Default = 5,
    Rounding = 1,
    Suffix = "studs",
    Callback = function(v) FakePosConfig.FakePositionY = v end,
})
RagebotGroup:AddToggle("rb_fakepos_panic", {
    Text = "fake pos panic",
    Default = false,
    Tooltip = "Adds a random X offset to the fake position",
    Callback = function(v) FakePosConfig.FakePositionPanic = v end,
})
RagebotGroup:AddSlider("rb_fakepos_panic_min", {
    Text = "panic x min",
    Min = -20,
    Max = 0,
    Default = -8,
    Rounding = 1,
    Callback = function(v) FakePosConfig.PanicPositionXMin = v end,
})
RagebotGroup:AddSlider("rb_fakepos_panic_max", {
    Text = "panic x max",
    Min = 0,
    Max = 20,
    Default = 8,
    Rounding = 1,
    Callback = function(v) FakePosConfig.PanicPositionXMax = v end,
})
RagebotGroup:AddToggle("rb_fakepos_walk", {
    Text = "fake pos walk",
    Default = false,
    Tooltip = "Lets you walk normally when the ragebot is off",
    Callback = function(v) FakePosConfig.FakePositionWalk = v end,
})

PriorityGroup:AddToggle("rb_autoprio", {
    Text = "auto prioritize",
    Default = true,
    Callback = function(v)
        RagebotSettings.autoPriority = v
        RagebotSettings.autoSwitch = v
        markDirty()
    end,
})
PriorityGroup:AddToggle("rb_notify", {
    Text = "send notification",
    Default = false,
    Callback = function(v) RagebotSettings.sendNotification = v; markDirty() end,
})
PriorityGroup:AddDropdown("rb_priosettings", {
    Text = "auto priority settings",
    Values = {"attackers", "voided players"},
    Default = {"attackers", "voided players"},
    Multi = true,
    Callback = function(v)
        RagebotSettings.priorityAttackers = v.attackers == true
        RagebotSettings.priorityVoided = v["voided players"] == true
        markDirty()
    end,
})
local function getPlayerNames()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then table.insert(names, plr.Name) end
    end
    table.sort(names)
    return names
end
local PrioritizedDropdown = PriorityGroup:AddDropdown("rb_prioritized", {
    Text = "prioritized",
    Values = getPlayerNames(),
    Default = 1,
    Multi = false,
    AllowNull = true,
    Callback = function(v) RagebotSettings.prioritizedPlayer = v; markDirty() end,
})
local function refreshPriorityPlayers()
    PrioritizedDropdown:SetValues(getPlayerNames())
end
Players.PlayerAdded:Connect(refreshPriorityPlayers)
Players.PlayerRemoving:Connect(refreshPriorityPlayers)

print("[Ragebot Standalone] Loaded — attack mode removed, automatic knife detection.")
end

do
local RBTextCfg = {
    enabled = false,
    color = Color3.fromRGB(235, 235, 235),
    mode = "static",
    staticOffsetX = 0,
    staticOffsetY = 40,
    showAmmo = true,
    hideOnReload = true,
    textSize = 15,
    lineGap = 15,
}

local HAS_DRAWING = pcall(function() return Drawing.new("Text") end)

local txt1, txt2
if HAS_DRAWING then
    local function mkText()
        local t = Drawing.new("Text")
        t.Size = RBTextCfg.textSize
        t.Font = 2
        t.Outline = true
        t.Center = true
        t.Visible = false
        t.Color = RBTextCfg.color
        t.OutlineColor = Color3.fromRGB(0, 0, 0)
        return t
    end
    txt1 = mkText()
    txt2 = mkText()
end

local RBTextFighterCache = { ctrl = nil, at = 0 }
local function rbTextGetFighterController()
    if RBTextFighterCache.ctrl and os.clock() - RBTextFighterCache.at < 1 then
        return RBTextFighterCache.ctrl
    end
    local ok, ctrl = pcall(function()
        local c = LocalPlayer.PlayerScripts:FindFirstChild("Controllers")
        return c and c:FindFirstChild("FighterController") and require(c.FighterController)
    end)
    RBTextFighterCache.ctrl, RBTextFighterCache.at = ok and ctrl or nil, os.clock()
    return RBTextFighterCache.ctrl
end

local function rbTextEquippedItem()
    local fc = rbTextGetFighterController()
    return fc and rawget(fc, "LocalFighter") and rawget(fc.LocalFighter, "EquippedItem") or nil
end

local RBTextMeleeNames = {
    ["Fists"] = true, ["Knife"] = true, ["Katana"] = true, ["Scythe"] = true,
    ["Battle Axe"] = true, ["Chainsaw"] = true, ["Maul"] = true, ["Spear"] = true,
    ["Daggers"] = true, ["Riot Shield"] = true, ["Trowel"] = true, ["Glast Shard"] = true,
}

local function rbTextAmmo()
    local item = rbTextEquippedItem()
    if type(item) ~= "table" then return nil end
    local okN, name = pcall(function() return item:Get("Name") or item.Name end)
    name = okN and tostring(name or "") or ""
    if name ~= "" and RBTextMeleeNames[name] then return "melee" end
    local okA, a = pcall(function() return item:Get("Ammo") end)
    local okM, m = pcall(function() return item:Get("MaxAmmo") end)
    a, m = tonumber(okA and a or nil), tonumber(okM and m or nil)
    if a == nil then return "inf" end
    return string.format("%d/%d", math.floor(a), math.max(math.floor(m or a), 0))
end

local function rbTextReloading()
    local item = rbTextEquippedItem()
    if type(item) ~= "table" then return false end
    local now = tick()
    local c = rawget(item, "_reload_cooldown")
    if type(c) == "number" and now < c then return true end
    local n = rawget(item, "_shoot_cooldown_no_ammo")
    return type(n) == "number" and now < n
end

local function rbTextMuzzleScreenPos()
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local vm = workspace:FindFirstChild("ViewModels")
    local fp = vm and vm:FindFirstChild("FirstPerson")
    if not fp then return nil end
    local pn = LocalPlayer.Name
    for _, model in ipairs(fp:GetChildren()) do
        if model:IsA("Model") and model.Name:find("^" .. pn) then
            local iv = model:FindFirstChild("ItemVisual")
            local body = iv and iv:FindFirstChild("Body")
            local bp = body and body:FindFirstChild("BodyPrimary")
            local muzzle = bp and bp:FindFirstChild("_muzzle")
            if muzzle and muzzle:IsA("Attachment") then
                local sp, on = cam:WorldToViewportPoint(muzzle.WorldPosition)
                if on then return Vector2.new(sp.X, sp.Y) end
            end
        end
    end
    return nil
end

local rbTextLastTarget = nil
local rbTextKillStart = nil

local function rbTextLines(now)
    local settings = getgenv().RB_Settings
    local state = getgenv().RB_State
    local active = settings ~= nil and settings.on == true and state ~= nil and state.active == true
    if not active then
        rbTextLastTarget, rbTextKillStart = nil, nil
        return "ragebot: idle", ""
    end
    if state.target ~= rbTextLastTarget then
        rbTextLastTarget = state.target
        rbTextKillStart = nil
    end
    local target = state.target
    local tChar = target and target.Character
    local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    local tValid = tHum ~= nil and tHum.Health > 0
    if rbTextReloading() then
        rbTextKillStart = nil
        return "ragebot: void hide", "reloading"
    end
    if not state.voidExposed and not tValid then
        rbTextKillStart = nil
        return "ragebot: void hide", ""
    end
    if tValid then
        if not rbTextKillStart then rbTextKillStart = now end
        local main = string.format("ragebot : attacking (%s) · %.1fs", tostring(target.Name), now - rbTextKillStart)
        local line2 = string.format("%.0f hp", tHum.Health)
        if RBTextCfg.showAmmo then
            local ammo = rbTextAmmo()
            if ammo and ammo ~= "" then
                line2 = line2 .. " · " .. ammo
            end
        end
        return main, line2
    end
    rbTextKillStart = nil
    return "ragebot: ready", ""
end

local function rbTextDraw()
    if not HAS_DRAWING then return end
    if not RBTextCfg.enabled or (RBTextCfg.hideOnReload and rbTextReloading()) then
        txt1.Visible = false
        txt2.Visible = false
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then
        txt1.Visible = false
        txt2.Visible = false
        return
    end
    local now = tick()
    local mainLine, detailLine = rbTextLines(now)
    local anchor
    if RBTextCfg.mode == "muzzle" then
        anchor = rbTextMuzzleScreenPos()
    end
    if not anchor then
        anchor = (cam.ViewportSize / 2) + Vector2.new(RBTextCfg.staticOffsetX, RBTextCfg.staticOffsetY)
    end
    local gap = RBTextCfg.lineGap
    local lineCount = 1 + (detailLine ~= "" and 1 or 0)
    local topOffset = -(lineCount - 1) * (gap / 2)
    txt1.Text = mainLine
    txt1.Size = RBTextCfg.textSize
    txt1.Color = RBTextCfg.color
    txt1.Position = anchor + Vector2.new(0, topOffset)
    txt1.Visible = true
    if detailLine ~= "" then
        txt2.Text = detailLine
        txt2.Size = math.max(RBTextCfg.textSize - 1, 10)
        txt2.Color = RBTextCfg.color
        txt2.Position = anchor + Vector2.new(0, topOffset + gap)
        txt2.Visible = true
    else
        txt2.Visible = false
    end
end

if HAS_DRAWING then
    Services.RunService.RenderStepped:Connect(rbTextDraw)
end


local RageTextGroup = Tabs.Ragebot:AddRightGroupbox("Ragebot Text", "type")

RageTextGroup:AddToggle("rb_text_enabled", {
    Text = "Rage Status",
    Default = false,
    Tooltip = "Ragebot status text (Lunara style): state, target, hp and ammo",
    Callback = function(v) RBTextCfg.enabled = v end,
}):AddColorPicker("rb_text_color", {
    Title = "text color",
    Default = RBTextCfg.color,
    Callback = function(v) RBTextCfg.color = v end,
})

RageTextGroup:AddDropdown("rb_text_mode", {
    Text = "Position",
    Values = { "static", "muzzle" },
    Default = "static",
    Tooltip = "static = screen center + offsets · muzzle = sticks to your gun muzzle",
    Callback = function(v) RBTextCfg.mode = v end,
})

RageTextGroup:AddSlider("rb_text_x", {
    Text = "Static X",
    Default = 0,
    Min = -500,
    Max = 500,
    Rounding = 0,
    Compact = true,
    Callback = function(v) RBTextCfg.staticOffsetX = v end,
})

RageTextGroup:AddSlider("rb_text_y", {
    Text = "Static Y",
    Default = 40,
    Min = -500,
    Max = 500,
    Rounding = 0,
    Compact = true,
    Callback = function(v) RBTextCfg.staticOffsetY = v end,
})

RageTextGroup:AddToggle("rb_text_ammo", {
    Text = "Show Ammo Line",
    Default = true,
    Callback = function(v) RBTextCfg.showAmmo = v end,
})

RageTextGroup:AddToggle("rb_text_reload", {
    Text = "Hide While Reloading",
    Default = true,
    Tooltip = "Hide the text while reloading / out of ammo",
    Callback = function(v) RBTextCfg.hideOnReload = v end,
})

RageTextGroup:AddSlider("rb_text_size", {
    Text = "Text Size",
    Default = 15,
    Min = 10,
    Max = 24,
    Rounding = 0,
    Compact = true,
    Callback = function(v) RBTextCfg.textSize = v end,
})
end



do
local UEConfig = {
    enabled = false,
    depth = 5.5,
}

local UEState = {
    active = false,
    stored_pos = nil,
    mode = "none",
    yaw_locked = false,
    locked_look = nil,
    weapon_cache = {},
    fc_active = false,
    fc_cf = nil,
}

local UECamCtrl = nil
task.spawn(function()
    pcall(function()
        UECamCtrl = require(LocalPlayer.PlayerScripts.Controllers.CameraController)
    end)
end)

local function ueRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function ueTeleport(x, y, z)
    local root = ueRoot()
    if not root then return end
    pcall(function()
        root.CFrame = CFrame.new(x, y, z)
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        -- FIX 100% ANTI-CHUTE UE COUNTER - maintien position
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
            -- Force pas de chute
            if root:FindFirstChild("UEAntiFall") == nil then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "UEAntiFall"
                bv.MaxForce = Vector3.new(0, 4000, 0)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.3)
            end
        end
    end)
end

local function ueScanWeapons()
    local viewModels = workspace:FindFirstChild("ViewModels")
    if not viewModels then return end
    local cache = {}
    for _, child in ipairs(viewModels:GetChildren()) do
        local a, b = string.match(child.Name, "^(.-) %- (.-) %-")
        if a and b then cache[a] = b end
    end
    UEState.weapon_cache = cache
end

local function ueWeaponOf(player)
    if not player then return nil end
    return UEState.weapon_cache[player.Name] or UEState.weapon_cache[player.DisplayName]
end

local function ueIsKnife(name)
    return name ~= nil and string.lower(tostring(name)) == "knife"
end

local function ueValidEnemy(player)
    if not player or player == LocalPlayer then return false end
    local char = player.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    local ok, same = pcall(function()
        return player:GetAttribute("TeamID") == LocalPlayer:GetAttribute("TeamID")
    end)
    if ok and same then return false end
    return true
end

local function ueNearestEnemy()
    local root = ueRoot()
    if not root then return nil end
    local best, bestD = nil, math.huge
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if ueValidEnemy(player) then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local d = (hrp.Position - root.Position).Magnitude
                if d < bestD then bestD = d best = player end
            end
        end
    end
    return best
end

local function ueGoUnderground()
    local root = ueRoot()
    if not root then return end
    if not UEState.stored_pos then UEState.stored_pos = root.Position end
    local p = UEState.stored_pos
    ueTeleport(p.X, p.Y - UEConfig.depth, p.Z)
    UEState.mode = "underground"
end

local function ueGoSky()
    local root = ueRoot()
    if not root then return end
    if not UEState.stored_pos then UEState.stored_pos = root.Position end
    local p = UEState.stored_pos
    local vector = Vector3.new((math.random() - 0.5) * 2, math.random() * 0.85 + 0.15, (math.random() - 0.5) * 2)
    local dir
    if vector.Magnitude < 0.05 then dir = Vector3.new(0, 1, 0) else dir = vector.Unit end
    local target = p + dir * (1000 + math.random() * 1500)
    local dx, dy, dz = target.X - p.X, target.Y - p.Y, target.Z - p.Z
    if math.abs(dx) < 1000 then dx = (dx >= 0 and 1 or -1) * (1000 + math.random() * 500) end
    if math.abs(dy) < 1000 then dy = 1000 + math.random() * 800 end
    if math.abs(dz) < 1000 then dz = (dz >= 0 and 1 or -1) * (1000 + math.random() * 500) end
    ueTeleport(p.X + dx, p.Y + dy, p.Z + dz)
    UEState.mode = "sky"
end

local function ueLockYaw()
    if UEState.yaw_locked then return end
    UEState.yaw_locked = true
    pcall(function()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local pos = cam.CFrame.Position
        UEState.locked_look = CFrame.lookAt(pos, pos + Vector3.new(0, 1, 0))
        if UECamCtrl and UECamCtrl.MimicRotation then
            UECamCtrl:MimicRotation(UEState.locked_look)
        end
        cam.CFrame = UEState.locked_look
    end)
end

local function ueStartFC()
    if UEState.fc_active then return end
    UEState.fc_active = true
    UEState.fc_cf = workspace.CurrentCamera and workspace.CurrentCamera.CFrame
    pcall(function()
        local cam = workspace.CurrentCamera
        if not cam then return end
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CameraSubject = nil
    end)
end

local function ueStopFC()
    if not UEState.fc_active then return end
    UEState.fc_active = false
    UEState.fc_cf = nil
    pcall(function()
        local cam = workspace.CurrentCamera
        if not cam then return end
        cam.CameraType = Enum.CameraType.Custom
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then cam.CameraSubject = hum end
    end)
end

local function ueRestore()
    UEState.active = false
    UEState.mode = "none"
    UEState.yaw_locked = false
    UEState.locked_look = nil
    ueStopFC()
    if UEState.stored_pos then
        local p = UEState.stored_pos
        ueTeleport(p.X, p.Y, p.Z)
    end
    UEState.stored_pos = nil
end

Services.RunService.Heartbeat:Connect(function()
    if not UEConfig.enabled then
        if UEState.active then ueRestore() end
        return
    end

    if not UEState.active then
        UEState.active = true
        local root = ueRoot()
        if root then UEState.stored_pos = root.Position end
        ueLockYaw()
        ueStartFC()
        if UEState.fc_cf == nil and workspace.CurrentCamera then
            UEState.fc_cf = workspace.CurrentCamera.CFrame
        end
        pcall(function()
            UEState.fc_cf = UEState.fc_cf * CFrame.new(0, 0.5, 0)
        end)
    end

    if UEState.yaw_locked then
        pcall(function()
            local cam = workspace.CurrentCamera
            if not cam then return end
            local pos = cam.CFrame.Position
            local cf = CFrame.lookAt(pos, pos + Vector3.new(0, 1, 0))
            UEState.locked_look = cf
            if UECamCtrl and UECamCtrl.MimicRotation then
                UECamCtrl:MimicRotation(cf)
            end
        end)
    end

    if UEState.fc_active and UEState.fc_cf then
        pcall(function()
            local cam = workspace.CurrentCamera
            if not cam then return end
            cam.CameraType = Enum.CameraType.Scriptable
            cam.CFrame = UEState.fc_cf
        end)
    end

    ueScanWeapons()
    local enemy = ueNearestEnemy()
    if not enemy then
        ueGoUnderground()
    elseif ueIsKnife(ueWeaponOf(enemy)) then
        ueGoSky()
    else
        ueGoUnderground()
    end
end)

-- FIX 100% LEAD FORCE CHAQUE FRAME - avantage sur autres ragebots
Services.RunService.Heartbeat:Connect(function()
    if not RagebotSettings.on then return end
    RagebotSettings.lead = true
    if rbState and rbState.active and rbState.target and not rbState.csyncCF then
        local char = rbState.target.Character
        local head = char and char:FindFirstChild("Head")
        local tr = char and char:FindFirstChild("HumanoidRootPart")
        if head and tr then
            local targetPos = head.Position + Vector3.new(0, 4, 0)
            local faceCF = CFrame.new(targetPos, head.Position)
            setCsync(faceCF, targetPos, 0, tr)
            rbState.voidExposed = true
            rbState.voidTargetCF = faceCF
        end
    end
    if rbState and rbState.active and RagebotSettings.mode ~= "Underground" then
        RagebotSettings.mode = "Orbit"
    end
end)

-- FIX 100% SUIVI ENNEMI SANS LATENCE CHAQUE FRAME - RenderStepped ultra rapide
Services.RunService:BindToRenderStep("RB_0LatencyTrack", Enum.RenderPriority.Character.Value + 1, function()
    if not RagebotSettings.on or not rbState.active or not rbState.target then return end
    local char = rbState.target.Character
    local head = char and char:FindFirstChild("Head")
    local tr = char and char:FindFirstChild("HumanoidRootPart")
    if not head or not tr then return end
    -- Suit la tete chaque frame, 4 studs au dessus, 0 latence
    local targetPos = head.Position + Vector3.new(0, 4, 0)
    local faceCF = CFrame.new(targetPos, head.Position)
    -- Force update ultra rapide
    rbState.csyncCF = faceCF
    rbState.voidTargetCF = faceCF
    rbState.lastFaceCF = faceCF
    local root = getRoot(LocalPlayer.Character)
    if root then
        root.CFrame = faceCF
    end
end)

-- FIX UE COUNTER MAINTIEN - anti-chute supplementaire chaque frame
Services.RunService.Heartbeat:Connect(function()
    if not UEConfig.enabled then return end
    local root = ueRoot()
    if not root then return end
    -- Si on est en underground, verifie qu'on tombe pas
    if UEState.mode == "underground" and UEState.stored_pos then
        local currentY = root.Position.Y
        local targetY = UEState.stored_pos.Y - UEConfig.depth
        -- Si on tombe trop bas ou trop haut, on re-teleporte
        if math.abs(currentY - targetY) > 2 then
            pcall(function()
                root.CFrame = CFrame.new(UEState.stored_pos.X, targetY, UEState.stored_pos.Z)
                root.AssemblyLinearVelocity = Vector3.zero
            end)
        end
        -- Anti-gravite
        if root.AssemblyLinearVelocity.Y < -5 then
            root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    if UEConfig.enabled then
        UEState.stored_pos = nil
    end
end)


local CounterGroup = Tabs.Ragebot:AddRightGroupbox("Counter", "zap")

CounterGroup:AddToggle("ue_counter", {
    Text = "UE Counter",
    Default = false,
    Tooltip = "Underground anti-aim: hide under the map; goes to the sky if the nearest enemy has a knife out",
    Callback = function(v) UEConfig.enabled = v end,
}):AddKeyPicker("ue_counter_key", {
    Text = "UE Counter",
    Default = "X",
    Mode = "Toggle",
    SyncToggleState = true,
    NoUI = false,
})

CounterGroup:AddSlider("ue_counter_depth", {
    Text = "depth",
    Default = 5.5,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Tooltip = "How deep underground you go",
    Callback = function(v) 
        UEConfig.depth = v
        -- Applique direct si deja en underground
        if UEState.active and UEState.stored_pos and UEState.mode == "underground" then
            local p = UEState.stored_pos
            pcall(function()
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(p.X, p.Y - v, p.Z)
                end
            end)
        end
    end,
})

-- KICIA COUNTER - CODE EXACT FOURNI (ne pas modifier)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local plr = Players.LocalPlayer

local speed = 1e6
local bounceBoost = 3
local rayLength = 50

local flying = false
local bv, bg
local direction = Vector3.new(1,0,0)
local currentSpeed = speed
local char, hrp
local heartbeatConn

local function createFly()
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end

	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.zero
	bv.Parent = hrp

	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bg.CFrame = hrp.CFrame
	bg.Parent = hrp
end

local function checkBounce()
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {char}

	local ray = workspace:Raycast(hrp.Position, direction * rayLength, rayParams)
	if ray then
		local normal = ray.Normal
		direction = (direction - 2 * direction:Dot(normal) * normal).Unit
		currentSpeed = speed * bounceBoost

		local spark = Instance.new("Part")
		spark.Size = Vector3.new(1,1,1)
		spark.CFrame = CFrame.new(ray.Position)
		spark.Anchored = true
		spark.CanCollide = false
		spark.Material = Enum.Material.Neon
		spark.Color = Color3.fromRGB(0,255,255)
		spark.Parent = workspace
		game:GetService("Debris"):AddItem(spark, 0.3)
	else
		currentSpeed = math.min(currentSpeed, speed)
	end
end

local function startFly()
	if flying then return end
	flying = true
	createFly()

	direction = Vector3.new(
		math.random()*2-1,
		math.random()*2-1,
		math.random()*2-1
	).Unit

	if heartbeatConn then heartbeatConn:Disconnect() end
	heartbeatConn = RunService.Heartbeat:Connect(function()
		if not flying or not bv or not bg or not hrp or not hrp.Parent then return end

		checkBounce()

		bv.Velocity = direction * currentSpeed
		bg.CFrame = CFrame.new(hrp.Position, hrp.Position + direction)

		if hrp.Position.Y < -500 then
			direction = Vector3.new(
				math.random()*2-1,
				1,
				math.random()*2-1
			).Unit
		end
	end)
end

local function setupCharacter(c)
	char = c
	hrp = c:WaitForChild("HumanoidRootPart")
	flying = false
	currentSpeed = speed
	startFly()
end

if plr.Character then
	setupCharacter(plr.Character)
end

plr.CharacterAdded:Connect(function(c)
	task.wait(0.5)
	setupCharacter(c)
end)
-- FIN CODE EXACT KICIA
-- Stop immediat, controle par toggle
flying = false
if bv then bv:Destroy() bv = nil end
if bg then bg:Destroy() bg = nil end
if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end

CounterGroup:AddToggle("kicia_counter", {
    Text = "Kicia Counter",
    Default = false,
    Tooltip = "High-speed bounce fly - counters Kicia ragebot",
    Callback = function(v)
        if v then
            if plr.Character then
                setupCharacter(plr.Character)
            end
        else
            flying = false
            if bv then bv:Destroy() bv = nil end
            if bg then bg:Destroy() bg = nil end
            if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end
        end
    end,
})
end

local LoggerInstance = Logger.new("[NoksVIP]")
local ErrorHandlerInstance = ErrorHandler.new(LoggerInstance)
local AimbotInstance = AimbotEngine.new(AimbotConfig)
local IOInstance = IOHandler.new()


local FOVAnimationConnection = Services.RunService.RenderStepped:Connect(function()
    if IOInstance and IOInstance.FOVGui then
        IOInstance:UpdateFOVCircles()
    end
end)
local ConfigInstance = ConfigManager.new("noks_vip_config.json")


local repS = cloneref(game:GetService("ReplicatedStorage"))
local plrs = cloneref(game:GetService("Players"))
local runS = cloneref(game:GetService("RunService"))
local ws = cloneref(game:GetService("Workspace"))
local uis = cloneref(game:GetService("UserInputService"))
local lplr = plrs.LocalPlayer
local util = require(repS.Modules.Utility)
local enum = require(repS.Modules.EnumLibrary)
local FighterController = require(lplr.PlayerScripts.Controllers.FighterController)
local SpectateController = require(lplr.PlayerScripts.Controllers:WaitForChild("SpectateController"))

local function isTargetDamageable(player)
    local character = player and player.Character
    if not character then return false end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    if character:FindFirstChildOfClass("ForceField") then return false end
    local protectedAttributes = { "Invulnerable", "IsInvulnerable", "Immune", "IsImmune", "Shielded", "IsShielded" }
    for _, attributeName in ipairs(protectedAttributes) do
        if character:GetAttribute(attributeName) == true then return false end
    end
    if character:GetAttribute("Damageable") == false or character:GetAttribute("CanTakeDamage") == false then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart and rootPart:FindFirstChild("Attachment") then return false end
    if not FighterController or not FighterController.Objects then return true end
    for _, fighterObj in FighterController.Objects do
        if fighterObj.Player == player then
            local protected = false
            local damageable = true
            pcall(function()
                protected = fighterObj:Get("Shielded") == true or fighterObj:Get("IsShielded") == true or fighterObj:Get("IsBlocking") == true
                    or fighterObj:Get("Invulnerable") == true or fighterObj:Get("IsInvulnerable") == true
                    or fighterObj:Get("Immune") == true or fighterObj:Get("IsImmune") == true
                damageable = fighterObj:Get("Damageable") ~= false and fighterObj:Get("CanTakeDamage") ~= false
            end)
            return damageable and not protected
        end
    end
    return true

end

local function isEnemy(player)
    if player == lplr then return false end
    local duel = SpectateController.CurrentDuelSubject
    local localDueler = duel and duel:GetDueler(lplr)
    local localTeam = localDueler and localDueler:Get("TeamID") or nil
    if localTeam and duel and duel.Duelers then
        for _, dueler in duel.Duelers do
            if dueler.Player == player then
                local team = dueler:Get("TeamID")
                return team ~= localTeam
            end
        end
    end
    local pTeam = player:GetAttribute("TeamID")
    local lTeam = lplr:GetAttribute("TeamID")
    if pTeam and lTeam then
        return pTeam ~= lTeam
    end
    return true
end

local AevyxCombatFeatures = {
    NoRecoil = false,
    AntiFlashbang = false,
    Counter = false,
    FakePosition = false,
}


getgenv().AevyxCombatMods = getgenv().AevyxCombatMods or {
    Hooked = false,
    OriginalRecoil = nil,
}

task.spawn(function()
    local success, gunModule = pcall(function()
        return require(lplr.PlayerScripts.Modules.ItemTypes.Gun)
    end)
    if not success or not gunModule or not gunModule._Recoil or getgenv().AevyxCombatMods.Hooked then return end
    getgenv().AevyxCombatMods.Hooked = true
    getgenv().AevyxCombatMods.OriginalRecoil = gunModule._Recoil
    gunModule._Recoil = function(self, multiplier)
        if AevyxCombatFeatures.NoRecoil then return end
        return getgenv().AevyxCombatMods.OriginalRecoil(self, multiplier)
    end
end)

getgenv().eteritum = getgenv().eteritum or {}
getgenv().eteritum.guns = getgenv().eteritum.guns or {}

local antiFlashbangHooked = false
local function applyAevyxAntiFlashbang()
    if antiFlashbangHooked then return end
    local success, utilModule = pcall(function()
        return require(repS.Modules.Utility)
    end)
    if not success or not utilModule or not utilModule.PlayParticles then return end
    antiFlashbangHooked = true
    local old_muzzle = utilModule.PlayParticles
    utilModule.PlayParticles = function(s, p)
        if getgenv().eteritum.guns.no_muzzle_flash and p and p.Name == "_muzzle" then
            return
        end
        return old_muzzle(s, p)
    end
end



local aevyxCounterState = {
    Root = nil,
    CFrame = nil,
    Velocity = nil,
    RotVelocity = nil,
}

local function restoreAevyxCounter()
    local state = aevyxCounterState
    if state.Root and state.Root.Parent and state.CFrame then
        state.Root.CFrame = state.CFrame
        state.Root.Velocity = state.Velocity or Vector3.new(0, 0, 0)
        state.Root.RotVelocity = state.RotVelocity or Vector3.new(0, 0, 0)
    end
    state.Root, state.CFrame, state.Velocity, state.RotVelocity = nil, nil, nil, nil
end

local function getAevyxCounterTarget()
    local character = lplr.Character
    local myRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, nil, nil end
    local bestPlayer, bestRoot, bestHead = nil, nil, nil
    local bestDistance = 9
    for _, player in ipairs(plrs:GetPlayers()) do
        if isEnemy(player) and isTargetDamageable(player) then
            local targetCharacter = player.Character
            local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
            local targetHead = targetCharacter and targetCharacter:FindFirstChild("Head")
            local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildWhichIsA("Humanoid")
            if targetRoot and targetHead and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (myRoot.Position - targetRoot.Position).Magnitude
                if distance <= bestDistance then
                    bestPlayer, bestRoot, bestHead, bestDistance = player, targetRoot, targetHead, distance
                end
            end
        end
    end
    return bestPlayer, bestRoot, bestHead
end

local counterDesyncActive = false

runS:BindToRenderStep("AevyxCounterSet", Enum.RenderPriority.First.Value - 1, function()
    if not AevyxCombatFeatures.Counter then
        if counterDesyncActive then
            restoreAevyxCounter()
            counterDesyncActive = false
        end
        return
    end
    local targetPlayer, targetRoot, targetHead = getAevyxCounterTarget()
    local character = lplr.Character
    local myRoot = character and character:FindFirstChild("HumanoidRootPart")
    if not targetPlayer or not targetRoot or not targetHead or not myRoot then
        if counterDesyncActive then
            restoreAevyxCounter()
            counterDesyncActive = false
        end
        return
    end
    if not counterDesyncActive then
        aevyxCounterState.Root = myRoot
        aevyxCounterState.CFrame = myRoot.CFrame
        aevyxCounterState.Velocity = myRoot.Velocity
        aevyxCounterState.RotVelocity = myRoot.RotVelocity
        counterDesyncActive = true
    end
    local fakePos = aevyxCounterState.CFrame.Position + Vector3.new(0, 1000, 0)
    myRoot.CFrame = CFrame.new(fakePos)
    myRoot.Velocity = Vector3.zero
    myRoot.RotVelocity = Vector3.zero
end)

runS.Heartbeat:Connect(function()
    if counterDesyncActive then
        restoreAevyxCounter()
    end
end)


local fakePositionState = {
    Root = nil,
    CFrame = nil,
    Velocity = nil,
    RotVelocity = nil,
    AssemblyLinearVelocity = nil,
    AssemblyAngularVelocity = nil,
}

local fakePositionPreConn = nil
local fakePositionPostConn = nil

local function stopFakePosition()
    if fakePositionPreConn then
        fakePositionPreConn:Disconnect()
        fakePositionPreConn = nil
    end
    if fakePositionPostConn then
        fakePositionPostConn:Disconnect()
        fakePositionPostConn = nil
    end
    local state = fakePositionState
    if state.Root and state.Root.Parent and state.CFrame then
        state.Root.CFrame = state.CFrame
        state.Root.Velocity = state.Velocity or Vector3.zero
        state.Root.RotVelocity = state.RotVelocity or Vector3.zero
        state.Root.AssemblyLinearVelocity = state.AssemblyLinearVelocity or Vector3.zero
        state.Root.AssemblyAngularVelocity = state.AssemblyAngularVelocity or Vector3.zero
    end
    state.Root, state.CFrame, state.Velocity, state.RotVelocity = nil, nil, nil, nil
    state.AssemblyLinearVelocity, state.AssemblyAngularVelocity = nil, nil
end

local function startFakePosition()
    if fakePositionPreConn then return end

    fakePositionPreConn = runS.PreSimulation:Connect(function()
        if not AevyxCombatFeatures.FakePosition then
            stopFakePosition()
            return
        end
        local character = lplr.Character
        local myRoot = character and character:FindFirstChild("HumanoidRootPart")
        if not myRoot then
            stopFakePosition()
            return
        end

        
        fakePositionState.Root = myRoot
        fakePositionState.CFrame = myRoot.CFrame
        fakePositionState.Velocity = myRoot.Velocity
        fakePositionState.RotVelocity = myRoot.RotVelocity
        fakePositionState.AssemblyLinearVelocity = myRoot.AssemblyLinearVelocity
        fakePositionState.AssemblyAngularVelocity = myRoot.AssemblyAngularVelocity

        
        local fakePos = myRoot.CFrame.Position + Vector3.new(0, 10000, 0)
        myRoot.CFrame = CFrame.new(fakePos)
        myRoot.Velocity = Vector3.zero
        myRoot.RotVelocity = Vector3.zero
        myRoot.AssemblyLinearVelocity = Vector3.zero
        myRoot.AssemblyAngularVelocity = Vector3.zero
    end)

    fakePositionPostConn = runS.PostSimulation:Connect(function()
        if not AevyxCombatFeatures.FakePosition then return end
        local state = fakePositionState
        if state.Root and state.Root.Parent and state.CFrame then
            
            state.Root.CFrame = state.CFrame
            state.Root.Velocity = state.Velocity or Vector3.zero
            state.Root.RotVelocity = state.RotVelocity or Vector3.zero
            state.Root.AssemblyLinearVelocity = state.AssemblyLinearVelocity or Vector3.zero
            state.Root.AssemblyAngularVelocity = state.AssemblyAngularVelocity or Vector3.zero
        end
    end)
end






local Toggles = Library.Toggles
local Options = Library.Options

local SkeletonESPConfig = {
    Enabled = false,
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "SkeletonESP"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local esp = {}

local bonesR15 = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"},
	{"LeftUpperArm", "LeftLowerArm"},
	{"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"},
	{"RightUpperArm", "RightLowerArm"},
	{"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"},
	{"LeftUpperLeg", "LeftLowerLeg"},
	{"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"},
	{"RightUpperLeg", "RightLowerLeg"},
	{"RightLowerLeg", "RightFoot"}
}

local bonesR6 = {
	{"Head", "Torso"},
	{"Torso", "Left Arm"},
	{"Torso", "Right Arm"},
	{"Torso", "Left Leg"},
	{"Torso", "Right Leg"}
}

local function newLine()
	local line = Instance.new("Frame")
	line.Name = "Line"
	line.AnchorPoint = Vector2.new(0.5, 0.5)
	line.BorderSizePixel = 0
	line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	line.BackgroundTransparency = 0
	line.Size = UDim2.fromOffset(1, 1)
	line.Visible = false
	line.ZIndex = 2
	line.Parent = gui
	return line
end

local function getBones(char)
	if char:FindFirstChild("UpperTorso") then
		return bonesR15
	end

	if char:FindFirstChild("Torso") then
		return bonesR6
	end

	return nil
end

local function hideLine(line)
	line.Visible = false
end

local function addPlayer(plr)
	if plr == player or esp[plr] then
		return
	end

	local data = {
		character = plr.Character,
		lines = {}
	}

	for i = 1, 14 do
		data.lines[i] = newLine()
	end

	esp[plr] = data

	plr.CharacterAdded:Connect(function(char)
		data.character = char
	end)
end

local function removePlayer(plr)
	local data = esp[plr]

	if not data then
		return
	end

	for _, line in ipairs(data.lines) do
		line:Destroy()
	end

	esp[plr] = nil
end

for _, plr in ipairs(Players:GetPlayers()) do
	addPlayer(plr)
end

Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

RunService:BindToRenderStep(
	"SkeletonESP",
	Enum.RenderPriority.Camera.Value + 1,
	function()
		if not SkeletonESPConfig.Enabled then
			for _, data in pairs(esp) do
				for _, parts in ipairs(data.lines) do
					hideLine(parts)
				end
			end
			return
		end

		local camera = workspace.CurrentCamera

		if not camera then
			return
		end

		for _, data in pairs(esp) do
			local char = data.character
			local bones = char and getBones(char)

			if not char or not char.Parent or not bones then
				for _, parts in ipairs(data.lines) do
					hideLine(parts)
				end

				continue
			end

			for i, bone in ipairs(bones) do
				local a = char:FindFirstChild(bone[1])
				local b = char:FindFirstChild(bone[2])
				local parts = data.lines[i]

				if a and b then
					local p1, v1 = camera:WorldToViewportPoint(a.Position)
					local p2, v2 = camera:WorldToViewportPoint(b.Position)

					if v1 and v2 and p1.Z > 0 and p2.Z > 0 then
						local dx = p2.X - p1.X
						local dy = p2.Y - p1.Y
						local length = math.sqrt(dx * dx + dy * dy)

						local position = UDim2.fromOffset(
							(p1.X + p2.X) * 0.5,
							(p1.Y + p2.Y) * 0.5
						)

						local rotation = math.deg(math.atan2(dy, dx))

						
						parts.Position = position
						parts.Size = UDim2.fromOffset(length, 1)
						parts.Rotation = rotation
						parts.Visible = true
					else
						hideLine(parts)
					end
				else
					hideLine(parts)
				end
			end

			for i = #bones + 1, #data.lines do
				hideLine(data.lines[i])
			end
		end
	end
)

local PremiumESPConfig = {
    Enabled = false,
    Box = true,
    HealthBar = true,
    Distance = true,
    TeamCheck = false,
    MaxDistance = 1000,
    BoxColor = Color3.fromRGB(0, 220, 255),
    AccentColor = Color3.fromRGB(130, 255, 190),
    TextSize = 13,
}

local WeaponESPConfig = {
    Enabled = false,
}

local PremiumESP = {
    Entities = {},
}

local ESPGui = Instance.new("ScreenGui")
ESPGui.Name = "NoksPremiumESP"
ESPGui.ResetOnSpawn = false
ESPGui.IgnoreGuiInset = true
ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ESPGui.DisplayOrder = 998
ESPGui.Parent = (gethui and gethui()) or Services.CoreGui

local function newGui(className, properties)
    local object = Instance.new(className)
    for property, value in pairs(properties) do
        object[property] = value
    end
    return object
end

function PremiumESP:CreateEntity(player)
    if self.Entities[player] then return self.Entities[player] end

    local root = newGui("Frame", {
        Name = "ESP_" .. player.Name,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        Size = UDim2.fromOffset(0, 0),
        Parent = ESPGui,
    })

    local boxShadow = newGui("Frame", {
        Name = "BoxShadow",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 4, 1, 4),
        Position = UDim2.fromOffset(-2, -2),
        Parent = root,
    })
    newGui("UIStroke", {
        Color = Color3.fromRGB(4, 8, 14),
        Thickness = 1.5,
        Transparency = 0.35,
        Parent = boxShadow,
    })

    local box = newGui("Frame", {
        Name = "Box",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Parent = root,
    })
    local boxStroke = newGui("UIStroke", {
        Color = PremiumESPConfig.BoxColor,
        Thickness = 0.85,
        Transparency = 0,
        Parent = box,
    })

    local healthBack = newGui("Frame", {
        Name = "HealthBackground",
        BackgroundColor3 = Color3.fromRGB(4, 8, 14),
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 3, 1, 0),
        Position = UDim2.fromOffset(-6, 0),
        Parent = root,
    })
    newGui("UICorner", { CornerRadius = UDim.new(1, 0), Parent = healthBack })

    local healthFill = newGui("Frame", {
        Name = "HealthFill",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(125, 255, 120),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 0),
        Parent = healthBack,
    })
    newGui("UICorner", { CornerRadius = UDim.new(1, 0), Parent = healthFill })
    newGui("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 35, 35)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 221, 54)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 140)),
        }),
        Rotation = -90,
        Parent = healthFill,
    })

    local nameLabel = newGui("TextLabel", {
        Name = "NameDistance",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0, -5),
        Size = UDim2.new(1, 90, 0, 14),
        Font = Enum.Font.Code,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = root,
    })

    local healthLabel = newGui("TextLabel", {
        Name = "HealthText",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 1, 5),
        Size = UDim2.new(1, 0, 0, 0),
        Font = Enum.Font.GothamMedium,
        Text = "",
        TextColor3 = Color3.fromRGB(240, 247, 255),
        TextSize = 11,
        TextStrokeColor3 = Color3.fromRGB(2, 5, 9),
        TextStrokeTransparency = 0,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = root,
    })

    local entity = {
        Root = root,
        BoxShadow = boxShadow,
        Box = box,
        BoxStroke = boxStroke,
        HealthBack = healthBack,
        HealthFill = healthFill,
        NameLabel = nameLabel,
        HealthLabel = healthLabel,
    }
    self.Entities[player] = entity
    return entity
end

function PremiumESP:Hide(entity)
    if not entity then return end
    entity.Root.Visible = false
end

function PremiumESP:Destroy(player)
    local entity = self.Entities[player]
    if not entity then return end
    entity.Root:Destroy()
    self.Entities[player] = nil
end

function PremiumESP:IsTeammate(player)
    if not PremiumESPConfig.TeamCheck then return false end

    local localTeamID = LocalPlayer:GetAttribute("TeamID")
    local playerTeamID = player:GetAttribute("TeamID")
    return localTeamID ~= nil and playerTeamID ~= nil and localTeamID == playerTeamID
end

function PremiumESP:GetBounds(character, rootPart, camera)
    local rootScreen, rootOnScreen = camera:WorldToViewportPoint(rootPart.Position)
    if not rootOnScreen or rootScreen.Z <= 0 then return nil end

    local head = character:FindFirstChild("Head")
    local topPosition = head and (head.Position + Vector3.new(0, head.Size.Y * 0.5, 0))
        or (rootPart.Position + Vector3.new(0, 3, 0))
    local bottomPosition = rootPart.Position - Vector3.new(0, 3, 0)

    for _, legName in ipairs({"Left Leg", "Right Leg", "LeftLowerLeg", "RightLowerLeg"}) do
        local leg = character:FindFirstChild(legName)
        if leg and leg:IsA("BasePart") then
            local foot = leg.Position - Vector3.new(0, leg.Size.Y * 0.5, 0)
            if foot.Y < bottomPosition.Y then
                bottomPosition = foot
            end
        end
    end

    local topScreen = camera:WorldToViewportPoint(topPosition)
    local bottomScreen = camera:WorldToViewportPoint(bottomPosition)
    local viewport = camera.ViewportSize
    local height = math.abs(bottomScreen.Y - topScreen.Y)
    local maximumHeight = math.min(240, viewport.Y * 0.28)

    height = math.clamp(height * 1.014, 10, maximumHeight)
    local width = height * 0.48
    local x = rootScreen.X - width * 0.5
    local y = math.min(topScreen.Y, bottomScreen.Y) + height * 0.012
    return x, y, width, height
end

function PremiumESP:Update(player, camera)
    local entity = self.Entities[player] or self:CreateEntity(player)
    if not PremiumESPConfig.Enabled or player == LocalPlayer or self:IsTeammate(player) then
        self:Hide(entity)
        return
    end

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    if not character or not humanoid or humanoid.Health <= 0 or not rootPart then
        self:Hide(entity)
        return
    end

    local distance = (rootPart.Position - camera.CFrame.Position).Magnitude
    if distance > PremiumESPConfig.MaxDistance then
        self:Hide(entity)
        return
    end

    local x, y, width, height = self:GetBounds(character, rootPart, camera)
    if not x then
        self:Hide(entity)
        return
    end

    entity.Root.Position = UDim2.fromOffset(math.floor(x), math.floor(y))
    entity.Root.Size = UDim2.fromOffset(math.floor(width), math.floor(height))
    entity.Root.Visible = true

    entity.BoxShadow.Visible = PremiumESPConfig.Box
    entity.Box.Visible = PremiumESPConfig.Box
    entity.BoxStroke.Color = PremiumESPConfig.BoxColor

    local healthRatio = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
    entity.HealthBack.Visible = PremiumESPConfig.HealthBar
    entity.HealthFill.Visible = PremiumESPConfig.HealthBar
    entity.HealthFill.Size = UDim2.new(1, 0, healthRatio, 0)

    entity.NameLabel.Visible = PremiumESPConfig.Distance
    entity.NameLabel.Text = string.format("%s  -  %dm", player.DisplayName, math.floor(distance + 0.5))
    entity.NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    entity.NameLabel.TextSize = 11

    entity.HealthLabel.Visible = false
    entity.HealthLabel.Text = ""

end

function PremiumESP:Start()
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer then self:CreateEntity(player) end
    end

    Services.Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then self:CreateEntity(player) end
    end)

    Services.Players.PlayerRemoving:Connect(function(player)
        self:Destroy(player)
    end)

    Services.RunService.RenderStepped:Connect(function()
        local camera = workspace.CurrentCamera
        if not camera then return end
        for _, player in ipairs(Services.Players:GetPlayers()) do
            if player ~= LocalPlayer then
                self:Update(player, camera)
            end
        end
    end)
end

PremiumESP:Start()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local weaponEsp = {}

local function getWeapon(player)
    local viewModels = workspace:FindFirstChild("ViewModels") or workspace:FindFirstChild("ViewModel")
    if not viewModels then
        return "NONE"
    end

    local function search(container)
        for _, child in ipairs(container:GetChildren()) do
            local parts = {}

            for part in child.Name:gmatch("[^-]+") do
                parts[#parts + 1] = part:match("^%s*(.-)%s*$")
            end

            if #parts >= 2 and parts[1] == player.Name then
                return parts[2]
            end
        end

        return nil
    end

    local weapon = search(viewModels)

    if not weapon then
        local firstPerson = viewModels:FindFirstChild("FirstPerson")
        if firstPerson then
            weapon = search(firstPerson)
        end
    end

    return weapon or "NONE"
end

local function createWeaponESP(player, character)
    local root = character:WaitForChild("HumanoidRootPart", 5)
    if not root then
        return
    end

    if weaponEsp[player] then
        weaponEsp[player]:Destroy()
    end

    local gui = Instance.new("BillboardGui")
    gui.Name = "WeaponESP"
    gui.Adornee = root
    gui.StudsOffset = Vector3.new(0, -3.5, 0)
    gui.Size = UDim2.fromOffset(140, 18)
    gui.AlwaysOnTop = true
    gui.LightInfluence = 0
    gui.ResetOnSpawn = false
    gui.Parent = root

    local label = Instance.new("TextLabel")
    label.Name = "Weapon"
    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.Code
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = gui

    weaponEsp[player] = gui
end

local function setupWeaponESPPlayer(player)
    if player == LocalPlayer then
        return
    end

    local function onCharacter(character)
        createWeaponESP(player, character)
    end

    if player.Character then
        onCharacter(player.Character)
    end

    player.CharacterAdded:Connect(onCharacter)
end

for _, player in ipairs(Players:GetPlayers()) do
    setupWeaponESPPlayer(player)
end

Players.PlayerAdded:Connect(setupWeaponESPPlayer)

Players.PlayerRemoving:Connect(function(player)
    if weaponEsp[player] then
        weaponEsp[player]:Destroy()
        weaponEsp[player] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    for player, gui in pairs(weaponEsp) do
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local label = gui and gui:FindFirstChild("Weapon")

        if not WeaponESPConfig.Enabled then
            if gui then gui.Enabled = false end
            continue
        end

        if character and humanoid and humanoid.Health > 0 and label then
            label.Text = getWeapon(player):upper()
            gui.Enabled = true
        elseif gui then
            gui.Enabled = false
        end
    end
end)

local getgenv = getgenv or function() return {} end

getgenv().NameSpooferConfig = {
    name_spoof = false,
    your_spoofed_name = "Andy",
    spoofed_enemy_names = "Johnny",

    level_spoof = false,
    spoofed_level = 996,

    winstreak_spoof = false,
    spoofed_winstreak = 56,
}

local DeviceSpoofConfig = {
    Enabled = false,
    Device = "MouseKeyboard",
}

local function applyDeviceSpoof()
    if not DeviceSpoofConfig.Enabled then return end
    local repS = game:GetService("ReplicatedStorage")
    local device = DeviceSpoofConfig.Device
    pcall(function()
        repS.Remotes.Replication.Fighter.SetControls:FireServer(device)
    end)
    pcall(function()
        LocalPlayer:SetAttribute("DeviceType", device)
    end)
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Config = getgenv().NameSpooferConfig
local connections = {}
local titleIdentity = setmetatable({}, {__mode = "k"})

local function spoofPlayer(player)
    if not Config.name_spoof then return end
    if player == LocalPlayer then
        pcall(function()
            player.Name = Config.your_spoofed_name
            player.DisplayName = Config.your_spoofed_name
        end)
    else
        pcall(function()
            player.Name = Config.spoofed_enemy_names
            player.DisplayName = Config.spoofed_enemy_names
        end)
    end
end

local function spoofLeaderstats(player)
    if player ~= LocalPlayer then return end
    local leaderstats = player:FindFirstChild("CustomLeaderstats")
    if not leaderstats then return end
    if Config.level_spoof then
        local levelVal = leaderstats:FindFirstChild("Level")
        if levelVal and levelVal:IsA("IntValue") then
            levelVal.Value = Config.spoofed_level
        end
        pcall(function() player:SetAttribute("Level", Config.spoofed_level) end)
    end
    if Config.winstreak_spoof then
        local winStreakFolder = leaderstats:FindFirstChild("Win Streak")
        if winStreakFolder and winStreakFolder:IsA("Folder") then
            local streakVal = winStreakFolder:FindFirstChildWhichIsA("IntValue")
            if streakVal then
                streakVal.Value = Config.spoofed_winstreak
            end
        elseif winStreakFolder and winStreakFolder:IsA("IntValue") then
            winStreakFolder.Value = Config.spoofed_winstreak
        end
        pcall(function() player:SetAttribute("StatisticDuelsWinStreak", Config.spoofed_winstreak) end)
    end
end

local function findAllTitleLabels(instance, results)
    results = results or {}
    if not instance then return results end
    for _, child in ipairs(instance:GetChildren()) do
        if child:IsA("TextLabel") and child.Name == "Title" then
            table.insert(results, child)
        end
        findAllTitleLabels(child, results)
    end
    return results
end

local GUI_PATH = {
    "PlayerGui", "MainGui", "PlayerList", "Container",
    "Elements", "Container", "Middle", "List", "Container"
}

local function getListContainer()
    local node = LocalPlayer
    for _, name in ipairs(GUI_PATH) do
        if not node then return nil end
        node = node:FindFirstChild(name)
    end
    return node
end

local function spoofTitleLabelsInContainer(container)
    if not container then return end
    for _, playerFrame in ipairs(container:GetChildren()) do
        if playerFrame:IsA("Frame") then
            local labels = findAllTitleLabels(playerFrame)
            for _, titleLabel in ipairs(labels) do
                local isLocal = titleIdentity[titleLabel]
                if isLocal == nil then
                    isLocal = titleLabel.Text == LocalPlayer.Name
                        or titleLabel.Text == LocalPlayer.DisplayName
                        or titleLabel.Text == Config.your_spoofed_name
                    titleIdentity[titleLabel] = isLocal
                end
                titleLabel.Text = isLocal and Config.your_spoofed_name or Config.spoofed_enemy_names
            end
        end
    end
end

local function applyNameSpoofNow()
    if not Config.name_spoof then return end
    for _, player in ipairs(Players:GetPlayers()) do
        spoofPlayer(player)
    end
    local listContainer = getListContainer()
    if listContainer then
        pcall(spoofTitleLabelsInContainer, listContainer)
    end
end

local function watchContainerForNewFrames(container)
    if not container then return end
    local conn = container.ChildAdded:Connect(function(child)
        if child:IsA("Frame") then
            task.wait(0.1)
            pcall(spoofTitleLabelsInContainer, container)
        end
    end)
    table.insert(connections, conn)
end

local function startGuiSpoofLoop()
    task.spawn(function()
        local playerGui = LocalPlayer:WaitForChild("PlayerGui", 30)
        if not playerGui then return end

        local monitoredContainer = nil

        while task.wait(0.1) do
            if not Config.name_spoof then continue end

            local listContainer = getListContainer()

            if listContainer and listContainer ~= monitoredContainer then
                monitoredContainer = listContainer
                watchContainerForNewFrames(listContainer)
            end

            applyNameSpoofNow()
        end
    end)
end

local function watchLeaderstats(player)
    if player ~= LocalPlayer then return end
    local conn
    conn = player.ChildAdded:Connect(function(child)
        if child.Name == "CustomLeaderstats" then
            task.wait(0.1)
            spoofLeaderstats(player)
            if conn then conn:Disconnect() end
        end
    end)
    table.insert(connections, conn)
    spoofLeaderstats(player)
end

for _, player in ipairs(Players:GetPlayers()) do
    spoofPlayer(player)
    if player == LocalPlayer then
        watchLeaderstats(player)
    end
end

local playerAddedConn = Players.PlayerAdded:Connect(function(player)
    spoofPlayer(player)
end)
table.insert(connections, playerAddedConn)

task.spawn(function()
    while task.wait(3) do
        if Config.level_spoof or Config.winstreak_spoof then
            spoofLeaderstats(LocalPlayer)
        end
    end
end)

startGuiSpoofLoop()

local snowWeatherPart = nil
local snowWeatherParticle = nil
local snowWeatherConnection = nil

local function applySnowWeather()
    if not snowWeatherParticle then return end
    local cfg = LunaraSnowConfig
    snowWeatherParticle.Texture = "http://www.roblox.com/asset/?id=99851851"
    snowWeatherParticle.EmissionDirection = Enum.NormalId.Bottom
    snowWeatherParticle.LockedToPart = false
    snowWeatherParticle.Orientation = Enum.ParticleOrientation.FacingCamera
    snowWeatherParticle.Shape = Enum.ParticleEmitterShape.Box
    snowWeatherParticle.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    snowWeatherParticle.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
    snowWeatherParticle.Speed = NumberRange.new(cfg.SpeedMin, math.max(cfg.SpeedMin, cfg.SpeedMax))
    snowWeatherParticle.Acceleration = Vector3.new(0, -30, 0)
    snowWeatherParticle.Lifetime = NumberRange.new(4, 4)
    snowWeatherParticle.SpreadAngle = Vector2.new(cfg.Spread, cfg.Spread)
    snowWeatherParticle.Rate = 1000 * (cfg.Rate / 100)
    snowWeatherParticle.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, cfg.SizeMin * cfg.SizeScale),
        NumberSequenceKeypoint.new(1, cfg.SizeMax * cfg.SizeScale),
    })
    snowWeatherParticle.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, cfg.TransparencyMax),
        NumberSequenceKeypoint.new(0.25, cfg.TransparencyMin),
        NumberSequenceKeypoint.new(0.75, cfg.TransparencyMin),
        NumberSequenceKeypoint.new(1, cfg.TransparencyMax),
    })
    local glow = math.clamp(cfg.Glow, 0, 5)
    snowWeatherParticle.Brightness = cfg.Brightness * (1 + glow * 1.75)
    snowWeatherParticle.LightEmission = math.clamp(cfg.LightEmission + glow * 0.2, 0, 1)
    snowWeatherParticle.LightInfluence = math.clamp(1 - (glow / 5) * 0.98, 0, 1)
    snowWeatherParticle.Color = ColorSequence.new(cfg.Color)
end

local function stopWeather()
    if snowWeatherConnection then snowWeatherConnection:Disconnect(); snowWeatherConnection = nil end
    if snowWeatherPart then snowWeatherPart:Destroy(); snowWeatherPart = nil end
    snowWeatherParticle = nil
end

local function startWeather()
    stopWeather()
    if not GlobalSettings.ENABLE_WEATHER then return end
    snowWeatherPart = Instance.new("Part")
    snowWeatherPart.Name = "AevyxLunaraSnow"
    snowWeatherPart.Size = Vector3.new(180, 2, 180)
    snowWeatherPart.Anchored = true
    snowWeatherPart.CanCollide = false
    snowWeatherPart.CastShadow = false
    snowWeatherPart.Transparency = 1
    snowWeatherPart.Parent = workspace
    snowWeatherParticle = Instance.new("ParticleEmitter")
    snowWeatherParticle.Parent = snowWeatherPart
    applySnowWeather()
    snowWeatherConnection = Services.RunService.PostSimulation:Connect(function()
        if not snowWeatherPart or not GlobalSettings.ENABLE_WEATHER then return end
        snowWeatherPart.CFrame = Camera.CFrame * CFrame.new(0, 28, -24)
    end)
end

local function refreshWeather()
    if GlobalSettings.ENABLE_WEATHER then
        if not snowWeatherPart then startWeather() else applySnowWeather() end
    else
        stopWeather()
    end
end

local viewModelConnection = nil
local viewModelOriginals = {}
local viewModelOutlines = {}
local viewModelHighlights = {}
local viewModelPhase = 0
local crosshairGui = nil
local crosshairLines = {}

local function isArmViewModelPart(part, model)
    local function isArmName(name)
        local lower = string.lower(name)
        if lower:find("handguard", 1, true) or lower:find("handle", 1, true) or lower:find("foregrip", 1, true) or lower:find("armor", 1, true) or lower:find("charm", 1, true) then
            return false
        end
        return lower:find("forearm", 1, true) or lower:find("upperarm", 1, true) or lower:find("lowerarm", 1, true)
            or lower:find("glove", 1, true) or lower:find("sleeve", 1, true) or lower:find("finger", 1, true)
            or lower:find("wrist", 1, true) or lower:find("palm", 1, true) or lower:find("thumb", 1, true)
            or lower == "arm" or lower == "leftarm" or lower == "rightarm" or lower == "left arm" or lower == "right arm"
            or lower:find("hand", 1, true) or lower:find("arm", 1, true)
    end
    if isArmName(model.Name) then return true end
    local parent = part.Parent
    while parent and parent ~= model do
        if isArmName(parent.Name) then return true end
        parent = parent.Parent
    end
    return isArmName(part.Name)
end

local function cacheViewModelPart(part)
    if viewModelOriginals[part] then return end
    local original = {
        Material = part.Material,
        Color = part.Color,
        Transparency = part.Transparency,
        LocalTransparencyModifier = part.LocalTransparencyModifier,
        Decorations = {},
    }
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("Texture") or child:IsA("Decal") or child:IsA("SurfaceAppearance") then
            local ok, transparency = pcall(function() return child.Transparency end)
            if ok then original.Decorations[child] = transparency end
        end
    end
    viewModelOriginals[part] = original
end

local function restoreViewModelPart(part)
    local original = viewModelOriginals[part]
    if not original or not part or not part.Parent then return end
    part.Material = original.Material
    part.Color = original.Color
    part.Transparency = original.Transparency
    part.LocalTransparencyModifier = original.LocalTransparencyModifier
    for child, transparency in pairs(original.Decorations) do
        if child and child.Parent then pcall(function() child.Transparency = transparency end) end
    end
end

local function clearViewModelOutline(part)
    local outline = viewModelOutlines[part]
    if outline then outline:Destroy() end
    viewModelOutlines[part] = nil
end

local function clearViewModelHighlight(part)
    local highlight = viewModelHighlights[part]
    if highlight then highlight:Destroy() end
    viewModelHighlights[part] = nil
end

local function setViewModelOutline(part, color)
    local outline = viewModelOutlines[part]
    if not outline then
        outline = Instance.new("Highlight")
        outline.Name = "AevyxViewModelOutline"
        outline.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        outline.FillTransparency = 1
        outline.Parent = part
        viewModelOutlines[part] = outline
    end
    outline.Adornee = part
    outline.OutlineColor = color
    outline.OutlineTransparency = 0
end

local function setViewModelHighlight(part, fillColor, fillTransparency, outlineTransparency)
    local highlight = viewModelHighlights[part]
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "AevyxViewModelHighlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = part
        viewModelHighlights[part] = highlight
    end
    highlight.Adornee = part
    highlight.FillColor = fillColor
    highlight.OutlineColor = fillColor:Lerp(Color3.new(0, 0, 0), 0.35)
    highlight.FillTransparency = fillTransparency
    highlight.OutlineTransparency = outlineTransparency
end

local function cycleViewModelColors(colors, phase)
    local position = phase % 1
    if position < 1 / 3 then return colors[1]:Lerp(colors[2], position * 3) end
    if position < 2 / 3 then return colors[2]:Lerp(colors[3], (position - 1 / 3) * 3) end
    return colors[3]:Lerp(colors[1], (position - 2 / 3) * 3)
end

local function getViewModelFirstPerson()
    local root = workspace:FindFirstChild("ViewModels") or workspace:FindFirstChild("ViewModel")
    return root and root:FindFirstChild("FirstPerson")
end

local function viewModelEffectsActive()
    return ViewModelConfig.GunChams or ViewModelConfig.ArmChams or ViewModelConfig.GunOutline
        or ViewModelConfig.ArmOutline or ViewModelConfig.GunHighlight or ViewModelConfig.ArmHighlight
        or ViewModelConfig.DisableArms or ViewModelConfig.Viewport
end

local function restoreAllViewModelParts()
    for part in pairs(viewModelOriginals) do
        restoreViewModelPart(part)
    end
    for part in pairs(viewModelOutlines) do clearViewModelOutline(part) end
    for part in pairs(viewModelHighlights) do clearViewModelHighlight(part) end
    table.clear(viewModelOriginals)
end

local function updateViewModel(dt)
    if not viewModelEffectsActive() then
        restoreAllViewModelParts()
        return
    end
    viewModelPhase = (viewModelPhase + dt) % 1
    local firstPerson = getViewModelFirstPerson()
    if not firstPerson then return end
    local activeParts = {}
    for _, model in ipairs(firstPerson:GetChildren()) do
        if model:IsA("Model") then
            if ViewModelConfig.Viewport then
                model:PivotTo(Camera.CFrame * CFrame.new(ViewModelConfig.OffsetX, ViewModelConfig.OffsetY, ViewModelConfig.OffsetZ))
            end
            for _, part in ipairs(model:GetDescendants()) do
                if part:IsA("BasePart") and part.Transparency < 0.99 then
                    activeParts[part] = true
                    cacheViewModelPart(part)
                    local isArm = isArmViewModelPart(part, model)
                    local useChams = (isArm and ViewModelConfig.ArmChams) or (not isArm and ViewModelConfig.GunChams)
                    local useOutline = (isArm and ViewModelConfig.ArmOutline) or (not isArm and ViewModelConfig.GunOutline)
                    local useHighlight = (isArm and ViewModelConfig.ArmHighlight) or (not isArm and ViewModelConfig.GunHighlight)
                    if isArm and ViewModelConfig.DisableArms then
                        part.Transparency = 1
                        for _, child in ipairs(part:GetChildren()) do
                            if child:IsA("Texture") or child:IsA("Decal") or child:IsA("SurfaceAppearance") then
                                pcall(function() child.Transparency = 1 end)
                            end
                        end
                        clearViewModelOutline(part)
                        clearViewModelHighlight(part)
                    elseif useHighlight then
                        restoreViewModelPart(part)
                        part.Material = isArm and ViewModelConfig.ArmHighlightMaterial or ViewModelConfig.GunHighlightMaterial
                        local top = isArm and ViewModelConfig.ArmHighlightTop or ViewModelConfig.GunHighlightTop
                        local bottom = isArm and ViewModelConfig.ArmHighlightBottom or ViewModelConfig.GunHighlightBottom
                        local color = bottom:Lerp(top, (math.sin(viewModelPhase * math.pi * 2) + 1) * 0.5)
                        setViewModelHighlight(part, color,
                            isArm and ViewModelConfig.ArmHighlightFillTransparency or ViewModelConfig.GunHighlightFillTransparency,
                            isArm and ViewModelConfig.ArmHighlightOutlineTransparency or ViewModelConfig.GunHighlightOutlineTransparency)
                    elseif useChams then
                        local colors = isArm and ViewModelConfig.ArmColors or ViewModelConfig.GunColors
                        local color = cycleViewModelColors(colors, viewModelPhase * (isArm and ViewModelConfig.ArmSpeed or ViewModelConfig.GunSpeed))
                        part.Material = isArm and ViewModelConfig.ArmMaterial or ViewModelConfig.GunMaterial
                        part.Color = color
                        part.Transparency = isArm and ViewModelConfig.ArmTransparency or ViewModelConfig.GunTransparency
                        part.LocalTransparencyModifier = 0
                        clearViewModelHighlight(part)
                    else
                        restoreViewModelPart(part)
                        clearViewModelHighlight(part)
                    end
                    if useOutline and not useHighlight then
                        local colors = isArm and ViewModelConfig.ArmOutlineColors or ViewModelConfig.GunOutlineColors
                        setViewModelOutline(part, cycleViewModelColors(colors, viewModelPhase * (isArm and ViewModelConfig.ArmSpeed or ViewModelConfig.GunSpeed)))
                    else
                        clearViewModelOutline(part)
                    end
                end
            end
        end
    end
    for part in pairs(viewModelOriginals) do
        if not activeParts[part] then
            restoreViewModelPart(part)
            viewModelOriginals[part] = nil
        end
    end
end

local function startViewModelEffects()
    if viewModelConnection then return end
    viewModelConnection = Services.RunService.RenderStepped:Connect(updateViewModel)
end

local function stopViewModelEffects()
    if viewModelConnection then viewModelConnection:Disconnect(); viewModelConnection = nil end
    restoreAllViewModelParts()
end

local function refreshViewModelEffects()
    if viewModelEffectsActive() then startViewModelEffects() else stopViewModelEffects() end
end

local function createCrosshair()
    if crosshairGui then return end
    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "AevyxCrosshair"
    crosshairGui.IgnoreGuiInset = true
    crosshairGui.ResetOnSpawn = false
    crosshairGui.DisplayOrder = 999999
    crosshairGui.Parent = (gethui and gethui()) or Services.CoreGui
    for index = 1, 4 do
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.Parent = crosshairGui
        crosshairLines[index] = line
    end
end

local function updateCrosshair(dt)
    createCrosshair()
    local settings = MehfilConfig.Crosshair
    local center
    if (settings.Mode or "static") == "static" then
        center = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
    else
        CrosshairCenterConfig.FOVMode = settings.Mode
        CrosshairCenterConfig.FOVSmoothness = settings.Smoothness
        CrosshairCenterConfig.HitPart = "Head"
        center = IOInstance:GetCircleCenter(CrosshairCenterConfig, dt or 0.016)
    end
    local angle = settings.Spin and (os.clock() * settings.SpinSpeed * 90) % 360 or 0
    local radians = math.rad(angle)
    local cosine, sine = math.cos(radians), math.sin(radians)
    local function rotate(vector)
        return Vector2.new(vector.X * cosine - vector.Y * sine, vector.X * sine + vector.Y * cosine)
    end
    local points = {
        { rotate(Vector2.new(0, settings.Gap + settings.Size)), rotate(Vector2.new(0, settings.Gap)) },
        { rotate(Vector2.new(0, -settings.Gap - settings.Size)), rotate(Vector2.new(0, -settings.Gap)) },
        { rotate(Vector2.new(settings.Gap + settings.Size, 0)), rotate(Vector2.new(settings.Gap, 0)) },
        { rotate(Vector2.new(-settings.Gap - settings.Size, 0)), rotate(Vector2.new(-settings.Gap, 0)) },
    }
    for index, line in ipairs(crosshairLines) do
        local first, second = points[index][1], points[index][2]
        local delta = second - first
        line.Visible = GlobalSettings.ENABLE_CROSSHAIR
        line.BackgroundColor3 = settings.Color
        line.Size = UDim2.fromOffset(math.max(delta.Magnitude, 1), settings.Thickness)
        line.Position = UDim2.fromOffset(center.X + (first.X + second.X) * 0.5, center.Y + (first.Y + second.Y) * 0.5)
        line.Rotation = math.deg(math.atan2(delta.Y, delta.X))
    end
end

local function stopCrosshair()
    if crosshairConnection then crosshairConnection:Disconnect(); crosshairConnection = nil end
    if crosshairGui then crosshairGui:Destroy(); crosshairGui = nil end
    table.clear(crosshairLines)
end

local function startCrosshair()
    stopCrosshair()
    createCrosshair()
    crosshairConnection = Services.RunService.RenderStepped:Connect(updateCrosshair)
end

local function ensurePostEffect(name, className)
    local effect = Services.Lighting:FindFirstChild(name)
    if not effect then
        effect = Instance.new(className)
        effect.Name = name
        effect.Parent = Services.Lighting
    end
    return effect
end

local function cacheVisualOriginals()
    if visualOriginals then return end
    visualOriginals = {
        FogColor = Services.Lighting.FogColor,
        FogStart = Services.Lighting.FogStart,
        FogEnd = Services.Lighting.FogEnd,
        ClockTime = Services.Lighting.ClockTime,
        Brightness = Services.Lighting.Brightness,
        EnvironmentDiffuseScale = Services.Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Services.Lighting.EnvironmentSpecularScale,
    }
end

local function applyPostProcessing()
    cacheVisualOriginals()
    local settings = MehfilConfig.PostProcessing
    local blur = ensurePostEffect("AevyxMotionBlur", "BlurEffect")
    blur.Enabled = settings.MotionBlur
    blur.Size = settings.MotionBlurIntensity * 56
    local bloom = ensurePostEffect("AevyxBloom", "BloomEffect")
    bloom.Enabled = settings.Bloom
    bloom.Intensity = settings.BloomIntensity
    bloom.Size = settings.BloomSize
    bloom.Threshold = settings.BloomThreshold
    local rays = ensurePostEffect("AevyxSunRays", "SunRaysEffect")
    rays.Enabled = settings.SunRays
    rays.Intensity = settings.SunRaysIntensity
    rays.Spread = settings.SunRaysSpread
    local correction = ensurePostEffect("AevyxColorCorrection", "ColorCorrectionEffect")
    correction.Enabled = settings.ColorCorrection
    correction.Brightness = settings.Brightness
    correction.Contrast = settings.Contrast
    correction.Saturation = settings.Saturation
    correction.TintColor = settings.TintColor
    if settings.CustomFog then
        Services.Lighting.FogColor = settings.FogColor
        Services.Lighting.FogStart = settings.FogStart
        Services.Lighting.FogEnd = settings.FogEnd
    elseif visualOriginals then
        Services.Lighting.FogColor = visualOriginals.FogColor
        Services.Lighting.FogStart = visualOriginals.FogStart
        Services.Lighting.FogEnd = visualOriginals.FogEnd
    end
    if settings.CustomTime then
        Services.Lighting.ClockTime = settings.Hour
        Services.Lighting.Brightness = settings.TimeBrightness
    elseif visualOriginals then
        Services.Lighting.ClockTime = visualOriginals.ClockTime
        Services.Lighting.Brightness = visualOriginals.Brightness
    end
    Services.Lighting.EnvironmentDiffuseScale = 1 - settings.ShadowSoftness * 0.5
    Services.Lighting.EnvironmentSpecularScale = 1 - settings.ShadowSoftness * 0.3
    local atmosphere = Services.Lighting:FindFirstChild("AevyxAtmosphere")
    if settings.Atmosphere then
        if not atmosphere then
            atmosphere = Instance.new("Atmosphere")
            atmosphere.Name = "AevyxAtmosphere"
            atmosphere.Parent = Services.Lighting
        end
        atmosphere.Density = settings.AtmosphereDensity
        atmosphere.Haze = settings.AtmosphereHaze
        atmosphere.Glare = settings.AtmosphereGlare
        atmosphere.Offset = settings.AtmosphereOffset
        atmosphere.Color = settings.AtmosphereColor
        atmosphere.Decay = settings.AtmosphereDecay
    elseif atmosphere then
        atmosphere:Destroy()
    end
end

local function restorePostProcessing()
    for _, name in ipairs({ "AevyxMotionBlur", "AevyxBloom", "AevyxSunRays", "AevyxColorCorrection", "AevyxAtmosphere" }) do
        local effect = Services.Lighting:FindFirstChild(name)
        if effect then effect:Destroy() end
    end
    if visualOriginals then
        Services.Lighting.FogColor = visualOriginals.FogColor
        Services.Lighting.FogStart = visualOriginals.FogStart
        Services.Lighting.FogEnd = visualOriginals.FogEnd
        Services.Lighting.ClockTime = visualOriginals.ClockTime
        Services.Lighting.Brightness = visualOriginals.Brightness
        Services.Lighting.EnvironmentDiffuseScale = visualOriginals.EnvironmentDiffuseScale
        Services.Lighting.EnvironmentSpecularScale = visualOriginals.EnvironmentSpecularScale
    end
end

local originalWalkSpeed = 16
local speedwalkVelocityConnection = nil

local function saveOriginalSpeed()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            originalWalkSpeed = hum.WalkSpeed
        end
    end
end

local function applySpeedwalk()
    if GlobalSettings.ENABLE_SPEEDWALK then
        if speedwalkVelocityConnection then return end

        speedwalkVelocityConnection = Services.RunService.Heartbeat:Connect(function()
            if not GlobalSettings.ENABLE_SPEEDWALK then return end

            local char = LocalPlayer.Character
            if not char then return end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then return end

            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                hrp.AssemblyLinearVelocity = moveDir * GlobalSettings.SPEEDWALK_VALUE
            end
        end)
    else
        if speedwalkVelocityConnection then
            speedwalkVelocityConnection:Disconnect()
            speedwalkVelocityConnection = nil
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    saveOriginalSpeed()
    applySpeedwalk()
end)

task.spawn(function()
    task.wait(1)
    saveOriginalSpeed()
end)


Services.UserInputService.JumpRequest:Connect(function()
    if GlobalSettings.ENABLE_INFJUMP and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)


local function setupRapidFire()
    local ItemLibrary = require(Services.ReplicatedStorage.Modules.ItemLibrary)
    local function scan(tbl)
        for _, v in pairs(tbl) do
            if typeof(v) == "table" then
                if v.ShootCooldown ~= nil then v.ShootCooldown = 1e-15 end
                if v.BurstCooldown ~= nil then v.BurstCooldown = 1e-15 end
                if v.AttackCooldown ~= nil then v.AttackCooldown = 1e-15 end
                if v.HeavyAttackCooldown ~= nil then v.HeavyAttackCooldown = 1e-15 end
                scan(v)
            end
        end
    end
    scan(ItemLibrary)
end

local function applyRapidFire()
    if GlobalSettings.ENABLE_RAPID_FIRE then
        pcall(setupRapidFire)
    end
end


local highlights = {}
Services.RunService.RenderStepped:Connect(function()
    for _, player in pairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then
            if highlights[player] then
                highlights[player]:Destroy()
                highlights[player] = nil
            end
            continue
        end
        if not player.Character then
            if highlights[player] then
                highlights[player]:Destroy()
                highlights[player] = nil
            end
            continue
        end

        if GlobalSettings.ENABLE_XRAY then
            if not highlights[player] then
                local hl = Instance.new("Highlight")
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
                hl.Adornee = player.Character
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Parent = player.Character
                highlights[player] = hl
            else
                highlights[player].Adornee = player.Character
            end
        else
            if highlights[player] then
                highlights[player]:Destroy()
                highlights[player] = nil
            end
        end
    end
end)


getgenv().noclipState = getgenv().noclipState or {}

function stopNoclip()
    if getgenv().noclipState.conn then
        getgenv().noclipState.conn:Disconnect()
        getgenv().noclipState.conn = nil
    end
    if getgenv().noclipState.parts then
        for part in pairs(getgenv().noclipState.parts) do
            if part.Parent then part.CanCollide = true end
        end
        getgenv().noclipState.parts = nil
    end
end

function applyNoclip()
    if GlobalSettings.ENABLE_NOCLIP then
        if not getgenv().noclipState.conn then
            getgenv().noclipState.parts = {}
            getgenv().noclipState.conn = Services.RunService.Stepped:Connect(function()
                if not GlobalSettings.ENABLE_NOCLIP then return end
                local char = LocalPlayer.Character
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health <= 0 then return end
                local parts = getgenv().noclipState.parts
                for _, desc in ipairs(char:GetDescendants()) do
                    if desc:IsA("BasePart") and desc.CanCollide then
                        parts[desc] = true
                        desc.CanCollide = false
                    end
                end
            end)
        end
    else
        stopNoclip()
    end
end


local function startNoAnimation()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer

    
    local FREEZE_IDLE       = true   
    local KILL_SWAY         = true   
    local KILL_RAYCAST_TILT = true   
    local KILL_BOB          = true   
    local KILL_JUMP         = true   
    local KILL_LANDING      = true   
    local KILL_TILT         = true   
    local KILL_SPRINT_LEAN  = true   
    local KILL_SLIDE_LEAN   = true   
    local KILL_CROUCH       = true   
    local KILL_RECOIL       = true   
    local KILL_EQUIP        = true   
    local KILL_IMPULSE      = true   
    local KILL_MOVEMENT_ANIMS = true 
    local IDLE_FRAME_3 = 0.05
    

    local ZERO_V2 = Vector2.new(0, 0)
    local ZERO_V3 = Vector3.new(0, 0, 0)

    local function zeroSpring(vm, name)
        local s = vm and vm[name]
        if not s then return end
        local t = s._target
        if type(t) == "number" then
            s._target = 0
            s._position0 = 0
            s._velocity0 = 0
        elseif typeof(t) == "Vector2" then
            s._target = ZERO_V2
            s._position0 = ZERO_V2
            s._velocity0 = ZERO_V2
        elseif typeof(t) == "Vector3" then
            s._target = ZERO_V3
            s._position0 = ZERO_V3
            s._velocity0 = ZERO_V3
        end
    end

    local function applySpringKills(vm)
        if not vm then return end
        if KILL_SWAY then zeroSpring(vm, "_sway_spring") end
        if KILL_RAYCAST_TILT then zeroSpring(vm, "_raycast_tilt_spring") end
        if KILL_BOB then zeroSpring(vm, "_bobbing_value_spring") end
        if KILL_JUMP then zeroSpring(vm, "_jump_spring") end
        if KILL_LANDING then zeroSpring(vm, "_landing_spring") end
        if KILL_TILT then zeroSpring(vm, "_tilt_spring") end
        if KILL_SPRINT_LEAN then zeroSpring(vm, "_sprinting_spring") end
        if KILL_SLIDE_LEAN then zeroSpring(vm, "_sliding_spring") end
        if KILL_CROUCH then zeroSpring(vm, "_crouching_spring") end
        if KILL_RECOIL then
            zeroSpring(vm, "_recoil_spring")
            zeroSpring(vm, "_unrecoil_spring")
        end
        if KILL_EQUIP then zeroSpring(vm, "_equip_spring") end
        if KILL_IMPULSE then zeroSpring(vm, "_impulse_position_spring") end
    end

    local function getVmModule()
        local item = plr and plr.PlayerScripts and plr.PlayerScripts.Modules
            and plr.PlayerScripts.Modules.ClientReplicatedClasses
            and plr.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter
            and plr.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem
        local mod = item and item:FindFirstChild("ClientViewModel")
        return mod
    end

    local modPath = getVmModule()
    local vmMod = modPath and require(modPath)

    if vmMod then
        local origUpdate = vmMod.Update
        vmMod.Update = function(self, ...)
            applySpringKills(self)
            return origUpdate(self, ...)
        end
    end

    local ViewModels = game.Workspace:FindFirstChild("ViewModels") or workspace:FindFirstChild("ViewModel")
    local animators = {}
    local connections = {}

    local function isLive(a)
        return pcall(function() return a.Parent ~= nil end)
    end

    local function idleFrame3(animator)
        if not FREEZE_IDLE then return end
        local best
        for _, t in ipairs(animator:GetPlayingAnimationTracks()) do
            local p = t.Priority
            if p == Enum.AnimationPriority.Idle or p == Enum.AnimationPriority.Action4 then
                best = t
            end
        end
        if best and best.Length > 0 then
            best.TimePosition = math.min(IDLE_FRAME_3, best.Length)
            best:AdjustSpeed(0)
            pcall(function() best.Priority = Enum.AnimationPriority.Action4 end)
        end
    end

    local function killTrack(track)
        if not KILL_MOVEMENT_ANIMS then return end
        local p = track.Priority
        if p == Enum.AnimationPriority.Idle or p == Enum.AnimationPriority.Action4 then return end
        if p == Enum.AnimationPriority.Movement then
            track:Stop(0)
        else
            if track.Length > 0 then
                track.TimePosition = math.max(track.Length - 0.001, 0)
                track:AdjustSpeed(0)
            end
        end
    end

    local function addAnimator(a)
        if not isLive(a) then return end
        for _, ex in ipairs(animators) do if ex == a then return end end
        table.insert(animators, a)
        local c = a.AnimationPlayed:Connect(function(track)
            task.defer(function()
                idleFrame3(a)
                killTrack(track)
            end)
        end)
        table.insert(connections, c)
    end

    local function scanAnimators()
        if not ViewModels then return end
        local fp = ViewModels:FindFirstChild("FirstPerson")
        if not fp then return end
        for _, obj in ipairs(fp:GetDescendants()) do
            if obj:IsA("Animator") then addAnimator(obj) end
        end
    end

    scanAnimators()

    ViewModels.DescendantAdded:Connect(function(obj)
        if obj:IsA("Animator") then addAnimator(obj) end
    end)

    RunService.Heartbeat:Connect(function()
        for i = #animators, 1, -1 do
            local a = animators[i]
            if not isLive(a) then
                table.remove(animators, i)
            else
                idleFrame3(a)
                for _, t in ipairs(a:GetPlayingAnimationTracks()) do
                    killTrack(t)
                end
            end
        end
    end)
end
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.2)
    applyNoclip()
end)


local slideBoostMech = nil
task.spawn(function()
    slideBoostMech = require(game:GetService("Players").LocalPlayer.PlayerScripts.Controllers.MechanicsController)
end)

Services.RunService.RenderStepped:Connect(function()
    if not GlobalSettings.ENABLE_SLIDE_BOOST then return end
    if slideBoostMech and slideBoostMech.IsSliding then
        slideBoostMech._sliding_velocity.Velocity = slideBoostMech._sliding_velocity.Velocity.Unit * GlobalSettings.SLIDE_BOOST_SPEED
    end
end)


local flyCharacter, flyHumanoid, flyRoot, flyAttachment, flyLV, flyAO
local flyControls

local function setupFlyPhysics()
    task.defer(function()
        flyCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        flyHumanoid = flyCharacter:WaitForChild("Humanoid")
        flyRoot = flyCharacter:WaitForChild("HumanoidRootPart")

        if GlobalSettings.ENABLE_FLY and flyRoot then
            if flyAttachment then flyAttachment:Destroy() end
            flyHumanoid.PlatformStand = true
            flyAttachment = Instance.new("Attachment", flyRoot)

            flyLV = Instance.new("LinearVelocity", flyAttachment)
            flyLV.MaxForce = 9e9
            flyLV.VectorVelocity = Vector3.zero
            flyLV.Attachment0 = flyAttachment

            flyAO = Instance.new("AlignOrientation", flyAttachment)
            flyAO.MaxTorque = 9e9
            flyAO.Responsiveness = 200
            flyAO.RigidityEnabled = false
            flyAO.Mode = Enum.OrientationAlignmentMode.OneAttachment
            flyAO.Attachment0 = flyAttachment
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    if GlobalSettings.ENABLE_FLY then
        task.wait(0.5)
        setupFlyPhysics()
    end
end)

task.spawn(function()
    local success, pm = pcall(function()
        return require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
    end)
    if success and pm then
        flyControls = pm:GetControls()
    end
end)

Services.RunService.RenderStepped:Connect(function(deltaTime)
    if not GlobalSettings.ENABLE_FLY then return end
    if flyRoot and workspace.CurrentCamera and flyLV and flyAO then
        local cam = workspace.CurrentCamera
        local moveVector = flyControls and flyControls:GetMoveVector() or Vector3.zero
        local targetDirection = Vector3.zero

        if moveVector.Magnitude > 0 then
            targetDirection = (cam.CFrame.LookVector * -moveVector.Z) + (cam.CFrame.RightVector * moveVector.X)
        end

        if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            targetDirection = targetDirection + Vector3.new(0, 1, 0)
        elseif Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            targetDirection = targetDirection + Vector3.new(0, -1, 0)
        end

        if targetDirection.Magnitude > 0 then
            flyLV.VectorVelocity = targetDirection.Unit * GlobalSettings.FLY_SPEED
        else
            flyLV.VectorVelocity = Vector3.zero
        end

        local alpha = 1 - math.exp(-20 * deltaTime)
        flyAO.CFrame = flyAO.CFrame:Lerp(cam.CFrame, alpha)
    end
end)


runS.Heartbeat:Connect(function()
    if not GlobalSettings.ENABLE_THIRD_PERSON then return end
    if CameraController and CameraController.CameraState then
        pcall(function()
            if CameraController.CameraState:GetPublicState() ~= CameraController.CameraState.States.ThirdPerson then
                CameraController.CameraState:TogglePOV()
            end
        end)
    end
end)

local SilentAimPlayers = Services.Players
local SilentAimUtility = require(Services.ReplicatedStorage.Modules.Utility)
local SilentAimGun = require(LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun)

local function silentAimWallCheck(targetPart)
    if not SilentAimConfig.VisibleCheck then return true end
    if not targetPart or not targetPart.Parent then return false end
    local character = targetPart.Parent
    local cam = workspace.CurrentCamera
    local vm = workspace:FindFirstChild("ViewModels")
    if not cam then return true end
    local origin = cam.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local blacklist = {LocalPlayer.Character, cam}
    if vm then table.insert(blacklist, vm) end
    params.FilterDescendantsInstances = blacklist
    params.IgnoreWater = true
    local toTarget = targetPart.Position - origin
    if toTarget.Magnitude <= 0 then return true end
    local result = workspace:Raycast(origin, toTarget.Unit * toTarget.Magnitude, params)
    if result == nil then return true end
    -- FIX 100% WALL ONLY: que sur mur/obstacle
    if result.Instance:IsDescendantOf(character) then return true end
    for _, plr in ipairs(Services.Players:GetPlayers()) do
        if plr.Character and result.Instance:IsDescendantOf(plr.Character) then
            return true
        end
    end
    return false
end

local function getTargetPart(char)
    return char:FindFirstChild("Head")
        or char:FindFirstChild("HitboxHead")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("HumanoidRootPart")
end

local function findTarget()
    local best, bestDist = nil, math.huge
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    
    local fovRadius = (SilentAimConfig.FOV or 200) / 2
    local screenPos
    if AimbotInstance and AimbotInstance.GetAimbotScreenPoint then
        screenPos = AimbotInstance:GetAimbotScreenPoint()
    end
    if not screenPos then
        local loc = Services.UserInputService:GetMouseLocation()
        screenPos = Vector2.new(loc.X, loc.Y)
    end
    for _, plr in ipairs(SilentAimPlayers:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if plr:GetAttribute("TeamID") ~= LocalPlayer:GetAttribute("TeamID") then
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local part = getTargetPart(plr.Character)
                    if part then
                        local pos, onScreen = cam:WorldToViewportPoint(part.Position)
                        if not onScreen then continue end
                        local dx = pos.X - screenPos.X
                        local dy = pos.Y - screenPos.Y
                        local screenDist = math.sqrt(dx * dx + dy * dy)
                        if screenDist > fovRadius then continue end
                        
                        if not silentAimWallCheck(part) then continue end
                        if screenDist < bestDist then
                            bestDist = screenDist
                            best = part
                        end
                    end
                end
            end
        end
    end
    return best
end

local oldStartShooting = SilentAimGun.StartShooting

SilentAimGun.StartShooting = function(self, ...)
    local results = { oldStartShooting(self, ...) }

    if not SilentAimConfig.Enabled then
        return table.unpack(results)
    end

    if not self.ClientFighter or not self.ClientFighter.IsLocalPlayer then
        return table.unpack(results)
    end

    local cameradata = results[3]
    if not cameradata or typeof(cameradata) ~= "table" then
        return table.unpack(results)
    end

    local targetPart = findTarget()
    SilentAimConfig.CurrentTarget = targetPart
    if not targetPart then
        return table.unpack(results)
    end

    
    local chance = math.clamp(tonumber(SilentAimConfig.Chance) or 100, 0, 100)
    if chance < 100 and math.random(1, 100) > chance then
        return table.unpack(results)
    end

    local cam = workspace.CurrentCamera
    local targetPos = targetPart.Position
    -- FIX 100% AFK: prediction meme si ennemi immobile, utilise HRP velocity
    if SilentAimConfig.Prediction then
        local char = targetPart.Parent
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local vel = hrp and hrp.AssemblyLinearVelocity or targetPart.AssemblyLinearVelocity
        if vel then
            targetPos = targetPos + vel * (SilentAimConfig.PredictionAmount or 0.1)
        end
    end
    local originPos = cam and cam.CFrame.Position or targetPos

    cameradata[utf8.char(0)] = SilentAimUtility:EncodeCFrame(CFrame.new(originPos, targetPos))
    cameradata[utf8.char(1)] = SilentAimUtility:EncodeCFrame(CFrame.new(targetPos))
    cameradata[utf8.char(2)] = targetPart
    cameradata[utf8.char(3)] = SilentAimUtility:EncodeCFrame(targetPart.CFrame:ToObjectSpace(CFrame.new(targetPos)))

    return table.unpack(results)
end




do
local repS = cloneref(game:GetService("ReplicatedStorage"))
local plrs = cloneref(game:GetService("Players"))
local runS = cloneref(game:GetService("RunService"))
local ws = cloneref(game:GetService("Workspace"))
local lplr = plrs.LocalPlayer
local util = require(repS.Modules.Utility)
local enum = require(repS.Modules.EnumLibrary)
local FighterController = require(lplr.PlayerScripts.Controllers.FighterController)

local lastAutoShoot = 0
runS.Heartbeat:Connect(function()
    if not SilentAimConfig.AutoShoot then return end
    if not SilentAimConfig.Enabled then return end
    -- Rate limit pour que AimChance soit visible
    if tick() - lastAutoShoot < 0.09 then return end
    local targetPart = findTarget()
    if not targetPart then return end
    
    -- FIX 100% AimChance pour AutoShoot
    local chance = math.clamp(tonumber(SilentAimConfig.Chance) or 100, 0, 100)
    if chance < 100 then
        if math.random(1, 100) > chance then
            lastAutoShoot = tick() + 0.12 + math.random() * 0.15
            return
        end
    end
    local char = lplr.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local cam = ws.CurrentCamera
    if not cam then return end

    if not FighterController or not FighterController.LocalFighter then return end
    local item = FighterController.LocalFighter.EquippedItem
    if not item then return end

    
    local targetPos = targetPart.Position
    -- FIX 100% AFK: marche meme si ennemi ne bouge pas
    if SilentAimConfig.Prediction then
        local char = targetPart.Parent
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local vel = hrp and hrp.AssemblyLinearVelocity or targetPart.AssemblyLinearVelocity
        if vel then
            targetPos = targetPos + vel * (SilentAimConfig.PredictionAmount or 0.1)
        end
    end

    local originPos = head.Position
    local aimCF = CFrame.lookAt(originPos, targetPos)
    local targetCF = CFrame.new(targetPos)

    local cameradata = {}
    cameradata[utf8.char(1)] = {
        [utf8.char(0)] = util:EncodeCFrame(aimCF),
        [utf8.char(1)] = util:EncodeCFrame(targetCF),
        [utf8.char(2)] = targetPart,
        [utf8.char(3)] = util:EncodeCFrame(targetPart.CFrame:ToObjectSpace(CFrame.new(targetPos)))
    }

    repS.Remotes.Replication.Fighter.UseItem:FireServer(
        item:Get("ObjectID"),
        enum:ToEnum("StartShooting"),
        cameradata,
        nil
    )
    lastAutoShoot = tick()
end)
end

local _plrs = Services.Players
local _rs = Services.ReplicatedStorage
local _http = Services.HttpService
local _lp = _plrs.LocalPlayer
local _pscripts = _lp.PlayerScripts
local _ctrl = _pscripts.Controllers
local _mods = _rs:WaitForChild("Modules", 10)

local _enumLib = require(_mods:WaitForChild("EnumLibrary", 10))
if _enumLib then pcall(function() _enumLib:WaitForEnumBuilder() end) end

local _cosLib = require(_mods:WaitForChild("CosmeticLibrary", 10))
local _datCtrl = require(_ctrl:WaitForChild("PlayerDataController", 10))

local _eq, _favs = {}, {}
local _buildingWep = nil
local _cfgFile = "rivals_unlocker_config.json"
local _saveLock = false
local _cosmeticsEnabled = false

local function _mkCosmetic(nm, ctype, opts)
    local _base = _cosLib.Cosmetics[nm]
    if not _base then return nil end
    local _d = {}
    for k, v in pairs(_base) do _d[k] = v end
    _d.Name = nm
    _d.Type = _d.Type or ctype
    _d.Seed = _d.Seed or math.random(1, 1000000)
    if _enumLib then
        local _s, _eid = pcall(_enumLib.ToEnum, _enumLib, nm)
        if _s and _eid then
            _d.Enum = _eid
            _d.ObjectID = _d.ObjectID or _eid
        end
    end
    if opts then
        if opts.inverted ~= nil then _d.Inverted = opts.inverted end
        if opts.favoritesOnly ~= nil then _d.OnlyUseFavorites = opts.favoritesOnly end
    end
    return _d
end

local function _stripForSave()
    local _out = {}
    for wn, cos in pairs(_eq) do
        _out[wn] = {}
        for ct, cd in pairs(cos) do
            if cd and cd.Name then
                _out[wn][ct] = {
                    Name = cd.Name,
                    Inverted = cd.Inverted,
                    OnlyUseFavorites = cd.OnlyUseFavorites
                }
            end
        end
    end
    return { equipped = _out, favorites = _favs }
end

local function _loadCfg()
    if not isfile or not readfile then return end
    local _ok1, _ex = pcall(isfile, _cfgFile)
    if not _ok1 or not _ex then return end
    local _ok2, _raw = pcall(readfile, _cfgFile)
    if not _ok2 or not _raw or _raw == "" then return end
    local _ok3, _dec = pcall(_http.JSONDecode, _http, _raw)
    if not _ok3 or not _dec then return end
    if _dec.favorites then _favs = _dec.favorites end
    if _dec.equipped then
        _eq = {}
        for wn, cos in pairs(_dec.equipped) do
            _eq[wn] = {}
            for ct, sd in pairs(cos) do
                if sd and sd.Name and _cosLib.Cosmetics[sd.Name] then
                    local _cloned = _mkCosmetic(sd.Name, ct, {
                        inverted = sd.Inverted,
                        favoritesOnly = sd.OnlyUseFavorites
                    })
                    if _cloned then _eq[wn][ct] = _cloned end
                end
            end
            if not next(_eq[wn]) then _eq[wn] = nil end
        end
    end
end

local function _saveCfg()
    if not writefile or _saveLock then return end
    _saveLock = true
    task.spawn(function()
        task.wait(1)
        local _payload = _stripForSave()
        local _ok, _enc = pcall(_http.JSONEncode, _http, _payload)
        if _ok then pcall(writefile, _cfgFile, _enc) end
        _saveLock = false
    end)
end

_loadCfg()

local _cosTypes = {"Skin", "Wrap", "Charm", "Dance", "Emote"}
local function _isCosType(cosObj)
    if not cosObj then return false end
    for _, t in ipairs(_cosTypes) do
        if cosObj.Type == t then return true end
    end
    return false
end

local function toggleCosmetics(enabled)
    _cosmeticsEnabled = enabled
    GlobalSettings.UNLOCK_COSMETICS = enabled

    if enabled then
        local _origOwns = _cosLib.OwnsCosmetic
        _cosLib.OwnsCosmetic = function(self, inv, nm, wep)
            if nm:find("MISSING_") or nm == "Bubble Gun" then
                return _origOwns(self, inv, nm, wep)
            end
            local c = _cosLib.Cosmetics[nm]
            if c and _isCosType(c) then return true end
            return _origOwns(self, inv, nm, wep)
        end

        local _origGet = _datCtrl.Get
        _datCtrl.Get = function(self, key)
            local _val = _origGet(self, key)
            if key == "CosmeticInventory" then
                local _prx = {}
                if _val then
                    for k, v in pairs(_val) do
                        local c = _cosLib.Cosmetics[k]
                        if c and _isCosType(c) then _prx[k] = v end
                    end
                end
                return setmetatable(_prx, {
                    __index = function(t, k)
                        local c = _cosLib.Cosmetics[k]
                        if c and _isCosType(c) then return true end
                        return nil
                    end
                })
            end
            if key == "FavoritedCosmetics" then
                local _res = _val and table.clone(_val) or {}
                for wep, fv in pairs(_favs) do
                    _res[wep] = _res[wep] or {}
                    for nm, isFav in pairs(fv) do
                        local c = _cosLib.Cosmetics[nm]
                        if c and _isCosType(c) then _res[wep][nm] = isFav end
                    end
                end
                return _res
            end
            return _val
        end

        local _origGetWep = _datCtrl.GetWeaponData
        _datCtrl.GetWeaponData = function(self, wn)
            local _d = _origGetWep(self, wn)
            if not _d then return nil end
            local _m = {}
            for k, v in pairs(_d) do _m[k] = v end
            _m.Name = wn
            if _eq[wn] then
                for ct, cd in pairs(_eq[wn]) do _m[ct] = cd end
            end
            return _m
        end

        if hookmetamethod then
            local _remotes = _rs:FindFirstChild("Remotes")
            local _dataRem = _remotes and _remotes:FindFirstChild("Data")
            local _equipRem = _dataRem and _dataRem:FindFirstChild("EquipCosmetic")
            local _favRem = _dataRem and _dataRem:FindFirstChild("FavoriteCosmetic")

            if _equipRem then
                local _onc
                _onc = hookmetamethod(game, "__namecall", function(self, ...)
                    if getnamecallmethod() ~= "FireServer" then
                        return _onc(self, ...)
                    end
                    local _a = {...}

                    if self == _equipRem then
                        local _wn = _a[1]
                        local _ct = _a[2]
                        local _cn = _a[3]
                        local _opts = _a[4] or {}
                        _eq[_wn] = _eq[_wn] or {}
                        if not _cn or _cn == "None" or _cn == "" then
                            _eq[_wn][_ct] = nil
                            if not next(_eq[_wn]) then _eq[_wn] = nil end
                        else
                            local _cloned = _mkCosmetic(_cn, _ct, {
                                inverted = _opts.IsInverted,
                                favoritesOnly = _opts.OnlyUseFavorites
                            })
                            if _cloned then _eq[_wn][_ct] = _cloned end
                        end
                        task.defer(function()
                            pcall(function() _datCtrl.CurrentData:Replicate("WeaponInventory") end)
                        end)
                        _saveCfg()
                        return
                    end

                    if self == _favRem then
                        local _cos = _cosLib.Cosmetics[_a[2]]
                        if _cos then
                            _favs[_a[1]] = _favs[_a[1]] or {}
                            _favs[_a[1]][_a[2]] = _a[3] or nil
                            task.spawn(function()
                                pcall(function() _datCtrl.CurrentData:Replicate("FavoritedCosmetics") end)
                            end)
                            _saveCfg()
                        end
                        return
                    end

                    return _onc(self, ...)
                end)
            end
        end

        local _cliItem
        pcall(function()
            _cliItem = require(_lp.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
        end)

        if _cliItem and _cliItem._CreateViewModel then
            local _origCVM = _cliItem._CreateViewModel
            _cliItem._CreateViewModel = function(self, vmRef)
                local _wn = self.Name
                local _wp = self.ClientFighter and self.ClientFighter.Player
                _buildingWep = (_wp == _lp) and _wn or nil
                if _wp == _lp and _eq[_wn] then
                    local _dk = self:ToEnum("Data")
                    if vmRef[_dk] then
                        if _eq[_wn].Skin then
                            vmRef[_dk][self:ToEnum("Skin")] = _eq[_wn].Skin
                            vmRef[_dk][self:ToEnum("Name")] = _eq[_wn].Skin.Name
                        end
                        if _eq[_wn].Charm then vmRef[_dk][self:ToEnum("Charm")] = _eq[_wn].Charm end
                        if _eq[_wn].Wrap then vmRef[_dk][self:ToEnum("Wrap")] = _eq[_wn].Wrap end
                    elseif vmRef.Data then
                        if _eq[_wn].Skin then vmRef.Data.Skin = _eq[_wn].Skin; vmRef.Data.Name = _eq[_wn].Skin.Name end
                        if _eq[_wn].Charm then vmRef.Data.Charm = _eq[_wn].Charm end
                        if _eq[_wn].Wrap then vmRef.Data.Wrap = _eq[_wn].Wrap end
                    end
                end
                local _r = _origCVM(self, vmRef)
                _buildingWep = nil
                return _r
            end
        end

        local _vmMod = _lp.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem:FindFirstChild("ClientViewModel")
        if _vmMod then
            local _CVM = require(_vmMod)
            local _origNew = _CVM.new
            _CVM.new = function(repData, cliItm)
                local _wp = cliItm.ClientFighter and cliItm.ClientFighter.Player
                local _wn = _buildingWep or cliItm.Name
                if _wp == _lp and _eq[_wn] then
                    local _RC = require(_rs.Modules.ReplicatedClass)
                    local _dk = _RC:ToEnum("Data")
                    repData[_dk] = repData[_dk] or {}
                    local _cos = _eq[_wn]
                    if _cos.Skin then repData[_dk][_RC:ToEnum("Skin")] = _cos.Skin end
                    if _cos.Charm then repData[_dk][_RC:ToEnum("Charm")] = _cos.Charm end
                    if _cos.Wrap then repData[_dk][_RC:ToEnum("Wrap")] = _cos.Wrap end
                end
                return _origNew(repData, cliItm)
            end
        end

        Library:Notify({
            Title = "Cosmetics",
            Description = "Unlock Cosmetics enabled!",
            Time = 2,
        })
    else
        Library:Notify({
            Title = "Cosmetics",
            Description = "Unlock Cosmetics disabled",
            Time = 2,
        })
    end
end

local HitFeedback = {}
;(function()
    local SoundService = game:GetService("SoundService")
    local Debris = game:GetService("Debris")
    local HttpService = game:GetService("HttpService")

    HitFeedback.BuiltInSounds = {
        { name = "Bell (Skeet)", soundId = "rbxassetid://83717596220569" },
        { name = "Bell (Skeet Loud)", soundId = "rbxassetid://140247876667835" },
        { name = "Neverlose", soundId = "rbxassetid://139452805868562" },
        { name = "Hitmarker (CoD)", soundId = "rbxassetid://160432334" },
        { name = "Hitmarker (MLG)", soundId = "rbxassetid://121351852050830" },
        { name = "Headshot (CS2)", soundId = "rbxassetid://133002449941130" },
        { name = "Headshot (Rust)", soundId = "rbxassetid://128633263668964" },
        { name = "Headshot Announcer", soundId = "rbxassetid://127613993360820" },
        { name = "TF2", soundId = "rbxassetid://3455144981" },
        { name = "TF2 Crit", soundId = "rbxassetid://8255306220" },
        { name = "Minecraft", soundId = "rbxassetid://101908484385575" },
        { name = "Minecraft XP", soundId = "rbxassetid://6647877129" },
        { name = "osu!", soundId = "rbxassetid://7149964817" },
        { name = "Bell Ding", soundId = "rbxassetid://124010691633262" },
        { name = "Bubble Pop", soundId = "rbxassetid://119697580657161" },
        { name = "Typewriter", soundId = "rbxassetid://9120300236" },
        { name = "Laser", soundId = "rbxassetid://8561505457" },
        { name = "Punch", soundId = "rbxassetid://138087186" },
        { name = "Roblox Oof", soundId = "rbxassetid://5943191430" },
        { name = "Bonk", soundId = "rbxassetid://132937320140224" },
        { name = "Among Us", soundId = "rbxassetid://7227567562" },
        { name = "Ka-Ching", soundId = "rbxassetid://7112275565" },
        { name = "Fatality", soundId = "rbxassetid://158012252" },
        { name = "Emotional Damage", soundId = "rbxassetid://8909407664" },
    }
    HitFeedback.MaterialMap = {
        Ghost = Enum.Material.ForceField,
        Flat = Enum.Material.Neon,
        Foil = Enum.Material.Foil,
        Custom = Enum.Material.SmoothPlastic,
        Reflective = Enum.Material.Glass,
    }
    HitFeedback.MaterialNames = { "Ghost", "Flat", "Foil", "Custom", "Reflective" }
    HitFeedback.SoundAssetCache = {}
    HitFeedback.EnumTokens = {}
    HitFeedback.Chams = {}
    HitFeedback.CustomSounds = {}
    HitFeedback.CustomSoundsLoaded = false
    HitFeedback.CustomSoundsPath = "Aevyx/RIVALS Custom Sounds.json"
    HitFeedback.AudioCacheFolder = "Aevyx/RIVALS Sounds"
    HitFeedback.BindingGeneration = 0
    HitFeedback.BindingPending = false
    HitFeedback.BindingConnected = false
    HitFeedback.Config = {
        Hit = false,
        PlayHitSound = false,
        HeadSound = "Hitmarker (CoD)",
        HeadVolume = 1,
        HeadPitch = 1,
        BodySound = "Hitmarker (MLG)",
        BodyVolume = 1,
        BodyPitch = 1,
        DisableGameSound = false,
        HitChams = false,
        HitChamsColor = Color3.fromRGB(255, 0, 0),
        HitChamsTransparency = 0,
        HitChamsDuration = 0.8,
        HitChamsMaterial = "Ghost",
        KillFeedback = false,
        PlayKillSound = false,
        KillSound = "TF2",
        KillVolume = 1,
        KillPitch = 1,
        KillChams = false,
        KillChamsColor = Color3.fromRGB(255, 0, 0),
        KillChamsTransparency = 0,
        KillChamsDuration = 0.8,
        KillChamsMaterial = "Ghost",
    }

    local hitFeedbackConnections = {}
    local chamUpdateConnection = nil
    local gameSoundOriginal = nil
    local gameSoundViewModel = nil
    local gameSoundHooked = false

    local function isEnabled()
        return HitFeedback.Config.Hit or HitFeedback.Config.KillFeedback
    end

    local function hashSoundUrl(url)
        local hash = 5381
        for index = 1, #url do
            hash = (hash * 33 + string.byte(url, index)) % 2147483647
        end
        return tostring(hash)
    end

    local function resolveFighterObjectId(fighter)
        if type(fighter) ~= "table" then
            return nil
        end
        local ok, objectId = pcall(function()
            return fighter:Get("ObjectID")
        end)
        if ok and type(objectId) == "string" and objectId ~= "" then
            return objectId
        end
        local data = rawget(fighter, "Data")
        if type(data) == "table" then
            objectId = rawget(data, "ObjectID")
            if type(objectId) == "string" and objectId ~= "" then
                return objectId
            end
        end
        return nil
    end

    local function resolveCharacterByObjectId(objectId)
        local controllers = { FighterController }
        local enemyModule = lplr.PlayerScripts:FindFirstChild("Controllers")
            and lplr.PlayerScripts.Controllers:FindFirstChild("EnemyController") or nil
        if enemyModule then
            local ok, enemyController = pcall(require, enemyModule)
            if ok and type(enemyController) == "table" then
                controllers[#controllers + 1] = enemyController
            end
        end
        for _, controller in ipairs(controllers) do
            for _, subject in ipairs(controller.Objects or {}) do
                if resolveFighterObjectId(subject) == objectId then
                    local entity = rawget(subject, "Entity")
                    local model = type(entity) == "table" and rawget(entity, "Model") or nil
                    if typeof(model) == "Instance" and model:IsA("Model") then
                        return model
                    end
                    local player = rawget(subject, "Player")
                    if typeof(player) == "Instance" and player:IsA("Player") then
                        return player.Character
                    end
                end
            end
        end
        return nil
    end

    function HitFeedback.SoundNames()
        local names = {}
        local seen = {}
        for _, record in ipairs(HitFeedback.BuiltInSounds) do
            names[#names + 1] = record.name
            seen[record.name] = true
        end
        for _, record in ipairs(HitFeedback.CustomSounds) do
            if not seen[record.name] then
                names[#names + 1] = record.name
            end
        end
        return names
    end

    function HitFeedback.LoadCustomSounds()
        HitFeedback.CustomSounds = {}
        if type(readfile) ~= "function" or type(isfile) ~= "function" or not isfile(HitFeedback.CustomSoundsPath) then
            return
        end
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(HitFeedback.CustomSoundsPath))
        end)
        if ok and type(decoded) == "table" then
            for _, record in ipairs(decoded) do
                if type(record) == "table" and type(record.name) == "string" and type(record.soundId) == "string" then
                    table.insert(HitFeedback.CustomSounds, { name = record.name, soundId = record.soundId })
                end
            end
        end
        HitFeedback.CustomSoundsLoaded = true
    end

    function HitFeedback.SaveCustomSounds()
        if type(writefile) ~= "function" then
            return false
        end
        local ok = pcall(function()
            writefile(HitFeedback.CustomSoundsPath, HttpService:JSONEncode(HitFeedback.CustomSounds))
        end)
        return ok
    end

    function HitFeedback.RefreshCustomSoundDropdowns()
        local names = HitFeedback.SoundNames()
        for _, optionId in ipairs({ "AEVYX_HF_HEAD_SOUND", "AEVYX_HF_BODY_SOUND", "AEVYX_HF_KILL_SOUND" }) do
            local option = Options and Options[optionId]
            if option and type(option.SetValues) == "function" then
                pcall(option.SetValues, option, names)
            end
        end
    end

    function HitFeedback.AddCustomSound(nameValue, sourceValue)
        HitFeedback.LoadCustomSounds()
        local name = tostring(nameValue or ""):match("^%s*(.-)%s*$") or ""
        local source = tostring(sourceValue or "")
        if name == "" or source == "" then
            return false
        end
        if source:match("^%s*rbxassetid://") or source:match("^%s*rbxasset://") then
            source = source:match("^%s*(.-)%s*$")
        elseif source:match("^%s*%d+%s*$") then
            source = "rbxassetid://" .. tostring(tonumber(source))
        else
            source = source:match("^%s*(.-)%s*$")
        end
        for _, record in ipairs(HitFeedback.CustomSounds) do
            if record.name == name then
                return false
            end
        end
        for _, record in ipairs(HitFeedback.BuiltInSounds) do
            if record.name == name then
                return false
            end
        end
        local previous = table.clone(HitFeedback.CustomSounds)
        table.insert(HitFeedback.CustomSounds, { name = name, soundId = source })
        table.sort(HitFeedback.CustomSounds, function(left, right)
            return left.name < right.name
        end)
        if not HitFeedback.SaveCustomSounds() then
            HitFeedback.CustomSounds = previous
            return false
        end
        HitFeedback.SoundAssetCache[name] = nil
        HitFeedback.RefreshCustomSoundDropdowns()
        return true
    end

    function HitFeedback.RemoveCustomSound(nameValue)
        HitFeedback.LoadCustomSounds()
        local name = tostring(nameValue or ""):match("^%s*(.-)%s*$") or ""
        if name == "" then
            return false
        end
        local index = nil
        for recordIndex, record in ipairs(HitFeedback.CustomSounds) do
            if record.name == name then
                index = recordIndex
                break
            end
        end
        if not index then
            return false
        end
        local previous = table.clone(HitFeedback.CustomSounds)
        table.remove(HitFeedback.CustomSounds, index)
        if not HitFeedback.SaveCustomSounds() then
            HitFeedback.CustomSounds = previous
            return false
        end
        HitFeedback.SoundAssetCache[name] = nil
        HitFeedback.RefreshCustomSoundDropdowns()
        return true
    end

    local function resolveCustomSoundSource(name)
        HitFeedback.LoadCustomSounds()
        for _, record in ipairs(HitFeedback.CustomSounds) do
            if record.name == name then
                return record.soundId
            end
        end
        for _, record in ipairs(HitFeedback.BuiltInSounds) do
            if record.name == name then
                return record.soundId
            end
        end
        return nil
    end

    function HitFeedback.ResolveSoundAsset(name)
        if type(name) ~= "string" or name == "" then
            return nil
        end
        local cached = HitFeedback.SoundAssetCache[name]
        if cached ~= nil then
            return cached or nil
        end
        local source = resolveCustomSoundSource(name)
        if not source then
            HitFeedback.SoundAssetCache[name] = false
            return nil
        end
        if source:match("^rbxassetid://") or source:match("^rbxasset://") then
            HitFeedback.SoundAssetCache[name] = source
            return source
        end

        local customAsset = type(getcustomasset) == "function" and getcustomasset
            or (type(getsynasset) == "function" and getsynasset or nil)
        if source:match("^https?://") then
            if type(writefile) ~= "function" or type(customAsset) ~= "function" then
                HitFeedback.SoundAssetCache[name] = false
                return nil
            end
            local extension = source:match("(%.[%w]+)[%?#]") or source:match("(%.[%w]+)$") or ".mp3"
            extension = extension:lower()
            if extension ~= ".mp3" and extension ~= ".ogg" and extension ~= ".wav" then
                extension = ".mp3"
            end
            local cachePath = string.format("%s/%s%s", HitFeedback.AudioCacheFolder, hashSoundUrl(source), extension)
            local ok = pcall(function()
                if type(makefolder) == "function" and type(isfolder) == "function" then
                    if not isfolder("Aevyx") then
                        makefolder("Aevyx")
                    end
                    if not isfolder(HitFeedback.AudioCacheFolder) then
                        makefolder(HitFeedback.AudioCacheFolder)
                    end
                end
                if type(isfile) ~= "function" or not isfile(cachePath) then
                    local requestFunction = type(request) == "function" and request
                        or (type(http_request) == "function" and http_request or nil)
                    local body = nil
                    if requestFunction then
                        local response = requestFunction({ Url = source, Method = "GET" })
                        local status = tonumber(response and (response.StatusCode or response.Status)) or 0
                        if status < 200 or status >= 300 then
                            error("download failed")
                        end
                        body = response.Body
                    else
                        body = game:HttpGet(source)
                    end
                    if type(body) ~= "string" or body == "" then
                        error("empty download")
                    end
                    writefile(cachePath, body)
                end
            end)
            if ok then
                local assetOk, asset = pcall(customAsset, cachePath)
                if assetOk and type(asset) == "string" and asset ~= "" then
                    HitFeedback.SoundAssetCache[name] = asset
                    return asset
                end
            end
            HitFeedback.SoundAssetCache[name] = false
            return nil
        end

        if type(customAsset) == "function" and type(isfile) == "function" and isfile(source) then
            local ok, asset = pcall(customAsset, source)
            if ok and type(asset) == "string" and asset ~= "" then
                HitFeedback.SoundAssetCache[name] = asset
                return asset
            end
        end
        HitFeedback.SoundAssetCache[name] = false
        return nil
    end

    function HitFeedback.PlaySound(name, volume, pitch)
        local asset = HitFeedback.ResolveSoundAsset(name)
        if not asset then
            return
        end
        local ok, sound = pcall(function()
            local created = Instance.new("Sound")
            created.Name = "AevyxHitFeedback"
            created.SoundId = asset
            created.Volume = math.max(0, tonumber(volume) or 1)
            created.PlaybackSpeed = math.max(0.01, tonumber(pitch) or 1)
            created.Parent = SoundService
            Debris:AddItem(created, 20)
            created:Play()
        end)
    end

    function HitFeedback.CreateChams(character, color, transparency, duration, materialName)
        if typeof(character) ~= "Instance" or not character:IsA("Model") then
            return
        end
        local model = Instance.new("Model")
        model.Name = "AevyxHitFeedbackChams"
        local parts = {}
        local material = HitFeedback.MaterialMap[materialName] or Enum.Material.ForceField
        local baseTransparency = math.clamp(tonumber(transparency) or 0, 0, 1)
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Transparency < 1 then
                local ok, ghost = pcall(function()
                    return part:Clone()
                end)
                if not ok or not ghost or not ghost:IsA("BasePart") then
                    ghost = Instance.new("Part")
                    ghost.Size = part.Size
                    ghost.Shape = part:IsA("Part") and part.Shape or Enum.PartType.Block
                end
                for _, descendant in ipairs(ghost:GetDescendants()) do
                    if not descendant:IsA("DataModelMesh") then
                        descendant:Destroy()
                    end
                end
                ghost.Name = part.Name
                ghost.Anchored = true
                ghost.CanCollide = false
                ghost.CanQuery = false
                ghost.CanTouch = false
                ghost.CastShadow = false
                ghost.Color = typeof(color) == "Color3" and color or Color3.fromRGB(255, 0, 0)
                ghost.Material = material
                ghost.Transparency = baseTransparency
                ghost.CFrame = part.CFrame
                pcall(function()
                    ghost.MaterialVariant = ""
                end)
                ghost.Parent = model
                table.insert(parts, { Source = part, Ghost = ghost })
            end
        end
        if #parts == 0 then
            model:Destroy()
            return
        end
        model.Parent = ws
        table.insert(HitFeedback.Chams, {
            Model = model,
            Parts = parts,
            StartedAt = tick(),
            Duration = math.max(0.05, tonumber(duration) or 0.8),
            Transparency = baseTransparency,
        })
    end

    function HitFeedback.UpdateChams()
        local now = tick()
        for index = #HitFeedback.Chams, 1, -1 do
            local cham = HitFeedback.Chams[index]
            local progress = math.clamp((now - cham.StartedAt) / cham.Duration, 0, 1)
            if progress >= 1 or not cham.Model or cham.Model.Parent == nil then
                if cham.Model then
                    pcall(function()
                        cham.Model:Destroy()
                    end)
                end
                table.remove(HitFeedback.Chams, index)
            else
                for partIndex = #cham.Parts, 1, -1 do
                    local pair = cham.Parts[partIndex]
                    if pair.Source and pair.Source.Parent and pair.Ghost and pair.Ghost.Parent then
                        pair.Ghost.CFrame = pair.Source.CFrame
                        pair.Ghost.Transparency = cham.Transparency + (1 - cham.Transparency) * progress
                    else
                        if pair.Ghost then
                            pair.Ghost:Destroy()
                        end
                        table.remove(cham.Parts, partIndex)
                    end
                end
            end
        end
    end

    function HitFeedback.ResolveEnumTokens()
        if type(enum) ~= "table" or type(enum.ToEnum) ~= "function" then
            return false
        end
        local all = true
        for _, enumName in ipairs({ "DamageNumberEffect", "EliminationEffect", "FinisherEffect" }) do
            local ok, token = pcall(enum.ToEnum, enum, enumName)
            if not ok or type(token) ~= "string" then
                all = false
            else
                HitFeedback.EnumTokens[enumName] = token
            end
        end
        return all
    end

    
    
    
    
    
    
    
    function HitFeedback.ResolveEffectPacket(packet)
        local tokens = HitFeedback.EnumTokens
        for index = 3, packet.n do
            local value = packet[index]
            local matched = nil
            if type(value) == "string" then
                for name, token in pairs(tokens) do
                    if value == token then
                        matched = name
                        break
                    end
                end
            end
            if matched then
                local objectId = (index == 4) and packet[2] or packet[index - 1]
                if type(objectId) == "string" then
                    return matched, objectId, index
                end
            end
        end
        return nil
    end

    function HitFeedback.HandleHit(damage, partName, character)
        if not HitFeedback.Config.Hit then
            return
        end
        if HitFeedback.Config.PlayHitSound then
            local isHead = partName == "Head"
            HitFeedback.PlaySound(
                isHead and HitFeedback.Config.HeadSound or HitFeedback.Config.BodySound,
                isHead and HitFeedback.Config.HeadVolume or HitFeedback.Config.BodyVolume,
                isHead and HitFeedback.Config.HeadPitch or HitFeedback.Config.BodyPitch
            )
        end
        if HitFeedback.Config.HitChams then
            HitFeedback.CreateChams(
                character,
                HitFeedback.Config.HitChamsColor,
                HitFeedback.Config.HitChamsTransparency,
                HitFeedback.Config.HitChamsDuration,
                HitFeedback.Config.HitChamsMaterial
            )
        end
    end

    function HitFeedback.HandleKill(character)
        if not HitFeedback.Config.KillFeedback then
            return
        end
        if HitFeedback.Config.PlayKillSound then
            HitFeedback.PlaySound(
                HitFeedback.Config.KillSound,
                HitFeedback.Config.KillVolume,
                HitFeedback.Config.KillPitch
            )
        end
        if HitFeedback.Config.KillChams then
            HitFeedback.CreateChams(
                character,
                HitFeedback.Config.KillChamsColor,
                HitFeedback.Config.KillChamsTransparency,
                HitFeedback.Config.KillChamsDuration,
                HitFeedback.Config.KillChamsMaterial
            )
        end
    end

    function HitFeedback.HandleReplicate(...)
        local packet = table.pack(...)
        local effectName, objectId, index = HitFeedback.ResolveEffectPacket(packet)
        if not effectName then
            return
        end
        if effectName == "DamageNumberEffect" and HitFeedback.Config.Hit then
            local localFighter = FighterController.LocalFighter
            if not localFighter or resolveFighterObjectId(localFighter) ~= objectId then
                return
            end
            local hitPart, damage, isHead = packet[index + 1], packet[index + 2], packet[index + 3]
            if typeof(hitPart) ~= "Instance" then
                return
            end
            local character = hitPart.Parent
            if typeof(character) ~= "Instance" or not character:IsA("Model") then
                return
            end
            HitFeedback.HandleHit(damage, isHead == true and "Head" or "Body", character)
        elseif effectName == "EliminationEffect" and HitFeedback.Config.KillFeedback then
            local localFighter = FighterController.LocalFighter
            if not localFighter or resolveFighterObjectId(localFighter) ~= objectId then
                return
            end
            local eliminated = packet[index + 1]
            if eliminated == lplr or (lplr.Character and eliminated == lplr.Character) then
                return
            end
            local character = nil
            if typeof(eliminated) == "Instance" then
                if eliminated:IsA("Player") then
                    character = eliminated.Character
                elseif eliminated:IsA("Model") then
                    character = eliminated
                end
            end
            HitFeedback.HandleKill(character)
        elseif effectName == "FinisherEffect" and HitFeedback.Config.KillFeedback then
            
            
            if packet[index + 3] ~= lplr then
                return
            end
            HitFeedback.HandleKill(resolveCharacterByObjectId(objectId))
        end
    end

    function HitFeedback.RefreshBinding()
        if isEnabled() then
            if HitFeedback.BindingPending or HitFeedback.BindingConnected then
                return
            end
            HitFeedback.BindingPending = true
            HitFeedback.BindingGeneration = HitFeedback.BindingGeneration + 1
            local generation = HitFeedback.BindingGeneration
            task.spawn(function()
                local deadline = tick() + 20
                while isEnabled() and HitFeedback.BindingGeneration == generation
                    and not HitFeedback.ResolveEnumTokens() and tick() < deadline do
                    task.wait(0.1)
                end
                if not isEnabled() or HitFeedback.BindingGeneration ~= generation then
                    HitFeedback.BindingPending = false
                    return
                end
                local remotes = repS:FindFirstChild("Remotes")
                local replication = remotes and remotes:FindFirstChild("Replication")
                local fighter = replication and replication:FindFirstChild("Fighter")
                local enemy = replication and replication:FindFirstChild("Enemy")
                local targets = {
                    fighter and fighter:FindFirstChild("Replicate"),
                    fighter and fighter:FindFirstChild("ReplicateUnreliable"),
                    enemy and enemy:FindFirstChild("Replicate"),
                    enemy and enemy:FindFirstChild("ReplicateUnreliable"),
                }
                local bound = false
                for _, remote in ipairs(targets) do
                    if remote and remote:IsA("RemoteEvent") and not hitFeedbackConnections[remote] then
                        hitFeedbackConnections[remote] = remote.OnClientEvent:Connect(HitFeedback.HandleReplicate)
                        bound = true
                    end
                end
                HitFeedback.BindingPending = false
                HitFeedback.BindingConnected = bound
            end)
        else
            HitFeedback.BindingGeneration = HitFeedback.BindingGeneration + 1
            HitFeedback.BindingPending = false
            HitFeedback.BindingConnected = false
            for remote, connection in pairs(hitFeedbackConnections) do
                pcall(function()
                    connection:Disconnect()
                end)
            end
            hitFeedbackConnections = {}
        end
    end

    HitFeedback.RefreshGameSoundHook = function()
        if HitFeedback.Config.DisableGameSound == gameSoundHooked then
            return
        end
        if HitFeedback.Config.DisableGameSound then
            local clientFighter = lplr.PlayerScripts
                and lplr.PlayerScripts:FindFirstChild("Modules")
                and lplr.PlayerScripts.Modules:FindFirstChild("ClientReplicatedClasses")
                and lplr.PlayerScripts.Modules.ClientReplicatedClasses:FindFirstChild("ClientFighter")
                and lplr.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter:FindFirstChild("ClientItem")
            local viewModelModule = clientFighter and clientFighter:FindFirstChild("ClientViewModel")
            if not viewModelModule then
                return
            end
            local ok, viewModel = pcall(require, viewModelModule)
            if not ok or type(viewModel) ~= "table" or type(viewModel.PlayHitmarkerSound) ~= "function" then
                return
            end
            gameSoundViewModel = viewModel
            gameSoundOriginal = viewModel.PlayHitmarkerSound
            viewModel.PlayHitmarkerSound = function() end
            gameSoundHooked = true
        else
            if gameSoundViewModel and gameSoundOriginal then
                gameSoundViewModel.PlayHitmarkerSound = gameSoundOriginal
            end
            gameSoundHooked = false
            gameSoundOriginal = nil
            gameSoundViewModel = nil
        end
    end

    function HitFeedback.Destroy()
        HitFeedback.BindingGeneration = HitFeedback.BindingGeneration + 1
        HitFeedback.BindingPending = false
        HitFeedback.BindingConnected = false
        for remote, connection in pairs(hitFeedbackConnections) do
            pcall(function()
                connection:Disconnect()
            end)
        end
        hitFeedbackConnections = {}
        HitFeedback.Config.DisableGameSound = false
        HitFeedback.RefreshGameSoundHook()
        for _, cham in ipairs(HitFeedback.Chams) do
            if cham and cham.Model then
                pcall(function()
                    cham.Model:Destroy()
                end)
            end
        end
        HitFeedback.Chams = {}
        if chamUpdateConnection then
            pcall(function()
                chamUpdateConnection:Disconnect()
            end)
            chamUpdateConnection = nil
        end
    end

    HitFeedback.LoadCustomSounds()
    chamUpdateConnection = runS.RenderStepped:Connect(function()
        HitFeedback.UpdateChams()
    end)
end)()

;(function()

local CrosshairGroup = Tabs.Visuals:AddLeftGroupbox("Crosshair", "crosshair")
CrosshairGroup:AddToggle("AEVYX_CROSSHAIR", {
    Text = "Crosshair",
    Default = false,
    Callback = function(value)
        GlobalSettings.ENABLE_CROSSHAIR = value
        if value then startCrosshair() else stopCrosshair() end
    end,
})
CrosshairGroup:AddLabel("Color"):AddColorPicker("AEVYX_CROSSHAIR_COLOR", {
    Default = MehfilConfig.Crosshair.Color,
    Callback = function(value) MehfilConfig.Crosshair.Color = value end,
})
CrosshairGroup:AddSlider("AEVYX_CROSSHAIR_SIZE", {
    Text = "Size",
    Default = MehfilConfig.Crosshair.Size,
    Min = 5,
    Max = 50,
    Rounding = 0,
    Callback = function(value) MehfilConfig.Crosshair.Size = value end,
})
CrosshairGroup:AddSlider("AEVYX_CROSSHAIR_THICKNESS", {
    Text = "Thickness",
    Default = MehfilConfig.Crosshair.Thickness,
    Min = 1,
    Max = 8,
    Rounding = 0,
    Callback = function(value) MehfilConfig.Crosshair.Thickness = value end,
})
CrosshairGroup:AddSlider("AEVYX_CROSSHAIR_GAP", {
    Text = "Gap",
    Default = MehfilConfig.Crosshair.Gap,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value) MehfilConfig.Crosshair.Gap = value end,
})
CrosshairGroup:AddToggle("AEVYX_CROSSHAIR_SPIN", {
    Text = "Spin",
    Default = false,
    Callback = function(value) MehfilConfig.Crosshair.Spin = value end,
})
CrosshairGroup:AddSlider("AEVYX_CROSSHAIR_SPIN_SPEED", {
    Text = "Spin Speed",
    Default = MehfilConfig.Crosshair.SpinSpeed,
    Min = 0.5,
    Max = 10,
    Rounding = 1,
    Callback = function(value) MehfilConfig.Crosshair.SpinSpeed = value end,
})

CrosshairGroup:AddDropdown("AEVYX_CROSSHAIR_MODE", {
    Text = "Mode",
    Values = { "static", "follow muzzle", "enemy" },
    Default = "static",
    Tooltip = "static = screen center · follow muzzle = sticks to your gun muzzle · enemy = tracks the nearest enemy (outside TeamID)",
    Callback = function(value)
        MehfilConfig.Crosshair.Mode = value
        if IOInstance and IOInstance.SmoothCenters then
            IOInstance.SmoothCenters[CrosshairCenterConfig] = nil
        end
    end,
})
CrosshairGroup:AddSlider("AEVYX_CROSSHAIR_SMOOTHNESS", {
    Text = "Follow Smoothness",
    Default = 6,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Suffix = "x",
    Tooltip = "Sliding speed toward the target (lower = slower/smoother)",
    Callback = function(value)
        MehfilConfig.Crosshair.Smoothness = value
    end,
})


local LunaraSnowGroup = Tabs.Visuals:AddRightGroupbox("Snow", "cloud-snow")
LunaraSnowGroup:AddToggle("AEVYX_LUNARA_SNOW", {
    Text = "Enable Snow",
    Default = false,
    Callback = function(value) GlobalSettings.ENABLE_WEATHER = value; refreshWeather() end,
}):AddColorPicker("AEVYX_LUNARA_SNOW_COLOR", {
    Default = LunaraSnowConfig.Color,
    Title = "Color",
    Callback = function(value) LunaraSnowConfig.Color = value; refreshWeather() end,
})
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_RATE", { Text = "Rate", Default = 100, Min = 0, Max = 100, Rounding = 0, Suffix = "%", Callback = function(value) LunaraSnowConfig.Rate = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SPEED_MIN", { Text = "Speed Min", Default = 30, Min = 0, Max = 200, Rounding = 1, Callback = function(value) LunaraSnowConfig.SpeedMin = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SPEED_MAX", { Text = "Speed Max", Default = 30, Min = 0, Max = 200, Rounding = 1, Callback = function(value) LunaraSnowConfig.SpeedMax = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SIZE_MIN", { Text = "Size Min", Default = 0.33, Min = 0.1, Max = 50, Rounding = 2, Callback = function(value) LunaraSnowConfig.SizeMin = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SIZE_MAX", { Text = "Size Max", Default = 0.40, Min = 0.1, Max = 50, Rounding = 2, Callback = function(value) LunaraSnowConfig.SizeMax = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_OPACITY_MIN", { Text = "Opacity Min", Default = 26, Min = 0, Max = 100, Rounding = 0, Suffix = "%", Callback = function(value) LunaraSnowConfig.TransparencyMin = 1 - value / 100; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_OPACITY_MAX", { Text = "Opacity Max", Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = "%", Callback = function(value) LunaraSnowConfig.TransparencyMax = 1 - value / 100; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SPREAD", { Text = "Spread", Default = 180, Min = 0, Max = 180, Rounding = 0,     Suffix = "°", Callback = function(value) LunaraSnowConfig.Spread = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_BRIGHTNESS", { Text = "Brightness", Default = 100, Min = 0, Max = 500, Rounding = 0, Suffix = "%", Callback = function(value) LunaraSnowConfig.Brightness = value / 100; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_EMISSION", { Text = "Light Emission", Default = 50, Min = 0, Max = 100, Rounding = 0, Suffix = "%", Callback = function(value) LunaraSnowConfig.LightEmission = value / 100; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_GLOW", { Text = "Glow", Default = 0, Min = 0, Max = 5, Rounding = 2, Suffix = "x", Callback = function(value) LunaraSnowConfig.Glow = value; refreshWeather() end })
LunaraSnowGroup:AddSlider("AEVYX_LUNARA_SNOW_SCALE", { Text = "Particle Size", Default = 1, Min = 0.1, Max = 5, Rounding = 2, Suffix = "x", Callback = function(value) LunaraSnowConfig.SizeScale = value; refreshWeather() end })


local GunViewModelGroup = Tabs.Visuals:AddLeftGroupbox("Viewmodel Gun", "crosshair")
GunViewModelGroup:AddToggle("AEVYX_VM_GUN_CHAMS", { Text = "Gun Chams", Default = false, Callback = function(value) ViewModelConfig.GunChams = value; refreshViewModelEffects() end })
GunViewModelGroup:AddLabel("Gun Color 1"):AddColorPicker("AEVYX_VM_GUN_COLOR_1", { Default = ViewModelConfig.GunColors[1], Callback = function(value) ViewModelConfig.GunColors[1] = value end })
GunViewModelGroup:AddLabel("Gun Color 2"):AddColorPicker("AEVYX_VM_GUN_COLOR_2", { Default = ViewModelConfig.GunColors[2], Callback = function(value) ViewModelConfig.GunColors[2] = value end })
GunViewModelGroup:AddLabel("Gun Color 3"):AddColorPicker("AEVYX_VM_GUN_COLOR_3", { Default = ViewModelConfig.GunColors[3], Callback = function(value) ViewModelConfig.GunColors[3] = value end })
GunViewModelGroup:AddDropdown("AEVYX_VM_GUN_MATERIAL", { Text = "Gun Material", Values = { "ForceField", "Neon", "SmoothPlastic", "Glass", "Ice", "Plastic", "Wood", "Marble", "Granite", "Brick", "Cobblestone", "Concrete", "Slate", "Foil" }, Default = "Neon", Callback = function(value) ViewModelConfig.GunMaterial = Enum.Material[value] end })
GunViewModelGroup:AddSlider("AEVYX_VM_GUN_SPEED", { Text = "Gradient Speed", Default = 1, Min = 0.1, Max = 10, Rounding = 1, Callback = function(value) ViewModelConfig.GunSpeed = value end })
GunViewModelGroup:AddSlider("AEVYX_VM_GUN_TRANSPARENCY", { Text = "Gun Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.GunTransparency = value end })
GunViewModelGroup:AddToggle("AEVYX_VM_GUN_OUTLINE", { Text = "Gun Outline", Default = false, Callback = function(value) ViewModelConfig.GunOutline = value; refreshViewModelEffects() end })
GunViewModelGroup:AddLabel("Outline Color 1"):AddColorPicker("AEVYX_VM_GUN_OUTLINE_1", { Default = ViewModelConfig.GunOutlineColors[1], Callback = function(value) ViewModelConfig.GunOutlineColors[1] = value end })
GunViewModelGroup:AddLabel("Outline Color 2"):AddColorPicker("AEVYX_VM_GUN_OUTLINE_2", { Default = ViewModelConfig.GunOutlineColors[2], Callback = function(value) ViewModelConfig.GunOutlineColors[2] = value end })
GunViewModelGroup:AddLabel("Outline Color 3"):AddColorPicker("AEVYX_VM_GUN_OUTLINE_3", { Default = ViewModelConfig.GunOutlineColors[3], Callback = function(value) ViewModelConfig.GunOutlineColors[3] = value end })
GunViewModelGroup:AddToggle("AEVYX_VM_GUN_HIGHLIGHT", { Text = "Gun Highlight", Default = false, Callback = function(value) ViewModelConfig.GunHighlight = value; refreshViewModelEffects() end })
GunViewModelGroup:AddLabel("Highlight Top"):AddColorPicker("AEVYX_VM_GUN_HIGHLIGHT_TOP", { Default = ViewModelConfig.GunHighlightTop, Callback = function(value) ViewModelConfig.GunHighlightTop = value end })
GunViewModelGroup:AddLabel("Highlight Bottom"):AddColorPicker("AEVYX_VM_GUN_HIGHLIGHT_BOTTOM", { Default = ViewModelConfig.GunHighlightBottom, Callback = function(value) ViewModelConfig.GunHighlightBottom = value end })
GunViewModelGroup:AddDropdown("AEVYX_VM_GUN_HIGHLIGHT_MATERIAL", { Text = "Highlight Material", Values = { "ForceField", "Neon", "SmoothPlastic", "Glass", "Ice", "Plastic", "Wood", "Marble", "Granite", "Brick", "Cobblestone", "Concrete", "Slate", "Foil" }, Default = "Neon", Callback = function(value) ViewModelConfig.GunHighlightMaterial = Enum.Material[value] end })
GunViewModelGroup:AddSlider("AEVYX_VM_GUN_HIGHLIGHT_FILL", { Text = "Highlight Fill Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.GunHighlightFillTransparency = value end })
GunViewModelGroup:AddSlider("AEVYX_VM_GUN_HIGHLIGHT_OUTLINE", { Text = "Highlight Outline Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.GunHighlightOutlineTransparency = value end })


local ArmsViewModelGroup = Tabs.Visuals:AddRightGroupbox("Viewmodel Arms", "hand")
ArmsViewModelGroup:AddToggle("AEVYX_VM_ARM_CHAMS", { Text = "Arm Chams", Default = false, Callback = function(value) ViewModelConfig.ArmChams = value; refreshViewModelEffects() end })
ArmsViewModelGroup:AddLabel("Arm Color 1"):AddColorPicker("AEVYX_VM_ARM_COLOR_1", { Default = ViewModelConfig.ArmColors[1], Callback = function(value) ViewModelConfig.ArmColors[1] = value end })
ArmsViewModelGroup:AddLabel("Arm Color 2"):AddColorPicker("AEVYX_VM_ARM_COLOR_2", { Default = ViewModelConfig.ArmColors[2], Callback = function(value) ViewModelConfig.ArmColors[2] = value end })
ArmsViewModelGroup:AddLabel("Arm Color 3"):AddColorPicker("AEVYX_VM_ARM_COLOR_3", { Default = ViewModelConfig.ArmColors[3], Callback = function(value) ViewModelConfig.ArmColors[3] = value end })
ArmsViewModelGroup:AddDropdown("AEVYX_VM_ARM_MATERIAL", { Text = "Arm Material", Values = { "ForceField", "Neon", "SmoothPlastic", "Glass", "Ice", "Plastic", "Wood", "Marble", "Granite", "Brick", "Cobblestone", "Concrete", "Slate", "Foil" }, Default = "ForceField", Callback = function(value) ViewModelConfig.ArmMaterial = Enum.Material[value] end })
ArmsViewModelGroup:AddSlider("AEVYX_VM_ARM_SPEED", { Text = "Gradient Speed", Default = 1, Min = 0.1, Max = 10, Rounding = 1, Callback = function(value) ViewModelConfig.ArmSpeed = value end })
ArmsViewModelGroup:AddSlider("AEVYX_VM_ARM_TRANSPARENCY", { Text = "Arm Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.ArmTransparency = value end })
ArmsViewModelGroup:AddToggle("AEVYX_VM_ARM_OUTLINE", { Text = "Arm Outline", Default = false, Callback = function(value) ViewModelConfig.ArmOutline = value; refreshViewModelEffects() end })
ArmsViewModelGroup:AddLabel("Outline Color 1"):AddColorPicker("AEVYX_VM_ARM_OUTLINE_1", { Default = ViewModelConfig.ArmOutlineColors[1], Callback = function(value) ViewModelConfig.ArmOutlineColors[1] = value end })
ArmsViewModelGroup:AddLabel("Outline Color 2"):AddColorPicker("AEVYX_VM_ARM_OUTLINE_2", { Default = ViewModelConfig.ArmOutlineColors[2], Callback = function(value) ViewModelConfig.ArmOutlineColors[2] = value end })
ArmsViewModelGroup:AddLabel("Outline Color 3"):AddColorPicker("AEVYX_VM_ARM_OUTLINE_3", { Default = ViewModelConfig.ArmOutlineColors[3], Callback = function(value) ViewModelConfig.ArmOutlineColors[3] = value end })
ArmsViewModelGroup:AddToggle("AEVYX_VM_ARM_HIGHLIGHT", { Text = "Arm Highlight", Default = false, Callback = function(value) ViewModelConfig.ArmHighlight = value; refreshViewModelEffects() end })
ArmsViewModelGroup:AddLabel("Highlight Top"):AddColorPicker("AEVYX_VM_ARM_HIGHLIGHT_TOP", { Default = ViewModelConfig.ArmHighlightTop, Callback = function(value) ViewModelConfig.ArmHighlightTop = value end })
ArmsViewModelGroup:AddLabel("Highlight Bottom"):AddColorPicker("AEVYX_VM_ARM_HIGHLIGHT_BOTTOM", { Default = ViewModelConfig.ArmHighlightBottom, Callback = function(value) ViewModelConfig.ArmHighlightBottom = value end })
ArmsViewModelGroup:AddDropdown("AEVYX_VM_ARM_HIGHLIGHT_MATERIAL", { Text = "Highlight Material", Values = { "ForceField", "Neon", "SmoothPlastic", "Glass", "Ice", "Plastic", "Wood", "Marble", "Granite", "Brick", "Cobblestone", "Concrete", "Slate", "Foil" }, Default = "Neon", Callback = function(value) ViewModelConfig.ArmHighlightMaterial = Enum.Material[value] end })
ArmsViewModelGroup:AddSlider("AEVYX_VM_ARM_HIGHLIGHT_FILL", { Text = "Highlight Fill Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.ArmHighlightFillTransparency = value end })
ArmsViewModelGroup:AddSlider("AEVYX_VM_ARM_HIGHLIGHT_OUTLINE", { Text = "Highlight Outline Transparency", Default = 0, Min = 0, Max = 1, Rounding = 2, Callback = function(value) ViewModelConfig.ArmHighlightOutlineTransparency = value end })
ArmsViewModelGroup:AddToggle("AEVYX_VM_DISABLE_ARMS", { Text = "Disable Arms", Default = false, Callback = function(value) ViewModelConfig.DisableArms = value; refreshViewModelEffects() end })


local ViewportGroup = Tabs.Visuals:AddLeftGroupbox("Viewmodel Viewport", "move-3d")
ViewportGroup:AddToggle("AEVYX_VM_VIEWPORT", { Text = "Enable", Default = false, Callback = function(value) ViewModelConfig.Viewport = value; refreshViewModelEffects() end })
ViewportGroup:AddSlider("AEVYX_VM_OFFSET_X", { Text = "X", Default = 0, Min = -10, Max = 10, Rounding = 2, Callback = function(value) ViewModelConfig.OffsetX = value end })
ViewportGroup:AddSlider("AEVYX_VM_OFFSET_Y", { Text = "Y", Default = 0, Min = -10, Max = 10, Rounding = 2, Callback = function(value) ViewModelConfig.OffsetY = value end })
ViewportGroup:AddSlider("AEVYX_VM_OFFSET_Z", { Text = "Z", Default = 0, Min = -10, Max = 10, Rounding = 2, Callback = function(value) ViewModelConfig.OffsetZ = value end })


local PostGroup = Tabs.Visuals:AddRightGroupbox("Post-Processing", "sparkles")
PostGroup:AddToggle("AEVYX_POST_BLUR", { Text = "Motion Blur", Default = false, Callback = function(value) MehfilConfig.PostProcessing.MotionBlur = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_BLUR_INTENSITY", { Text = "Blur Intensity", Default = 0.5, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.MotionBlurIntensity = value; applyPostProcessing() end })
PostGroup:AddToggle("AEVYX_POST_BLOOM", { Text = "Bloom", Default = false, Callback = function(value) MehfilConfig.PostProcessing.Bloom = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_BLOOM_INTENSITY", { Text = "Bloom Intensity", Default = 0.5, Min = 0, Max = 3, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.BloomIntensity = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_BLOOM_SIZE", { Text = "Bloom Size", Default = 24, Min = 1, Max = 56, Rounding = 0, Callback = function(value) MehfilConfig.PostProcessing.BloomSize = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_BLOOM_THRESHOLD", { Text = "Bloom Threshold", Default = 0.8, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.BloomThreshold = value; applyPostProcessing() end })
PostGroup:AddToggle("AEVYX_POST_SUNRAYS", { Text = "Sun Rays", Default = false, Callback = function(value) MehfilConfig.PostProcessing.SunRays = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_SUNRAYS_INTENSITY", { Text = "Ray Intensity", Default = 0.5, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.SunRaysIntensity = value; applyPostProcessing() end })
PostGroup:AddSlider("AEVYX_POST_SUNRAYS_SPREAD", { Text = "Ray Spread", Default = 0.5, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.SunRaysSpread = value; applyPostProcessing() end })


local ColorGroup = Tabs.Visuals:AddRightGroupbox("Color Correction", "palette")
ColorGroup:AddToggle("AEVYX_POST_CC", { Text = "Enable", Default = false, Callback = function(value) MehfilConfig.PostProcessing.ColorCorrection = value; applyPostProcessing() end })
ColorGroup:AddSlider("AEVYX_POST_CC_BRIGHTNESS", { Text = "Brightness", Default = 0, Min = -1, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.Brightness = value; applyPostProcessing() end })
ColorGroup:AddSlider("AEVYX_POST_CC_CONTRAST", { Text = "Contrast", Default = 0, Min = -1, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.Contrast = value; applyPostProcessing() end })
ColorGroup:AddSlider("AEVYX_POST_CC_SATURATION", { Text = "Saturation", Default = 0, Min = -1, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.Saturation = value; applyPostProcessing() end })
ColorGroup:AddLabel("Tint Color"):AddColorPicker("AEVYX_POST_CC_TINT", { Default = MehfilConfig.PostProcessing.TintColor, Callback = function(value) MehfilConfig.PostProcessing.TintColor = value; applyPostProcessing() end })


local MapGroup = Tabs.Visuals:AddLeftGroupbox("Map Visuals", "map")
MapGroup:AddToggle("AEVYX_MAP_FOG", { Text = "Custom Fog", Default = false, Callback = function(value) MehfilConfig.PostProcessing.CustomFog = value; applyPostProcessing() end })
MapGroup:AddLabel("Fog Color"):AddColorPicker("AEVYX_MAP_FOG_COLOR", { Default = MehfilConfig.PostProcessing.FogColor, Callback = function(value) MehfilConfig.PostProcessing.FogColor = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_FOG_START", { Text = "Fog Start", Default = 0, Min = 0, Max = 1000, Rounding = 0, Callback = function(value) MehfilConfig.PostProcessing.FogStart = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_FOG_END", { Text = "Fog End", Default = 500, Min = 10, Max = 10000, Rounding = 0, Callback = function(value) MehfilConfig.PostProcessing.FogEnd = value; applyPostProcessing() end })
MapGroup:AddToggle("AEVYX_MAP_TIME", { Text = "Custom Time", Default = false, Callback = function(value) MehfilConfig.PostProcessing.CustomTime = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_HOUR", { Text = "Hour", Default = 12, Min = 0, Max = 24, Rounding = 1, Callback = function(value) MehfilConfig.PostProcessing.Hour = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_BRIGHTNESS", { Text = "Brightness", Default = 2, Min = 0, Max = 10, Rounding = 1, Callback = function(value) MehfilConfig.PostProcessing.TimeBrightness = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_SHADOW", { Text = "Shadow Softness", Default = 0.5, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.ShadowSoftness = value; applyPostProcessing() end })
MapGroup:AddToggle("AEVYX_MAP_ATMOSPHERE", { Text = "Atmosphere", Default = false, Callback = function(value) MehfilConfig.PostProcessing.Atmosphere = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_ATMOSPHERE_DENSITY", { Text = "Atmo Density", Default = 0.3, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereDensity = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_ATMOSPHERE_HAZE", { Text = "Atmo Haze", Default = 1, Min = 0, Max = 5, Rounding = 1, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereHaze = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_ATMOSPHERE_GLARE", { Text = "Atmo Glare", Default = 0, Min = 0, Max = 5, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereGlare = value; applyPostProcessing() end })
MapGroup:AddSlider("AEVYX_MAP_ATMOSPHERE_OFFSET", { Text = "Atmo Offset", Default = 0.25, Min = 0, Max = 1, Rounding = 2, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereOffset = value; applyPostProcessing() end })
MapGroup:AddLabel("Atmo Color"):AddColorPicker("AEVYX_MAP_ATMOSPHERE_COLOR", { Default = MehfilConfig.PostProcessing.AtmosphereColor, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereColor = value; applyPostProcessing() end })
MapGroup:AddLabel("Atmo Decay"):AddColorPicker("AEVYX_MAP_ATMOSPHERE_DECAY", { Default = MehfilConfig.PostProcessing.AtmosphereDecay, Callback = function(value) MehfilConfig.PostProcessing.AtmosphereDecay = value; applyPostProcessing() end })

do
    local BT_Enabled = false
    local BT_Color = Color3.fromRGB(255, 255, 255)
    local BT_Duration = 3
    local BT_Size = 1
    local BT_FadeTime = 0.5
    local BT_LerpSpeed = 0
    local BT_Style = "Line"
    local BT_Tracers = {}
    local BT_Connection = nil
    local BT_Hooked = false
    local BT_LastCreations = {}
    local BT_DEDUPE_INTERVAL = 0.1
    local BT_DEDUPE_EXPIRY = 1.0
    local BT_DISABLE = false

    local BT_TextureAssets = {
        Line = "",
        Beam = "rbxassetid://12781852245",
        Lightning = "rbxassetid://446111271",
        Heartrate = "rbxassetid://5830549480",
        Chain = "rbxassetid://9632168658",
        Glitch = "rbxassetid://8089467613",
        Swirl = "rbxassetid://5638168605",
        Neon = "rbxassetid://6361963422",
        Plasma = "rbxassetid://8993645509",
        Laser = "rbxassetid://14549123968",
    }

    local function BT_WorldToScreen(worldPos, cam)
        local c = cam or workspace.CurrentCamera
        local screenPos, onScreen = c:WorldToViewportPoint(worldPos)
        return screenPos, onScreen
    end

    local function BT_MuzzlePos()
        local viewModels = workspace:FindFirstChild("ViewModels") or workspace:FindFirstChild("ViewModel")
        if not viewModels then return nil end
        local firstPerson = viewModels:FindFirstChild("FirstPerson")
        if not firstPerson then return nil end
        local playerName = lplr.Name
        for _, model in ipairs(firstPerson:GetChildren()) do
            if model:IsA("Model") and model.Name:find("^" .. playerName) then
                local iv = model:FindFirstChild("ItemVisual")
                if iv then
                    local body = iv:FindFirstChild("Body")
                    if body then
                        local bp = body:FindFirstChild("BodyPrimary")
                        if bp then
                            local muzzle = bp:FindFirstChild("_muzzle")
                            if muzzle and muzzle:IsA("Attachment") then
                                return muzzle.WorldPosition
                            end
                        end
                    end
                end
            end
        end
        if type(findShotMuzzlePosition) == "function" then
            return findShotMuzzlePosition()
        end
        return nil
    end

    local function BT_GetDrawEnd(tr, age)
        if BT_LerpSpeed <= 0 then
            return tr.EndPos
        end
        local drawTime = math.max(BT_LerpSpeed * 0.25, 0.001)
        local progress = math.clamp(age / drawTime, 0, 1)
        return tr.StartPos:Lerp(tr.EndPos, progress)
    end

    local function BT_MakeLine(pos3, endPos)
        local outline = Drawing.new("Line")
        outline.Thickness = 4 * BT_Size
        outline.Color = Color3.new(0, 0, 0)
        outline.Transparency = 1
        outline.Visible = false

        local line = Drawing.new("Line")
        line.Thickness = 2 * BT_Size
        line.Color = BT_Color
        line.Transparency = 1
        line.Visible = false

        table.insert(BT_Tracers, {
            IsLine = true,
            Outline = outline,
            Line = line,
            StartPos = pos3,
            EndPos = endPos,
            Lifetime = BT_Duration,
            FadeTime = BT_FadeTime,
            CreatedTime = tick(),
        })
    end

    local function BT_MakeBeam(pos3, endPos)
        local a0 = Instance.new("Attachment")
        a0.Parent = workspace.Terrain
        local a1 = Instance.new("Attachment")
        a1.Parent = workspace.Terrain

        local beam = Instance.new("Beam")
        beam.Attachment0 = a0
        beam.Attachment1 = a1
        beam.Color = ColorSequence.new(BT_Color)
        local baseW = BT_Style == "Laser" and 0.02 or 0.15
        beam.Width0 = baseW * BT_Size
        beam.Width1 = baseW * BT_Size
        beam.Transparency = NumberSequence.new(0)
        beam.FaceCamera = true
        beam.LightEmission = 0.8
        beam.LightInfluence = 0.2

        local tex = BT_TextureAssets[BT_Style]
        if tex and tex ~= "" then
            beam.Texture = tex
            beam.TextureLength = 4
            beam.TextureSpeed = 1
        else
            beam.Texture = ""
            beam.TextureLength = 1
            beam.TextureSpeed = 0
        end

        beam.Parent = workspace.Terrain
        a0.WorldPosition = pos3
        a1.WorldPosition = endPos

        table.insert(BT_Tracers, {
            IsLine = false,
            Beam = beam,
            Attachment0 = a0,
            Attachment1 = a1,
            StartPos = pos3,
            EndPos = endPos,
            Lifetime = BT_Duration,
            FadeTime = BT_FadeTime,
            CreatedTime = tick(),
        })
    end

    local function BT_MakeTracer(pos3, endPos)
        if BT_DISABLE or not BT_Enabled or not pos3 or not endPos then return end

        local kx = math.floor(pos3.X * 5 + 0.5)
        local ky = math.floor(pos3.Y * 5 + 0.5)
        local kz = math.floor(pos3.Z * 5 + 0.5)
        local ex = math.floor(endPos.X * 5 + 0.5)
        local ey = math.floor(endPos.Y * 5 + 0.5)
        local ez = math.floor(endPos.Z * 5 + 0.5)
        local posKey = kx * 1e9 + ky * 1e6 + kz * 1e3 + ex + ey * 1e-3 + ez * 1e-6

        local now = tick()
        local last = BT_LastCreations[posKey]
        if last and (now - last) < BT_DEDUPE_INTERVAL then return end
        BT_LastCreations[posKey] = now

        if BT_Style == "Line" then
            BT_MakeLine(pos3, endPos)
        else
            BT_MakeBeam(pos3, endPos)
        end
    end

    local function BT_Destroy(tr)
        if tr.IsLine then
            if tr.Outline then tr.Outline:Remove() end
            if tr.Line then tr.Line:Remove() end
        else
            if tr.Beam then tr.Beam:Destroy() end
            if tr.Attachment0 then tr.Attachment0:Destroy() end
            if tr.Attachment1 then tr.Attachment1:Destroy() end
        end
    end

    local BT_FrameCount = 0
    local function BT_Update()
        if #BT_Tracers == 0 then return end
        BT_FrameCount = BT_FrameCount + 1
        local now = tick()
        local cam = workspace.CurrentCamera

        if BT_FrameCount % 120 == 0 then
            for k, t in next, BT_LastCreations do
                if (now - t) > BT_DEDUPE_EXPIRY then
                    BT_LastCreations[k] = nil
                end
            end
        end

        local i = #BT_Tracers
        while i >= 1 do
            local tr = BT_Tracers[i]
            local age = now - tr.CreatedTime

            if age >= tr.Lifetime then
                BT_Destroy(tr)
                BT_Tracers[i] = BT_Tracers[#BT_Tracers]
                BT_Tracers[#BT_Tracers] = nil
            else
                local fadeAlpha
                local fadeStart = tr.Lifetime - tr.FadeTime
                if tr.FadeTime > 0 and age >= fadeStart then
                    fadeAlpha = 1 - math.clamp((age - fadeStart) / tr.FadeTime, 0, 1)
                else
                    fadeAlpha = 1
                end

                if tr.IsLine then
                    local visible = false
                    local drawEnd = BT_GetDrawEnd(tr, age)
                    local camPos = cam and cam.CFrame.Position
                    local myChar = lplr.Character
                    local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    local myPos = root and root.Position
                    local nearCamera = camPos and (tr.StartPos - camPos).Magnitude <= 12
                    if nearCamera or not myPos or (tr.StartPos - myPos).Magnitude > 2 then
                        local s2, onS = BT_WorldToScreen(tr.StartPos, cam)
                        local e2, onE = BT_WorldToScreen(drawEnd, cam)
                        if onS and onE then
                            local sx, sy = s2.X, s2.Y
                            local ex2, ey = e2.X, e2.Y
                            if sx == sx and sy == sy and ex2 == ex2 and ey == ey
                                and math.abs(sx) < 20000 and math.abs(sy) < 20000
                                and math.abs(ex2) < 20000 and math.abs(ey) < 20000 then
                                local dx = ex2 - sx
                                local dy = ey - sy
                                local len = math.sqrt(dx * dx + dy * dy)
                                if len > 0.1 and len < 3000 then
                                    local fv2s = Vector2.new(sx, sy)
                                    local fv2e = Vector2.new(ex2, ey)
                                    tr.Outline.From = fv2s
                                    tr.Outline.To = fv2e
                                    tr.Outline.Transparency = fadeAlpha
                                    tr.Outline.Visible = true
                                    tr.Line.From = fv2s
                                    tr.Line.To = fv2e
                                    tr.Line.Transparency = fadeAlpha
                                    tr.Line.Visible = true
                                    visible = true
                                end
                            end
                        end
                    end
                    if not visible then
                        tr.Outline.Visible = false
                        tr.Line.Visible = false
                    end
                else
                    local drawEnd = BT_GetDrawEnd(tr, age)
                    if tr.Attachment0 then tr.Attachment0.WorldPosition = tr.StartPos end
                    if tr.Attachment1 then tr.Attachment1.WorldPosition = drawEnd end
                    tr.Beam.Transparency = NumberSequence.new(1 - fadeAlpha)
                end
            end
            i = i - 1
        end
    end

    local function BT_Hook()
        if BT_Hooked then return end
        pcall(function()
            local TracerEffect = require(lplr.PlayerScripts.Modules.TracerEffect)
            local originalPlay = TracerEffect.Play
            TracerEffect.Play = function(self, tracerData, config, extraData)
                if BT_Enabled and tracerData and tracerData.IsLocal and tracerData.RaycastResults then
                    local mPos = BT_MuzzlePos()
                    if mPos then
                        for _, hit in ipairs(tracerData.RaycastResults) do
                            if hit.Position then
                                BT_MakeTracer(mPos, hit.Position)
                            end
                        end
                    end
                end
                return originalPlay(self, tracerData, config, extraData)
            end
            BT_Hooked = true
        end)
    end

    local function BT_Start()
        if BT_DISABLE then
            BT_Enabled = false
            return
        end
        BT_Hook()
        if not BT_Connection then
            BT_Connection = runS.RenderStepped:Connect(BT_Update)
        end
    end

    local function BT_Stop()
        if BT_Connection then
            BT_Connection:Disconnect()
            BT_Connection = nil
        end
        for _, tr in ipairs(BT_Tracers) do
            BT_Destroy(tr)
        end
        BT_Tracers = {}
    end

    local BulletTracerGroup = Tabs.Visuals:AddRightGroupbox("Bullet Tracer", "crosshair")
    BulletTracerGroup:AddToggle("AEVYX_BULLET_TRACER", {
        Text = "Enable",
        Default = false,
        Callback = function(value)
            BT_Enabled = value
            if value then BT_Start() else BT_Stop() end
        end,
    })
    BulletTracerGroup:AddDropdown("AEVYX_BULLET_TRACER_STYLE", {
        Text = "Style",
        Values = { "Line", "Beam", "Lightning", "Heartrate", "Chain", "Glitch", "Swirl", "Neon", "Plasma", "Laser" },
        Default = "Line",
        Callback = function(value)
            BT_Style = value
        end,
    })
    BulletTracerGroup:AddLabel("Color"):AddColorPicker("AEVYX_BULLET_TRACER_COLOR", {
        Default = BT_Color,
        Callback = function(value)
            BT_Color = value
            for _, tr in ipairs(BT_Tracers) do
                if tr.IsLine then
                    if tr.Line then tr.Line.Color = value end
                elseif tr.Beam then
                    tr.Beam.Color = ColorSequence.new(value)
                end
            end
        end,
    })

    BulletTracerGroup:AddSlider("AEVYX_BULLET_TRACER_DURATION", {
        Text = "Duration", Default = BT_Duration, Min = 0.1, Max = 10, Rounding = 1,
        Callback = function(value)
            BT_Duration = value
            for _, tr in ipairs(BT_Tracers) do tr.Lifetime = value end
        end,
    })
    BulletTracerGroup:AddSlider("AEVYX_BULLET_TRACER_SIZE", {
        Text = "Size / Thickness", Default = BT_Size, Min = 0.5, Max = 5, Rounding = 1,
        Callback = function(value)
            BT_Size = value
            for _, tr in ipairs(BT_Tracers) do
                if tr.IsLine then
                    if tr.Outline then tr.Outline.Thickness = 4 * value end
                    if tr.Line then tr.Line.Thickness = 2 * value end
                elseif tr.Beam then
                    local baseW = BT_Style == "Laser" and 0.02 or 0.15
                    tr.Beam.Width0 = baseW * value
                    tr.Beam.Width1 = baseW * value
                end
            end
        end,
    })
    BulletTracerGroup:AddSlider("AEVYX_BULLET_TRACER_FADE", {
        Text = "Fade Time", Default = BT_FadeTime, Min = 0, Max = 2, Rounding = 1,
        Callback = function(value)
            BT_FadeTime = value
            for _, tr in ipairs(BT_Tracers) do tr.FadeTime = value end
        end,
    })
    BulletTracerGroup:AddSlider("AEVYX_BULLET_TRACER_LERP", {
        Text = "Lerp Speed", Default = BT_LerpSpeed, Min = 0, Max = 5, Rounding = 1,
        Callback = function(value)
            BT_LerpSpeed = value
        end,
    })

    task.defer(function()
        BT_Start()
        for _ = 1, 30 do
            if BT_Hooked then break end
            BT_Hook()
            task.wait(0.5)
        end
    end)
end


local MainGroup = Tabs.Main:AddLeftGroupbox("Features", "boxes")
MainGroup:AddToggle("AEVYX_COUNTER", {
    Text = "UE Counter",
    Tooltip = "Temporarily move above a vulnerable enemy within 9 studs",
    Default = false,
    Callback = function(Value)
        AevyxCombatFeatures.Counter = Value
    end,
})
MainGroup:AddToggle("AEVYX_NO_RECOIL", {
    Text = "No Recoil",
    Default = false,
    Callback = function(Value)
        AevyxCombatFeatures.NoRecoil = Value
    end,
})
MainGroup:AddToggle("AEVYX_ANTI_FLASHBANG", {
    Text = "Anti Flashbang",
    Default = false,
    Callback = function(Value)
        getgenv().eteritum.guns.no_muzzle_flash = Value
        applyAevyxAntiFlashbang()
    end,
})

MainGroup:AddToggle("THIRD_PERSON", {
    Text = "Third Person",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_THIRD_PERSON = Value
    end,
})

MainGroup:AddDivider()

MainGroup:AddToggle("NO_SPREAD", {
    Text = "No Spread",
    Tooltip = "Remove weapon spread",
    Default = false,
    Callback = function(Value)
        getgenv().eteritum.guns.no_spread = Value
        setupNoSpread()
    end,
})

MainGroup:AddDivider()


local LunaraGameplayState = getgenv().LunaraGameplayState or {
    MaxAccuracy = false,
    RapidAttack = false,
    AntiKatana = false,
    AutoTarget = false,
}
getgenv().LunaraGameplayState = LunaraGameplayState

MainGroup:AddToggle("LUNARA_MAX_ACCURACY", {
    Text = "Max Accuracy",
    Default = false,
    Callback = function(Value)
        LunaraGameplayState.MaxAccuracy = Value
        getgenv().CombatMods = getgenv().CombatMods or {}
        getgenv().CombatMods.MaxAccuracy = Value
    end,
})

MainGroup:AddToggle("LUNARA_RAPID_ATTACK", {
    Text = "Rapid Attack",
    Default = false,
    Callback = function(Value)
        LunaraGameplayState.RapidAttack = Value
        getgenv().CombatMods = getgenv().CombatMods or {}
        getgenv().CombatMods.RapidAttack = Value
    end,
})

MainGroup:AddToggle("LUNARA_ANTI_KATANA", {
    Text = "Anti Katana",
    Default = false,
    Callback = function(Value)
        LunaraGameplayState.AntiKatana = Value
    end,
})

MainGroup:AddToggle("LUNARA_AUTO_TARGET", {
    Text = "Auto Target",
    Default = false,
    Callback = function(Value)
        LunaraGameplayState.AutoTarget = Value
    end,
})

local LunaraTripmineState = { Enabled = false, Root = nil, RootConn = nil, DetectConn = nil }
local function LunaraTripmineRefreshRoot()
    local player = game:GetService("Players").LocalPlayer
    LunaraTripmineState.Root = player.Character and player.Character:FindFirstChild("HumanoidRootPart") or nil
end
local function LunaraTripmineDetect()
    if not LunaraTripmineState.Enabled then return end
    local root = LunaraTripmineState.Root
    if not root or not root:IsA("BasePart") then return end
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "SubspaceTripmineHitbox" then
            local hitbox = obj:FindFirstChild("Hitbox")
            if hitbox and typeof(firetouchinterest) == "function" then
                pcall(function()
                    firetouchinterest(root, hitbox, 1)
                    firetouchinterest(root, hitbox, 0)
                end)
            end
        end
    end
end

MainGroup:AddToggle("LUNARA_ANTI_TRIPMINE", {
    Text = "Anti Subspace Tripmine",
    Default = false,
    Callback = function(Value)
        LunaraTripmineState.Enabled = Value
        if LunaraTripmineState.RootConn then
            LunaraTripmineState.RootConn:Disconnect()
            LunaraTripmineState.RootConn = nil
        end
        if LunaraTripmineState.DetectConn then
            LunaraTripmineState.DetectConn:Disconnect()
            LunaraTripmineState.DetectConn = nil
        end
        if Value then
            LunaraTripmineRefreshRoot()
            LunaraTripmineState.RootConn = game:GetService("RunService").Heartbeat:Connect(LunaraTripmineRefreshRoot)
            LunaraTripmineState.DetectConn = game:GetService("RunService").Heartbeat:Connect(LunaraTripmineDetect)
        else
            LunaraTripmineState.Root = nil
        end
    end,
})


local AimbotGroup = Tabs.Main:AddLeftGroupbox("Aimbot", "crosshair")

AimbotGroup:AddToggle("AEVYX_AIMBOT_ENABLED", {
    Text = "Enable Aimbot",
    Default = false,
    Callback = function(Value)
        AimbotConfig.Enabled = Value
        GlobalSettings.ENABLE_AIMBOT = Value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotGroup:AddToggle("AIMBOT_SHOW_FOV", {
    Text = "Show FOV Circle (Red)",
    Default = false,
    Callback = function(Value)
        AimbotConfig.ShowFOV = Value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotGroup:AddSlider("AIMBOT_FOV", {
    Text = "FOV Radius",
    Default = 250,
    Min = 30,
    Max = 500,
    Rounding = 0,
    Suffix = "px",
    Callback = function(Value)
        AimbotConfig.FOV = Value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotGroup:AddSlider("AIMBOT_SMOOTH", {
    Text = "Smoothness",
    Default = 6,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(Value)
        AimbotConfig.Smooth = Value
    end,
})

AimbotGroup:AddDropdown("AIMBOT_HIT_PART", {
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
    Text = "Hit Part",
    Callback = function(Value)
        AimbotConfig.HitPart = Value
    end,
})

AimbotGroup:AddDropdown("AIMBOT_TRIGGER", {
    Values = {"Always On", "Left Click", "Right Click"},
    Default = "Always On",
    Text = "Trigger",
    Callback = function(Value)
        AimbotConfig.Trigger = Value
    end,
})

AimbotGroup:AddToggle("AIMBOT_TEAM_CHECK", {
    Text = "Team Check",
    Default = false,
    Callback = function(Value)
        AimbotConfig.TeamCheck = Value
    end,
})

AimbotGroup:AddToggle("AIMBOT_VISIBLE_CHECK", {
    Text = "Visible Check",
    Default = true,
    Callback = function(Value)
        AimbotConfig.VisibleCheck = Value
    end,
})

AimbotGroup:AddToggle("AIMBOT_PREDICTION", {
    Text = "Prediction",
    Default = false,
    Callback = function(Value)
        AimbotConfig.Prediction = Value
    end,
})

AimbotGroup:AddSlider("AIMBOT_PREDICTION_AMOUNT", {
    Text = "Prediction Amount",
    Default = 0.12,
    Min = 0.01,
    Max = 0.5,
    Rounding = 2,
    Suffix = "s",
    Callback = function(Value)
        AimbotConfig.PredictionAmount = Value
    end,
})



local AimbotFOVGroup = Tabs.Main:AddLeftGroupbox("Aimbot FOV", "circle")

AimbotFOVGroup:AddToggle("AIMBOT_FOV_FILL", {
    Text = "FOV Fill",
    Default = false,
    Callback = function(value)
        AimbotConfig.FOVFill = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_FILL_TRANSPARENCY", {
    Text = "Fill Transparency",
    Default = 75,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(value)
        AimbotConfig.FOVFillTransparency = value / 100
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddLabel("Fill Color 1"):AddColorPicker("AIMBOT_FOV_FILL_COLOR_1", {
    Title = "Fill Color 1",
    Default = AimbotConfig.FOVFillColor1,
    Callback = function(value)
        AimbotConfig.FOVFillColor1 = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddLabel("Fill Color 2"):AddColorPicker("AIMBOT_FOV_FILL_COLOR_2", {
    Title = "Fill Color 2",
    Default = AimbotConfig.FOVFillColor2,
    Callback = function(value)
        AimbotConfig.FOVFillColor2 = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddLabel("Border Color 1"):AddColorPicker("AIMBOT_FOV_BORDER_COLOR_1", {
    Title = "Border Color 1",
    Default = AimbotConfig.FOVBorderColor1,
    Callback = function(value)
        AimbotConfig.FOVBorderColor1 = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddLabel("Border Color 2"):AddColorPicker("AIMBOT_FOV_BORDER_COLOR_2", {
    Title = "Border Color 2",
    Default = AimbotConfig.FOVBorderColor2,
    Callback = function(value)
        AimbotConfig.FOVBorderColor2 = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_FILL_ROTATION", {
    Text = "Fill Angle",
    Default = 0,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = "°",
    Callback = function(value)
        AimbotConfig.FOVFillRotation = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddToggle("AIMBOT_FOV_FILL_ANIMATED", {
    Text = "Animated Fill",
    Default = false,
    Callback = function(value)
        AimbotConfig.FOVFillAnimated = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_FILL_SPEED", {
    Text = "Fill Rotation Speed",
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Suffix = "x",
    Callback = function(value)
        AimbotConfig.FOVFillSpeed = value
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_BORDER_THICKNESS", {
    Text = "Border Thickness",
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(value)
        AimbotConfig.FOVBorderThickness = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_BORDER_ROTATION", {
    Text = "Border Angle",
    Default = 0,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = "°",
    Callback = function(value)
        AimbotConfig.FOVBorderRotation = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddToggle("AIMBOT_FOV_BORDER_SPIN", {
    Text = "Border Spin",
    Default = false,
    Callback = function(value)
        AimbotConfig.FOVBorderSpin = value
        IOInstance:UpdateFOVCircles()
    end,
})

AimbotFOVGroup:AddSlider("AIMBOT_FOV_BORDER_SPIN_SPEED", {
    Text = "Border Rotation Speed",
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Suffix = "x",
    Callback = function(value)
        AimbotConfig.FOVBorderSpinSpeed = value
    end,
})



local SilentAimGroup = Tabs.Main:AddRightGroupbox("Silent Aim", "target")

SilentAimGroup:AddToggle("ENABLE_SILENT_AIM", {
    Text = "Enable Silent Aim",
    Default = false,
    Callback = function(Value)
        Rivals.Silent.enabled = Value
        SilentAimConfig.Enabled = Value
        GlobalSettings.ENABLE_SILENT_AIM = Value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimGroup:AddToggle("ENABLE_AUTOSHOOT", {
    Text = "Autoshoot",
    Tooltip = "Automatically shoots when a target enters the FOV circle",
    Default = false,
    Callback = function(Value)
        SilentAimConfig.AutoShoot = Value
    end,
})

SilentAimGroup:AddToggle("SILENT_SHOW_FOV", {
    Text = "Show FOV Circle",
    Default = SilentAimConfig.ShowFOV,
    Callback = function(Value)
        Rivals.Fov.Enabled = Value
        SilentAimConfig.ShowFOV = Value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimGroup:AddSlider("SILENT_FOV", {
    Text = "FOV Radius",
    Default = SilentAimConfig.FOV,
    Min = 30,
    Max = 500,
    Rounding = 0,
    Suffix = "px",
    Callback = function(Value)
        Rivals.Fov.Fov = Value
        SilentAimConfig.FOV = Value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimGroup:AddSlider("AIM_CHANCE", {
    Text = "Aim Chance (%)",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(Value)
        SilentAimConfig.Chance = Value
    end,
})

SilentAimGroup:AddDivider()

SilentAimGroup:AddDropdown("SILENT_HIT_PART", {
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = "Head",
    Text = "Hit Part",
    Callback = function(Value)
        SilentAimConfig.HitPart = Value
    end,
})

SilentAimGroup:AddToggle("SILENT_TEAM_CHECK", {
    Text = "Team Check",
    Default = false,
    Callback = function(Value)
        SilentAimConfig.TeamCheck = Value
    end,
})

SilentAimGroup:AddToggle("SILENT_VISIBLE_CHECK", {
    Text = "Visible Check",
    Default = true,
    Callback = function(Value)
        SilentAimConfig.VisibleCheck = Value
    end,
})

SilentAimGroup:AddToggle("SILENT_PREDICTION", {
    Text = "Prediction",
    Default = false,
    Callback = function(Value)
        SilentAimConfig.Prediction = Value
    end,
})

SilentAimGroup:AddSlider("SILENT_PREDICTION_AMOUNT", {
    Text = "Prediction Amount",
    Default = 0.1,
    Min = 0.01,
    Max = 0.5,
    Rounding = 2,
    Suffix = "s",
    Callback = function(Value)
        SilentAimConfig.PredictionAmount = Value
    end,
})


local SilentAimFOVGroup = Tabs.Main:AddRightGroupbox("Silent Aim FOV", "circle")

SilentAimFOVGroup:AddDropdown("SILENT_FOV_MODE", {
    Text = "FOV Mode",
    Values = {"static", "follow muzzle", "enemy"},
    Default = 1,
    Multi = false,
    Tooltip = "static = screen center · follow muzzle = sticks to your gun muzzle · enemy = tracks the locked target",
    Callback = function(value)
        SilentAimConfig.FOVMode = value
        
        if IOInstance and IOInstance.SmoothCenters then
            IOInstance.SmoothCenters[SilentAimConfig] = nil
        end
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_SMOOTHNESS", {
    Text = "Follow Smoothness",
    Default = 6,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Suffix = "x",
    Tooltip = "How fast the circle glides to its target (lower = slower, smoother, more latency)",
    Callback = function(value)
        SilentAimConfig.FOVSmoothness = value
    end,
})

SilentAimFOVGroup:AddToggle("SILENT_FOV_FILL", {
    Text = "FOV Fill",
    Default = false,
    Callback = function(value)
        SilentAimConfig.FOVFill = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_FILL_TRANSPARENCY", {
    Text = "Fill Transparency",
    Default = 75,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(value)
        SilentAimConfig.FOVFillTransparency = value / 100
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddLabel("Fill Color 1"):AddColorPicker("SILENT_FOV_FILL_COLOR_1", {
    Title = "Fill Color 1",
    Default = SilentAimConfig.FOVFillColor1,
    Callback = function(value)
        SilentAimConfig.FOVFillColor1 = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddLabel("Fill Color 2"):AddColorPicker("SILENT_FOV_FILL_COLOR_2", {
    Title = "Fill Color 2",
    Default = SilentAimConfig.FOVFillColor2,
    Callback = function(value)
        SilentAimConfig.FOVFillColor2 = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_FILL_ROTATION", {
    Text = "Fill Angle",
    Default = 0,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = "°",
    Callback = function(value)
        SilentAimConfig.FOVFillRotation = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddToggle("SILENT_FOV_FILL_ANIMATED", {
    Text = "Animated Fill",
    Default = false,
    Callback = function(value)
        SilentAimConfig.FOVFillAnimated = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_FILL_SPEED", {
    Text = "Fill Rotation Speed",
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Suffix = "x",
    Callback = function(value)
        SilentAimConfig.FOVFillSpeed = value
    end,
})

SilentAimFOVGroup:AddLabel("Border Color 1"):AddColorPicker("SILENT_FOV_BORDER_COLOR_1", {
    Title = "Border Color 1",
    Default = SilentAimConfig.FOVBorderColor1,
    Callback = function(value)
        SilentAimConfig.FOVBorderColor1 = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddLabel("Border Color 2"):AddColorPicker("SILENT_FOV_BORDER_COLOR_2", {
    Title = "Border Color 2",
    Default = SilentAimConfig.FOVBorderColor2,
    Callback = function(value)
        SilentAimConfig.FOVBorderColor2 = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_BORDER_THICKNESS", {
    Text = "Border Thickness",
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Callback = function(value)
        SilentAimConfig.FOVBorderThickness = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_BORDER_ROTATION", {
    Text = "Border Angle",
    Default = 0,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = "°",
    Callback = function(value)
        SilentAimConfig.FOVBorderRotation = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddToggle("SILENT_FOV_BORDER_SPIN", {
    Text = "Border Spin",
    Default = false,
    Callback = function(value)
        SilentAimConfig.FOVBorderSpin = value
        IOInstance:UpdateFOVCircles()
    end,
})

SilentAimFOVGroup:AddSlider("SILENT_FOV_BORDER_SPIN_SPEED", {
    Text = "Border Rotation Speed",
    Default = 1,
    Min = 0.1,
    Max = 10,
    Rounding = 1,
    Suffix = "x",
    Callback = function(value)
        SilentAimConfig.FOVBorderSpinSpeed = value
    end,
})



local MusicPlayerGroup = Tabs.Misc:AddLeftGroupbox("Music Player", "music")

local YMP_SOURCE = [==[
getgenv().YMP_MIN = getgenv().YMP_MIN or false
if getgenv().YMP_MIN then return end
getgenv().YMP_MIN = true

local cloneref = cloneref or function(o) return o end
local HttpService  = cloneref(game:GetService("HttpService"))
local SoundService = cloneref(game:GetService("SoundService"))
local CoreGui      = cloneref(game:GetService("CoreGui"))
local UIS          = cloneref(game:GetService("UserInputService"))
local Players      = cloneref(game:GetService("Players"))

local IsMobile = UIS.TouchEnabled
local YMP_CFG  = getgenv().YMP_CFG

local request = (typeof(request) == "function" and request)
	or (typeof(http_request) == "function" and http_request)
	or (typeof(syn) == "table" and syn.request)
	or (typeof(http) == "table" and typeof(http.request) == "function" and http.request)

for _, fn in ipairs({ "writefile", "readfile", "isfile", "delfile", "listfiles", "makefolder", "isfolder", "getcustomasset" }) do
	if type(_G[fn] or getgenv()[fn]) ~= "function" then
		error("[YMP] Your executor is missing: " .. fn)
		return
	end
end

for _, f in ipairs({ "YMP", "YMP/Musics", "YMP/Cache", "YMP/Icons" }) do
	if not isfolder(f) then makefolder(f) end
end

local SAVE_NOW   = "https://p.savenow.to"
local SAVE_TOKEN = "dfcb6d76f2f6a9894gjkege8a4ab232222"
local LOADER     = "https://en.loader.to/"
local API        = "https://ymp-api.ddns.net"

local BLACK = Color3.new(0, 0, 0)
local WHITE = Color3.new(1, 1, 1)
local GRAY  = Color3.fromRGB(150, 150, 150)
local DARK  = Color3.fromRGB(24, 24, 24)
local TRACK = Color3.fromRGB(45, 45, 45)
local TABLINE = Color3.fromRGB(70, 70, 70)

local function buildAcceptLanguage()
	local loc = "en"
	pcall(function() loc = Players.LocalPlayer.LocaleId:lower() end)
	local a, b = loc:match("^(%a+)%-(%a+)$")
	if a and b then
		return a .. "-" .. b:upper() .. "," .. a .. ";q=0.9,en-US;q=0.8,en;q=0.7"
	end
	local base = loc:match("^(%a+)") or "en"
	return base .. "-" .. base:upper() .. "," .. base .. ";q=0.9,en-US;q=0.8,en;q=0.7"
end

local HEADERS = {
	["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36",
	["Accept-Language"] = buildAcceptLanguage(),
	["X-Requested-With"] = "XMLHttpRequest",
}

local dlog = {}
local function logln(s)
	dlog[#dlog + 1] = s
end

local function httpGet(url)
	local ok, res = pcall(function()
		return request({ Url = url, Method = "GET", Headers = HEADERS })
	end)
	if ok and res and type(res.Body) == "string" and #res.Body > 0 then
		logln("GET " .. url:sub(1, 70) .. " -> HTTP " .. tostring(res.StatusCode or "?") .. ", " .. #res.Body .. " bytes")
		return res.Body
	end
	local ok2, body = pcall(function() return game:HttpGet(url) end)
	if ok2 and type(body) == "string" and #body > 0 then
		logln("HttpGet " .. url:sub(1, 70) .. " -> OK, " .. #body .. " bytes")
		return body
	end
	logln("GET " .. url:sub(1, 70) .. " -> FAILED (both transports)")
	return nil
end

local function httpPost(url, body)
	local ok, res = pcall(function()
		return request({
			Url = url, Method = "POST",
			Headers = {
				["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8",
				["User-Agent"] = HEADERS["User-Agent"],
				["Accept-Language"] = HEADERS["Accept-Language"],
				["X-Requested-With"] = "XMLHttpRequest",
			},
			Body = body,
		})
	end)
	if ok and res and type(res.Body) == "string" and #res.Body > 0 then
		logln("POST " .. url:sub(1, 70) .. " -> HTTP " .. tostring(res.StatusCode or "?") .. ", " .. #res.Body .. " bytes")
		return res.Body
	end
	local ok2, resBody = pcall(function() return game:HttpPost(url, body, Enum.HttpContentType.ApplicationUrlEncoded) end)
	if ok2 and type(resBody) == "string" and #resBody > 0 then
		logln("HttpPost " .. url:sub(1, 70) .. " -> OK, " .. #resBody .. " bytes")
		return resBody
	end
	logln("POST " .. url:sub(1, 70) .. " -> FAILED (both transports)")
	return nil
end

local function cleanUrl(u)
	if not u then return nil end
	u = u:gsub("\\u0026", "&"):gsub("\\/", "/"):gsub("&amp;", "&"):gsub("\\u003d", "=")
	if u:sub(1, 4) ~= "http" then return nil end
	return u
end

local function extractAudioLink(body)
	if not body then return nil end
	local patterns = {
		'href=\\?"([^"<>\\]+%.mp3[^"<>\\]*)',
		'(https?://[^"\\<>%s]+%.mp3[^"\\<>%s]*)',
		'(https?://[^"\\<>%s]+%.m4a[^"\\<>%s]*)',
		'"download_url"%s*:%s*"(https?://[^"\\]+)"',
		'"url"%s*:%s*"(https?://[^"\\]+%.mp[^"\\]*)"',
	}
	for _, pat in ipairs(patterns) do
		local u = cleanUrl(body:match(pat))
		if u then return u end
	end
	return nil
end

local B64 = {}
do
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	for i = 1, #chars do B64[chars:sub(i, i)] = i - 1 end
end

local function base64decode(data)
	data = data:gsub("%s", ""):gsub("=+$", "")
	local out, buf, n = {}, 0, 0
	for c in data:gmatch(".") do
		local v = B64[c]
		if v then
			buf = buf * 64 + v
			n = n + 6
			if n >= 8 then
				n = n - 8
				out[#out + 1] = string.char((buf // (2 ^ n)) % 256)
				buf = buf % (2 ^ n)
			end
		end
	end
	return table.concat(out)
end

local ICONS_B64 = {
	play   = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAACDklEQVR42u2aQWoUQRSGv9c9yRGyyQHcuM8BJFeQbHMGQQQVFLPyBkFw6xECbly41oXmEgZcCyHdv4vUYCHqZGS66lX3+2Fo6EUP73vv/6kqCkKhUCgUCoVC/y9JnaQ+QEi9JFtU59PzoaQH2fvVIkBIWqXna93qjaTDfCKWAuC5fumbpGeS9rN86OYO4IWkUdKPDMRXSSfe82GXnTFgBQi4Ae4D7yS9l3RkZoOZyVs+TDGaaxBj+h0DHyW9lXRoZjcJRD9XAPm3O2AA9oBT4PM6H8xs8JAPJf68z2xxALwCPkk6MbPRzMaa+VCKvtt8KD1+7vKhq2g9F/lQe4FSPR88rNCq5oOnJWqVfPC4Ri+aD543KUXywfsubfJ8aGWbOlk+tLZP33k+tHpQsTEf5g7gX/nwQdJxCshuzgByEJZAABwB99K7jVo1XvyYWeIaOAdemtn3u36gVQBKxa9T/wJ4bGaXcHv+aGbDHAHkhffAZSr8Yl04MN61+NYADFnhV8AZcG5m1+uw26bwlgD8yednZna17bi3BmCjz7cd91YA7NznLQGYxOctAJjU554BFPG5RwBFfe4NQHGfewFQzee1AVT3eS0AbnxeA4Arn5cEMGZdd+PzEgCUur7v0eclAOylrn8Bnnjz+XQpl87hJT2S9DS7NTbfq3F/AWG/Q1mcFndPOBQKhUKhUKh1/QTDYTSsdRRXGwAAAABJRU5ErkJggg==]],
	pause  = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAABY0lEQVR42u2aMU7DQBBF3zimiAQScKJUHIeDcItcgpYLINHS5QAUNFSAMxRZSxaK8DoWQSLvSaso0e54/Xay1QcREREROU1izuLMbKcuiYhupGYDNBPrdhGRHucxOiAzIyIyM5fALbAEcqTWtpzqJiLWfY3vJx8R28xcAavBmh+3U567johNX+NXjWVmlM/rnM7joM33/p0y8+6Aujdl7WLq+7RzXAAvwFVFB3TAAnitqPsGfJYxtr++S94PfYl2ZkO0ZYwJiCKg5oSawb5qBRx8mTenfgkqQAEKUIACFKAABShAAQpQgAIUoAAFKEABClCAAhSgAAUoQAEKUIACFKCA/8/chEhXRk1EBnaJjjG2g7pRMTfLOLqAAC6pi730c84r5i6pj9P0c87+QsAHcA9cUB+Seirf951Y/9sz8DBYM9YBDbuwFnM64WSZG5WdfImOBRlLDnHqvtKorIiIiIhM4ws+ns248/2cwwAAAABJRU5ErkJggg==]],
	next   = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADHUlEQVR42u2av48NURzFP2dmVqFBaTuFVZP4VagUi79glfR+JBoJjdBIVFaLkkrpR0IiUciS0FDYRqe2xYbEm3cU7o3J5O2y67074+09ycstZubd7z33zPfc770DGRkZGRkZGRkZGVsS2sxDtgUgyV0FbrtYI35LGqYMYusowLYk2fZO4Luk77YroE6lhkYM+4GdI275Kul9vG/cnZehPWH7ne1D7WupVGf7tUfj9UbUuVkJfwP2A69sX7e9Q1Jtu4r5IQFWgSHwo9WubuRPNktAETorgavAG9vzkgZBnlUCAop1fhMnID4rYADMAU9t37M9K2lgu/gfkuQ4AqyCGobAGeCt7bOShpKGidTQKQFNOQ6AWeCu7ae25yQN+myZ4w6qAhyImA+54artmaCGMmGS7ISAuLaogBrYAVwPbnFYUh2SZDnNBESUDTUcDiTcblhmL9Qw6fdSjSQ5A5wLr8XJhhqqaSag3U8dLPOx7Qd9sMzUnZYNy1wIlnmmS8ssOiK9CGqYBe6NsMxymgkYlSTblpksSXa9OFnLMo+nssy+rM7alvk8lWX2aXmqVl0RLXMhqmHaCRhVV8wBD2w/sr0vqEDTTkB7zwHgKLC7oZSpJiDmgmiVi8BeSS/D9bHu+PatVq9DQqyAJeCCpKVYTofFkqaRAPN7i20FuAXclPQj2OBwUnv9fSBgEOIogSfARUnLjVmvp3UdEO2uAr4ApyWdkrQca4IUJzxFh7Me7e4+cFDSw1gVxpogBaoOZr0I/S4D5yU9iwXQpOXepQIcMnzBrwOMG8AhSc/iYUoXg0+lgGht5QhrK1PKPbUC3Bj8CnAeOCZpqetZT6GAP1nbgJ5g3ApYz9rKVNbWBQH+C2ur6SHG8Qo01+8fgUtdW1sqBcRZL0N7DTgQrK3sS5KblAKGoS7fBrwArrSsLcXA60B83XCc2E6cgO38+hLjsqQ7YeDxW6FUs74rxF+1xrJrkgTEDP4JOCLpQzzRSWhtcW9wEdjTWF7H9nPrvglG0qNT3s3iXz6UVJeeHshf60PJmoyMjIyMjIyMjIyM9fATvv7yAH4WeusAAAAASUVORK5CYII=]],
	prev   = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADIElEQVR42u2avYsUWRTFf6eqRg2EWQUVhAVNJtlIWB1QjAZU9B/QUPMxWlgWdgPxIzNRc9P5A0QRzJdhA/MJRSYwE2EX1646BnMbHo2zO90z9WH3O/B4dFdX1b3n3nfPq9sFGRkZGRkZGRkZGQsJTfNj28Vu50iq+3TEtiR54SJoW7bVagaM2bV9FjgDeOLcEfCnpFHHzlfje9o+KelDazeK+ZG/jc+2j4/J6sDxIpYjtk/ZfmH7YWrrXlFMee/PQAP8G3Md86fIiq6i3khqbN8G/gJuhG1To5phyRTJcPJd246XkmpJI9srwBPgahyuZ7Wh+h6KHFBIqm0vAb8CvwDLUXsMLM16/Wrgzpchr7XtNeAhsJpEvQoSmCsCJqK+DNwH1hPFKWPsG9UAnR9LW237JnAPWIlie+A2VwNyvIgd5cj2aeAxcDOJeiu2FkNI9wlpWwfehvNNjNYCVfXs/LjIjWz/FFFPpa1s24aqr6gnRa4Cfgd+Aw4lml52YUvVY9R3k7ayS3uqDh0vdmpc+9I2OAImntpal7bBEDAhbSvheOvSNggCJqK+Him/HOtcQ9mDtGZERH01itxaX0WuDwJk+1jI2jpwuGtpG8JO8ChwMZxPewksBAGS3km6FBnwISLfJFV/rgnwuFMr6RlwDthIukijRcgARxe5krQt6RZwC9hK6k4zzzUgVQLF9ncDuAA8Bb4k2eC5JSDJhjpI+CjpLnAZ2IxsUKjEfBKQEFEn2bAZJPwBfIwi2Us2dNoQSbKhkPRF0oNYFq/7yoZeOkKSmmS7vCXpGnAH2O5aMnttiUWRLCIjngPnJySznmsCxtkQvcBUMq+HZJZtS2bvBOwima+6kszBENCXZA6KgCkksz6obBgkAf8jma+CBB3Ec8VgCfgPybwezxXbsSz2JZnTEtAE698aXUrmRkjmc3b+Gp/5KXNaAo4G60diXor5RBcNj0Qyy5DMO8AV4D3wwyzXrKaIPMBL4O/4nL4h8k+MToskUEp6Y/tn4Mc4XLNIsL2vPuMsL0oWu63RHknQjglqyMjIyMjIyMjIyMjYC74CFYy9pkEKdlIAAAAASUVORK5CYII=]],
	close  = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAACeElEQVR42u2avW4TQRSFZzamQEIiiZCQqHgDpIAbCgTPQsJD8CSQPEc6EG34k+ioEBUVkaGKkni9XwpmxGTk9drrubMZ655m1pI3957Pu9frMzFGpVKpVCqVSqXqLaACbOaaW7lrtpoPjm2mmjZ3zbZGRm7dAx7EQCSMe8PAa+C+dM1lzD8BzoBvwI5UQ878ljt+wz+dALvZIQTmx8CE//okASEyf+hqnUvWXDh85pifAVOJhlrMX7p1Xk0rPvCAx5F5FjRUJTY/5br864/AvXBOiHzVBfd8bD4phCXNe1249T0w8ueJTGDgIfC1o6G1IKxovnbrKfDMnVtJ3QL+K2jbmUsOYUXz/gqcAOMsgzCYAzupISQwP8r69JcSQjHmJSAUZz4lhGLNJ4Rwq1jzCSDcdecdFWt+TQgfgLfFm+8JYdZyXKb5NSDUG2O+J4TNMt8BYbaE+catf4o1PwfCLvDOmZt1mG+An8BeDvOVPANG1tqJMeaHMcYaY1j0freeGmO+u+Om1E8/fMI7WuEW8O/5kjXqEjR/2GMI1oPkfQOYXzQTpsVB6GG+60GoHAg9f9X9CuK1ulgIa/ykfQTcBj5LZow31fw4+BvJ47UizLsIuyoSQsokpzgIEjFWMRAkM7wbDyH6xwSRDC8BBCv5yVfAHekYqycE8c1Rf9m/CLaoG6kwY0UI8pujUVMvg6e3RirJWRJCvs3R6Eo4iCCIxFgdEOrsm6OhsQDCpWSG1wLhYtDcMICw7xr5K9lIBOHE1fw9aG4YQHgFPJduJICwDRwDTwcPTaNd3ipDPdtWv49swsGItbbJBN33bXPVVKlUKpVKpVJtmq4A/HnJJQZ8k8wAAAAASUVORK5CYII=]],
	search = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAEfUlEQVR42u2aT4gcRRTGv5qZXZEkbjZqBBGDMesf4kmSIF68RPci4kHFi8fcA3oSwRwDIrnGBES8iHgSFHJYREVIjHowKkQwIv4JqInrXpLdzEz/PKQePMrq2Z5kZrd3th803dNUV9X31auq974aqbHGGmusscYaa2yTWhhHpUCQ1Ir1Ey+zlhWTVIQQmBg2gRbQGfKbTiRs43qAjXgIoR9/b5N0QNJjku6XtCuOeJB0TtIvkk5L+sZ907bnDTfq7vkR4A3gN6rZt8ArwE7nQWEjgW/H+xRwBFhx4PpAN149d9m7wpX9A3gxR+pGAD8HfOHApOAGmZFkdhK4rfYkWOeA/cDlVYAXiQeUlTEivgR2AKGW08GB3w3848CnNsgTjIzUrsX7aaAdr1An8CEuVFPAGQcmHU0P/G/gc+AT4Czwb0JEGQnH/FSr27w/UjLyfff8LvAksD2p407gJWDBfVNkvAfgYG1IcK7/cByldD4b+MvAfCZA+t8WBxwu8Rqr60fg1lqsBxbhAW9mRt8AXAL2u62xnQEdYvRn3nTILZRkpsfT6+4FBgKYAS6WjFjXuexUxfVkOplSvYSAAvho3bdFN1oHM3PdPOG9quATEtrRWy4kdRvBi8AdfiBGaVVZtYb3xXuR1NGT9FbsYFE5EbmeCYYQQlfSOy5LtDYLSTOS5obs78gJsE49lHnfkrQo6esIqBjewQiSFlzC5OsPrt2w3gTsTjpiYM9Lugq0biC/N03ggqSl2CeSdveMa3oP61LXSt6vjCCVXR7gPSt1IaBTsjbMxMXvZtSd7ZKmKra75gRYue8yC5UkPShpawiBG1ipLUCak7QtekFI6j+XtLtuHvBTxgP6krZKsuhv6IAlrgHPZUC2Yv0/j4uAYcPgfcke7YOXz4bV+Cw8jvnBpSTAsvtFYMu44oBhM8FbgO9j5/oZEg7HstOrddYLqMAHmUjQ0umTtUiIXGdfLskFrPOH0pjfkpkIuu2VY+BESWpsvw/UhQADsRP4M3pAPyHBfr9ucf6A+u4G3l8F/IIJI3XTA15IxIucGHI+EvFEJG0WuBd4Ko76XwMElR5wFbgnTcjqRMLbJSTkQC3FpObKKuUKV9+zwF7gFDBTG6HUZXBbosRVRoKlyP0M6Jxe6IXRo8B9cWcwoXS2TiTYtrjDSeL9DNh0agwSSXHg9zjB1c4aztaVhA5wLKP4FhXOBHqOtCXgeeCBOF08Md26khDc83yMEXIgu8kpUUrOqQj80Qx4ak+CWxingWeAD92BSZn9GneDx11dnyZuz7hJCKPcHXxKDNwuaW/UENLT4d8l/RBCuOJABEmzkj7W9ZPlXkkWaO+/kjQfQliMOkRRpx2iVZU05z0mvM663aW7Vp4wTjI6yVV65OUW1skg4SZ3l4aEhoSGhIaEhoQRkRA2KwlngF0b7t9nIyJhOd5fq4WktsYkmD5xfJjIdFJIMPAnvJapSbMSEpYT8O2JBF+iTNm/1o5vCvAZEu4CXp1ot6+oTG0e4GXKVGONNdZYYxXtP8h13Ep3Eh0VAAAAAElFTkSuQmCC]],
	music  = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADyklEQVR42u2avYvUUBTFz8uMioqrg9ssiCJW2ina2Io2gmBhI1j4H4jYa2ch+AcIIjYWgqBipYXVqlgoKlbiB34g+LHgqoW7SX4W3oePmHGymdlNMpsDQ2YyyXu559373rn3RWrRokWLFi2WLdxSdAIM7Mc5x9gSUJCkyJ4nXUoy3BKN/oSkSBKZPr2hOOe+Bfd07Vyy2M/XXUzDbSTXS3psx35IgHuSLkq665z7HpDXkZRUFSJDxz3QA2YpjnfAOWBvNkSATpH5pI4EfAVSILFj3ie2/0NMA6eATZm2u0CnSQTMmEFpAQ9IgfnMtbPADeAQsC7sw8hw40RAiNjIaF6IjIiA0CsWFCLjRkCpEBlXAgaFyHvgLLDa5ghXiRDyOgDoSXopqZcjhEbWnaTUvnfs96RzbibQI7mIajRvxoERZRRtx+xJJX0JVGY1SnAIVYqkxIwpM0DRQuyqiwf8kHRF0lsbzW6QO8RGCIvJemVzpRk8J+mYpFWSdko6LOmgpO2ZZ4zt+qhOmewwq4D/PQNMZu7vAHtsnZ+2GT+7AmS1Qdher2gtoi4E9AJp281pbwdwAriek1wlthzGjSYgc58zefuP1gc2AceBayaNs21+ajwBeRUjIyPKnJ8wBXgJeBO0XYiArhoC51zqdYKREFnVaFbSTUk3gTU2iR5YrFWjMg/4Xz82YZaqDzTGAwZUk5OAvOjPaRcvCwL6kdE0JVgZWgJaApY5RjIJhrNv5nwy1gR4w20LK+lzTWcsCQAiU2eJGblL0l5JG+ySZ5IeSPpcuSobNQFAxzmXABOSTko6ImlHzqWzku5LWhmUrpoN79LATuBRTrl6PpOaDipxV5q+dku4fQLslnRbfyq98/pbkOzmVHxS+z9Eav/5ilBS+xAIkpuNkq6a8bGkFf9TpznG5y2/G6oKj4V4gB/985K22sivKFkDfCJpJjj/3dqrfX1vCvgRbHMvFH4X50zTlKB34/2S1qr8Do/v7yiwyufx2SpPHQkgIEBDrOu+1r9F0jYTUJieaAQBm0ewnmO6YKoO2qDNBosWW+z4dsgQ8G3NSfo4graWnIA7Q7ptave+lvTCtq7TJhCQBAT8NCMoSYAk3XLOzfcRSbXPAS7bWj5X8j2fGNjupXWTCPBbVRuBVxlhU8T4X/b9RBPqBH2TITvuDjY75nLe3sobdYALjTV+BOnwaU9iY153LUDCBHAGeN7HA77Z62v76mq8GyYc/BLWpyT2VNJD59yHsIo0VirKb0wOIqrOMe9GRYT+LYtTdaLTokWLFi0G4DcHSVgRe8KLsgAAAABJRU5ErkJggg==]],
	trash  = [[iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAADTUlEQVR42u1av2/TQBT+nu2IgJQGUMPMn0AHhFAHVAESMDEwIrF3RGJnYQMmxF7EgsTOyApDlY6MLAhEC5S20KAk/hh4p1xNm5wd5+I090mWz/f84/m753d3nw8ICAiYZ4ivB5GMcjkmkobmOQ4RQFJEhCSfAFgC0AcQH3W6+rQL4K6I7JrrJ+Vf4olkAlgGcMnxmh6Amo8ISDxG2562vksEbGt54ojmPQckOb7lomTFJAGgqS0fO1xzVq+LAAj1BnnTj0vucCZgjG4pVQLfAPisx9GIT2APwLdJJj+nXsDK4A0ALwE0LCfzYl+/f1e/ThV8jiH4vohskIyGNZ5rBNQA3PKcNMdFy6WRXV+ImpnPjBEBvmAioFt2N2gSWNUJECVAyiYg1W0WIgCu44gkB6uNGRk3RHneLRnR9RkWdwBcm7EkuJGJiICxZoMkYysy+lV8GdtHAKnLQEpyPiASkZTkBQBPR4zqfMFMrtZEZI1knKeBkoIR0wKwUrEAeF+kUYsmta4yX4UI6Ol77PvUA0TDTjIEpJ7m8XFmlBoXbYiyu7WZ0xfKIsCMDts6ZzCqTteaTDWt6BAAv3UzxJ3WvblXF8BPDCS1pt4nAXC5LN/LJmBVRN5pj3EHwHm1fxSR15ke5SKAK3rYEZFnGXsLwD0rz7wQka8k6wA+qWhCr+Fi+lmSK/yHfmZ/lWSkW5sDtLWuRvKElh/zIFpab+w3MvabWn+O5HetS0l2tfxQfUummQNSIz6Q3NIMDQBbOn4wUlVKcsey/wDQ0/q+7jtq72rod7Q+rWIOOCpTJ4dkbTthJkP8EK2n7icyA517VTgQEAgIBAQCAgGBgEBAICAQEAgIBMwnJjkb7FvT3cNk6tSy944QWXq6yaTEj9I1QWspzaJ1/0Wtj/WcFMCCZW8BSMw5aq+r3ZxTV3tUZQJ+WYLIIxyUxMzfZaj9FYAvetgRkU0t/1H7OoAHGEhi65aQwqoRYMSK5yS38b8oukxyFUNEUZK3MVwUvU7SiKILmedWhoCleU+C0/gxMhUCiMGvMU6h4fqZsqDgOoCiBNTgvujRVzSc9EGAae1NAG9Rrd/jHzI+BuTJ3vnCgBRUb6UYfSytDQgICAgICAg4NvgLp1W396LRkU4AAAAASUVORK5CYII=]],
}

for name, data in pairs(ICONS_B64) do
	local p = "YMP/Icons/" .. name .. ".png"
	if not isfile(p) then
		writefile(p, base64decode(data))
	end
end

local function icon(name)
	return getcustomasset("YMP/Icons/" .. name .. ".png")
end

local function draggable(guiObj)
	local drag, startPos, startInput
	guiObj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			drag = true
			startInput = input.Position
			startPos = guiObj.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then drag = false end
			end)
		end
	end)
	guiObj.InputChanged:Connect(function(input)
		if drag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - startInput
			guiObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

local function fmt(t)
	if type(t) == "string" and t:find(":") then return t end
	t = math.floor(tonumber(t) or 0)
	return string.format("%02d:%02d", t // 60, t % 60)
end

local LIB_PATH = "YMP/library.json"
local library = {}

pcall(function()
	library = HttpService:JSONDecode(readfile(LIB_PATH))
end)
if type(library) ~= "table" then library = {} end

local function saveLibrary()
	pcall(function()
		writefile(LIB_PATH, HttpService:JSONEncode(library))
	end)
end

local INNERTUBE_KEY = "AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8"

local function searchYouTube(query)
	local ok, res = pcall(function()
		return request({
			Url = "https://www.youtube.com/youtubei/v1/search?key=" .. INNERTUBE_KEY,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode({
				context = { client = { clientName = "WEB", clientVersion = "2.20241025.01.00" } },
				query = query,
			}),
		})
	end)
	if not ok or not res or not res.Body then return {} end

	local ok2, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not ok2 then return {} end

	local out = {}
	local sections = data.contents
		and data.contents.twoColumnSearchResultsRenderer
		and data.contents.twoColumnSearchResultsRenderer.primaryContents
		and data.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer
		and data.contents.twoColumnSearchResultsRenderer.primaryContents.sectionListRenderer.contents
	if not sections then return out end

	for _, section in ipairs(sections) do
		local itemSection = section.itemSectionRenderer
		if itemSection and itemSection.contents then
			for _, item in ipairs(itemSection.contents) do
				local vr = item.videoRenderer
				if vr and vr.videoId then
					local thumbs = vr.thumbnail and vr.thumbnail.thumbnails
					table.insert(out, {
						id = vr.videoId,
						title = (vr.title and vr.title.runs and vr.title.runs[1] and vr.title.runs[1].text) or "Untitled",
						duration = vr.lengthText and vr.lengthText.simpleText or nil,
						thumb = thumbs and thumbs[#thumbs].url or nil,
					})
				end
			end
		end
	end
	return out
end

local function searchFallback(query)
	local ok, res = pcall(function()
		return request({ Url = API .. "/searchfree/" .. HttpService:UrlEncode(query), Method = "GET" })
	end)
	if not ok or not res or not res.Body then return {} end

	local ok2, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
	if not ok2 or type(data) ~= "table" then return {} end

	local out = {}
	for _, item in ipairs(data) do
		local id = item.id or item.videoId or item.video_id
		if id and item.title then
			table.insert(out, {
				id = id,
				title = tostring(item.title),
				duration = item.duration,
				thumb = item.thumbnail or item.thumb,
			})
		end
	end
	return out
end

local function svcLoader(videoUrl, videoId, statusFn)
	local page = httpGet(LOADER .. "ajax/download.php?start=1&end=1&format=mp3&url=" .. HttpService:UrlEncode(videoUrl))
	if not page then return nil end
	local jobId = page:match('"id"%s*:%s*"([^"]+)"')
	if not jobId then
		logln("loader.to: no job id in response")
		return nil
	end
	for i = 1, 25 do
		task.wait(1)
		if statusFn then statusFn("loader.to " .. i .. "s") end
		local body = httpGet(LOADER .. "ajax/progress.php?id=" .. jobId)
		if body then
			local u = extractAudioLink(body)
			if u then return u end
			if body:find('"success"%s*:%s*"?40') or body:find('"success"%s*:%s*"?50') then
				logln("loader.to: converter error")
				return nil
			end
		end
	end
	logln("loader.to: timed out")
	return nil
end

local function fetchFile(url)
	local headers = {
		["User-Agent"] = HEADERS["User-Agent"],
		["Accept-Language"] = HEADERS["Accept-Language"],
		["Referer"] = "https://en.loader.to/",
	}

	for i = 1, 2 do
		local ok, res = pcall(function()
			return request({ Url = url, Method = "GET", Headers = headers })
		end)
		if not ok then
			logln("direct fetch error: " .. tostring(res))
		end
		local size = (ok and res and type(res.Body) == "string") and #res.Body or 0
		logln("direct try " .. i .. ": " .. tostring(ok and res and res.StatusCode) .. ", " .. size .. " bytes")
		if ok and res and size > 8000 then
			return res.Body
		end
		task.wait(1)
	end

	local proxied = {
		"https://api.codetabs.com/v1/proxy?quest=" .. HttpService:UrlEncode(url),
		"https://api.allorigins.win/raw?url=" .. HttpService:UrlEncode(url),
		"https://corsproxy.io/?url=" .. HttpService:UrlEncode(url),
	}
	for i, purl in ipairs(proxied) do
		local ok, res = pcall(function()
			return request({ Url = purl, Method = "GET", Headers = { ["User-Agent"] = HEADERS["User-Agent"] } })
		end)
		local size = (ok and res and type(res.Body) == "string") and #res.Body or 0
		logln("proxy " .. i .. ": " .. tostring(ok and res and res.StatusCode) .. ", " .. size .. " bytes")
		if ok and res and size > 8000 then
			return res.Body
		end
	end

	local ok3, body = pcall(function() return game:HttpGet(url) end)
	if ok3 and type(body) == "string" and #body > 8000 then
		logln("file fetch via game:HttpGet: " .. #body .. " bytes")
		return body
	end
	logln("file fetch: everything failed")
	return nil
end

local function svcYtdownload(videoUrl, videoId)
	local body = httpGet("https://www.yt-download.org/api/button/mp3/" .. videoId)
	return body and extractAudioLink(body) or nil
end

local function svcVevioz(videoUrl, videoId)
	local body = httpGet("https://api.vevioz.com/api/button/mp3/" .. videoId)
	local u = body and extractAudioLink(body)
	if u then return u end
	body = httpPost("https://api.vevioz.com/api/button/mp3/" .. videoId, "url=" .. HttpService:UrlEncode(videoUrl))
	return body and extractAudioLink(body) or nil
end

local SAVENOW_KEYS = {
	"21fbd971d02303568cf35043e7993dafc4ddf260",
	"bbef82fcaaf5e3272e8c2b7e373239add6f0a5ad",
	"13e24bc93edbe1f693dd89ca192ed67b63e7eae4",
	"8e478fd61e30968d16db9e542402d4782738a201",
	"c9aa069e6bf1b0714c2c407f8370fa273c1485ec",
}

local function urlEncode(p)
	return p:gsub("([^%w%-%.%_%~])", function(c)
		return string.format("%%%02X", c:byte())
	end)
end

local function svcSavenow(videoUrl, videoId, statusFn)
	for keyIndex, key in ipairs(SAVENOW_KEYS) do
		local startBody = httpGet("https://p.savenow.to/ajax/download.php?url=" .. urlEncode(videoUrl) .. "&format=mp3&apikey=" .. key .. "&add_info=1&allow_extended_duration=1&no_merge=0")
		local jobId
		if startBody then
			local ok, data = pcall(function() return HttpService:JSONDecode(startBody) end)
			if ok and type(data) == "table" then
				jobId = data.id
				if not jobId and data.error then
					logln("savenow key " .. keyIndex .. ": " .. tostring(data.error))
				end
			end
		end

		if jobId then
			for i = 1, 120 do
				task.wait(1.5)
				local pb = httpGet("https://p.savenow.to/ajax/progress.php?id=" .. tostring(jobId))
				if pb then
					local ok2, pd = pcall(function() return HttpService:JSONDecode(pb) end)
					if ok2 and type(pd) == "table" then
						local progress = tonumber(pd.progress) or 0
						local pct = progress > 100 and math.floor(progress / 10) or math.floor(progress)
						pct = math.clamp(pct, 0, 100)
						if statusFn then statusFn("savenow " .. pct .. "%") end
						if progress >= 1000 then
							local u = cleanUrl(pd.download_url)
							if u then return u end
						end
						if pd.error and pd.error ~= "" then
							logln("savenow progress error: " .. tostring(pd.error))
							break
						end
					end
				end
			end
		end
	end
	return nil
end

local SERVICES = {
	{ name = "savenow.to", fn = svcSavenow },
}

local function downloadMp3(videoId, title, statusFn)
	local path = "YMP/Musics/" .. videoId .. ".mp3"
	if isfile(path) then return path end

	local videoUrl = "https://youtu.be/" .. videoId
	dlog = {}
	logln("==== YMP download log | video: " .. videoId .. " ====")

	for i, svc in ipairs(SERVICES) do
		if statusFn then statusFn("Trying " .. i .. "/" .. #SERVICES .. ": " .. svc.name .. "...") end
		logln("-- service: " .. svc.name)
		local ok, out = pcall(svc.fn, videoUrl, videoId, statusFn, title)

		if type(out) == "table" and type(out.bytes) == "string" and #out.bytes > 8000 then
			writefile(path, out.bytes)
			logln("SUCCESS via " .. svc.name .. ": " .. #out.bytes .. " bytes (direct)")
			return path
		end

		local url = (ok and type(out) == "string") and out or nil
		if url then
			logln("LINK FOUND via " .. svc.name .. ": " .. url:sub(1, 90))
			for attempt = 1, 2 do
				if statusFn then statusFn("Downloading file... (try " .. attempt .. ")") end
				local body = fetchFile(url)
				if body and #body > 8000 then
					writefile(path, body)
					logln("SUCCESS: " .. #body .. " bytes saved")
					return path
				end
				if attempt == 1 then task.wait(5) end
			end
			logln("file fetch failed after all retries")
		end
	end

	logln("==== ALL SERVICES FAILED ====")
	pcall(function() writefile("YMP/last_error.txt", table.concat(dlog, "\n")) end)
	if typeof(setclipboard) == "function" then
		pcall(setclipboard, table.concat(dlog, "\n"))
	end
	return nil
end

local gui = Instance.new("ScreenGui")
gui.Name = "YMP_Min"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui

local function mkIconBtn(parent, size, pos, imgName)
	local b = Instance.new("ImageButton")
	b.Size = size
	b.Position = pos
	b.BackgroundColor3 = BLACK
	b.BorderSizePixel = 0
	b.AutoButtonColor = false
	b.Image = icon(imgName)
	b.Parent = parent
	local s = Instance.new("UIStroke")
	s.Color = WHITE
	s.Thickness = 1
	s.Parent = b
	b.MouseEnter:Connect(function() b.BackgroundColor3 = DARK end)
	b.MouseLeave:Connect(function() b.BackgroundColor3 = BLACK end)
	return b
end

local toggle = mkIconBtn(gui, UDim2.new(0, 40, 0, 40), UDim2.new(1, -56, 0, 40), "music")
toggle.Image = ""

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 174)
main.Position = UDim2.new(0.5, -200, 0, 60)
main.BackgroundColor3 = BLACK
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = WHITE
mainStroke.Thickness = 1
mainStroke.Parent = main
draggable(main)
draggable(toggle)

local winTitle = Instance.new("TextLabel")
winTitle.Size = UDim2.new(1, 0, 0, 14)
winTitle.Position = UDim2.new(0, 0, 0, 6)
winTitle.BackgroundTransparency = 1
winTitle.Text = "AEVYX  MUSIC  PLAYER"
winTitle.TextColor3 = WHITE
winTitle.Font = Enum.Font.GothamBold
winTitle.TextSize = 10
winTitle.Parent = main

local TAB_W = 192
local function mkTab(x, label)
	local t = Instance.new("TextButton")
	t.Size = UDim2.new(0, TAB_W, 0, 24)
	t.Position = UDim2.new(0, x, 0, 24)
	t.BackgroundColor3 = BLACK
	t.BorderSizePixel = 0
	t.Text = label
	t.TextColor3 = GRAY
	t.Font = Enum.Font.GothamBold
	t.TextSize = 11
	t.AutoButtonColor = false
	t.Parent = main
	local s = Instance.new("UIStroke")
	s.Color = TABLINE
	s.Thickness = 1
	s.Parent = t
	return t
end

local tabSearch = mkTab(8, "SEARCH")
local tabLibrary = mkTab(8 + TAB_W + 4, "LIBRARY")

local function setActiveTab(active, inactive)
	active.BackgroundColor3 = WHITE
	active.TextColor3 = BLACK
	local as = active:FindFirstChildOfClass("UIStroke")
	if as then as.Color = WHITE end
	inactive.BackgroundColor3 = BLACK
	inactive.TextColor3 = GRAY
	local is2 = inactive:FindFirstChildOfClass("UIStroke")
	if is2 then is2.Color = TABLINE end
end

local searchBox = Instance.new("Frame")
searchBox.Size = UDim2.new(1, -16, 0, 28)
searchBox.Position = UDim2.new(0, 8, 0, 56)
searchBox.BackgroundColor3 = BLACK
searchBox.BorderSizePixel = 0
searchBox.Parent = main
local sbStroke = Instance.new("UIStroke")
sbStroke.Color = WHITE
sbStroke.Thickness = 1
sbStroke.Parent = searchBox

local searchIcon = Instance.new("ImageLabel")
searchIcon.Size = UDim2.new(0, 16, 0, 16)
searchIcon.Position = UDim2.new(0, 8, 0.5, -8)
searchIcon.BackgroundTransparency = 1
searchIcon.Image = icon("search")
searchIcon.Parent = searchBox

local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -32, 1, 0)
search.Position = UDim2.new(0, 28, 0, 0)
search.BackgroundTransparency = 1
search.PlaceholderText = "Search on YouTube..."
search.PlaceholderColor3 = GRAY
search.Text = ""
search.TextColor3 = WHITE
search.Font = Enum.Font.Gotham
search.TextSize = 12
search.ClearTextOnFocus = false
search.TextXAlignment = Enum.TextXAlignment.Left
search.Parent = searchBox

local libInfo = Instance.new("TextLabel")
libInfo.Size = UDim2.new(1, -16, 0, 28)
libInfo.Position = UDim2.new(0, 8, 0, 56)
libInfo.BackgroundColor3 = BLACK
libInfo.BorderSizePixel = 0
libInfo.Text = ""
libInfo.TextColor3 = WHITE
libInfo.Font = Enum.Font.GothamBold
libInfo.TextSize = 11
libInfo.Visible = false
libInfo.Parent = main
local liStroke = Instance.new("UIStroke")
liStroke.Color = TABLINE
liStroke.Thickness = 1
liStroke.Parent = libInfo

local cover = Instance.new("ImageLabel")
cover.Size = UDim2.new(0, 60, 0, 60)
cover.Position = UDim2.new(0, 10, 0, 94)
cover.BackgroundColor3 = DARK
cover.BorderSizePixel = 0
cover.Image = ""
cover.Parent = main
local cvStroke = Instance.new("UIStroke")
cvStroke.Color = WHITE
cvStroke.Thickness = 1
cvStroke.Parent = cover

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 240, 0, 16)
title.Position = UDim2.new(0, 82, 0, 92)
title.BackgroundTransparency = 1
title.Text = "Nothing playing"
title.TextColor3 = WHITE
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextTruncate = Enum.TextTruncate.AtEnd
title.Parent = main

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 238, 0, 4)
bar.Position = UDim2.new(0, 82, 0, 114)
bar.BackgroundColor3 = TRACK
bar.BorderSizePixel = 0
bar.Active = true
bar.Parent = main

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = WHITE
fill.BorderSizePixel = 0
fill.Parent = bar

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0, 10, 0, 10)
knob.AnchorPoint = Vector2.new(0.5, 0.5)
knob.Position = UDim2.new(1, 0, 0.5, 0)
knob.BackgroundColor3 = WHITE
knob.BorderSizePixel = 0
knob.Parent = fill

local seekHit = Instance.new("Frame")
seekHit.Size = UDim2.new(0, 238, 0, 20)
seekHit.Position = UDim2.new(0, 82, 0, 106)
seekHit.BackgroundTransparency = 1
seekHit.BorderSizePixel = 0
seekHit.Active = true
seekHit.Parent = main

local timeLbl = Instance.new("TextLabel")
timeLbl.Size = UDim2.new(0, 70, 0, 12)
timeLbl.Position = UDim2.new(0, 322, 0, 110)
timeLbl.BackgroundTransparency = 1
timeLbl.Text = "00:00 / 00:00"
timeLbl.TextColor3 = WHITE
timeLbl.Font = Enum.Font.Gotham
timeLbl.TextSize = 10
timeLbl.TextXAlignment = Enum.TextXAlignment.Right
timeLbl.Parent = main

local prevBtn = mkIconBtn(main, UDim2.new(0, 32, 0, 32), UDim2.new(0, 82, 0, 128), "prev")
local playBtn = mkIconBtn(main, UDim2.new(0, 32, 0, 32), UDim2.new(0, 120, 0, 128), "play")
local nextBtn = mkIconBtn(main, UDim2.new(0, 32, 0, 32), UDim2.new(0, 158, 0, 128), "next")

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(0, 200, 0, 32)
statusLbl.Position = UDim2.new(0, 198, 0, 128)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = ""
statusLbl.TextColor3 = WHITE
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextSize = 10
statusLbl.TextXAlignment = Enum.TextXAlignment.Right
statusLbl.TextWrapped = true
statusLbl.Parent = main

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(0, 400, 0, 0)
list.Position = UDim2.new(0, 0, 1, 8)
list.BackgroundColor3 = BLACK
list.BorderSizePixel = 0
list.ScrollBarThickness = 2
list.ScrollBarImageColor3 = WHITE
list.Visible = false
list.ClipsDescendants = true
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = main
local listStroke = Instance.new("UIStroke")
listStroke.Color = WHITE
listStroke.Thickness = 1
listStroke.Parent = list

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 6)
pad.PaddingBottom = UDim.new(0, 6)
pad.PaddingLeft = UDim.new(0, 6)
pad.PaddingRight = UDim.new(0, 6)
pad.Parent = list

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

local results = {}
local currentIndex = nil
local playToken = 0
local searching = false
local mode = "search"
local downloading = {}
local sound = Instance.new("Sound")
sound.Volume = 1
sound.Parent = SoundService

local function setStatus(t)
	statusLbl.Text = t or ""
end

local function clearList()
	for _, c in ipairs(list:GetChildren()) do
		if c:IsA("GuiObject") then c:Destroy() end
	end
	list.Size = UDim2.new(0, 400, 0, 0)
	list.Visible = false
end

local function setCover(url)
	if not url or url == "" then cover.Image = "" return end
	pcall(function()
		local ext = url:match("%.(%w+)$") or "jpg"
		local path = "YMP/Cache/" .. HttpService:GenerateGUID(false) .. "." .. ext:gsub("[^%w]", "")
		local r = request({ Url = url, Method = "GET" })
		writefile(path, r.Body)
		cover.Image = getcustomasset(path)
	end)
end

local function playIndex(i)
	local r = results[i]
	if not r then return end
	currentIndex = i
	playToken += 1
	local token = playToken

	title.Text = r.title
	setCover(r.thumb)

	task.spawn(function()
		local path = r.path
		if not path then
			if downloading[r.id] then
				if token == playToken then setStatus("Already downloading, waiting...") end
				local t0 = os.clock()
				while downloading[r.id] and os.clock() - t0 < 150 do task.wait(0.5) end
				local p2 = "YMP/Musics/" .. r.id .. ".mp3"
				if isfile(p2) then path = p2 end
			else
				downloading[r.id] = true
				local okDl, resDl = pcall(downloadMp3, r.id, r.title, function(t)
					if token == playToken then setStatus(t) end
				end)
				downloading[r.id] = nil
				path = (okDl and resDl) or nil
			end
			if path then
				library[r.id] = { title = r.title, duration = r.duration, thumb = r.thumb }
				saveLibrary()
			end
		end

		if token ~= playToken then return end

		if not path then
			setStatus("FAILED - log copied, send it back")
			return
		end

		local okPlay = pcall(function()
			sound:Stop()
			sound.TimePosition = 0
			sound.SoundId = getcustomasset(path)
			sound.TimePosition = 0
			sound:Play()
		end)
		fill.Size = UDim2.new(0, 0, 1, 0)
		timeLbl.Text = "00:00 / 00:00"
		if not okPlay then
			setStatus("Executor cannot play this file")
			return
		end
		playBtn.Image = icon("pause")
		setStatus("")
	end)
end

local function addResult(r, i, fromLibrary)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 32)
	row.BackgroundColor3 = BLACK
	row.BorderSizePixel = 0
	row.LayoutOrder = i
	row.Parent = list
	local s = Instance.new("UIStroke")
	s.Color = Color3.fromRGB(60, 60, 60)
	s.Thickness = 1
	s.Parent = row

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, fromLibrary and -36 or 0, 1, 0)
	b.BackgroundTransparency = 1
	b.TextColor3 = WHITE
	b.Font = Enum.Font.Gotham
	b.TextSize = 12
	b.TextXAlignment = Enum.TextXAlignment.Left
	b.TextTruncate = Enum.TextTruncate.AtEnd
	b.Text = "  " .. (r.duration and (fmt(r.duration) .. "  ") or "") .. r.title
	b.Parent = row

	b.MouseEnter:Connect(function() row.BackgroundColor3 = DARK end)
	b.MouseLeave:Connect(function() row.BackgroundColor3 = BLACK end)
	b.MouseButton1Click:Connect(function() playIndex(i) end)

	if fromLibrary then
		local del = mkIconBtn(row, UDim2.new(0, 24, 0, 24), UDim2.new(1, -30, 0, 4), "trash")
		del.MouseButton1Click:Connect(function()
			row:Destroy()
			pcall(delfile, r.path)
			library[r.id] = nil
			saveLibrary()
			for j, v in ipairs(results) do
				if v == r then table.remove(results, j) break end
			end
			local n = #results
			list.Size = UDim2.new(0, 400, 0, n > 0 and math.min(n * 36 + 12, 260) or 0)
			if n == 0 then list.Visible = false end
			libInfo.Text = #listfiles("YMP/Musics") .. " SONG(S) IN LIBRARY"
		end)
	end
end

local function showList(n)
	if n == 0 then
		setStatus("Nothing to show")
	else
		setStatus("")
		list.Size = UDim2.new(0, 400, 0, math.min(n * 36 + 12, 260))
		list.Visible = true
	end
end

local function buildLibrary()
	clearList()
	results = {}
	mode = "library"
	setActiveTab(tabLibrary, tabSearch)
	searchBox.Visible = false
	libInfo.Visible = true

	local files = listfiles("YMP/Musics")
	table.sort(files)
	libInfo.Text = #files .. " SONG(S) IN LIBRARY"

	local n = 0
	for _, f in ipairs(files) do
		local id = f:match("([^/\\]+)%.mp3$")
		if id then
			n += 1
			local meta = library[id] or {}
			results[n] = {
				id = id,
				title = meta.title or id,
				duration = meta.duration,
				thumb = meta.thumb,
				path = f,
			}
			addResult(results[n], n, true)
		end
	end

	if n == 0 then
		setStatus("Library empty - download a song first")
	else
		setStatus("")
		list.Size = UDim2.new(0, 400, 0, math.min(n * 36 + 12, 260))
		list.Visible = true
	end
end

local lastSearch = nil

local function renderSearch()
	clearList()
	results = {}
	if not lastSearch or #lastSearch == 0 then
		list.Visible = false
		return
	end
	for i, item in ipairs(lastSearch) do
		results[i] = item
		addResult(item, i, false)
	end
	list.Size = UDim2.new(0, 400, 0, math.min(#lastSearch * 36 + 12, 260))
	list.Visible = true
end

local function doSearch(query)
	if searching then return end
	searching = true
	mode = "search"
	setActiveTab(tabSearch, tabLibrary)
	searchBox.Visible = true
	libInfo.Visible = false
	clearList()
	setStatus("Searching...")
	results = {}

	task.spawn(function()
		local entries = searchYouTube(query)
		if #entries == 0 then
			entries = searchFallback(query)
		end
		searching = false
		lastSearch = entries
		renderSearch()
	end)
end

tabSearch.MouseButton1Click:Connect(function()
	setActiveTab(tabSearch, tabLibrary)
	searchBox.Visible = true
	libInfo.Visible = false
	mode = "search"
	if lastSearch and #lastSearch > 0 then
		renderSearch()
	else
		clearList()
	end
end)

tabLibrary.MouseButton1Click:Connect(function()
	buildLibrary()
end)

search.FocusLost:Connect(function(enter)
	if enter then
		local q = search.Text:match("^%s*(.-)%s*$")
		if q ~= "" then doSearch(q) end
	end
end)

playBtn.MouseButton1Click:Connect(function()
	if sound.SoundId == "" then
		if #results > 0 then playIndex(currentIndex or 1) end
		return
	end
	if sound.Playing then
		sound:Pause()
		playBtn.Image = icon("play")
	else
		sound:Resume()
		playBtn.Image = icon("pause")
	end
end)

nextBtn.MouseButton1Click:Connect(function()
	if #results == 0 then return end
	playIndex((currentIndex or 0) % #results + 1)
end)

prevBtn.MouseButton1Click:Connect(function()
	if #results == 0 then return end
	playIndex((currentIndex or 2) - 1 < 1 and #results or (currentIndex or 2) - 1)
end)

sound.Ended:Connect(function()
	if #results > 0 then
		playIndex((currentIndex or 0) % #results + 1)
	else
		playBtn.Image = icon("play")
	end
end)

local dragging = false
local function seekFromX(x)
	if sound.TimeLength <= 0 then return end
	local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
	sound.TimePosition = rel * sound.TimeLength
	fill.Size = UDim2.new(rel, 0, 1, 0)
	timeLbl.Text = fmt(sound.TimePosition) .. " / " .. fmt(sound.TimeLength)
end

for _, zone in ipairs({ bar, seekHit }) do
	zone.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			seekFromX(input.Position.X)
		end
	end)
end
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		seekFromX(input.Position.X)
	end
end)
UIS.InputEnded:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = false
		seekFromX(input.Position.X)
	end
end)

task.spawn(function()
	while gui.Parent do
		task.wait(0.1)
		if not dragging then
			if sound.TimeLength > 0 then
				fill.Size = UDim2.new(math.clamp(sound.TimePosition / sound.TimeLength, 0, 1), 0, 1, 0)
				timeLbl.Text = fmt(sound.TimePosition) .. " / " .. fmt(sound.TimeLength)
			else
				fill.Size = UDim2.new(0, 0, 1, 0)
				timeLbl.Text = "00:00 / 00:00"
			end
		end
	end
end)

local closeBtn = mkIconBtn(main, UDim2.new(0, 24, 0, 24), UDim2.new(1, -32, 0, 58), "close")
closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	toggle.Visible = IsMobile
end)

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

setActiveTab(tabSearch, tabLibrary)

-- ===== AEVYX INTEGRATION (ne pas supprimer) =====
toggle.Visible = IsMobile

main.Visible = not ((YMP_CFG and YMP_CFG.AlwaysHide) or false)

local keyName = YMP_CFG and YMP_CFG.Keybind
if keyName then
	keyName = tostring(keyName):gsub("^Enum%.KeyCode%.", "")
end
if keyName and keyName ~= "" and keyName ~= "Unknown" and not IsMobile then
	local keyCode = Enum.KeyCode[keyName]
	if keyCode then
		UIS.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == keyCode then
				main.Visible = not main.Visible
			end
		end)
	end
end

getgenv().YMP_ToggleUI = function()
	main.Visible = not main.Visible
end

getgenv().YMP_SetVisible = function(v)
	main.Visible = v and true or false
	toggle.Visible = v and IsMobile or false
end

if YMP_CFG and YMP_CFG.DirectPlay then
	task.spawn(function()
		task.wait(0.5)
		buildLibrary()
		task.wait(0.5)
		if #results > 0 then
			playIndex(1)
		end
	end)
end
]==]

local ympLoaded = false

local function getYmpCfg()
	return {
		AlwaysHide = (Toggles["MUSIC_PLAYER_ALWAYS_HIDE"] and Toggles["MUSIC_PLAYER_ALWAYS_HIDE"].Value) or false,
		DirectPlay = (Toggles["MUSIC_PLAYER_DIRECT_PLAY"] and Toggles["MUSIC_PLAYER_DIRECT_PLAY"].Value) or false,
		Keybind = "",
	}
end

MusicPlayerGroup:AddToggle("MUSIC_PLAYER_ENABLED", {
	Text = "Enabled",
	Default = false,
	Callback = function(Value)
		if Value then
			if not ympLoaded then
				getgenv().YMP_CFG = getYmpCfg()
				ympLoaded = true
				local fn, loadErr = loadstring(YMP_SOURCE)
				if fn then
					pcall(fn)
				else
					warn("[YMP] Load error: " .. tostring(loadErr))
				end
			else
				local alwaysHide = (Toggles["MUSIC_PLAYER_ALWAYS_HIDE"] and Toggles["MUSIC_PLAYER_ALWAYS_HIDE"].Value) or false
				if not alwaysHide then
					pcall(function() getgenv().YMP_SetVisible(true) end)
				end
			end
		else
			
			pcall(function() getgenv().YMP_SetVisible(false) end)
		end
	end,
})

MusicPlayerGroup:AddLabel("Keybind"):AddKeyPicker("MUSIC_PLAYER_KEYBIND", {
	Default = "M",
	NoUI = false,
	Text = "Music Player Keybind",
})

MusicPlayerGroup:AddToggle("MUSIC_PLAYER_ALWAYS_HIDE", {
	Text = "Always Hide",
	Default = false,
	Tooltip = "When enabled, the UI is not shown right away: click the square (mobile) or use the keybind (PC)",
})

MusicPlayerGroup:AddToggle("MUSIC_PLAYER_DIRECT_PLAY", {
	Text = "Direct Play",
	Default = false,
	Tooltip = "Plays the first song in the library on startup",
})

Services.UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if not ympLoaded then return end
	local kb = Options["MUSIC_PLAYER_KEYBIND"]
	if not kb then return end
	local keyName = tostring(kb.Value or ""):gsub("^Enum%.KeyCode%.", "")
	if keyName == "" or keyName == "Unknown" then return end
	if input.KeyCode == Enum.KeyCode[keyName] then
		pcall(function() getgenv().YMP_ToggleUI() end)
	end
end)


local MiscMovementGroup = Tabs.Misc:AddLeftGroupbox("Movement", "move-3d")

MiscMovementGroup:AddToggle("INFJUMP", {
    Text = "Infinite Jump",
    Tooltip = "Jump infinitely",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_INFJUMP = Value
    end,
})

MiscMovementGroup:AddToggle("SPEEDWALK", {
    Text = "Speed Walk",
    Tooltip = "Increase walk speed",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_SPEEDWALK = Value
        applySpeedwalk()
    end,
})

MiscMovementGroup:AddSlider("SPEEDWALK_VALUE", {
    Text = "Speed Value",
    Default = 50,
    Min = 16,
    Max = 500,
    Rounding = 0,
    Suffix = "",
    Callback = function(Value)
        GlobalSettings.SPEEDWALK_VALUE = Value
        if GlobalSettings.ENABLE_SPEEDWALK then
            applySpeedwalk()
        end
    end,
})

MiscMovementGroup:AddToggle("NOCLIP", {
    Text = "Noclip",
    Tooltip = "Walk through walls",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_NOCLIP = Value
        applyNoclip()
    end,
})

MiscMovementGroup:AddToggle("SLIDE_BOOST", {
    Text = "Slide Boost",
    Tooltip = "Increase slide speed",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_SLIDE_BOOST = Value
    end,
})

MiscMovementGroup:AddSlider("SLIDE_BOOST_SPEED", {
    Text = "Slide Boost Speed",
    Default = 100,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Suffix = "",
    Callback = function(Value)
        GlobalSettings.SLIDE_BOOST_SPEED = Value
    end,
})

MiscMovementGroup:AddToggle("FLY", {
    Text = "Fly",
    Tooltip = "Enable fly mode",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_FLY = Value
        if Value then
            setupFlyPhysics()
        else
            if flyHumanoid then flyHumanoid.PlatformStand = false end
            if flyAttachment then flyAttachment:Destroy() end
            flyAttachment = nil
            flyLV = nil
            flyAO = nil
        end
    end,
})

MiscMovementGroup:AddSlider("FLY_SPEED", {
    Text = "Fly Speed",
    Default = 50,
    Min = 10,
    Max = 300,
    Rounding = 0,
    Suffix = "",
    Callback = function(Value)
        GlobalSettings.FLY_SPEED = Value
    end,
})


MiscMovementGroup:AddToggle("NO_ANIMATION", {
    Text = "No Animation",
    Default = false,
    Callback = function(Value)
        if Value then
            startNoAnimation()
        end
    end,
})


local IdKGroup = Tabs.Misc:AddLeftGroupbox("idk", "palette")


local AntiHitConfig = {
    Enabled = false,
    Studs = 6,
    Stretch = true,
    Spin = true,
    SpinSpeed = 8,
}

local SkyboxList = {
    ["Deep Space"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=159248188",
        SkyboxDn = "http://www.roblox.com/asset/?id=159248183",
        SkyboxFt = "http://www.roblox.com/asset/?id=159248187",
        SkyboxLf = "http://www.roblox.com/asset/?id=159248173",
        SkyboxRt = "http://www.roblox.com/asset/?id=159248192",
        SkyboxUp = "http://www.roblox.com/asset/?id=159248176"
    },
    ["Vaporwave"] = {
        SkyboxBk = "rbxassetid://1417494030",
        SkyboxDn = "rbxassetid://1417494146",
        SkyboxFt = "rbxassetid://1417494253",
        SkyboxLf = "rbxassetid://1417494402",
        SkyboxRt = "rbxassetid://1417494499",
        SkyboxUp = "rbxassetid://1417494643"
    },
    ["Elisium Sky"] = {
        SkyboxBk = "rbxassetid://1898724755",
        SkyboxDn = "rbxassetid://1898727189",
        SkyboxFt = "rbxassetid://1898722814",
        SkyboxLf = "rbxassetid://1898729298",
        SkyboxRt = "rbxassetid://1898741025",
        SkyboxUp = "rbxassetid://1898736761"
    },
    ["Abyssal Blues"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=16269815885",
        SkyboxDn = "http://www.roblox.com/asset/?id=16269839652",
        SkyboxFt = "http://www.roblox.com/asset/?id=16269798011",
        SkyboxLf = "http://www.roblox.com/asset/?id=16269813852",
        SkyboxRt = "http://www.roblox.com/asset/?id=16269814948",
        SkyboxUp = "http://www.roblox.com/asset/?id=16269829700"
    },
    ["Pink Sky"] = {
        SkyboxBk = "rbxassetid://271042516",
        SkyboxDn = "rbxassetid://271077243",
        SkyboxFt = "rbxassetid://271042556",
        SkyboxLf = "rbxassetid://271042310",
        SkyboxRt = "rbxassetid://271042467",
        SkyboxUp = "rbxassetid://271077958"
    },
    ["SpongeBob"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=15962101128",
        SkyboxDn = "http://www.roblox.com/asset/?id=15970246218",
        SkyboxFt = "http://www.roblox.com/asset/?id=15962101128",
        SkyboxLf = "http://www.roblox.com/asset/?id=15962101128",
        SkyboxRt = "http://www.roblox.com/asset/?id=15962101128",
        SkyboxUp = "http://www.roblox.com/asset/?id=15962901054"
    },
}

local SkyChanger = {
    Enabled = false,
    Selected = "Deep Space",
    DefaultSky = nil,
    Connection = nil,
}

SkyChanger.DefaultSky = Services.Lighting:FindFirstChildOfClass("Sky") and Services.Lighting:FindFirstChildOfClass("Sky"):Clone() or nil

function SkyChanger:Apply()
    for _,v in ipairs(Services.Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end
    local Sky
    if not self.Enabled then
        if self.DefaultSky then
            Sky = self.DefaultSky:Clone()
            Sky.Parent = Services.Lighting
        end
        return
    end
    local data = SkyboxList[self.Selected]
    if not data then return end
    Sky = Instance.new("Sky")
    Sky.SkyboxBk = data.SkyboxBk
    Sky.SkyboxDn = data.SkyboxDn
    Sky.SkyboxFt = data.SkyboxFt
    Sky.SkyboxLf = data.SkyboxLf
    Sky.SkyboxRt = data.SkyboxRt
    Sky.SkyboxUp = data.SkyboxUp
    Sky.SunAngularSize = 21
    Sky.MoonAngularSize = 11
    Sky.StarCount = 3000
    Sky.SunTextureId = "rbxasset://sky/sun.jpg"
    Sky.MoonTextureId = "rbxasset://sky/moon.jpg"
    Sky.Parent = Services.Lighting
end


local AntiHit = {}
AntiHit.Enabled = false
AntiHit.conn = nil
AntiHit.originalSizes = {}
AntiHit.spin = 0

function AntiHit:Start()
    if self.conn then self.conn:Disconnect() end
    self.conn = Services.RunService.Heartbeat:Connect(function(dt)
        if not self.Enabled then return end
        local char = Services.Players.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        
        
        
        self.spin += dt * AntiHitConfig.SpinSpeed
        
        
        for _, name in ipairs({"Left Arm","Right Arm","Left Leg","Right Leg","LeftUpperArm","RightUpperArm","LeftLowerArm","RightLowerArm","LeftUpperLeg","RightUpperLeg","LeftLowerLeg","RightLowerLeg"}) do
            local part = char:FindFirstChild(name)
            if part and part:IsA("BasePart") then
                if not self.originalSizes[part] then
                    self.originalSizes[part] = part.Size
                end
                if AntiHitConfig.Stretch then
                    
                    part.Size = self.originalSizes[part] * Vector3.new(1,1.2,1.2) + Vector3.new(0,0.5,0)
                end
                
                local motor = nil
                for _, m in ipairs(char:GetDescendants()) do
                    if m:IsA("Motor6D") and m.Part1 == part then motor = m break end
                end
                if motor and AntiHitConfig.Spin then
                    
                    local angle = self.spin * 2
                    motor.C0 = motor.C0 * CFrame.Angles(0,0,0.05) 
                    
                    part.CFrame = part.CFrame * CFrame.Angles(math.sin(angle)*0.3, math.cos(angle)*0.3, angle)
                end
            end
        end
        
        
        if AntiHitConfig.Spin then
            local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm")
            local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
            if leftArm and rightArm and hrp then
                
                
                hrp.CFrame = hrp.CFrame + Vector3.new(0, -0.1, 0) 
                
                pcall(function()
                    if getgenv().AevyxDesyncPos then
                        getgenv().AevyxDesyncPos = hrp.Position - Vector3.new(0,6,0)
                    end
                end)
            end
        end
    end)
    
    
    task.spawn(function()
        while AntiHit.Enabled do
            task.wait(0.1)
            local char = Services.Players.LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    
                    
                    pcall(function()
                        hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 6, hrp.Position.Z) * (hrp.CFrame - hrp.Position)
                    end)
                end
            end
        end
    end)
end

function AntiHit:Stop()
    if self.conn then self.conn:Disconnect() self.conn=nil end
    local char = Services.Players.LocalPlayer.Character
    if char then
        for part,size in pairs(self.originalSizes) do
            if part and part.Parent then pcall(function() part.Size=size end) end
        end
    end
    self.originalSizes={}
    self.spin=0
end

getgenv().SkyChanger = SkyChanger
getgenv().AntiHit = AntiHit




IdKGroup:AddToggle("STRETCH_RES", {
    Text = "Stretch Resolution",
    Tooltip = "Stretches the screen resolution",
    Default = false,
    Callback = function(Value)
        GlobalSettings.ENABLE_STRETCH_RES = Value
        if not Value then
            
            pcall(function()
                Camera.CFrame = Camera.CFrame
            end)
        end
    end,
})

IdKGroup:AddSlider("STRETCH_RES_VALUE", {
    Text = "Stretch Amount",
    Default = 0.81,
    Min = 0.5,
    Max = 1.0,
    Rounding = 2,
    Callback = function(Value)
        GlobalSettings.STRETCH_RES_VALUE = Value
    end,
})



IdKGroup:AddToggle("SKY_ENABLED", {
    Text = "Sky Changer",
    Default = false,
    Callback = function(v)
        SkyChanger.Enabled = v
        SkyChanger:Apply()
    end
})

IdKGroup:AddDropdown("SKY_SELECTED", {
    Text = "SkyChangers",
    Values = {"Deep Space","Vaporwave","Elisium Sky","Abyssal Blues","Pink Sky","SpongeBob"},
    Default = "Deep Space",
    Callback = function(v)
        SkyChanger.Selected = v
        if SkyChanger.Enabled then SkyChanger:Apply() end
    end
})

do
    local PersonalizedTextConfig = {
        Enabled = false,
        Text = "Aevyx",
        Size = 14,
        Color = Color3.fromRGB(255, 255, 255),
        Rainbow = false,
        Font = Enum.Font.GothamBold,
    }

    local ptextGui = nil
    local ptextLabel = nil
    local ptextConnection = nil

    local function stopPersonalizedText()
        if ptextConnection then
            ptextConnection:Disconnect()
            ptextConnection = nil
        end
        if ptextGui then
            ptextGui:Destroy()
            ptextGui = nil
        end
        ptextLabel = nil
    end

    local function startPersonalizedText()
        stopPersonalizedText()
        ptextGui = Instance.new("ScreenGui")
        ptextGui.Name = "AevyxPersonalizedText"
        ptextGui.ResetOnSpawn = false
        ptextGui.IgnoreGuiInset = true
        ptextGui.DisplayOrder = 999998
        ptextGui.Parent = (gethui and gethui()) or Services.CoreGui

        ptextLabel = Instance.new("TextLabel")
        ptextLabel.Name = "Text"
        ptextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ptextLabel.Position = UDim2.new(0.5, 0, 0.5, 45)
        ptextLabel.Size = UDim2.new(0, 500, 0, 60)
        ptextLabel.BackgroundTransparency = 1
        ptextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        ptextLabel.TextStrokeTransparency = 0.6
        ptextLabel.Text = PersonalizedTextConfig.Text
        ptextLabel.TextSize = PersonalizedTextConfig.Size
        ptextLabel.TextColor3 = PersonalizedTextConfig.Color
        ptextLabel.Font = PersonalizedTextConfig.Font
        ptextLabel.Parent = ptextGui

        ptextConnection = Services.RunService.RenderStepped:Connect(function()
            if not ptextLabel then return end
            ptextLabel.Text = PersonalizedTextConfig.Text
            ptextLabel.TextSize = PersonalizedTextConfig.Size
            ptextLabel.Font = PersonalizedTextConfig.Font
            if PersonalizedTextConfig.Rainbow then
                ptextLabel.TextColor3 = Color3.fromHSV((tick() % 5) / 5, 1, 1)
            else
                ptextLabel.TextColor3 = PersonalizedTextConfig.Color
            end
        end)
    end

    getgenv().AevyxStopPersonalText = stopPersonalizedText

    IdKGroup:AddToggle("PERSONAL_TEXT_ENABLED", {
        Text = "Personalized Text",
        Default = false,
        Callback = function(Value)
            PersonalizedTextConfig.Enabled = Value
            if Value then startPersonalizedText() else stopPersonalizedText() end
        end,
    })
    IdKGroup:AddInput("PERSONAL_TEXT_VALUE", {
        Text = "Text",
        Default = PersonalizedTextConfig.Text,
        Finished = false,
        Placeholder = "Enter text",
        Callback = function(Value)
            PersonalizedTextConfig.Text = Value
        end,
    })
    IdKGroup:AddSlider("PERSONAL_TEXT_SIZE", {
        Text = "Text Size",
        Default = 14,
        Min = 10,
        Max = 50,
        Rounding = 0,
        Callback = function(Value)
            PersonalizedTextConfig.Size = Value
        end,
    })
    IdKGroup:AddLabel("Text Color"):AddColorPicker("PERSONAL_TEXT_COLOR", {
        Default = PersonalizedTextConfig.Color,
        Callback = function(Value)
            PersonalizedTextConfig.Color = Value
        end,
    })
    IdKGroup:AddToggle("PERSONAL_TEXT_RAINBOW", {
        Text = "Rainbow",
        Default = false,
        Callback = function(Value)
            PersonalizedTextConfig.Rainbow = Value
        end,
    })
    IdKGroup:AddDropdown("PERSONAL_TEXT_FONT", {
        Text = "Font",
        Values = { "Gotham", "GothamBold", "GothamBlack", "GothamMedium", "Arial", "ArialBold", "Bangers", "Creepster", "DenkOne", "FredokaOne", "GrenzeGotisch", "IndieFlower", "JosefinSans", "Kalam", "LuckiestGuy", "Merriweather", "Montserrat", "Neue", "Oswald", "PatrickHand", "Poppins", "Roboto", "RobotoMono", "SourceSans", "SourceSansBold", "Ubuntu", "Fantasy", "Cartoon", "Code", "Highway", "Balthazar", "SpecialElite", "Nunito", "Raleway", "TitilliumWeb" },
        Default = "GothamBold",
        Callback = function(Value)
            PersonalizedTextConfig.Font = Enum.Font[Value]
        end,
    })
end





getgenv().Resolution = getgenv().Resolution or {
    [".gg/scripters"] = 0.81
}

local stretchResConnection = nil
local function startStretchRes()
    if stretchResConnection then return end
    stretchResConnection = Services.RunService.RenderStepped:Connect(function()
        if not GlobalSettings.ENABLE_STRETCH_RES then return end
        local stretchValue = GlobalSettings.STRETCH_RES_VALUE
        getgenv().Resolution[".gg/scripters"] = stretchValue
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, stretchValue, 0, 0, 0, 1)
    end)
end

local function stopStretchRes()
    if stretchResConnection then
        stretchResConnection:Disconnect()
        stretchResConnection = nil
    end
end

startStretchRes()

getgenv().AutoLoadoutConfig = getgenv().AutoLoadoutConfig or {
    Enabled = false,
    Primary = "Assault Rifle",
    Secondary = "Handgun",
    Melee = "Fists",
    Utility = "Grenade",
}

local Weapons = {
    Primary = {
        "Assault Rifle",
        "Bow",
        "Burst Rifle",
        "Crossbow",
        "Energy Rifle",
        "Flamethrower",
        "Grenade Launcher",
        "Gunblade",
        "Minigun",
        "Paintball Gun",
        "Permafrost",
        "RPG",
        "Shotgun",
        "Sniper",
        "Distortion",
    },
    Secondary = {
        "Handgun",
        "Uzi",
        "Revolver",
        "Shorty",
        "Energy Pistols",
        "Exogun",
        "Slingshot",
        "Daggers",
        "Flare Gun",
        "Spray",
        "Warper",
        "Glass Cannon",
    },
    Melee = {
        "Fists",
        "Knife",
        "Katana",
        "Scythe",
        "Battle Axe",
        "Chainsaw",
        "Maul",
        "Spear",
        "Riot Shield",
        "Trowel",
        "Glast Shard",
    },
    Utility = {
        "Grenade",
        "Medkit",
        "Flashbang",
        "Smoke Grenade",
        "Grappler",
        "Jump Pad",
        "Satchel",
        "War Horn",
        "Subspace Tripmine",
        "Warpstone",
        "Elixir",
        "RNG Dice",
    },
}


local MiscLoadoutGroup = Tabs.Misc:AddRightGroupbox("Auto Loadout", "backpack")

MiscLoadoutGroup:AddToggle("AUTO_LOADOUT_ENABLED", {
    Text = "Auto Loadout",
    Default = false,
    Callback = function(Value)
        getgenv().AutoLoadoutConfig.Enabled = Value
    end,
})

MiscLoadoutGroup:AddDropdown("AUTO_LOADOUT_PRIMARY", {
    Text = "Primary",
    Values = Weapons.Primary,
    Default = getgenv().AutoLoadoutConfig.Primary,
    Callback = function(Value)
        getgenv().AutoLoadoutConfig.Primary = Value
    end,
})

MiscLoadoutGroup:AddDropdown("AUTO_LOADOUT_SECONDARY", {
    Text = "Secondary",
    Values = Weapons.Secondary,
    Default = getgenv().AutoLoadoutConfig.Secondary,
    Callback = function(Value)
        getgenv().AutoLoadoutConfig.Secondary = Value
    end,
})

MiscLoadoutGroup:AddDropdown("AUTO_LOADOUT_MELEE", {
    Text = "Melee",
    Values = Weapons.Melee,
    Default = getgenv().AutoLoadoutConfig.Melee,
    Callback = function(Value)
        getgenv().AutoLoadoutConfig.Melee = Value
    end,
})

MiscLoadoutGroup:AddDropdown("AUTO_LOADOUT_UTILITY", {
    Text = "Utility",
    Values = Weapons.Utility,
    Default = getgenv().AutoLoadoutConfig.Utility,
    Callback = function(Value)
        getgenv().AutoLoadoutConfig.Utility = Value
    end,
})


do
    local AnimationPlayerEnabled = false
    local AnimValue = "Floss"
    local CustomAnimationValue = ""
    local AnimationSpeedValue = 1
    local AnimationStartValue = 0
    local AnimationEndValue = 100

    local CurrentTrack
    local CurrentAnimation
    local CurrentHumanoid
    local CurrentAnimator
    local ReplayToken = 0
    local LastReplay = 0
    local animations = {
        ["Bodybuilder"] = "3994130516",
        ["Crawling in a Circle"] = "116935126100338",
        ["Dolphin Dance"] = "5938365243",
        ["Dance"] = "507771019",
        ["Dance Break"] = "94258912028011",
        ["French Confidence"] = "116968182519797",
        ["Floss"] = "72174079036035",
        ["Frosty Flair"] = "10214406616",
        ["Full Wiggle"] = "86520127496722",
        ["Ghost Floating"] = "75911227509248",
        ["Gun"] = "81100102810594",
        ["Gangnam Style"] = "78801539668900",
        ["Hip Bounce"] = "123602332785269",
        ["Hype Dance"] = "93079641847306",
        ["Kicking Feet"] = "109814083870185",
        ["Line Dance"] = "4049646104",
        ["Lay Floating"] = "126579240140537",
        ["Let's Drive"] = "17360720445",
        ["Long Legs"] = "82416741608012",
        ["Rock Out"] = "18225077553",
        ["Samba"] = "6869813008",
        ["Still Standing"] = "11435177473",
        ["Spiral"] = "81926730031709",
        ["Solar System"] = "118314972618293",
        ["Twirl"] = "3716633898",
        ["Take Me Under"] = "6797938823",
        ["The Worm"] = "99563207397301",
        ["Take the L"] = "110664723286332",
        ["Zesty"] = "102901317133934",
    }

    local animationList = {
        "Bodybuilder", "Custom", "Crawling in a Circle", "Dolphin Dance", "Dance",
        "Dance Break", "French Confidence", "Floss", "Frosty Flair", "Full Wiggle",
        "Ghost Floating", "Gun", "Gangnam Style", "Hip Bounce", "Hype Dance",
        "Kicking Feet", "Line Dance", "Lay Floating", "Let's Drive", "Long Legs",
        "Rock Out", "Samba", "Still Standing", "Spiral", "Solar System", "Twirl",
        "Take Me Under", "The Worm", "Take the L", "Zesty",
    }

    local function stopAnimation()
        ReplayToken += 1
        if CurrentTrack then
            pcall(CurrentTrack.Stop, CurrentTrack, 0.1)
            pcall(CurrentTrack.Destroy, CurrentTrack)
            CurrentTrack = nil
        end
        if CurrentAnimation then
            CurrentAnimation:Destroy()
            CurrentAnimation = nil
        end
        CurrentHumanoid = nil
        CurrentAnimator = nil
    end

    local function selectedId()
        if AnimValue == "Custom" then
            return tostring(CustomAnimationValue):match("%d+")
        end
        return animations[AnimValue]
    end

    local function loadCatalogEmote(humanoid, animator, id)
        local description = humanoid:FindFirstChildOfClass("HumanoidDescription")
        if not description then return nil end

        local emoteName = "LionAnimationPlayer"
        local captured
        local connection = animator.AnimationPlayed:Connect(function(track)
            captured = track
        end)

        local ok = pcall(function()
            pcall(description.RemoveEmote, description, emoteName)
            description:AddEmote(emoteName, tonumber(id))
            humanoid:PlayEmote(emoteName)
        end)

        local timeout = os.clock() + 2
        while ok and not captured and os.clock() < timeout do
            Services.RunService.Heartbeat:Wait()
        end
        connection:Disconnect()
        return captured
    end

    local function playSelected()
        if not AnimationPlayerEnabled then return end
        local id = selectedId()
        if not id or id == "" then
            stopAnimation()
            return
        end

        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then return end

        stopAnimation()
        ReplayToken += 1
        local token = ReplayToken
        local track
        local animation

        if AnimValue ~= "Custom" then
            track = loadCatalogEmote(humanoid, animator, id)
        else
            animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://" .. id
            local ok
            ok, track = pcall(animator.LoadAnimation, animator, animation)
            if not ok then track = nil end
        end

        if not track then
            if animation then animation:Destroy() end
            return
        end
        CurrentAnimation = animation
        CurrentTrack = track
        CurrentHumanoid = humanoid
        CurrentAnimator = animator
        LastReplay = os.clock()
        track.Priority = Enum.AnimationPriority.Action4
        track.Looped = true
        track:Play(0.1, 1, AnimationSpeedValue)

        task.spawn(function()
            while token == ReplayToken and CurrentTrack == track and AnimationPlayerEnabled do
                local length = track.Length
                local startPercent = AnimationStartValue
                local endPercent = AnimationEndValue
                if endPercent <= startPercent then endPercent = math.min(100, startPercent + 1) end
                if length > 0 then
                    local startTime = length * startPercent / 100
                    local endTime = length * endPercent / 100
                    if track.TimePosition < startTime or track.TimePosition >= endTime then
                        track.TimePosition = startTime
                    end
                end
                if not track.IsPlaying then
                    track:Play(0.05, 1, AnimationSpeedValue)
                end
                track:AdjustSpeed(AnimationSpeedValue)
                track:AdjustWeight(1, 0)
                Services.RunService.Heartbeat:Wait()
            end
        end)
    end

    local AnimationPlayerGroup = Tabs.Misc:AddRightGroupbox("Animation Player", "clapperboard")

    AnimationPlayerGroup:AddToggle("ANIMATION_PLAYER_ENABLED", {
        Text = "Enabled",
        Default = false,
        Callback = function(v)
            AnimationPlayerEnabled = v == true
            if AnimationPlayerEnabled then playSelected() else stopAnimation() end
        end,
    }):AddKeyPicker("ANIMATION_PLAYER_KEYBIND", {
        Default = "None",
        SyncToggleState = true,
        Mode = "Toggle",
        Text = "Animation Player",
        NoUI = true,
    })

    AnimationPlayerGroup:AddDropdown("ANIMATION_PLAYER_ANIM", {
        Text = "animation",
        Values = animationList,
        Default = "Floss",
        Callback = function(v)
            AnimValue = v
            playSelected()
        end,
    })

    AnimationPlayerGroup:AddInput("ANIMATION_PLAYER_CUSTOM", {
        Text = "custom animation",
        Default = "",
        Placeholder = "id... (ex: 4049646104)",
        Finished = false,
        Callback = function(v)
            CustomAnimationValue = v
            if AnimValue == "Custom" then playSelected() end
        end,
    })

    AnimationPlayerGroup:AddSlider("ANIMATION_PLAYER_SPEED", {
        Text = "speed",
        Min = 0.1,
        Max = 5,
        Default = 1,
        Rounding = 1,
        Callback = function(v)
            AnimationSpeedValue = v
            if CurrentTrack then CurrentTrack:AdjustSpeed(v) end
        end,
    })

    AnimationPlayerGroup:AddSlider("ANIMATION_PLAYER_START", {
        Text = "start",
        Min = 0,
        Max = 99,
        Default = 0,
        Rounding = 0,
        Suffix = "%",
        Callback = function(v) AnimationStartValue = v end,
    })

    AnimationPlayerGroup:AddSlider("ANIMATION_PLAYER_END", {
        Text = "end",
        Min = 1,
        Max = 100,
        Default = 100,
        Rounding = 0,
        Suffix = "%",
        Callback = function(v) AnimationEndValue = v end,
    })

    LocalPlayer.CharacterAdded:Connect(function(character)
        task.spawn(function()
            local humanoid = character:WaitForChild("Humanoid", 10)
            if not humanoid then return end
            humanoid:WaitForChild("Animator", 10)
            if LocalPlayer.Character ~= character then return end
            task.wait(0.5)
            if AnimationPlayerEnabled then
                playSelected()
            end
        end)
    end)

    LocalPlayer.CharacterRemoving:Connect(function(character)
        if LocalPlayer.Character == character then
            stopAnimation()
        end
    end)

    Services.RunService.Heartbeat:Connect(function()
        if not AnimationPlayerEnabled or os.clock() - LastReplay < 1 then return end

        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        local trackValid = false
        if CurrentTrack then
            trackValid = pcall(function()
                return CurrentTrack.IsPlaying
            end)
        end

        if humanoid and animator and (
            humanoid ~= CurrentHumanoid
            or animator ~= CurrentAnimator
            or not CurrentTrack
            or not trackValid
        ) then
            LastReplay = os.clock()
            task.spawn(playSelected)
        end
    end)
end

do
    local Players = Services.Players
    local RunService = Services.RunService
    local CoreGui = Services.CoreGui
    local LP = Players.LocalPlayer

    local C = {
        enable = false,
        remove_ingame = false,
        color_type = "Gradient",
        color1 = Color3.fromRGB(255, 105, 180),
        color2 = Color3.fromRGB(255, 220, 235),
        font = "GothamBold",
        duration = 0.9,
        rise = 46,
        text_size = 19,
        outline = true,
        outline_color = Color3.fromRGB(40, 10, 25),
        outline_transp = 0.1,
        outline_thick = 1.8,
    }

    local gui = Instance.new("ScreenGui")
    gui.Name = "\0"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 500
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then
        pcall(function() gui.Parent = LP:FindFirstChildOfClass("PlayerGui") end)
    end

    local function new(class, props, parent)
        local object = Instance.new(class)
        for key, value in pairs(props) do
            object[key] = value
        end
        if parent then object.Parent = parent end
        return object
    end

    local damageCallbacks, damageQueue = {}, {}

    local function onDamage(callback)
        damageCallbacks[#damageCallbacks + 1] = callback
    end

    local function fireDamage(player, amount, position)
        damageQueue[#damageQueue + 1] = { player, amount, position }
    end

    RunService.Heartbeat:Connect(function()
        local queue = damageQueue
        if #queue == 0 then return end
        damageQueue = {}
        for index = 1, #queue do
            local damage = queue[index]
            for _, callback in ipairs(damageCallbacks) do
                pcall(callback, damage[1], damage[2], damage[3])
            end
        end
    end)

    local camera = workspace.CurrentCamera

    local function fontOf(name)
        local ok, font = pcall(function() return Enum.Font[name] end)
        return (ok and font) or Enum.Font.GothamBold
    end

    onDamage(function(player, amount, worldPosition)
        if not C.enable or not worldPosition then return end

        local screenPosition, onscreen = camera:WorldToViewportPoint(worldPosition)
        if not onscreen then return end

        local label = new("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(160, 28),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(screenPosition.X, screenPosition.Y),
            Font = fontOf(C.font),
            TextSize = C.text_size,
            Text = "-" .. tostring(math.floor(amount + 0.5)),
            TextStrokeTransparency = 1,
            TextColor3 = C.color1,
            ZIndex = 10,
        }, gui)

        local stroke
        if C.outline then
            stroke = new("UIStroke", {
                Thickness = C.outline_thick,
                Color = C.outline_color,
                Transparency = C.outline_transp,
                LineJoinMode = Enum.LineJoinMode.Round,
            }, label)
        end

        local scale = new("UIScale", { Scale = 0.4 }, label)

        if C.color_type == "Gradient" then
            new("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, C.color1),
                    ColorSequenceKeypoint.new(1, C.color2),
                }),
                Rotation = 90,
            }, label)
            label.TextColor3 = Color3.new(1, 1, 1)
        end

        local startX, startY = screenPosition.X, screenPosition.Y
        local jitter = math.random(-16, 16)
        local start = tick()
        local duration = C.duration
        local rise = C.rise
        local connection

        connection = RunService.RenderStepped:Connect(function()
            local elapsed = (tick() - start) / duration
            if elapsed >= 1 then
                connection:Disconnect()
                pcall(function() label:Destroy() end)
                return
            end

            local ease = 1 - (1 - elapsed)^3

            if C.color_type == "Rainbow" then
                label.TextColor3 = Color3.fromHSV((tick() * 0.6) % 1, 0.75, 1)
            end

            if elapsed < 0.18 then
                scale.Scale = 0.4 + (elapsed / 0.18) * 0.72
            else
                scale.Scale = 1.12 - ((elapsed - 0.18) / 0.82) * 0.12
            end

            local fade = elapsed < 0.55 and 0 or (elapsed - 0.55) / 0.45
            label.Position = UDim2.fromOffset(startX + jitter * ease, startY - rise * ease)
            label.TextTransparency = fade
            if stroke then
                stroke.Transparency = C.outline_transp + (1 - C.outline_transp) * fade
            end
        end)
    end)

    local DamageChangerGroup = Tabs.Misc:AddRightGroupbox("damage changer", "type")

    DamageChangerGroup:AddToggle("AEVYX_DAMAGE_CHANGER_ENABLE", {
        Text = "enable",
        Default = C.enable,
        Callback = function(value) C.enable = value end,
    })
    DamageChangerGroup:AddToggle("AEVYX_DAMAGE_CHANGER_REMOVE", {
        Text = "remove in game",
        Default = C.remove_ingame,
        Callback = function(value) C.remove_ingame = value end,
    })
    DamageChangerGroup:AddDropdown("AEVYX_DAMAGE_CHANGER_COLOR_TYPE", {
        Text = "color type",
        Values = { "Gradient", "Solid", "Rainbow" },
        Default = C.color_type,
        Callback = function(value) C.color_type = value end,
    })
    DamageChangerGroup:AddLabel("color 1"):AddColorPicker("AEVYX_DAMAGE_CHANGER_COLOR_1", {
        Default = C.color1,
        Callback = function(value) C.color1 = value end,
    })
    DamageChangerGroup:AddLabel("color 2"):AddColorPicker("AEVYX_DAMAGE_CHANGER_COLOR_2", {
        Default = C.color2,
        Callback = function(value) C.color2 = value end,
    })
    DamageChangerGroup:AddToggle("AEVYX_DAMAGE_CHANGER_OUTLINE", {
        Text = "outline",
        Default = C.outline,
        Callback = function(value) C.outline = value end,
    })
    DamageChangerGroup:AddLabel("outline color"):AddColorPicker("AEVYX_DAMAGE_CHANGER_OUTLINE_COLOR", {
        Default = C.outline_color,
        Callback = function(value) C.outline_color = value end,
    })
    DamageChangerGroup:AddSlider("AEVYX_DAMAGE_CHANGER_OUTLINE_THICKNESS", {
        Text = "outline thickness",
        Min = 1,
        Max = 5,
        Default = C.outline_thick,
        Rounding = 1,
        Suffix = "px",
        Callback = function(value) C.outline_thick = value end,
    })
    DamageChangerGroup:AddSlider("AEVYX_DAMAGE_CHANGER_OUTLINE_TRANSPARENCY", {
        Text = "outline transparency",
        Min = 0,
        Max = 1,
        Default = C.outline_transp,
        Rounding = 2,
        Callback = function(value) C.outline_transp = value end,
    })
    DamageChangerGroup:AddDropdown("AEVYX_DAMAGE_CHANGER_FONT", {
        Text = "font",
        Values = {
            "GothamBold", "GothamBlack", "GothamMedium", "Gotham",
            "SourceSansBold", "Code", "RobotoMono", "Fantasy",
            "Arcade", "SciFi", "Cartoon", "Bangers", "Michroma",
            "LuckiestGuy", "PermanentMarker", "Creepster",
        },
        Default = C.font,
        Callback = function(value) C.font = value end,
    })
    DamageChangerGroup:AddSlider("AEVYX_DAMAGE_CHANGER_SIZE", {
        Text = "size",
        Min = 10,
        Max = 40,
        Default = C.text_size,
        Rounding = 0,
        Suffix = "px",
        Callback = function(value) C.text_size = value end,
    })
    DamageChangerGroup:AddSlider("AEVYX_DAMAGE_CHANGER_RISE", {
        Text = "rise",
        Min = 0,
        Max = 120,
        Default = C.rise,
        Rounding = 0,
        Suffix = "px",
        Callback = function(value) C.rise = value end,
    })
    DamageChangerGroup:AddSlider("AEVYX_DAMAGE_CHANGER_DURATION", {
        Text = "duration",
        Min = 0.2,
        Max = 3,
        Default = C.duration,
        Rounding = 2,
        Suffix = "s",
        Callback = function(value) C.duration = value end,
    })

    local ok, fighterController = pcall(function()
        return require(LP.PlayerScripts.Controllers.FighterController)
    end)
    if ok and fighterController then
        local localFighter = fighterController.LocalFighter
        local old = localFighter and localFighter.ReplicateFromServer
        if localFighter and type(old) == "function" then
            localFighter.ReplicateFromServer = function(controller, effectType, ...)
                if effectType == "DamageNumberEffect" then
                    local hitRoot, hitDamage, isHeadshot = ...
                    if hitRoot and hitDamage then
                        local hitCharacter = hitRoot.Parent
                        local humanoid = hitCharacter and hitCharacter:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            local player = Players:GetPlayerFromCharacter(hitCharacter)
                            if C.enable then
                                local positionOk, position = pcall(function()
                                    return hitRoot.Position + Vector3.new(0, isHeadshot and 2.6 or 2.1, 0)
                                end)
                                fireDamage(player, hitDamage, positionOk and position or nil)
                            end
                            if C.enable and C.remove_ingame then
                                return
                            end
                        end
                    end
                end
                return old(controller, effectType, ...)
            end
        end
    end

    getgenv().elisium_dn = C
    getgenv().elisium_dn_ui = DamageChangerGroup
end

do
    local AutoQueueGroup = Tabs.Misc:AddLeftGroupbox("Auto Queue", "users")

    do
        local queuemode = "1v1"
        local ranked = false
        local queueenabled = false
        local queuethread = nil

        local function queuestop()
            if queuethread then
                queuethread = nil
            end
        end

        local function queuestart()
            queuestop()

            queuethread = task.spawn(function()
                while queueenabled and task.wait(1) do
                    local success, result = pcall(function()
                        local storage = game:GetService("ReplicatedStorage")
                        local remotes = storage:WaitForChild("Remotes")
                        local matchmaking = remotes:WaitForChild("Matchmaking")
                        local joinqueue = matchmaking:WaitForChild("JoinQueue")

                        if ranked then
                            return joinqueue:InvokeServer(queuemode, true)
                        else
                            return joinqueue:InvokeServer(queuemode)
                        end
                    end)

                    if not success and not string.find(result:lower(), "already in queue") then
                        queuethread = nil
                        break
                    end
                end
            end)
        end

        AutoQueueGroup:AddToggle("AUTO_QUEUE_ENABLED", {
            Text = "Enabled",
            Default = false,
            Callback = function(s)
                queueenabled = s

                if s then
                    queuestart()
                else
                    queuestop()
                end
            end
        })

        AutoQueueGroup:AddDropdown("AUTO_QUEUE_MATCH", {
            Text = "Select Match",
            Values = { "1v1", "2v2", "3v3", "4v4", "5v5", "2v2_beginner" },
            Default = "1v1",
            Callback = function(v)
                queuemode = v
                if queueenabled then
                    queuestop()
                    queuestart()
                end
            end
        })

        AutoQueueGroup:AddToggle("AUTO_QUEUE_RANKED", {
            Text = "Ranked",
            Default = false,
            Callback = function(s)
                ranked = s
                if queueenabled then
                    queuestop()
                    queuestart()
                end
            end
        })

        game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
            queuestop()
            queueenabled = false
        end)
    end
end

local pendingCustomSoundName = ""
local pendingCustomSoundSource = ""
local pendingRemoveSoundName = ""


local HitFeedbackGroup = Tabs.Misc:AddLeftGroupbox("Hit Feedback", "crosshair")
HitFeedbackGroup:AddToggle("AEVYX_HF_HIT", {
    Text = "Hit Feedback",
    Tooltip = "Plays effects when you damage someone: sound and chams.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.Hit = Value
        HitFeedback.RefreshBinding()
    end,
})
HitFeedbackGroup:AddToggle("AEVYX_HF_PLAY_SOUND", {
    Text = "Play Sound",
    Tooltip = "Plays a sound on every hit. Add your own in Custom Sounds.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.PlayHitSound = Value
    end,
})
HitFeedbackGroup:AddDropdown("AEVYX_HF_HEAD_SOUND", {
    Text = "Head Sound",
    Values = HitFeedback.SoundNames(),
    Default = HitFeedback.Config.HeadSound,
    Callback = function(Value)
        HitFeedback.Config.HeadSound = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_HEAD_VOLUME", {
    Text = "Head Volume",
    Default = HitFeedback.Config.HeadVolume,
    Min = 0.1,
    Max = 1.5,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.HeadVolume = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_HEAD_PITCH", {
    Text = "Head Pitch",
    Default = HitFeedback.Config.HeadPitch,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.HeadPitch = Value
    end,
})
HitFeedbackGroup:AddDropdown("AEVYX_HF_BODY_SOUND", {
    Text = "Body Sound",
    Values = HitFeedback.SoundNames(),
    Default = HitFeedback.Config.BodySound,
    Callback = function(Value)
        HitFeedback.Config.BodySound = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_BODY_VOLUME", {
    Text = "Body Volume",
    Default = HitFeedback.Config.BodyVolume,
    Min = 0.1,
    Max = 1.5,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.BodyVolume = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_BODY_PITCH", {
    Text = "Body Pitch",
    Default = HitFeedback.Config.BodyPitch,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.BodyPitch = Value
    end,
})
HitFeedbackGroup:AddToggle("AEVYX_HF_DISABLE_GAME_SOUND", {
    Text = "Disable Game Sound",
    Tooltip = "Mutes the game's own hitmarker sound so only your custom hit sound plays.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.DisableGameSound = Value
        HitFeedback.RefreshGameSoundHook()
    end,
})
HitFeedbackGroup:AddDivider()
HitFeedbackGroup:AddToggle("AEVYX_HF_CHAMS", {
    Text = "Chams",
    Tooltip = "Briefly highlights the body of the player you hit.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.HitChams = Value
    end,
})
HitFeedbackGroup:AddLabel("Cham Color"):AddColorPicker("AEVYX_HF_CHAM_COLOR", {
    Default = HitFeedback.Config.HitChamsColor,
    Title = "Hit Cham Color",
    Callback = function(Value)
        HitFeedback.Config.HitChamsColor = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_CHAM_TRANSPARENCY", {
    Text = "Cham Transparency",
    Default = HitFeedback.Config.HitChamsTransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.HitChamsTransparency = Value
    end,
})
HitFeedbackGroup:AddSlider("AEVYX_HF_CHAM_DURATION", {
    Text = "Cham Duration",
    Default = HitFeedback.Config.HitChamsDuration,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.HitChamsDuration = Value
    end,
})
HitFeedbackGroup:AddDropdown("AEVYX_HF_CHAM_MATERIAL", {
    Text = "Cham Material",
    Values = HitFeedback.MaterialNames,
    Default = HitFeedback.Config.HitChamsMaterial,
    Callback = function(Value)
        HitFeedback.Config.HitChamsMaterial = Value
    end,
})


local KillFeedbackGroup = Tabs.Misc:AddLeftGroupbox("Kill Feedback", "target")
KillFeedbackGroup:AddToggle("AEVYX_HF_KILL", {
    Text = "Kill Feedback",
    Tooltip = "Plays effects when you eliminate someone: sound and chams.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.KillFeedback = Value
        HitFeedback.RefreshBinding()
    end,
})
KillFeedbackGroup:AddToggle("AEVYX_HF_PLAY_KILL_SOUND", {
    Text = "Play Sound",
    Tooltip = "Plays a sound on every elimination. Add your own in Custom Sounds.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.PlayKillSound = Value
    end,
})
KillFeedbackGroup:AddDropdown("AEVYX_HF_KILL_SOUND", {
    Text = "Sound",
    Values = HitFeedback.SoundNames(),
    Default = HitFeedback.Config.KillSound,
    Callback = function(Value)
        HitFeedback.Config.KillSound = Value
    end,
})
KillFeedbackGroup:AddSlider("AEVYX_HF_KILL_VOLUME", {
    Text = "Volume",
    Default = HitFeedback.Config.KillVolume,
    Min = 0.1,
    Max = 1.5,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.KillVolume = Value
    end,
})
KillFeedbackGroup:AddSlider("AEVYX_HF_KILL_PITCH", {
    Text = "Pitch",
    Default = HitFeedback.Config.KillPitch,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.KillPitch = Value
    end,
})
KillFeedbackGroup:AddDivider()
KillFeedbackGroup:AddToggle("AEVYX_HF_KILL_CHAMS", {
    Text = "Chams",
    Tooltip = "Briefly highlights the body of the player you eliminated.",
    Default = false,
    Callback = function(Value)
        HitFeedback.Config.KillChams = Value
    end,
})
KillFeedbackGroup:AddLabel("Cham Color"):AddColorPicker("AEVYX_HF_KILL_CHAM_COLOR", {
    Default = HitFeedback.Config.KillChamsColor,
    Title = "Kill Cham Color",
    Callback = function(Value)
        HitFeedback.Config.KillChamsColor = Value
    end,
})
KillFeedbackGroup:AddSlider("AEVYX_HF_KILL_CHAM_TRANSPARENCY", {
    Text = "Cham Transparency",
    Default = HitFeedback.Config.KillChamsTransparency,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.KillChamsTransparency = Value
    end,
})
KillFeedbackGroup:AddSlider("AEVYX_HF_KILL_CHAM_DURATION", {
    Text = "Cham Duration",
    Default = HitFeedback.Config.KillChamsDuration,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        HitFeedback.Config.KillChamsDuration = Value
    end,
})
KillFeedbackGroup:AddDropdown("AEVYX_HF_KILL_CHAM_MATERIAL", {
    Text = "Cham Material",
    Values = HitFeedback.MaterialNames,
    Default = HitFeedback.Config.KillChamsMaterial,
    Callback = function(Value)
        HitFeedback.Config.KillChamsMaterial = Value
    end,
})


local CustomSoundGroup = Tabs.Misc:AddLeftGroupbox("Custom Sounds", "sparkles")
CustomSoundGroup:AddInput("AEVYX_HF_SOUND_NAME_INPUT", {
    Text = "Sound Name",
    Default = "",
    Finished = false,
    Placeholder = "Name shown in the sound pickers",
    Callback = function(Value)
        pendingCustomSoundName = Value or ""
    end,
})
CustomSoundGroup:AddInput("AEVYX_HF_SOUND_SOURCE_INPUT", {
    Text = "Sound ID / URL / File",
    Default = "",
    Finished = false,
    Placeholder = "rbxassetid://, https://, or a local file path",
    Callback = function(Value)
        pendingCustomSoundSource = Value or ""
    end,
})
CustomSoundGroup:AddButton({
    Text = "Add Custom Sound",
    Func = function()
        local ok = HitFeedback.AddCustomSound(pendingCustomSoundName, pendingCustomSoundSource)
        Library:Notify({
            Title = "Hit Feedback",
            Description = ok and "Custom sound added." or "Add failed: empty/duplicate name or missing source.",
            Time = 2,
        })
    end,
})
CustomSoundGroup:AddInput("AEVYX_HF_SOUND_REMOVE_INPUT", {
    Text = "Remove Sound",
    Default = "",
    Finished = false,
    Placeholder = "Name of a custom sound to remove",
    Callback = function(Value)
        pendingRemoveSoundName = Value or ""
    end,
})
CustomSoundGroup:AddButton({
    Text = "Remove Custom Sound",
    Func = function()
        local ok = HitFeedback.RemoveCustomSound(pendingRemoveSoundName)
        Library:Notify({
            Title = "Hit Feedback",
            Description = ok and "Custom sound removed." or "Remove failed: no such custom sound.",
            Time = 2,
        })
    end,
})


local ESPVisualGroup = Tabs.ESP:AddLeftGroupbox("ESP", "eye")

ESPVisualGroup:AddToggle("ESP_PREMIUM_ENABLED", {
    Text = "Enable ESP",
    Tooltip = "Enable the premium box ESP",
    Default = false,
    Callback = function(value)
        PremiumESPConfig.Enabled = value
    end,
})

ESPVisualGroup:AddToggle("WEAPON_ESP_ENABLED", {
    Text = "Weapon ESP",
    Tooltip = "Show equipped weapon name under players",
    Default = false,
    Callback = function(value)
        WeaponESPConfig.Enabled = value
    end,
})

ESPVisualGroup:AddToggle("ESP_PREMIUM_BOX", {
    Text = "Box",
    Default = true,
    Callback = function(value)
        PremiumESPConfig.Box = value
    end,
})

ESPVisualGroup:AddToggle("ESP_PREMIUM_HEALTH", {
    Text = "Health Bar",
    Default = true,
    Callback = function(value)
        PremiumESPConfig.HealthBar = value
    end,
})

ESPVisualGroup:AddToggle("ESP_PREMIUM_DISTANCE", {
    Text = "Name & Distance",
    Default = true,
    Callback = function(value)
        PremiumESPConfig.Distance = value
    end,
})

ESPVisualGroup:AddSlider("ESP_PREMIUM_MAX_DISTANCE", {
    Text = "Max Distance",
    Default = 1000,
    Min = 50,
    Max = 5000,
    Rounding = 0,
    Suffix = " studs",
    Callback = function(value)
        PremiumESPConfig.MaxDistance = value
    end,
})


ESPVisualGroup:AddToggle("ESP_PREMIUM_TEAMCHECK", {
    Text = "Team Check (TeamID)",
    Tooltip = "Hide players sharing your TeamID",
    Default = false,
    Callback = function(value)
        PremiumESPConfig.TeamCheck = value
    end,
})

ESPVisualGroup:AddToggle("SKELETON_ESP", {
    Text = "Skeleton ESP",
    Tooltip = "Show skeleton lines on players",
    Default = false,
    Callback = function(value)
        SkeletonESPConfig.Enabled = value
    end,
})

ESPVisualGroup:AddToggle("XRAY", {
    Text = "Xray",
    Tooltip = "Highlight players through walls",
    Default = false,
    Callback = function(value)
        GlobalSettings.ENABLE_XRAY = value
    end,
})

ESPVisualGroup:AddDivider()



local ESPStyleGroup = Tabs.ESP:AddRightGroupbox("Appearance", "palette")

ESPStyleGroup:AddLabel("Box Accent"):AddColorPicker("ESP_PREMIUM_BOX_COLOR", {
    Title = "Box Accent",
    Default = PremiumESPConfig.BoxColor,
    Callback = function(value)
        PremiumESPConfig.BoxColor = value
    end,
})

ESPStyleGroup:AddLabel("Text Accent"):AddColorPicker("ESP_PREMIUM_TEXT_COLOR", {
    Title = "Text Accent",
    Default = PremiumESPConfig.AccentColor,
    Callback = function(value)
        PremiumESPConfig.AccentColor = value
    end,
})


ESPStyleGroup:AddSlider("ESP_PREMIUM_TEXT_SIZE", {
    Text = "Text Size",
    Default = 13,
    Min = 10,
    Max = 22,
    Rounding = 0,
    Callback = function(value)
        PremiumESPConfig.TextSize = value
    end,
})



local SpoofGroup = Tabs.Spoof:AddLeftGroupbox("Spoof", "user")

SpoofGroup:AddToggle("SPOOF_NAME_ENABLED", {
    Text = "Spoof Name",
    Default = false,
    Callback = function(Value)
        Config.name_spoof = Value
        if Value then
            applyNameSpoofNow()
        end
    end,
})

SpoofGroup:AddInput("SPOOF_NAME_VALUE", {
    Text = "Name",
    Default = Config.your_spoofed_name,
    Finished = false,
    Placeholder = "Enter a name",
    Callback = function(Value)
        if Value and Value ~= "" then
            Config.your_spoofed_name = Value
            if Config.name_spoof then
                applyNameSpoofNow()
            end
        end
    end,
})

SpoofGroup:AddInput("SPOOF_ENEMY_NAME_VALUE", {
    Text = "Enemy Name",
    Default = Config.spoofed_enemy_names,
    Finished = false,
    Placeholder = "Enter an enemy name",
    Callback = function(Value)
        if Value and Value ~= "" then
            Config.spoofed_enemy_names = Value
            if Config.name_spoof then
                applyNameSpoofNow()
            end
        end
    end,
})

SpoofGroup:AddDivider()

SpoofGroup:AddToggle("SPOOF_LEVEL_ENABLED", {
    Text = "Spoof Level",
    Default = Config.level_spoof,
    Callback = function(Value)
        Config.level_spoof = Value
    end,
})

SpoofGroup:AddSlider("SPOOF_LEVEL_VALUE", {
    Text = "Level",
    Default = Config.spoofed_level,
    Min = 0,
    Max = 10000,
    Rounding = 0,
    Callback = function(Value)
        Config.spoofed_level = Value
    end,
})

SpoofGroup:AddDivider()

SpoofGroup:AddToggle("SPOOF_WINSTREAK_ENABLED", {
    Text = "Spoof Winstreak",
    Default = Config.winstreak_spoof,
    Callback = function(Value)
        Config.winstreak_spoof = Value
    end,
})

SpoofGroup:AddSlider("SPOOF_WINSTREAK_VALUE", {
    Text = "Winstreak",
    Default = Config.spoofed_winstreak,
    Min = 1,
    Max = 100000,
    Rounding = 0,
    Callback = function(Value)
        Config.spoofed_winstreak = Value
    end,
})

SpoofGroup:AddDivider()

SpoofGroup:AddToggle("SPOOF_DEVICE_ENABLED", {
    Text = "Spoof Device",
    Default = false,
    Callback = function(Value)
        DeviceSpoofConfig.Enabled = Value
        applyDeviceSpoof()
    end,
})

SpoofGroup:AddDropdown("SPOOF_DEVICE_TYPE", {
    Text = "Device Type",
    Values = {"MouseKeyboard", "Touch", "Gamepad", "VR"},
    Default = "MouseKeyboard",
    Callback = function(Value)
        DeviceSpoofConfig.Device = Value
        if DeviceSpoofConfig.Enabled then
            applyDeviceSpoof()
        end
    end,
})


local CosmeticsGroup = Tabs.Spoof:AddRightGroupbox("Unlock Cosmetics", "palette")

CosmeticsGroup:AddToggle("UNLOCK_COSMETICS", {
    Text = "Unlock All Cosmetics",
    Tooltip = "Unlocks all cosmetics",
    Default = false,
    Callback = function(Value)
        toggleCosmetics(Value)
    end,
})

CosmeticsGroup:AddDivider()

CosmeticsGroup:AddButton({
    Text = "Refresh Cosmetics",
    Func = function()
        pcall(function()
            _datCtrl.CurrentData:Replicate("WeaponInventory")
            _datCtrl.CurrentData:Replicate("FavoritedCosmetics")
            Library:Notify({
                Title = "Cosmetics",
                Description = "Inventory refreshed!",
                Time = 2,
            })
        end)
    end,
})

CosmeticsGroup:AddButton({
    Text = "Save Loadout",
    Func = function()
        _saveCfg()
        Library:Notify({
            Title = "Cosmetics",
            Description = "Loadout saved!",
            Time = 2,
        })
    end,
})

CosmeticsGroup:AddDivider()
CosmeticsGroup:AddLabel("Status: " .. (_cosmeticsEnabled and "Enabled" or "Disabled"))


local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = Library.ShowCustomCursor,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = Library.CornerRadius,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        Window:SetCornerRadius(value)
    end
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu keybind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)






do
    local AevyxVisualExtras = {
        SmoothTextures = false,
        DarkTextures = false,
        TransparentTextures = false,
        DisableParticles = false,
        DisableBeams = false,
        DisableTrails = false,
        DisableFireSmokeSparkles = false,
        HideDecals = false,
        HideClouds = false,
        DisableTerrainDecoration = false,
        DisableWaterReflections = false,
        HideAccessories = false,
        HideSkybox = false,
        Fullbright = false,
        NoShadows = false,
        NoFog = false,
        NoBloom = false,
        NoBlur = false,
        NoSunRays = false,
        NoColorCorrection = false,
    }

    local savedProperties = setmetatable({}, { __mode = "k" })
    local function saveAndSet(instance, property, value)
        local ok, original = pcall(function() return instance[property] end)
        if not ok then return end
        local props = savedProperties[instance]
        if not props then
            props = {}
            savedProperties[instance] = props
        end
        if props[property] == nil then props[property] = original end
        pcall(function() instance[property] = value end)
    end

    local function restoreProperty(instance, property)
        local props = savedProperties[instance]
        if not props or props[property] == nil then return end
        local original = props[property]
        pcall(function() instance[property] = original end)
        props[property] = nil
    end

    local function restoreFeature(predicate, property)
        for instance, props in pairs(savedProperties) do
            if instance and instance.Parent and predicate(instance) then
                restoreProperty(instance, property)
            end
        end
    end

    local function applyOne(instance, feature)
        if not instance or not instance.Parent then return end
        if feature == "SmoothTextures" and instance:IsA("BasePart") then
            saveAndSet(instance, "Material", Enum.Material.SmoothPlastic)
        elseif feature == "DarkTextures" and instance:IsA("BasePart") then
            local ok, color = pcall(function() return instance.Color end)
            if ok then saveAndSet(instance, "Color", color:Lerp(Color3.new(0, 0, 0), 0.45)) end
        elseif feature == "TransparentTextures" and instance:IsA("BasePart") then
            saveAndSet(instance, "LocalTransparencyModifier", 0.35)
        elseif feature == "DisableParticles" and instance:IsA("ParticleEmitter") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "DisableBeams" and instance:IsA("Beam") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "DisableTrails" and instance:IsA("Trail") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "DisableFireSmokeSparkles" and (instance:IsA("Fire") or instance:IsA("Smoke") or instance:IsA("Sparkles")) then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "HideDecals" and (instance:IsA("Decal") or instance:IsA("Texture")) then
            saveAndSet(instance, "Transparency", 1)
        elseif feature == "HideClouds" and instance:IsA("Clouds") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "DisableWaterReflections" and instance == workspace.Terrain then
            saveAndSet(instance, "WaterReflectance", 0)
        elseif feature == "HideAccessories" and instance:IsA("Accessory") then
            for _, part in ipairs(instance:GetDescendants()) do
                if part:IsA("BasePart") then saveAndSet(part, "LocalTransparencyModifier", 1) end
            end
        elseif feature == "HideSkybox" and instance:IsA("Sky") then
            for _, prop in ipairs({ "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp" }) do
                saveAndSet(instance, prop, "")
            end
        elseif feature == "NoBloom" and instance:IsA("BloomEffect") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "NoBlur" and instance:IsA("BlurEffect") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "NoSunRays" and instance:IsA("SunRaysEffect") then
            saveAndSet(instance, "Enabled", false)
        elseif feature == "NoColorCorrection" and instance:IsA("ColorCorrectionEffect") then
            saveAndSet(instance, "Enabled", false)
        end
    end

    local function restoreOne(instance, feature)
        if not instance then return end
        local function restore(property) restoreProperty(instance, property) end
        if feature == "SmoothTextures" and instance:IsA("BasePart") then restore("Material")
        elseif feature == "DarkTextures" and instance:IsA("BasePart") then restore("Color")
        elseif feature == "TransparentTextures" and instance:IsA("BasePart") then restore("LocalTransparencyModifier")
        elseif feature == "DisableParticles" and instance:IsA("ParticleEmitter") then restore("Enabled")
        elseif feature == "DisableBeams" and instance:IsA("Beam") then restore("Enabled")
        elseif feature == "DisableTrails" and instance:IsA("Trail") then restore("Enabled")
        elseif feature == "DisableFireSmokeSparkles" and (instance:IsA("Fire") or instance:IsA("Smoke") or instance:IsA("Sparkles")) then restore("Enabled")
        elseif feature == "HideDecals" and (instance:IsA("Decal") or instance:IsA("Texture")) then restore("Transparency")
        elseif feature == "HideClouds" and instance:IsA("Clouds") then restore("Enabled")
        elseif feature == "DisableWaterReflections" and instance == workspace.Terrain then restore("WaterReflectance")
        elseif feature == "HideAccessories" and instance:IsA("Accessory") then
            for _, part in ipairs(instance:GetDescendants()) do if part:IsA("BasePart") then restoreProperty(part, "LocalTransparencyModifier") end end
        elseif feature == "HideSkybox" and instance:IsA("Sky") then
            for _, prop in ipairs({ "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp" }) do restore(prop) end
        elseif feature == "NoBloom" and instance:IsA("BloomEffect") then restore("Enabled")
        elseif feature == "NoBlur" and instance:IsA("BlurEffect") then restore("Enabled")
        elseif feature == "NoSunRays" and instance:IsA("SunRaysEffect") then restore("Enabled")
        elseif feature == "NoColorCorrection" and instance:IsA("ColorCorrectionEffect") then restore("Enabled") end
    end

    local function processFeature(feature, enabled)
        AevyxVisualExtras[feature] = enabled
        if feature == "Fullbright" then
            if enabled then
                saveAndSet(Services.Lighting, "Ambient", Color3.new(1, 1, 1))
                saveAndSet(Services.Lighting, "OutdoorAmbient", Color3.new(1, 1, 1))
                saveAndSet(Services.Lighting, "Brightness", 3)
            else
                restoreProperty(Services.Lighting, "Ambient")
                restoreProperty(Services.Lighting, "OutdoorAmbient")
                restoreProperty(Services.Lighting, "Brightness")
            end
            return
        elseif feature == "NoShadows" then
            if enabled then saveAndSet(Services.Lighting, "GlobalShadows", false) else restoreProperty(Services.Lighting, "GlobalShadows") end
            return
        elseif feature == "NoFog" then
            if enabled then
                saveAndSet(Services.Lighting, "FogStart", 0)
                saveAndSet(Services.Lighting, "FogEnd", 1000000)
            else
                restoreProperty(Services.Lighting, "FogStart")
                restoreProperty(Services.Lighting, "FogEnd")
            end
            return
        elseif feature == "DisableTerrainDecoration" then
            if enabled then saveAndSet(workspace.Terrain, "Decoration", false) else restoreProperty(workspace.Terrain, "Decoration") end
            return
        end

        for _, instance in ipairs(game:GetDescendants()) do
            if enabled then applyOne(instance, feature) else restoreOne(instance, feature) end
        end
    end

    local extrasConnection = game.DescendantAdded:Connect(function(instance)
        for feature, enabled in pairs(AevyxVisualExtras) do
            if enabled then task.defer(applyOne, instance, feature) end
        end
    end)

    local LunaraVisualGroup = Tabs.Visuals:AddLeftGroupbox("AEVYX Visual Extras", "sparkles")
    local function addExtraToggle(id, text, feature, default)
        LunaraVisualGroup:AddToggle(id, {
            Text = text,
            Default = default or false,
            Callback = function(value)
                local ok, err = pcall(processFeature, feature, value)
                if not ok then warn("[AEVYX/Lunara Extras] " .. feature .. ": " .. tostring(err)) end
            end,
        })
    end

    addExtraToggle("AEVYX_LUNARA_SMOOTH_TEXTURES", "Smooth Textures", "SmoothTextures")
    addExtraToggle("AEVYX_LUNARA_DARK_TEXTURES", "Dark Textures", "DarkTextures")
    addExtraToggle("AEVYX_LUNARA_TRANSPARENT_TEXTURES", "Transparent Textures", "TransparentTextures")
    addExtraToggle("AEVYX_LUNARA_NO_PARTICLES", "Disable Particles", "DisableParticles")
    addExtraToggle("AEVYX_LUNARA_NO_BEAMS", "Disable Beams", "DisableBeams")
    addExtraToggle("AEVYX_LUNARA_NO_TRAILS", "Disable Trails", "DisableTrails")
    addExtraToggle("AEVYX_LUNARA_NO_FX", "Disable Fire / Smoke / Sparkles", "DisableFireSmokeSparkles")
    addExtraToggle("AEVYX_LUNARA_HIDE_DECALS", "Hide Decals / Textures", "HideDecals")
    addExtraToggle("AEVYX_LUNARA_HIDE_CLOUDS", "Hide Clouds", "HideClouds")
    addExtraToggle("AEVYX_LUNARA_NO_TERRAIN_DECOR", "Disable Terrain Decoration", "DisableTerrainDecoration")
    addExtraToggle("AEVYX_LUNARA_NO_WATER_REFLECTIONS", "Disable Water Reflections", "DisableWaterReflections")
    addExtraToggle("AEVYX_LUNARA_HIDE_ACCESSORIES", "Hide Accessories", "HideAccessories")
    addExtraToggle("AEVYX_LUNARA_HIDE_SKYBOX", "Hide Skybox", "HideSkybox")
    addExtraToggle("AEVYX_LUNARA_FULLBRIGHT", "Fullbright", "Fullbright")
    addExtraToggle("AEVYX_LUNARA_NO_SHADOWS", "Disable Global Shadows", "NoShadows")
    addExtraToggle("AEVYX_LUNARA_NO_FOG", "Disable Fog", "NoFog")
    addExtraToggle("AEVYX_LUNARA_NO_BLOOM", "Disable Bloom Effect", "NoBloom")
    addExtraToggle("AEVYX_LUNARA_NO_BLUR", "Disable Blur Effect", "NoBlur")
    addExtraToggle("AEVYX_LUNARA_NO_SUNRAYS", "Disable Sun Rays", "NoSunRays")
    addExtraToggle("AEVYX_LUNARA_NO_COLOR_CORRECTION", "Disable Color Correction", "NoColorCorrection")
end



end)()



do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    local CONFIG = {
        Speed = 20,
        Invisible = true,
    }

    local state = {
        enabled = false,
        flyPart = nil,
        weld = nil,
        bv = nil,
        bg = nil,
        conn = nil,
        savedTransparency = {},
        savedCollide = {},
    }

    local function getControlModule()
        local ok, ctrl = pcall(function()
            local playerScripts = LocalPlayer:WaitForChild("PlayerScripts", 3)
            local playerModule = playerScripts and playerScripts:WaitForChild("PlayerModule", 3)
            local controlModule = playerModule and playerModule:WaitForChild("ControlModule", 3)
            return controlModule and require(controlModule)
        end)
        return ok and ctrl or nil
    end

    local ctrlModule = getControlModule()

    local function getMoveVector()
        if ctrlModule then
            local ok, vec = pcall(function()
                return ctrlModule:GetMoveVector()
            end)
            if ok and typeof(vec) == "Vector3" then
                return vec
            end
        end
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            return hum.MoveDirection
        end
        return Vector3.zero
    end

    local function setCharacterVisibility(visible)
        local char = LocalPlayer.Character
        if not char then return end

        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                if not visible then
                    if state.savedTransparency[part] == nil then
                        state.savedTransparency[part] = part.Transparency
                        state.savedCollide[part] = part.CanCollide
                    end
                    part.Transparency = 1
                    part.CanCollide = false
                elseif state.savedTransparency[part] ~= nil then
                    part.Transparency = state.savedTransparency[part]
                    part.CanCollide = state.savedCollide[part]
                end
            elseif part:IsA("Decal") or part:IsA("Texture") then
                if not visible then
                    if state.savedTransparency[part] == nil then
                        state.savedTransparency[part] = part.Transparency
                    end
                    part.Transparency = 1
                elseif state.savedTransparency[part] ~= nil then
                    part.Transparency = state.savedTransparency[part]
                end
            end
        end

        if visible then
            state.savedTransparency = {}
            state.savedCollide = {}
        end
    end

    local function start()
        if state.enabled then return end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        local flyPart = Instance.new("Part")
        flyPart.Name = "StandaloneFlyPart"
        flyPart.Size = Vector3.new(0.1, 0.1, 0.1)
        flyPart.Transparency = 1
        flyPart.CanCollide = false
        flyPart.Massless = true
        flyPart.Anchored = false
        flyPart.Parent = Workspace

        local weld = Instance.new("Weld")
        weld.Part0 = flyPart
        weld.Part1 = hrp
        weld.C0 = CFrame.new(0, 0, 0)
        weld.Parent = flyPart

        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.zero
        bv.Parent = flyPart

        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 10000
        bg.D = 100
        bg.CFrame = Camera.CFrame
        bg.Parent = flyPart

        state.flyPart = flyPart
        state.weld = weld
        state.bv = bv
        state.bg = bg
        state.enabled = true

        if CONFIG.Invisible then
            setCharacterVisibility(false)
        end

        state.conn = RunService.RenderStepped:Connect(function()
            if not state.enabled then return end
            local c = LocalPlayer.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local root = c and c:FindFirstChild("HumanoidRootPart")
            if not root or not h then return end

            if state.weld and state.weld.Part1 ~= root then
                state.weld.Part1 = root
            end

            h.PlatformStand = true
            if state.bg then state.bg.CFrame = Camera.CFrame end

            local mv = getMoveVector()
            local worldMove = Camera.CFrame:VectorToWorldSpace(Vector3.new(mv.X, 0, mv.Z))
            if worldMove.Magnitude > 1 then
                worldMove = worldMove.Unit
            end
            if state.bv then
                state.bv.Velocity = worldMove * CONFIG.Speed * 2
            end
        end)
    end

    local function stop()
        if not state.enabled then return end
        state.enabled = false

        if state.conn then
            state.conn:Disconnect()
            state.conn = nil
        end
        if state.flyPart then
            state.flyPart:Destroy()
            state.flyPart = nil
        end

        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end

        state.weld = nil
        state.bv = nil
        state.bg = nil

        if CONFIG.Invisible then
            setCharacterVisibility(true)
        end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        if state.enabled then
            stop()
            task.wait(0.5)
            start()
        end
    end)

    getgenv().StandaloneFly = {
        Start = start,
        Stop = stop,
        Toggle = function()
            if state.enabled then stop() else start() end
        end,
        SetSpeed = function(v)
            CONFIG.Speed = math.clamp(tonumber(v) or CONFIG.Speed, 1, 200)
        end,
        IsActive = function()
            return state.enabled
        end,
    }

    local FreecamGroup = Tabs.Main:AddLeftGroupbox("Freecam", "video")
    FreecamGroup:AddToggle("FREECAM_ENABLED", {
        Text = "Enable Freecam",
        Default = false,
        Callback = function(Value)
            if Value then start() else stop() end
        end,
    })
    FreecamGroup:AddSlider("FREECAM_SPEED", {
        Text = "Speed",
        Default = 20,
        Min = 1,
        Max = 200,
        Rounding = 0,
        Callback = function(Value)
            CONFIG.Speed = Value
        end,
    })
end


Library.ToggleKeybind = Library.Options.MenuKeybind


ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("Aevyx")
SaveManager:SetFolder("Aevyx")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

getgenv().AIMBOT_RENDER_BIND = "NoksVIP_Aimbot"

pcall(function()
    Services.RunService:UnbindFromRenderStep(getgenv().AIMBOT_RENDER_BIND)
end)

Services.RunService:BindToRenderStep(getgenv().AIMBOT_RENDER_BIND, Enum.RenderPriority.Camera.Value + 1, function(dt)
    ErrorHandlerInstance:SafeCall(function()
        AimbotInstance:Update(dt)
        IOInstance:UpdateFOVCircles()
    end)
end)

Services.RunService:BindToRenderStep("NoksVIP_Speedwalk", Enum.RenderPriority.Character.Value, function()
    ErrorHandlerInstance:SafeCall(applySpeedwalk)
end)


task.spawn(function()
    while true do
        task.wait(0.5)
        local now = tick()
        for k, v in pairs(AimbotInstance.VisibilityCache) do
            if not k.Parent or (now - v.t) > AimbotInstance.CacheTTL * 3 then
                AimbotInstance.VisibilityCache[k] = nil
            end
        end
    end
end)


if type(Library.OnUnload) == "function" then
    Library:OnUnload(function()
        stopWeather()
        stopViewModelEffects()
        stopCrosshair()
        restorePostProcessing()
        stopNoclip()
        stopStretchRes()
        HitFeedback.Destroy()
        pcall(function() getgenv().AevyxStopPersonalText() end)
        pcall(function() getgenv().StandaloneFreecam.Stop() end)
    end)
end



getgenv().eteritum = getgenv().eteritum or {}
getgenv().eteritum.guns = getgenv().eteritum.guns or {}

getgenv().noSpreadHooked = false
function setupNoSpread()
    if getgenv().noSpreadHooked then return end
    getgenv().noSpreadHooked = true
    -- New no spread code provided by user, wrapped to avoid top-level return killing script
    -- but still disabling IsFullyAiming
    task.spawn(function()
        local people = game:GetService("Players")
        local yo, gun = pcall(function()
            return require(people.LocalPlayer.PlayerScripts.Modules.ItemTypes.Gun)
        end)

        if not yo or not gun or not gun.IsFullyAiming then
            return
        end

        local aim = gun.IsFullyAiming
        gun.IsFullyAiming = function(self, ...)
            return true
        end
    end)
end


(function()
local autoLoadoutRemotePick
local autoLoadoutRemotePrePick

local function fetchAutoLoadoutRemotes()
    if autoLoadoutRemotePick then return true end
    local success = pcall(function()
        autoLoadoutRemotePick = repS.Remotes.Replication.Fighter.PickWeapons
        autoLoadoutRemotePrePick = repS.Remotes.Duels.PickWeaponsAheadOfTime
    end)
    return success and autoLoadoutRemotePick ~= nil
end

task.spawn(function()
    while task.wait(0.1) do
        if not getgenv().AutoLoadoutConfig.Enabled then continue end
        local playerGui = lplr:FindFirstChildOfClass("PlayerGui")
        local selectionInterface = playerGui and playerGui:FindFirstChild("PickWeapons", true)
        if selectionInterface and selectionInterface.Visible then
            if not fetchAutoLoadoutRemotes() then continue end
            local payload = {
                [1] = getgenv().AutoLoadoutConfig.Primary,
                [2] = getgenv().AutoLoadoutConfig.Secondary,
                [3] = getgenv().AutoLoadoutConfig.Melee,
                [4] = getgenv().AutoLoadoutConfig.Utility,
            }
            pcall(function()
                autoLoadoutRemotePick:FireServer(payload)
            end)
            pcall(function()
                autoLoadoutRemotePrePick:FireServer(payload)
            end)
            repeat
                task.wait(0.1)
            until not (selectionInterface and selectionInterface.Visible)
        end
    end
end)
end)()



Library:Notify({
    Title = "Aevyx",
    Description = "Loaded successfully!",
    Time = 3,
})