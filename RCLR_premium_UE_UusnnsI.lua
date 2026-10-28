-- RCLR Premium — UI swapped to Unnamed Enhancements library
-- Only the library loader is changed; all gameplay code is identical.

-- Point at UE's library instead of RCLR_Monova
local LIBRARY_URL = "https://raw.githubusercontent.com/mstudio45/LinoriaLib/refs/heads/main/Example.lua"
-- ^ swap this URL to wherever UE's Library.lua actually lives in your executor env;
--   if UE loads its lib from getgenv().Library directly (already injected), we handle that below.

local loadstring = loadstring or load

local RCLR_Functions = {}
local RCLR_Run = {alive=true, connections={}}
RCLR_Run.previousRun = (type(getgenv) == "function" and getgenv() or _G).RCLR_PREM_Run
if RCLR_Run.previousRun and type(RCLR_Run.previousRun.shutdown) == "function" then
    pcall(RCLR_Run.previousRun.shutdown)
end
RCLR_Run.shutdown = function()
    RCLR_Run.alive = false
    for _, connection in pairs(RCLR_Run.connections) do
        pcall(function() connection:Disconnect() end)
    end
end
(type(getgenv) == "function" and getgenv() or _G).RCLR_PREM_Run = RCLR_Run

local function RCLR_getgenv()
    if type(getgenv) == "function" then return getgenv() end
    return _G
end

-- ============================================================
-- LIBRARY LOADER — uses UE's Library if already present,
-- otherwise fetches it from LIBRARY_URL
-- ============================================================
local function loadUELibrary()
    local g = RCLR_getgenv()

    -- If Unnamed Enhancements already injected its Library into getgenv(), reuse it.
    -- UE sets getgenv().Library; we just reference that same table so both scripts
    -- share one UI instance (same window, same toggles — that's what the Chief wants).
    local existing = g.Library
    if type(existing) == "table" and existing.CreateWindow then
        return existing
    end

    -- Fallback: fetch + execute UE's library source
    local ok, src = pcall(function() return game:HttpGet(LIBRARY_URL) end)
    if not ok or type(src) ~= "string" or #src < 500 then
        error("[RCLR PREM] HttpGet failed: " .. tostring(src))
    end

    local fn, err = loadstring(src)
    if not fn then error("[RCLR PREM] compile error: " .. tostring(err)) end

    local ok2, lib = pcall(fn)
    if not ok2 or type(lib) ~= "table" then
        -- some UE libs return nothing and just set getgenv().Library
        lib = g.Library
        if type(lib) ~= "table" then
            error("[RCLR PREM] runtime error: " .. tostring(lib))
        end
    end
    return lib
end

getgenv().RCLR_PREM_PresetShown = false
getgenv().RCLR_PREM_LoadingDone = false

local Library = loadUELibrary()
-- Tag so other code can detect this is RCLR's instance riding on UE's lib
Library.RCLR_PREM = true

local g = RCLR_getgenv()
g.RCLR_PREM_Library = Library
-- Keep UE's own globals intact — we READ them, never overwrite
-- g.Library is UE's; g.Toggles / g.Options are UE's
-- RCLR gets its own shadow copies
local Toggles = Library.Toggles or {}
local Options = Library.Options or {}
g.RCLR_Toggles = Toggles
g.RCLR_Options = Options

local function Notify(text, duration)
    pcall(function() if Library and Library.Notify then Library:Notify(tostring(text), duration or 3) end end)
end

-- ============================================================
-- WINDOW — created inside UE's already-open UI
-- UE's Library.CreateWindow will add a new window tab / panel
-- depending on how its CreateWindow is implemented.
-- If UE's lib doesn't support multiple windows, this reuses
-- the existing one and just adds new tabs to it.
-- ============================================================
local function detectGameName()
    local name = nil
    pcall(function()
        local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
        if info and type(info.Name) == "string" and info.Name ~= "" then name = info.Name end
    end)
    if not name or name == "" then name = tostring(game.Name or "Unknown") end
    local lower = string.lower(name)
    if string.find(lower, "rival", 1, true)
        or (string.find(lower, "ranked", 1, true) and string.find(lower, "1v1", 1, true)) then
        return "Rivals"
    end
    return name
end

local Window = Library:CreateWindow({
    Title    = "RCLR Lua Prem - discord.gg/ZmN2Djb7m",
    GameName = detectGameName(),
    Center   = true,
    AutoShow = true,
    Size     = UDim2.fromOffset(560, 645),
})

getgenv().RCLR_PREM_LoadingDone = true

-- ============================================================
-- FROM HERE DOWN: identical to original RCLR premium src.
-- All gameplay systems, tabs, toggles, sliders — unchanged.
-- ============================================================

local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local UserInputService= game:GetService("UserInputService")
local ReplicatedStorage= game:GetService("ReplicatedStorage")
local LocalPlayer     = Players.LocalPlayer
local Camera          = workspace.CurrentCamera

local char, root, hum
local conns = {}

RCLR_Run.connections.featureShutdown = { Disconnect = function()
    for _, connection in pairs(conns) do
        pcall(function() connection:Disconnect() end)
    end
end }
local function killConn(key)
    if conns[key] then conns[key]:Disconnect(); conns[key] = nil end
end
local function getLocalRoot() return root end

local MAX_DODGES_PER_FRAME = 3
local _dodgeFrame = -1
local _dodgeFrameCount = 0
local function tryDodgeFrame()
    local f = math.floor(tick() * 60 + 0.5)
    if f ~= _dodgeFrame then _dodgeFrame = f; _dodgeFrameCount = 0 end
    if _dodgeFrameCount >= MAX_DODGES_PER_FRAME then return false end
    _dodgeFrameCount = _dodgeFrameCount + 1
    return true
end

local CFG = {
    VOID_ENABLED = false, VOID_METHOD = "Quantum",
    SPEED = 1e15, CHAOS = 0.98, BASE_X = 0, BASE_Y = 0, BASE_Z = 0,
    RADIUS = 1e11, VOID_Y_MIN = -1e15, VOID_Y_MAX = 1e15,
    TP_MIN_STUDS = -1e10, TP_MAX_STUDS = 1e10,
    TP_RAND_ENABLED = true, TP_RAND_MIN = -1e10, TP_RAND_MAX = 1e10, TP_CORNER_ONLY = false,
    TP_VERT_SPIKE = true, TP_VERT_MULT_MIN = 0.5, TP_VERT_MULT_MAX = 3.0,
    TP_CORNER_WEIGHT = 0.20, TP_EDGE_WEIGHT = 0.10, TP_SCREEN_JITTER = 0.02,
    TP_SCREEN_CLAMP = true, TP_VIEWPORT_RAY = true, TP_NEG_BIAS = true,
    TP_PRESERVE_Y = false,
    VOID_SAFE_RADIUS = 0, VOID_ORBIT_TARGET = false, VOID_ORBIT_SPEED = 90,
    VOID_STOP_ON_DAMAGE = false, VOID_PREDICTIVE = false, VOID_PREDICT_LEAD = 0.15,
    VOID_AUTO_REENABLE = false, VOID_ANTIFLING = true,
    VOID_FREEZE_ON_GROUND = false, VOID_ANTIVOID = false,
    VOID_DURATION_ENABLED = false, VOID_DURATION = 10,
    VOID_RANDOM_DURATION = false, VOID_DURATION_MIN = 5, VOID_DURATION_MAX = 30,
    VOID_STAY_IN_REGION = false, VOID_REGION_X = 1e4, VOID_REGION_Y = 1e4, VOID_REGION_Z = 1e4,
    VOID_REGION_CIRCLE = true, VOID_REGION_BOX = false, VOID_REGION_CENTER_SELF = true,
    VOID_REGION_CX = 0, VOID_REGION_CY = 0, VOID_REGION_CZ = 0,
    VOID_REGION_PUSH = true, VOID_REGION_PUSH_AWAY = 120,
    VOID_REGION_COLLAPSE = false, VOID_REGION_COLLAPSE_SPD = 50,
    VOID_REGION_NOTIFY_EXIT = false, VOID_REGION_SNAP_EDGE = true,
    VOID_LOG_POSITIONS = false,
    SMART_EVASION = false, SMART_EVASION_INF = false,
    EVASION_RANGE = 80, EVASION_THREAT_DIST = 40,
    EVASION_DODGE_POWER = 100, EVASION_COOLDOWN = 0.03,
    EVASION_PREDICT_TIME = 0.18, EVASION_NOTIFY = false,
    EVASION_MICRO_JITTER = true, EVASION_VERTICAL_SPIKE = true,
    EVASION_LAYERED = true, EVASION_THREAT_SCALE = true,
}

local cfg = {
    orbitEnabled = false, orbitSpeed = 90, orbitDist = 8, orbitHeight = 0,
    orbitLerp = 0.3, orbitMode = "Circle", orbitPredict = false, orbitPredStr = 0.2,
    orbitFace = true, orbitLockDist = 999999999, orbitTarget = "Closest", orbitAxis = "XZ",
    orbitReverse = false, orbitRandRad = false, orbitRandMin = 5, orbitRandMax = 20,
    orbitYawOff = 0, orbitPitchOff = 0, orbitOffX = 0, orbitOffZ = 0,
    orbitHeightOscillate = false, orbitHeightOscAmp = 5, orbitHeightOscSpeed = 2,
    orbitSpeedRandom = false, orbitSpeedRandMin = 20, orbitSpeedRandMax = 200,
    orbitDistPulse = false, orbitDistPulseAmp = 5, orbitDistPulseSpeed = 1,
    orbitZigzag = false, orbitZigzagAmp = 3, orbitZigzagFreq = 4,
    orbitSnapBack = false, orbitSnapInterval = 0.5,
}

local cfgDodge = {
    predEnabled = false, predRadius = 400, predDodgeDist = 160,
    predCooldown = 0.008, predThreshold = 150, predMult = 1,
    predLeadTime = 0.22, predShootDetect = true, predShootDot = 0.60,
    predShootDist = 100, predBulletSpd = 200, predReactTime = 0.06,
    predRaycast = true, predMultiPoint = true, predBackstep = true,
    predReactionLadder = true, predThreatScore = true,
    predAimVector = true, predCameraBone = true, predAnimDetect = true,
    predRemoteHook = true, predPredictiveAim = true, predPredictiveLead = 0.25,
    predInfiniteRange = true, predNotifyAnywhere = false,
    predSmoothedTargeting = true, predAlignLookAtThreat = true,
    predAdaptiveCooldown = true, predCooldownDecay = 0.6,
    predRecoilOffset = 0.25, predLeadNoise = 0.05,
    predLookaheadBias = 0.62, predPlanDontTPClose = 0.35,
}

local antiBaitCFG = {
    enabled = false, velSpikeEnabled = true, velThreshold = 200,
    velDodgeDist = 100, flickerEnabled = true, flickerWindow = 0.3,
    flickerMinTps = 2, flickerTpDist = 10, dodgeCooldown = 0.005,
    dodgeMode = "Perpendicular", notifyOnDodge = true,
    dodgeOnShoot = true, shootLookThresh = 0.85,
    gunPredEnabled = true, gunPredDot = 0.80, gunPredVelMin = 30,
    gunPredDodgeDist = 160, gunPredCooldown = 0.005, gunPredLead = 0.22,
    baitEnabled = true, baitStallTime = 0.08, baitStallChance = 0.4,
    baitFakeLock = true, baitFakeLockTime = 0.06,
    baitHookActivate = true, baitReactionWindow = 0.3,
    baitNotifyLabel = true,
    universalRemotes = true, universalTools = true,
    universalAnimation = true, universalVelocity = true, universalAim = true,
    reScanInterval = 5,
    infiniteRange = true, infiniteRadius = 5e12,
}

local translocCFG = {
    enabled = false, frequency = 256, offsetDist = 999000000000,
    offsetMode = "Ahead", offsetY = 0, fakeVel = true,
    fakeVelMag = 1e10, snapBack = true, jitter = true,
    jitterAmp = 1e11, layers = 5,
    burstMode = false, burstCount = 10, burstInterval = 0.001,
    randomFrequency = false, freqMin = 50, freqMax = 500,
    spinFake = false, spinFakeSpeed = 720,
    mirrorX = false, mirrorZ = false,
    cascadeOffset = false, cascadeStep = 1e11,
    wavePattern = false, waveFreq = 2, waveAmp = 1e11,
    pingPong = false, pingPongDist = 1e12,
    pulse = false, pulseAmp = 1e11, pulseSpeed = 1,
    diagonal = false, diagonalAngle = 45,
    alternatingVertical = false, altVertAmp = 1e11,
    screenEdge = false, orbitFake = false, orbitSpeed = 90, orbitRadius = 1e11,
    zoneEscape = false, zoneEscapeRadius = 200,
    autoDodge = false, autoDodgeRadius = 60,
    networkOwnerFix = true,
}

local riotGodmodeCFG = {
    enabled = false, speed = 0.03, evadeRange = 30,
    spinSpeed = 180, avoidBullets = true, bulletDodge = 40,
    heightVariance = 10, groundSnap = false, phaseMode = false,
    phaseInterval = 0.02, spinAxis = "Y", randomAxis = false,
    maxJump = 200, minJump = 10, multiTp = false,
    multiTpCount = 3, multiTpDelay = 0.01,
}

local riotAbuserCFG = {
    enabled = false, mode = "Stick", height = 3, forward = 0, right = 0, down = 0,
    autoShoot = true, attackRange = 10, orbitEnabled = false,
    orbitRadius = 5, orbitSpeed = 200, orbitHeight = 2,
    spinOnTarget = false, spinSpeed = 360, phaseOffset = 3,
    multiTarget = false, randomOffset = false, randomOffAmp = 2,
    bounceHeight = 5, bounceSpeed = 8, shootCooldown = 0.05,
    lastShot = 0, predictTarget = false, predictLead = 0.1,
    forceFaceTarget = true,
}

local aaSettings = {
    enabled = false, mode = "RandomSpin", speed = 5000,
    angle = 90, randomSpeed = true, jitterPitch = true,
    pitchAngle = 45, yawAngle = 45, staticYaw = 90, staticPitch = 0,
    customYaw = 180, customPitch = 0, jitterYaw = true,
    fakeAngle = false, fakeYaw = 45, fakePitch = 0,
    microJitter = false, microJitterAmp = 5, microJitterSpeed = 30,
    desyncMode = false, desyncOffset = 180,
    rollEnabled = false, rollSpeed = 360,
    breatheEffect = false, breatheAmp = 3, breatheSpeed = 1,
    randomFlip = false, flipChance = 0.05,
}

local function getClosest()
    if not root then return nil end
    local best, bestD = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local d = (root.Position - hrp.Position).Magnitude
        if d < bestD then bestD = d; best = p end
    end
    return best
end

local function getTarget(mode)
    if mode == "Closest" then return getClosest() end
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            table.insert(list, p)
        end
    end
    if #list == 0 then return nil end
    if mode == "Random" then return list[math.random(1, #list)]
    elseif mode == "Weakest" then
        table.sort(list, function(a, b)
            local ha = a.Character:FindFirstChildOfClass("Humanoid")
            local hb = b.Character:FindFirstChildOfClass("Humanoid")
            return (ha and ha.Health or 0) < (hb and hb.Health or 0)
        end)
        return list[1]
    elseif mode == "Strongest" then
        table.sort(list, function(a, b)
            local ha = a.Character:FindFirstChildOfClass("Humanoid")
            local hb = b.Character:FindFirstChildOfClass("Humanoid")
            return (ha and ha.Health or 0) > (hb and hb.Health or 0)
        end)
        return list[1]
    end
    return list[1]
end

local function AddBindableToggle(group, flag, text, default, callback)
    return group:AddToggle(flag, { Text = text, Default = default or false, Callback = callback })
end

local function predictPos(hrp, lead)
    if not hrp then return Vector3.zero end
    local vel = hrp.AssemblyLinearVelocity
    local grav = Vector3.new(0, -workspace.Gravity * 0.5, 0)
    return hrp.Position + vel * lead + grav * (lead * lead * 0.5)
end

local function getAimOrigin(plr)
    if not plr or not plr.Character then return nil end
    return plr.Character:FindFirstChild("Head")
        or plr.Character:FindFirstChild("CameraBone", true)
        or plr.Character:FindFirstChild("HumanoidRootPart")
end

local function getInfiniteRange() return 5e12 end

local function enemyAimingUniversal(plr, myPos, dot)
    local origin = getAimOrigin(plr)
    if not origin then return false end
    local look = origin.CFrame.LookVector
    local eye = origin.Position + look * 0.5
    local toMe = myPos - eye
    if toMe.Magnitude < 0.01 then return false end
    return look:Dot(toMe.Unit) > dot
end

local function perpDodgeDir(fromPos, myPos)
    local flat = Vector3.new(fromPos.X - myPos.X, 0, fromPos.Z - myPos.Z)
    if flat.Magnitude < 0.01 then flat = Vector3.new(1, 0, 0) end
    flat = flat.Unit
    local p1 = Vector3.new(-flat.Z, 0, flat.X)
    local p2 = Vector3.new(flat.Z, 0, -flat.X)
    return (math.random(0, 1) == 0 and p1 or p2) + Vector3.new(0, (math.random() - 0.5) * 0.4, 0)
end

local function buildThreatMap(myPos)
    local map = {}
    if not myPos then return map end
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        local tool = p.Character:FindFirstChildOfClass("Tool")
        local origin = getAimOrigin(p) or hrp
        local look = origin.CFrame.LookVector
        local eye = origin.Position + look * 0.5
        local toMe = myPos - eye
        local dist = toMe.Magnitude
        if dist < 0.01 then continue end
        local aimDot = look:Dot(toMe.Unit)
        local velDot = 0
        local vel = hrp.AssemblyLinearVelocity
        if vel.Magnitude > 1 then velDot = vel.Unit:Dot(toMe.Unit) end
        local score = math.max(0, aimDot) * 45 + math.max(0, velDot) * 20
        if tool then score = score + 25 end
        local distFactor = CFG.SMART_EVASION_INF and 30 or math.max(0, 1 - dist / 250) * 30
        score = score + distFactor
        map[p] = { hrp = hrp, dist = dist, aimDot = aimDot, velDot = velDot, score = score, hasTool = tool ~= nil, origin = origin }
    end
    return map
end

local function predictEnemyAim(plr, lead, myHrp)
    if not plr or not plr.Character or not myHrp then return nil end
    local origin = getAimOrigin(plr)
    if not origin then return nil end
    local enemyHrp = plr.Character:FindFirstChild("HumanoidRootPart")
    if not enemyHrp then return nil end
    local enemyVel = enemyHrp.AssemblyLinearVelocity
    local myVel = myHrp.AssemblyLinearVelocity
    local predictedOrigin = origin.Position + enemyVel * lead
    local predictedMy = myHrp.Position + myVel * lead
    local dir = predictedMy - predictedOrigin
    if dir.Magnitude < 0.01 then return nil end
    local look = origin.CFrame.LookVector
    return { predictedOrigin=predictedOrigin, predictedMe=predictedMy, dir=dir.Unit, futureDot=look:Dot(dir.Unit), dist=dir.Magnitude }
end

local voidElapsed = 0
local voidPos = Vector3.new(0,0,0)
local voidDriftDir = Vector3.new(1,0,0)
local intendedVoidPos = Vector3.new(0,0,0)
local smartLastDodge = 0
local voidStartTime = 0
local voidRegionCurrentRadius = nil
local voidRegionLastIn = true
local lastGroundY = 0
local voidPredBest = nil
local voidPredBestTile = nil
local dtForColl = 1/60
local isInsideVoidPart = nil

local function refreshVoidUtils()
    if isInsideVoidPart then return end
    isInsideVoidPart = function(pos)
        if not workspace then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Include
        params.FilterDescendantsInstances = { workspace }
        local result = workspace:Spherecast(pos, 1, Vector3.new(0, 0.01, 0), params)
        return result ~= nil
    end
end

local voidRegionCollapsed = 0
local voidRegionTarget = 0

local function clampToRegionRadius(pos, cx, cy, cz, r)
    local dx = pos.X - cx
    local dy = pos.Y - cy
    local dz = pos.Z - cz
    if CFG.VOID_REGION_CIRCLE then
        local flat = math.sqrt(dx*dx + dz*dz)
        if flat > r then local s = r/flat; dx=dx*s; dz=dz*s end
        voidRegionLastIn = true
    else
        local rx, ry, rz = r, CFG.VOID_REGION_Y, r
        if math.abs(dx)>rx then dx=(dx>0 and rx or -rx) end
        if math.abs(dy)>ry then dy=(dy>0 and ry or -ry) end
        if math.abs(dz)>rz then dz=(dz>0 and rz or -rz) end
    end
    if not CFG.VOID_REGION_SNAP_EDGE then
        dx = dx + (math.random()-0.5)*20
        dz = dz + (math.random()-0.5)*20
    end
    return Vector3.new(cx+dx, cy+dy, cz+dz)
end

local function clampToRegion(pos)
    if not CFG.VOID_STAY_IN_REGION then return pos end
    local cx, cy, cz = CFG.VOID_REGION_CX, CFG.VOID_REGION_CY, CFG.VOID_REGION_CZ
    if CFG.VOID_REGION_CENTER_SELF and root then
        cx, cy, cz = root.Position.X, root.Position.Y, root.Position.Z
    end
    if not voidRegionTarget or voidRegionTarget <= 0 then
        voidRegionTarget = math.max(CFG.VOID_REGION_X, CFG.VOID_REGION_Z, 1)
    end
    if CFG.VOID_REGION_COLLAPSE then
        voidRegionCollapsed = math.max(0, voidRegionCollapsed + dtForColl * CFG.VOID_REGION_COLLAPSE_SPD)
        return clampToRegionRadius(pos, cx, cy, cz, math.max(10, voidRegionTarget - voidRegionCollapsed))
    end
    return clampToRegionRadius(pos, cx, cy, cz, voidRegionTarget)
end

local getTpEverywherePosition = nil

local function refreshTpEverywhere()
    if getTpEverywherePosition then return end
    getTpEverywherePosition = function()
        if not Camera then
            local dist = CFG.TP_RAND_ENABLED
                and CFG.TP_RAND_MIN + math.random()*(CFG.TP_RAND_MAX-CFG.TP_RAND_MIN)
                or  CFG.TP_MIN_STUDS + math.random()*(CFG.TP_MAX_STUDS-CFG.TP_MIN_STUDS)
            if CFG.TP_NEG_BIAS and math.random()<0.5 then dist=-math.abs(dist) end
            local rx,ry,rz = math.random()*2-1, math.random()*2-1, math.random()*2-1
            return Vector3.new(CFG.BASE_X+rx*math.abs(dist), CFG.BASE_Y+ry*math.abs(dist), CFG.BASE_Z+rz*math.abs(dist))
        end
        local dist = CFG.TP_RAND_ENABLED
            and CFG.TP_RAND_MIN + math.random()*(CFG.TP_RAND_MAX-CFG.TP_RAND_MIN)
            or  CFG.TP_MIN_STUDS + math.random()*(CFG.TP_MAX_STUDS-CFG.TP_MIN_STUDS)
        if CFG.TP_NEG_BIAS and math.random()<0.5 then dist=-math.abs(dist) end
        local vp = Camera.ViewportSize
        local roll = math.random()
        local screenX, screenY
        if CFG.TP_CORNER_ONLY or roll < CFG.TP_CORNER_WEIGHT then
            local corners = {Vector2.new(0,0),Vector2.new(vp.X,0),Vector2.new(0,vp.Y),Vector2.new(vp.X,vp.Y)}
            local c = corners[math.random(1,4)]; screenX=c.X; screenY=c.Y
        elseif roll < CFG.TP_CORNER_WEIGHT + CFG.TP_EDGE_WEIGHT then
            local edge = math.random(1,4)
            if edge==1 then screenX=math.random()*vp.X; screenY=0
            elseif edge==2 then screenX=math.random()*vp.X; screenY=vp.Y
            elseif edge==3 then screenX=0; screenY=math.random()*vp.Y
            else screenX=vp.X; screenY=math.random()*vp.Y end
        else screenX=math.random()*vp.X; screenY=math.random()*vp.Y end
        if CFG.TP_SCREEN_JITTER > 0 then
            screenX = screenX + (math.random()-0.5)*vp.X*CFG.TP_SCREEN_JITTER
            screenY = screenY + (math.random()-0.5)*vp.Y*CFG.TP_SCREEN_JITTER
        end
        if CFG.TP_SCREEN_CLAMP then
            screenX = math.clamp(screenX,0,vp.X)
            screenY = math.clamp(screenY,0,vp.Y)
        end
        local depth = math.max(math.abs(dist),1)
        local ray = Camera:ViewportPointToRay(screenX, screenY, depth)
        local camCF = Camera.CFrame
        local origin = (ray and ray.Origin) or camCF.Position
        local dir = (ray and ray.Direction) or camCF.LookVector
        if typeof(origin)~="Vector3" then origin=camCF.Position end
        if typeof(dir)~="Vector3" or dir.Magnitude<1e-3 then dir=camCF.LookVector end
        dir = dir.Unit
        local point = origin + dir * depth
        if point.X~=point.X or point.Z~=point.Z then point=camCF.Position+camCF.LookVector*depth end
        local lateral = depth*0.35
        local px = point.X + (math.random()*2-1)*lateral
        local pz = point.Z + (math.random()*2-1)*lateral
        local vertMult = (CFG.TP_VERT_MULT_MIN + math.random()*(CFG.TP_VERT_MULT_MAX-CFG.TP_VERT_MULT_MIN)) * (CFG.TP_VERT_MULT_EXTRA or 1)
        local vert = CFG.TP_VERT_SPIKE and (math.random()*2-1)*depth*vertMult or 0
        if CFG.TP_NEG_BIAS then vert=vert-math.abs(vert)*0.3 end
        local y = CFG.TP_PRESERVE_Y and (root and root.Position.Y or 0) or (point.Y + vert)
        return Vector3.new(px, y, pz)
    end
end

refreshVoidUtils()
refreshTpEverywhere()

local function driftDir3D(t)
    local nx,ny,nz = 0,0,0
    local amp,freq = 1,0.0001
    for _ = 1,4 do
        nx=nx+math.noise(t*freq,0,0)*amp; ny=ny+math.noise(0,t*freq,0)*amp; nz=nz+math.noise(0,0,t*freq)*amp
        freq=freq*2.37; amp=amp*0.5
    end
    local sp=t*0.00073; local cp=t*0.00213
    nx=nx+math.noise(sp+13.7,7.3,0)*0.3+math.sin(cp)*math.cos(cp*1.618)*0.2
    ny=ny+math.noise(0,sp+31.1,17.9)*0.3+math.cos(cp*0.618)*math.sin(cp*2.718)*0.2
    nz=nz+math.noise(7.3,0,sp+11.5)*0.3+math.sin(cp*1.3)*math.cos(cp*0.7)*0.2
    local len=math.sqrt(nx*nx+ny*ny+nz*nz)
    if len<0.001 then return 1,0,0 end
    return nx/len,ny/len,nz/len
end

local function stepVoidImplDrift(dt)
    local dx,dy,dz = driftDir3D(voidElapsed)
    voidDriftDir = voidDriftDir:Lerp(Vector3.new(dx,dy,dz).Unit, math.clamp(CFG.CHAOS*dt*10,0,1))
    voidPos = voidPos + voidDriftDir*CFG.SPEED*dt
    if voidPos.X>CFG.BASE_X+CFG.RADIUS or voidPos.X<CFG.BASE_X-CFG.RADIUS then voidDriftDir=Vector3.new(-voidDriftDir.X,voidDriftDir.Y,voidDriftDir.Z) end
    if voidPos.Y>CFG.VOID_Y_MAX or voidPos.Y<CFG.VOID_Y_MIN then voidDriftDir=Vector3.new(voidDriftDir.X,-voidDriftDir.Y,voidDriftDir.Z) end
    if voidPos.Z>CFG.BASE_Z+CFG.RADIUS or voidPos.Z<CFG.BASE_Z-CFG.RADIUS then voidDriftDir=Vector3.new(voidDriftDir.X,voidDriftDir.Y,-voidDriftDir.Z) end
    return voidPos
end
local function stepVoidImplChaos(dt)
    voidPos = voidPos + Vector3.new((math.random()-0.5)*CFG.SPEED*dt*5,(math.random()-0.5)*CFG.SPEED*dt*5,(math.random()-0.5)*CFG.SPEED*dt*5)
    voidPos = Vector3.new(math.clamp(voidPos.X,CFG.BASE_X-CFG.RADIUS,CFG.BASE_X+CFG.RADIUS),math.clamp(voidPos.Y,CFG.VOID_Y_MIN,CFG.VOID_Y_MAX),math.clamp(voidPos.Z,CFG.BASE_Z-CFG.RADIUS,CFG.BASE_Z+CFG.RADIUS))
    return voidPos
end
local function stepVoidImplLoop(dt)
    local r=math.min(CFG.RADIUS*0.8,1e9+(voidElapsed%100)*1e7)
    return Vector3.new(CFG.BASE_X+math.cos(voidElapsed*2)*r,(CFG.VOID_Y_MIN+CFG.VOID_Y_MAX)/2+math.sin(voidElapsed*1.3)*r*0.2,CFG.BASE_Z+math.sin(voidElapsed*2)*r)
end
local function stepVoidImplSpiral(dt)
    local r=math.min(CFG.RADIUS*0.9,(voidElapsed%50)*2e9)
    return Vector3.new(CFG.BASE_X+math.cos(voidElapsed*3)*r,(CFG.VOID_Y_MIN+CFG.VOID_Y_MAX)/2+math.sin(voidElapsed*0.5)*r*0.3,CFG.BASE_Z+math.sin(voidElapsed*3)*r)
end
local function stepVoidImplQuantum(dt)
    return Vector3.new(CFG.BASE_X+(math.random()*2-1)*CFG.RADIUS,(math.random()*2-1)*(CFG.VOID_Y_MAX-CFG.VOID_Y_MIN)/2+(CFG.VOID_Y_MAX+CFG.VOID_Y_MIN)/2,CFG.BASE_Z+(math.random()*2-1)*CFG.RADIUS)
end
local function stepVoidImplTpEverywhere(dt)
    if not getTpEverywherePosition then return voidPos end
    return getTpEverywherePosition()
end
local function stepVoidImplOrbitTarget(dt)
    local t=getClosest()
    if t and t.Character then
        local hrp=t.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local ang=voidElapsed*math.rad(CFG.VOID_ORBIT_SPEED)
            return hrp.Position+Vector3.new(math.cos(ang)*5,2,math.sin(ang)*5)
        end
    end
    return stepVoidImplTpEverywhere(dt)
end
local function stepVoidImplPredictive(dt)
    local map=buildThreatMap(root and root.Position or Vector3.zero)
    local best,bestScore=nil,-1
    for _,d in pairs(map) do if d.score>bestScore then bestScore=d.score; best=d end end
    if best and best.hrp then
        return best.hrp.Position-best.hrp.CFrame.LookVector*50+Vector3.new((math.random()-0.5)*100,(math.random()-0.5)*100,(math.random()-0.5)*100)
    end
    return stepVoidImplTpEverywhere(dt)
end

local stepVoidImpls = {
    Drift=stepVoidImplDrift, Chaos=stepVoidImplChaos, Loop=stepVoidImplLoop,
    Spiral=stepVoidImplSpiral, Quantum=stepVoidImplQuantum,
    ["TP Everywhere"]=stepVoidImplTpEverywhere, OrbitTarget=stepVoidImplOrbitTarget, Predictive=stepVoidImplPredictive,
}
local function stepVoid(dt)
    local impl=stepVoidImpls[CFG.VOID_METHOD]
    return impl and impl(dt) or stepVoidImplQuantum(dt)
end

local function runSmartEvasionV2(currentPos)
    if not CFG.SMART_EVASION or not root then return currentPos end
    local now=tick()
    local map=buildThreatMap(currentPos)
    local threats,totalScore={},0
    for _,d in pairs(map) do
        if d.dist<=CFG.EVASION_RANGE and d.score>20 then table.insert(threats,d); totalScore=totalScore+d.score end
    end
    if #threats==0 then return currentPos end
    local cd=CFG.EVASION_COOLDOWN
    if CFG.EVASION_THREAT_SCALE then cd=cd/math.max(1,#threats*0.5) end
    if now-smartLastDodge<cd then return currentPos end
    local primary=threats[1]
    for _,d in ipairs(threats) do if d.score>primary.score then primary=d end end
    local dodgeDir=perpDodgeDir(primary.hrp.Position,currentPos)
    local dodge=dodgeDir*CFG.EVASION_DODGE_POWER
    if CFG.EVASION_LAYERED and #threats>1 then
        local cum=Vector3.zero
        for _,d in ipairs(threats) do cum=cum+perpDodgeDir(d.hrp.Position,currentPos)*(d.score/totalScore) end
        if cum.Magnitude>0.01 then dodge=cum.Unit*CFG.EVASION_DODGE_POWER end
    end
    if CFG.EVASION_MICRO_JITTER then dodge=dodge+Vector3.new((math.random()-0.5)*15,0,(math.random()-0.5)*15) end
    local finalPos=currentPos+dodge
    if CFG.EVASION_VERTICAL_SPIKE and #threats>=2 then finalPos=finalPos+Vector3.new(0,math.random()*20+10,0) end
    smartLastDodge=now
    if CFG.EVASION_NOTIFY then pcall(function() Notify("evasion v2: "..primary.hrp.Parent.Name.." score "..math.floor(primary.score),1.2) end) end
    return finalPos
end

local function voidSafeFilter(pos)
    if not pos then return pos end
    local x,y,z=pos.X,pos.Y,pos.Z
    if x~=x or x==math.huge or x==-math.huge then x=CFG.BASE_X end
    if y~=y or y==math.huge or y==-math.huge then y=0 end
    if z~=z or z==math.huge or z==-math.huge then z=CFG.BASE_Z end
    y=math.clamp(y,CFG.VOID_Y_MIN,CFG.VOID_Y_MAX)
    local r=math.abs(CFG.RADIUS)
    if r>0 then
        local dx,dz=x-CFG.BASE_X,z-CFG.BASE_Z
        local flat=math.sqrt(dx*dx+dz*dz)
        if flat>r and flat>0 then local s=r/flat; x=CFG.BASE_X+dx*s; z=CFG.BASE_Z+dz*s end
    end
    if CFG.VOID_SAFE_RADIUS and CFG.VOID_SAFE_RADIUS>0 and root then
        local me=root.Position
        local ddx,ddy,ddz=x-me.X,y-me.Y,z-me.Z
        local dist=math.sqrt(ddx*ddx+ddy*ddy+ddz*ddz)
        local sr=CFG.VOID_SAFE_RADIUS
        if dist<sr then
            if dist<0.01 then ddx,ddy,ddz,dist=1,0,0,1 end
            local s=sr/dist; x=me.X+ddx*s; y=me.Y+ddy*s; z=me.Z+ddz*s
        end
    end
    return Vector3.new(x,y,z)
end

local function lockToVoid(dt)
    local targetPos=stepVoid(dt)
    targetPos=voidSafeFilter(targetPos)
    targetPos=clampToRegion(targetPos)
    if CFG.VOID_ANTIVOID and isInsideVoidPart(targetPos) then
        targetPos=targetPos+Vector3.new((math.random()-0.5)*200,math.random()*200,(math.random()-0.5)*200)
    end
    targetPos=runSmartEvasionV2(targetPos)
    intendedVoidPos=targetPos
    local hrp=getLocalRoot()
    if not hrp then return end
    voidPredBest=nil; voidPredBestTile=nil
    if CFG.VOID_FREEZE_ON_GROUND then lastGroundY=hrp.Position.Y end
    pcall(function()
        hrp.CFrame=CFrame.new(intendedVoidPos)
        hrp.AssemblyLinearVelocity=Vector3.zero
        hrp.AssemblyAngularVelocity=Vector3.zero
        hrp.Velocity=Vector3.zero
    end)
    if CFG.VOID_LOG_POSITIONS and math.random(1,30)==1 then print("[VOID] "..tostring(intendedVoidPos)) end
    if not CFG.VOID_ANTIFLING and math.random(1,10)==1 then
        pcall(function()
            hrp.AssemblyLinearVelocity=Vector3.new((math.random()-0.5)*2e7,(math.random()-0.5)*2e7,(math.random()-0.5)*2e7)
        end)
    end
end

function RCLR_Functions.startVoid()
    killConn("void"); voidElapsed=0; voidStartTime=tick(); voidRegionCurrentRadius=nil; voidRegionLastIn=true
    local hrp=getLocalRoot()
    if hrp then voidPos=hrp.Position; intendedVoidPos=voidPos end
    pcall(function() if hrp then hrp:SetNetworkOwner(LocalPlayer) end end)
    conns.void=(RunService.PreSimulation or RunService.Heartbeat):Connect(function(dt)
        if not CFG.VOID_ENABLED then
            if CFG.VOID_AUTO_REENABLE then CFG.VOID_ENABLED=true else killConn("void") end
            return
        end
        if CFG.VOID_DURATION_ENABLED then
            local dur=CFG.VOID_RANDOM_DURATION and CFG.VOID_DURATION_MIN+math.random()*(CFG.VOID_DURATION_MAX-CFG.VOID_DURATION_MIN) or CFG.VOID_DURATION
            if (tick()-voidStartTime)>dur then CFG.VOID_ENABLED=false; pcall(function() Notify("void duration reached",2) end); return end
        end
        if CFG.VOID_STOP_ON_DAMAGE and hum and hum.Health<(hum.MaxHealth*0.9) then
            CFG.VOID_ENABLED=false; pcall(function() Notify("void disabled: damage taken",2) end); return
        end
        voidElapsed=voidElapsed+dt
        lockToVoid(dt)
    end)
end
function RCLR_Functions.stopVoid() killConn("void"); CFG.VOID_ENABLED=false end

local orbitAngle,orbitLocalElapsed,orbitCurrentRadius=0,0,0
local orbitSnapTimer=0

function RCLR_Functions.startOrbit()
    killConn("orbit"); orbitAngle=0; orbitLocalElapsed=0; orbitCurrentRadius=cfg.orbitDist; orbitSnapTimer=0
    if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end) end
    conns.orbit=RunService.Heartbeat:Connect(function(dt)
        if not cfg.orbitEnabled then killConn("orbit"); return end
        if not root then return end
        if hum then pcall(function() if hum:GetState()~=Enum.HumanoidStateType.Physics then hum:ChangeState(Enum.HumanoidStateType.Physics) end end) end
        local target=getTarget(cfg.orbitTarget)
        local targetPos=root.Position
        if target and target.Character then
            local hrp=target.Character:FindFirstChild("HumanoidRootPart")
            if hrp and (root.Position-hrp.Position).Magnitude<=cfg.orbitLockDist then
                targetPos=hrp.Position
                if cfg.orbitPredict then targetPos=targetPos+hrp.AssemblyLinearVelocity*cfg.orbitPredStr end
            end
        end
        local speed=cfg.orbitReverse and -cfg.orbitSpeed or cfg.orbitSpeed
        if cfg.orbitSpeedRandom then
            speed=(cfg.orbitSpeedRandMin+math.random()*(cfg.orbitSpeedRandMax-cfg.orbitSpeedRandMin))
            if cfg.orbitReverse then speed=-speed end
        end
        orbitAngle=(orbitAngle+math.rad(speed)*dt)%(2*math.pi)
        orbitLocalElapsed=orbitLocalElapsed+dt
        local r=cfg.orbitRandRad and math.random(cfg.orbitRandMin,cfg.orbitRandMax) or cfg.orbitDist
        if cfg.orbitDistPulse then r=r+math.sin(orbitLocalElapsed*cfg.orbitDistPulseSpeed*2*math.pi)*cfg.orbitDistPulseAmp end
        local h=cfg.orbitHeight
        if cfg.orbitHeightOscillate then h=h+math.sin(orbitLocalElapsed*cfg.orbitHeightOscSpeed*2*math.pi)*cfg.orbitHeightOscAmp end
        local x,y,z=0,0,0
        local ax=cfg.orbitAxis; local om=cfg.orbitMode
        if om=="Circle" then
            if ax=="XZ" then x=math.cos(orbitAngle)*r; z=math.sin(orbitAngle)*r; y=h
            elseif ax=="XY" then x=math.cos(orbitAngle)*r; y=math.sin(orbitAngle)*r; z=h
            elseif ax=="YZ" then y=math.cos(orbitAngle)*r; z=math.sin(orbitAngle)*r; x=h end
        elseif om=="Figure 8" then x=math.sin(orbitAngle)*r; z=math.sin(orbitAngle)*math.cos(orbitAngle)*r*0.7; y=h
        elseif om=="Ellipse" then x=math.cos(orbitAngle)*r; z=math.sin(orbitAngle)*r*0.6; y=h
        elseif om=="Bounce" then x=math.cos(orbitAngle)*r; z=math.sin(orbitAngle)*r; y=h+math.sin(orbitLocalElapsed*3)*5
        elseif om=="RandomOrbit" then local a=math.random()*2*math.pi; x=math.cos(a)*r; z=math.sin(a)*r; y=h end
        if cfg.orbitZigzag then x=x+math.sin(orbitLocalElapsed*cfg.orbitZigzagFreq*2*math.pi)*cfg.orbitZigzagAmp end
        x=x+cfg.orbitOffX; z=z+cfg.orbitOffZ
        local dst=targetPos+Vector3.new(x,y,z)
        if cfg.orbitSnapBack then
            orbitSnapTimer=orbitSnapTimer+dt
            if orbitSnapTimer>=cfg.orbitSnapInterval then orbitSnapTimer=0; dst=targetPos+Vector3.new(cfg.orbitOffX,h,cfg.orbitOffZ) end
        end
        local alpha=math.min(1,1-(1-cfg.orbitLerp)^(dt*60))
        local smooth=root.Position:Lerp(dst,alpha)
        pcall(function()
            if cfg.orbitFace then
                local cf=CFrame.new(smooth,Vector3.new(targetPos.X,smooth.Y,targetPos.Z))
                cf=cf*CFrame.Angles(math.rad(cfg.orbitPitchOff),math.rad(cfg.orbitYawOff),0)
                root.CFrame=cf
            else root.CFrame=CFrame.new(smooth) end
            root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero
        end)
    end)
end
function RCLR_Functions.stopOrbit()
    killConn("orbit"); cfg.orbitEnabled=false
    if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
end

local lastDodgeTick=0; local predShootCD={}; local predLastShot=0; local predRungIndex=0
local hookedActivate={}; local hookedActivateCount=0; local hookedRemotes={}
local lastRemoteFire=0

local RIVALS_SHOT_REMOTE_HINTS={"fire","shoot","attack","bullet","ray","hit","damage","combat","weapon","gun","melee","swing","slash","stab","cast","castskill","attackrequest","fireweapon","dealDamage","projectile","spawnbullet","swingweapon","strike","slashblade","firebullet","shootbullet"}
local function isShotRemote(name)
    local n=name:lower()
    for _,h in ipairs(RIVALS_SHOT_REMOTE_HINTS) do if n:find(h,1,true) then return true end end
    return false
end

local function raycastLineOfFire(enemyHrp, myPos)
    if not enemyHrp then return false,0 end
    local origin=enemyHrp.Position+Vector3.new(0,1.5,0)
    local target=myPos+Vector3.new(0,1.5,0)
    local dir=(target-origin); local dist=dir.Magnitude
    if dist<0.01 then return false,0 end
    local params=RaycastParams.new()
    params.FilterType=Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances={LocalPlayer.Character,enemyHrp.Parent}
    local result=workspace:Raycast(origin,dir.Unit*dist,params)
    if result then return false,dist end
    return true,dist
end

local HOOK_CAP=64
local function hookToolActivate(tool)
    if not tool or hookedActivate[tool] then return end
    if hookedActivateCount>=HOOK_CAP then return end
    hookedActivate[tool]=true; hookedActivateCount=hookedActivateCount+1
    local oldActivate
    pcall(function()
        oldActivate=hookfunction(tool.Activate,function(self,...)
            if not checkcaller() and self==tool then
                local owner=tool.Parent and tool.Parent.Parent
                if owner and owner~=LocalPlayer and owner.Character then
                    predShootCD[owner]=tick()
                    if antiBaitCFG.baitEnabled and antiBaitCFG.baitHookActivate then
                        local hrp=owner.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and root then task.spawn(function() RCLR_Functions.doBaitCounter(owner,"tool") end) end
                    end
                end
            end
            return oldActivate(self,...)
        end)
    end)
end

local watchedRemotes={}; local remoteHookInstalled=false
local function hookRemote(remote)
    if not remote or hookedRemotes[remote] then return end
    hookedRemotes[remote]=true
    if type(hookmetamethod)~="function" then return end
    watchedRemotes[remote]=true
    if remoteHookInstalled then return end
    remoteHookInstalled=true
    pcall(function()
        local wrap=(type(newcclosure)=="function") and newcclosure or function(f) return f end
        local old
        old=hookmetamethod(game,"__namecall",wrap(function(self,...)
            if watchedRemotes[self] then
                local caller=checkcaller and checkcaller()
                if not caller then lastRemoteFire=tick() end
            end
            return old(self,...)
        end))
    end)
end

local function watchAllTools()
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer or not p.Character then continue end
        local tool=p.Character:FindFirstChildOfClass("Tool")
        if tool then hookToolActivate(tool) end
        p.Character.ChildAdded:Connect(function(c) if c:IsA("Tool") then hookToolActivate(c) end end)
    end
end

local function scanUniversal()
    if not antiBaitCFG.universalRemotes and not antiBaitCFG.universalTools then return end
    if CFG.VOID_ENABLED then return end
    local roots={ReplicatedStorage}
    for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and p.Character then roots[#roots+1]=p.Character end end
    local budget=4000
    for _,r in ipairs(roots) do
        for _,d in ipairs(r:GetDescendants()) do
            if budget<=0 then return end; budget=budget-1
            if antiBaitCFG.universalTools and d:IsA("Tool") then hookToolActivate(d)
            elseif antiBaitCFG.universalRemotes and (d:IsA("RemoteEvent") or d:IsA("RemoteFunction")) then
                if isShotRemote(d.Name) then hookRemote(d) end
            end
        end
    end
end

local _scanLoopRunning=false
local function ensureScanLoop()
    if _scanLoopRunning then return end; _scanLoopRunning=true
    task.spawn(function()
        while cfgDodge.predEnabled or antiBaitCFG.enabled do
            task.wait(math.max(antiBaitCFG.reScanInterval,5))
            pcall(scanUniversal)
        end
        _scanLoopRunning=false
    end)
end

local animThreatCache={}
local function getAimAnimKeyword(track)
    local n=(track.Animation and track.Animation.Name or ""):lower()
    return n:find("shoot") or n:find("fire") or n:find("attack") or n:find("swing") or n:find("slash") or n:find("stab") or n:find("punch") or n:find("cast") or n:find("thrust")
end
local function animationThreat(plr)
    if not antiBaitCFG.universalAnimation then return false end
    local now=tick()
    local cached=animThreatCache[plr]
    if cached and (now-cached.t)<0.15 then return cached.v end
    local v=false
    local char=plr.Character
    if char then
        local h=char:FindFirstChildOfClass("Humanoid")
        local animator=h and h:FindFirstChildOfClass("Animator")
        if animator then for _,track in ipairs(animator:GetPlayingAnimationTracks()) do if getAimAnimKeyword(track) then v=true; break end end end
    end
    animThreatCache[plr]={t=now,v=v}
    return v
end

local function watchAnimation(plr)
    if not plr.Character then return end
    local h=plr.Character:FindFirstChildOfClass("Humanoid")
    if not h then return end
    h.AnimationPlayed:Connect(function(track)
        if getAimAnimKeyword(track) then
            predShootCD[plr]=tick()
            if antiBaitCFG.baitEnabled then task.spawn(function() RCLR_Functions.doBaitCounter(plr,"anim") end) end
        end
    end)
end

local function startPredictionV2()
    killConn("pred"); watchAllTools()
    for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer then watchAnimation(p) end end
    ensureScanLoop()
    Players.PlayerAdded:Connect(function(p)
        p.CharacterAdded:Connect(function(c)
            c.ChildAdded:Connect(function(ch) if ch:IsA("Tool") then hookToolActivate(ch) end end)
            local tool=c:FindFirstChildOfClass("Tool"); if tool then hookToolActivate(tool) end
            watchAnimation(p)
        end)
    end)
    conns.pred=RunService.Heartbeat:Connect(function(dt)
        if not cfgDodge.predEnabled then killConn("pred"); return end
        if not root then return end
        if hum and hum.Health<=0 then return end
        local myPos=root.Position; local now=tick()
        local map=buildThreatMap(myPos)
        local highestScore=0; local primary=nil
        for p,d in pairs(map) do if d.score>highestScore then highestScore=d.score; primary={p=p,d=d} end end
        if not primary then return end
        local effectiveRadius=cfgDodge.predInfiniteRange and getInfiniteRange() or cfgDodge.predRadius
        if primary.d.dist>effectiveRadius then return end
        local cooldown=cfgDodge.predCooldown
        if cfgDodge.predReactionLadder then
            if now-predLastShot<1.5 then predRungIndex=math.min(predRungIndex+1,5) else predRungIndex=0 end
            cooldown=cooldown/(1+predRungIndex*0.5)
        end
        if now-lastDodgeTick<cooldown then return end
        local threat=false
        local fired=(predShootCD[primary.p] and (now-predShootCD[primary.p])<cfgDodge.predReactTime) or (lastRemoteFire>0 and (now-lastRemoteFire)<cfgDodge.predReactTime)
        if fired then threat=true end
        if primary.d.aimDot>cfgDodge.predShootDot then threat=true end
        if primary.d.velDot>0.7 and primary.d.hrp.AssemblyLinearVelocity.Magnitude>cfgDodge.predThreshold then threat=true end
        if cfgDodge.predRaycast then local clear=raycastLineOfFire(primary.d.hrp,myPos); if clear and primary.d.aimDot>0.6 then threat=true end end
        if cfgDodge.predPredictiveAim and not threat then
            local prediction=predictEnemyAim(primary.p,cfgDodge.predPredictiveLead,root)
            if prediction and prediction.futureDot>0.85 and prediction.dist<effectiveRadius then threat=true end
        end
        if cfgDodge.predAnimDetect and not threat then if animationThreat(primary.p) then threat=true end end
        if not threat then return end
        lastDodgeTick=now; predLastShot=now
        local dir=perpDodgeDir(primary.d.hrp.Position,myPos)
        local newPos=myPos+dir*cfgDodge.predDodgeDist
        if cfgDodge.predMultiPoint then
            local altDir=Vector3.new(-dir.Z,0,dir.X); if math.random()<0.5 then altDir=-altDir end
            newPos=myPos+dir*(cfgDodge.predDodgeDist*0.7)+altDir*(cfgDodge.predDodgeDist*0.5)
        end
        if cfgDodge.predBackstep then
            local toward=(primary.d.hrp.Position-myPos)
            if toward.Magnitude>0.01 then newPos=newPos-toward.Unit*(cfgDodge.predDodgeDist*0.3) end
        end
        if cfgDodge.predMultiPoint then newPos=newPos+Vector3.new(0,math.random()*15,0) end
        if tryDodgeFrame() then
            pcall(function()
                root.CFrame=CFrame.new(newPos+Vector3.new((math.random()-0.5)*4,0,(math.random()-0.5)*4))
                root.AssemblyLinearVelocity=dir*150
            end)
        end
    end)
end
function RCLR_Functions.stopPredictionV2() killConn("pred"); cfgDodge.predEnabled=false end

local antiBaitData={}; local lastAntiBaitDodge=0; local gunDodgeCDs={}; local baitActive={}
local function getDodgeDir(threatPos)
    if not root then return Vector3.new(1,0,0) end
    local flat=Vector3.new(threatPos.X-root.Position.X,0,threatPos.Z-root.Position.Z)
    local away=flat.Magnitude>0.01 and -flat.Unit or Vector3.new(1,0,0)
    local m=antiBaitCFG.dodgeMode
    if m=="Away" then return away end
    if m=="Perpendicular" then local p=Vector3.new(-away.Z,0,away.X); return math.random(0,1)==0 and p or -p end
    local a=math.random()*2*math.pi; return Vector3.new(math.cos(a),0,math.sin(a))
end
local function doDodge(player,reason)
    if not root then return end
    local now=tick()
    if now-lastAntiBaitDodge<antiBaitCFG.dodgeCooldown then return end
    lastAntiBaitDodge=now
    local threatPos=Vector3.zero
    if player and player.Character then local h=player.Character:FindFirstChild("HumanoidRootPart"); if h then threatPos=h.Position end end
    local dir=getDodgeDir(threatPos)
    if tryDodgeFrame() then
        pcall(function() root.CFrame=root.CFrame+dir*(antiBaitCFG.velDodgeDist*0.005); root.AssemblyLinearVelocity=dir*180 end)
    end
    if antiBaitCFG.notifyOnDodge then
        local dist=0
        if player and player.Character then local h=player.Character:FindFirstChild("HumanoidRootPart"); if h and root then dist=math.floor((h.Position-root.Position).Magnitude) end end
        pcall(function() Notify("anti-bait: "..(player and player.Name or "?").." ["..reason.."] "..dist.." studs",1.5) end)
    end
end
local function baitStall(player)
    if not root then return end
    task.spawn(function()
        local orig=root.CFrame
        pcall(function() root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero end)
        task.wait(antiBaitCFG.baitStallTime)
        if root then pcall(function() root.CFrame=orig end) end
    end)
end
function RCLR_Functions.doBaitCounter(player,source)
    if not antiBaitCFG.baitEnabled then return end
    if baitActive[player] and tick()-baitActive[player]<antiBaitCFG.baitReactionWindow then return end
    baitActive[player]=tick()
    if antiBaitCFG.baitNotifyLabel then Notify("BAIT CONFIRMED: "..player.Name.." ["..source.."]",2) end
    task.spawn(function()
        if antiBaitCFG.baitStallChance>0 and math.random()<antiBaitCFG.baitStallChance then baitStall(player) end
        task.wait(antiBaitCFG.baitFakeLockTime)
        doDodge(player,"bait-"..source)
    end)
end
local function initBaitData(p) antiBaitData[p]={lastPos=nil,tpTimes={},lastVel=Vector3.zero,lastTool=nil,lastYaw=0,lastAim=0} end
local function cleanBaitTimes(data) local now,clean=tick(),{}; for _,t in ipairs(data.tpTimes) do if now-t<antiBaitCFG.flickerWindow then clean[#clean+1]=t end end; data.tpTimes=clean end
local function installBaitHooks()
    for _,p in ipairs(Players:GetPlayers()) do
        if p==LocalPlayer or not p.Character then continue end
        local tool=p.Character:FindFirstChildOfClass("Tool"); if tool then hookToolActivate(tool) end
        p.Character.ChildAdded:Connect(function(c) if c:IsA("Tool") then hookToolActivate(c) end end)
        watchAnimation(p)
    end
end
local function startAntiBaitV2()
    killConn("antiBait")
    for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer then initBaitData(p) end end
    installBaitHooks(); scanUniversal(); ensureScanLoop()
    conns.antiBait=RunService.Heartbeat:Connect(function(dt)
        if not antiBaitCFG.enabled then RCLR_Functions.stopAntiBait(); return end
        if not root then return end
        local myPos=root.Position; local now=tick()
        local effectiveAntiBaitRadius=antiBaitCFG.infiniteRange and antiBaitCFG.infiniteRadius or 500
        for _,p in ipairs(Players:GetPlayers()) do
            if p==LocalPlayer or not p.Character then continue end
            local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
            local data=antiBaitData[p]; if not data then initBaitData(p); data=antiBaitData[p] end
            local curPos=hrp.Position; local curVel=hrp.AssemblyLinearVelocity
            if antiBaitCFG.gunPredEnabled then
                local tool=p.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local aiming=enemyAimingUniversal(p,myPos,antiBaitCFG.gunPredDot)
                    local key=p.UserId
                    local predP=predictPos(hrp,antiBaitCFG.gunPredLead)
                    local predDist=(predP-myPos).Magnitude
                    if aiming and (curVel.Magnitude>antiBaitCFG.gunPredVelMin or predDist<effectiveAntiBaitRadius) then
                        if not gunDodgeCDs[key] or now-gunDodgeCDs[key]>antiBaitCFG.gunPredCooldown then gunDodgeCDs[key]=now; doDodge(p,"gun") end
                    end
                end
            end
            if antiBaitCFG.baitHookActivate then
                local fired=predShootCD[p] and (now-predShootCD[p])<antiBaitCFG.baitReactionWindow
                if fired then pcall(function() RCLR_Functions.doBaitCounter(p,"fire") end) end
            end
            if antiBaitCFG.dodgeOnShoot then
                local tool=p.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local look=hrp.CFrame.LookVector; local toMe=(myPos-hrp.Position)
                    if toMe.Magnitude>0.01 then
                        local dot=look:Dot(toMe.Unit)
                        if dot>antiBaitCFG.shootLookThresh and data.lastTool~=tool then doDodge(p,"shoot"); data.lastTool=tool end
                        data.lastAim=dot
                    end
                end
            end
            if antiBaitCFG.universalAim and enemyAimingUniversal(p,myPos,antiBaitCFG.gunPredDot) then
                if not gunDodgeCDs[p.UserId] or now-gunDodgeCDs[p.UserId]>antiBaitCFG.gunPredCooldown then gunDodgeCDs[p.UserId]=now; doDodge(p,"aim") end
            end
            if antiBaitCFG.universalAnimation and animationThreat(p) then doDodge(p,"anim") end
            if antiBaitCFG.velSpikeEnabled and curVel.Magnitude>antiBaitCFG.velThreshold then
                local toMe=(myPos-curPos); if toMe.Magnitude>0.01 and curVel.Unit:Dot(toMe.Unit)>0.6 then doDodge(p,"vel-spike") end
            end
            if antiBaitCFG.flickerEnabled and data.lastPos then
                if (curPos-data.lastPos).Magnitude>antiBaitCFG.flickerTpDist then data.tpTimes[#data.tpTimes+1]=tick() end
                cleanBaitTimes(data)
                if #data.tpTimes>=antiBaitCFG.flickerMinTps then data.tpTimes={}; doDodge(p,"flicker") end
            end
            data.lastPos=curPos; data.lastVel=curVel; data.lastYaw=hrp.Orientation.Y
        end
    end)
end
function RCLR_Functions.stopAntiBait() killConn("antiBait"); antiBaitCFG.enabled=false; antiBaitData={}; gunDodgeCDs={}; baitActive={} end

local translocConn,translocPreRender,translocRealCF=nil,nil,nil
local translocPingPongDir=1; local translocWaveT=0; local translocAltVert=1
local translocPulseT=0; local translocAcc=0; local translocPingPongTimer=0

local function getTranslocFakePos(realCF,index)
    local d=translocCFG.offsetDist; local jmp=translocCFG.jitter and translocCFG.jitterAmp or 0
    if not realCF then return CFrame.new(root and root.Position or Vector3.zero) end
    local base=realCF.Position; local ox,oy,oz=0,0,0; local m=translocCFG.offsetMode
    if translocCFG.wavePattern then translocWaveT=translocWaveT+0.01; d=d+math.sin(translocWaveT*translocCFG.waveFreq*2*math.pi)*translocCFG.waveAmp end
    if translocCFG.pingPong then d=d*translocPingPongDir end
    if translocCFG.cascadeOffset and index then d=d+(index-1)*translocCFG.cascadeStep end
    if translocCFG.pulse then translocPulseT=translocPulseT+0.01; d=d+math.sin(translocPulseT*translocCFG.pulseSpeed*2*math.pi)*translocCFG.pulseAmp end
    if m=="Ahead" then local look=realCF.LookVector; ox=look.X*d; oz=look.Z*d; oy=translocCFG.offsetY
    elseif m=="Behind" then local look=realCF.LookVector; ox=-look.X*d; oz=-look.Z*d; oy=translocCFG.offsetY
    elseif m=="Perpendicular" then local right=realCF.RightVector; local side=math.random()<0.5 and 1 or -1; ox=right.X*d*side; oz=right.Z*d*side; oy=translocCFG.offsetY
    elseif m=="Above" then ox=(math.random()-0.5)*jmp; oy=math.abs(d)+translocCFG.offsetY; oz=(math.random()-0.5)*jmp
    elseif m=="Below" then ox=(math.random()-0.5)*jmp; oy=-math.abs(d)+translocCFG.offsetY; oz=(math.random()-0.5)*jmp end
    if translocCFG.spinFake then
        local spinAng=tick()*math.rad(translocCFG.spinFakeSpeed)
        local nx=ox*math.cos(spinAng)-oz*math.sin(spinAng); local nz=ox*math.sin(spinAng)+oz*math.cos(spinAng); ox=nx; oz=nz
    end
    return CFrame.new(base.X+ox,base.Y+oy,base.Z+oz)
end

function RCLR_Functions.startTransloc()
    if translocConn then translocConn:Disconnect() end
    if translocPreRender then translocPreRender:Disconnect() end
    translocRealCF=nil; translocPingPongDir=1; translocWaveT=0; translocAltVert=1; translocPulseT=0; translocAcc=0; translocPingPongTimer=0
    if translocCFG.networkOwnerFix and root then pcall(function() root:SetNetworkOwner(LocalPlayer) end) end
    translocPreRender=RunService.PreRender:Connect(function()
        if not translocCFG.enabled or not root or not translocRealCF then return end
        if translocCFG.snapBack then root.CFrame=translocRealCF; root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero end
    end)
    translocConn=RunService.Heartbeat:Connect(function(dt)
        if not translocCFG.enabled then RCLR_Functions.stopTransloc(); return end
        if not root then return end
        translocRealCF=root.CFrame; translocAcc=translocAcc+dt; translocPingPongTimer=translocPingPongTimer+dt
        if translocCFG.pingPong and translocPingPongTimer>0.5 then translocPingPongTimer=0; translocPingPongDir=-translocPingPongDir end
        local interval = translocCFG.randomFrequency
            and 1/(translocCFG.freqMin+math.random()*(translocCFG.freqMax-translocCFG.freqMin))
            or  1/math.max(translocCFG.frequency,1)
        if translocAcc<interval then return end; translocAcc=translocAcc%interval
        local layerCount=math.max(translocCFG.layers,1); local burstCount=translocCFG.burstMode and translocCFG.burstCount or 1
        for b=1,burstCount do
            for i=1,layerCount do
                local fcf=getTranslocFakePos(translocRealCF,i)
                local fv=Vector3.zero
                if translocCFG.fakeVel then local mag=translocCFG.fakeVelMag; fv=Vector3.new((math.random()-0.5)*mag*2,(math.random()-0.5)*mag*2,(math.random()-0.5)*mag*2) end
                pcall(function() root.CFrame=fcf; root.AssemblyLinearVelocity=fv end)
            end
            if b<burstCount then task.wait(translocCFG.burstInterval) end
        end
    end)
end
function RCLR_Functions.stopTransloc()
    if translocConn then translocConn:Disconnect(); translocConn=nil end
    if translocPreRender then translocPreRender:Disconnect(); translocPreRender=nil end
    translocCFG.enabled=false; translocRealCF=nil
end

local aaAngAcc=0; local aaJitter=0; local aaRandTimer=0; local aaRandMult=1
local aaMicroTimer=0; local aaRollAcc=0; local aaBreatheAcc=0

function RCLR_Functions.startAntiAim()
    killConn("antiAim")
    conns.antiAim=RunService.Heartbeat:Connect(function(dt)
        if not aaSettings.enabled then killConn("antiAim"); return end
        if not root then return end
        aaMicroTimer=aaMicroTimer+dt; aaBreatheAcc=aaBreatheAcc+dt; aaRollAcc=aaRollAcc+dt
        local spd=aaSettings.speed
        if aaSettings.randomSpeed then aaRandTimer=aaRandTimer+dt; if aaRandTimer>0.1 then aaRandTimer=0; aaRandMult=0.2+math.random()*0.8 end; spd=spd*aaRandMult end
        local extraYaw,extraPitch=0,0
        if aaSettings.fakeAngle then extraYaw=extraYaw+aaSettings.fakeYaw; extraPitch=extraPitch+aaSettings.fakePitch end
        if aaSettings.breatheEffect then extraPitch=extraPitch+math.sin(aaBreatheAcc*aaSettings.breatheSpeed*2*math.pi)*aaSettings.breatheAmp end
        if aaSettings.microJitter and aaMicroTimer>=(1/math.max(aaSettings.microJitterSpeed,1)) then
            aaMicroTimer=0; extraYaw=extraYaw+(math.random()-0.5)*aaSettings.microJitterAmp*2; extraPitch=extraPitch+(math.random()-0.5)*aaSettings.microJitterAmp
        end
        if aaSettings.desyncMode then extraYaw=extraYaw+aaSettings.desyncOffset end
        if aaSettings.randomFlip and math.random()<aaSettings.flipChance then extraYaw=extraYaw+180 end
        local rollAngle=aaSettings.rollEnabled and (aaRollAcc*aaSettings.rollSpeed*math.pi/180)%(2*math.pi) or 0
        local m=aaSettings.mode
        if m=="Spin" then aaAngAcc=aaAngAcc+spd*dt; root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(extraPitch),math.rad(aaAngAcc+extraYaw),rollAngle)
        elseif m=="Jitter" then
            local p=aaSettings.jitterPitch and aaSettings.pitchAngle or 0; local y=aaSettings.jitterYaw and aaSettings.yawAngle or 0
            root.CFrame=root.CFrame*CFrame.Angles(math.rad((aaJitter==0 and p or -p)+extraPitch),math.rad((aaJitter==0 and y or -y)+extraYaw),rollAngle)
            aaJitter=(aaJitter+1)%2
        elseif m=="Static" then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(aaSettings.staticPitch+extraPitch),math.rad(aaSettings.staticYaw+extraYaw),rollAngle)
        elseif m=="Up" then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(90+extraPitch),math.rad(extraYaw),rollAngle)
        elseif m=="Down" then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(-90+extraPitch),math.rad(extraYaw),rollAngle)
        elseif m=="Side" then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(extraPitch),math.rad(extraYaw),math.rad(90)+rollAngle)
        elseif m=="RandomSpin" then aaAngAcc=aaAngAcc+spd*dt*(math.random()*2-1); root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(aaSettings.customPitch+extraPitch),math.rad(aaAngAcc+extraYaw),rollAngle)
        elseif m=="Custom" then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(math.rad(aaSettings.customPitch+extraPitch),math.rad(aaSettings.customYaw+extraYaw),rollAngle) end
    end)
end
function RCLR_Functions.stopAntiAim() killConn("antiAim"); aaSettings.enabled=false end

local riotGMTimer=0; local riotGMAng=0; local riotGMConn=nil

function RCLR_Functions.startRiotGodmode()
    if riotGMConn then riotGMConn:Disconnect() end; riotGMTimer=0; riotGMAng=0
    riotGMConn=RunService.Heartbeat:Connect(function(dt)
        if not riotGodmodeCFG.enabled then RCLR_Functions.stopRiotGodmode(); return end
        local hrp=getLocalRoot(); if not hrp then return end
        riotGMTimer=riotGMTimer+dt; if riotGMTimer<riotGodmodeCFG.speed then return end; riotGMTimer=0
        local cur=hrp.Position; local target=getClosest()
        local function pickPos(from)
            local a=math.random()*2*math.pi; local dist=riotGodmodeCFG.minJump+math.random()*(riotGodmodeCFG.maxJump-riotGodmodeCFG.minJump)
            local hv=riotGodmodeCFG.heightVariance; return from+Vector3.new(math.cos(a)*dist,math.random(-hv,hv),math.sin(a)*dist)
        end
        local newPos=cur
        if target and target.Character then
            local tHrp=target.Character:FindFirstChild("HumanoidRootPart")
            if tHrp then
                if riotGodmodeCFG.avoidBullets and (cur-tHrp.Position).Magnitude<riotGodmodeCFG.evadeRange then
                    newPos=cur+(cur-tHrp.Position).Unit*riotGodmodeCFG.bulletDodge
                else newPos=pickPos(cur) end
            else newPos=pickPos(cur) end
        else newPos=pickPos(cur) end
        if riotGodmodeCFG.groundSnap then newPos=Vector3.new(newPos.X,cur.Y,newPos.Z) end
        riotGMAng=(riotGMAng+riotGodmodeCFG.spinSpeed*dt)%360
        local ax=riotGodmodeCFG.randomAxis and math.random(1,3) or (riotGodmodeCFG.spinAxis=="X" and 1 or riotGodmodeCFG.spinAxis=="Y" and 2 or 3)
        local cf=CFrame.new(newPos)
        if ax==1 then cf=cf*CFrame.Angles(math.rad(riotGMAng),0,0) elseif ax==2 then cf=cf*CFrame.Angles(0,math.rad(riotGMAng),0) else cf=cf*CFrame.Angles(0,0,math.rad(riotGMAng)) end
        pcall(function() hrp.CFrame=cf; hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero end)
    end)
end
function RCLR_Functions.stopRiotGodmode() if riotGMConn then riotGMConn:Disconnect(); riotGMConn=nil end; riotGodmodeCFG.enabled=false end

local riotAbuserConn=nil; local riotAbuserOrbAng=0

function RCLR_Functions.startRiotAbuser()
    if riotAbuserConn then riotAbuserConn:Disconnect() end; riotAbuserOrbAng=0
    riotAbuserConn=RunService.Heartbeat:Connect(function(dt)
        if not riotAbuserCFG.enabled then RCLR_Functions.stopRiotAbuser(); return end
        local hrp=getLocalRoot(); if not hrp then return end
        local target=riotAbuserCFG.multiTarget and getTarget("Random") or getClosest()
        if not target or not target.Character then return end
        local tHrp=target.Character:FindFirstChild("HumanoidRootPart"); if not tHrp then return end
        local cf=tHrp.CFrame
        local tPos=riotAbuserCFG.predictTarget and predictPos(tHrp,riotAbuserCFG.predictLead) or tHrp.Position
        local mode=riotAbuserCFG.mode
        local rOff=riotAbuserCFG.randomOffset and Vector3.new((math.random()-0.5)*riotAbuserCFG.randomOffAmp*2,0,(math.random()-0.5)*riotAbuserCFG.randomOffAmp*2) or Vector3.zero
        if mode=="Stick" then hrp.CFrame=CFrame.new(tPos+cf.RightVector*riotAbuserCFG.right+cf.UpVector*(riotAbuserCFG.height-riotAbuserCFG.down)+cf.LookVector*riotAbuserCFG.forward+rOff)
        elseif mode=="Bounce" then
            local bounce=math.abs(math.sin(tick()*riotAbuserCFG.bounceSpeed))*riotAbuserCFG.bounceHeight
            hrp.CFrame=CFrame.new(tPos+cf.RightVector*riotAbuserCFG.right+cf.UpVector*(bounce-riotAbuserCFG.down)+cf.LookVector*riotAbuserCFG.forward+rOff)
        elseif mode=="Orbit" then
            riotAbuserOrbAng=(riotAbuserOrbAng+math.rad(riotAbuserCFG.orbitSpeed)*dt)%(2*math.pi)
            hrp.CFrame=CFrame.new(tPos+Vector3.new(math.cos(riotAbuserOrbAng)*riotAbuserCFG.orbitRadius,riotAbuserCFG.orbitHeight,math.sin(riotAbuserOrbAng)*riotAbuserCFG.orbitRadius))
        elseif mode=="Phase" then
            local side=math.random(0,1)==0 and 1 or -1
            hrp.CFrame=CFrame.new(tPos+cf.RightVector*riotAbuserCFG.right*side+cf.UpVector*(riotAbuserCFG.height-riotAbuserCFG.down)+cf.LookVector*riotAbuserCFG.phaseOffset+rOff)
        end
        if riotAbuserCFG.spinOnTarget then hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad((tick()*riotAbuserCFG.spinSpeed)%360),0) end
        if riotAbuserCFG.forceFaceTarget then
            local look=tHrp.Position-hrp.Position; if look.Magnitude>0.1 then hrp.CFrame=CFrame.new(hrp.Position,hrp.Position+Vector3.new(look.X,0,look.Z)) end
        end
        hrp.AssemblyLinearVelocity=tHrp.AssemblyLinearVelocity; hrp.AssemblyAngularVelocity=Vector3.zero
        if riotAbuserCFG.autoShoot then
            local now=tick()
            if (hrp.Position-tHrp.Position).Magnitude<riotAbuserCFG.attackRange and now-riotAbuserCFG.lastShot>riotAbuserCFG.shootCooldown then
                riotAbuserCFG.lastShot=now
                local tool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate(); task.wait(0.02); tool:Deactivate() end) end
            end
        end
    end)
end
function RCLR_Functions.stopRiotAbuser() if riotAbuserConn then riotAbuserConn:Disconnect(); riotAbuserConn=nil end; riotAbuserCFG.enabled=false end

local function bindChar(c)
    char=c; root=c:WaitForChild("HumanoidRootPart",5); hum=c:WaitForChild("Humanoid",5)
    if CFG.VOID_ENABLED then RCLR_Functions.startVoid() end
    if cfg.orbitEnabled then RCLR_Functions.startOrbit() end
    if cfgDodge.predEnabled then startPredictionV2() end
    if antiBaitCFG.enabled then startAntiBaitV2() end
    if aaSettings.enabled then RCLR_Functions.startAntiAim() end
    if translocCFG.enabled then RCLR_Functions.startTransloc() end
    if riotGodmodeCFG.enabled then RCLR_Functions.startRiotGodmode() end
    if riotAbuserCFG.enabled then RCLR_Functions.startRiotAbuser() end
end

if LocalPlayer.Character then bindChar(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(c) task.wait(0.3); bindChar(c) end)
LocalPlayer.CharacterRemoving:Connect(function()
    killConn("void"); killConn("orbit"); killConn("pred"); killConn("antiAim"); killConn("antiBait")
    if translocConn then translocConn:Disconnect(); translocConn=nil end
    if translocPreRender then translocPreRender:Disconnect(); translocPreRender=nil end
    if riotGMConn then riotGMConn:Disconnect(); riotGMConn=nil end
    if riotAbuserConn then riotAbuserConn:Disconnect(); riotAbuserConn=nil end
    root=nil; hum=nil; char=nil; antiBaitData={}; translocRealCF=nil
end)

-- ============================================================
-- TABS — same layout as original RCLR premium
-- ============================================================
local Tabs = {
    VoidSpam      = Window:AddTab("VoidSpam",     "activity"),
    Orbit         = Window:AddTab("Orbit",        "refresh-cw"),
    Prediction    = Window:AddTab("Prediction",   "crosshair"),
    Defense       = Window:AddTab("Defense",      "shield"),
    Translocation = Window:AddTab("Translocation","move"),
    Riot          = Window:AddTab("Riot",         "flame"),
    Rage          = Window:AddTab("Rage",         "zap"),
    Settings      = Window:AddTab("Settings",     "settings"),
}

do
local VG=Tabs.VoidSpam:AddLeftGroupbox("Void Control")
AddBindableToggle(VG,"VoidToggle","Enable Void",false,function(v) CFG.VOID_ENABLED=v; if v then RCLR_Functions.startVoid() else RCLR_Functions.stopVoid() end end)
VG:AddDropdown("VoidMethod",{Text="Method",Default="Quantum",Values={"Drift","Chaos","Loop","Spiral","Quantum","TP Everywhere","OrbitTarget","Predictive"},Callback=function(v) CFG.VOID_METHOD=v end})
VG:AddSlider("Speed",{Text="Speed",Default=1,Min=0.001,Max=1,Rounding=3,Callback=function(v) CFG.SPEED=v*1e9 end})
VG:AddSlider("Chaos",{Text="Chaos (%)",Default=98,Min=1,Max=100,Rounding=0,Callback=function(v) CFG.CHAOS=v*0.01 end})
VG:AddSlider("Radius",{Text="Radius (studs)",Default=1e11,Min=1,Max=1e15,Rounding=0,Callback=function(v) CFG.RADIUS=v end})
end
do
local VX=Tabs.VoidSpam:AddRightGroupbox("Void Options")
AddBindableToggle(VX,"VoidAntifling","Anti-Fling",true,function(v) CFG.VOID_ANTIFLING=v end)
AddBindableToggle(VX,"VoidAutoReenable","Auto Reenable",false,function(v) CFG.VOID_AUTO_REENABLE=v end)
AddBindableToggle(VX,"VoidStopOnDamage","Stop On Damage",false,function(v) CFG.VOID_STOP_ON_DAMAGE=v end)
AddBindableToggle(VX,"VoidAntiVoid","Anti-Void (skip)",false,function(v) CFG.VOID_ANTIVOID=v end)
AddBindableToggle(VX,"VoidFreezeGround","Freeze On Ground",false,function(v) CFG.VOID_FREEZE_ON_GROUND=v end)
VX:AddSlider("VoidOrbitSpeed",{Text="Orbit Speed (deg/s)",Default=90,Min=1,Max=720,Rounding=0,Callback=function(v) CFG.VOID_ORBIT_SPEED=v end})
VX:AddSlider("VoidSafeRadius",{Text="Safe Radius (studs)",Default=0,Min=0,Max=200,Rounding=0,Callback=function(v) CFG.VOID_SAFE_RADIUS=v end})
end
do
local VE=Tabs.VoidSpam:AddLeftGroupbox("TP Everywhere")
AddBindableToggle(VE,"TpRandToggle","Randomize Studs",true,function(v) CFG.TP_RAND_ENABLED=v end)
AddBindableToggle(VE,"TpCornerOnly","Pin To Screen Corners",false,function(v) CFG.TP_CORNER_ONLY=v end)
AddBindableToggle(VE,"TpVertSpike","Vertical Spike",true,function(v) CFG.TP_VERT_SPIKE=v end)
AddBindableToggle(VE,"TpNegBias","Negative Bias",true,function(v) CFG.TP_NEG_BIAS=v end)
AddBindableToggle(VE,"TpViewportRay","Viewport Raycast",true,function(v) CFG.TP_VIEWPORT_RAY=v end)
AddBindableToggle(VE,"TpScreenClamp","Clamp To Screen",true,function(v) CFG.TP_SCREEN_CLAMP=v end)
AddBindableToggle(VE,"TpPreserveY","Preserve Y",false,function(v) CFG.TP_PRESERVE_Y=v end)
end
do
local OG=Tabs.Orbit:AddLeftGroupbox("Orbit")
AddBindableToggle(OG,"OrbitToggle","Enable Orbit",false,function(v) cfg.orbitEnabled=v; if v then RCLR_Functions.startOrbit() else RCLR_Functions.stopOrbit() end end)
OG:AddDropdown("OrbitMode",{Text="Mode",Default="Circle",Values={"Circle","Figure 8","Ellipse","Spiral In","Spiral Out","Bounce","Lemniscate","Infinity","RandomOrbit"},Callback=function(v) cfg.orbitMode=v end})
OG:AddDropdown("OrbitTarget",{Text="Target",Default="Closest",Values={"Closest","Random","Weakest","Strongest"},Callback=function(v) cfg.orbitTarget=v end})
OG:AddSlider("OrbitSpeed",{Text="Speed (deg/s)",Default=90,Min=5,Max=720,Rounding=0,Callback=function(v) cfg.orbitSpeed=v end})
OG:AddSlider("OrbitDist",{Text="Radius",Default=8,Min=1,Max=200,Rounding=0,Callback=function(v) cfg.orbitDist=v end})
OG:AddSlider("OrbitHeight",{Text="Height Offset",Default=0,Min=-200,Max=200,Rounding=0,Callback=function(v) cfg.orbitHeight=v end})
AddBindableToggle(OG,"OrbitReverse","Reverse",false,function(v) cfg.orbitReverse=v end)
end
do
local PG=Tabs.Prediction:AddLeftGroupbox("Prediction V2")
AddBindableToggle(PG,"PredToggle","Enable Prediction V2",false,function(v) cfgDodge.predEnabled=v; if v then startPredictionV2() else RCLR_Functions.stopPredictionV2() end end)
PG:AddSlider("PredRadius",{Text="Danger Radius",Default=120,Min=5,Max=5000,Rounding=0,Callback=function(v) cfgDodge.predRadius=v end})
PG:AddSlider("PredDodge",{Text="Dodge Distance",Default=80,Min=5,Max=500,Rounding=0,Callback=function(v) cfgDodge.predDodgeDist=v end})
PG:AddSlider("PredCooldown",{Text="Cooldown (ms)",Default=30,Min=10,Max=2000,Rounding=0,Callback=function(v) cfgDodge.predCooldown=v/1000 end})
AddBindableToggle(PG,"PredShootDetect","Detect Enemy Shooting",true,function(v) cfgDodge.predShootDetect=v end)
AddBindableToggle(PG,"PredRaycast","Raycast Line of Fire",true,function(v) cfgDodge.predRaycast=v end)
AddBindableToggle(PG,"PredMultiPoint","Multi-Point Dodge",true,function(v) cfgDodge.predMultiPoint=v end)
AddBindableToggle(PG,"PredBackstep","Backstep Dodge",true,function(v) cfgDodge.predBackstep=v end)
AddBindableToggle(PG,"PredPredictiveAim","Predictive Aim",true,function(v) cfgDodge.predPredictiveAim=v end)
AddBindableToggle(PG,"PredAnimDetect","Animation Detect",true,function(v) cfgDodge.predAnimDetect=v end)
AddBindableToggle(PG,"PredInfiniteRange","Infinite Range Prediction",false,function(v) cfgDodge.predInfiniteRange=v end)
end
do
local PG2=Tabs.Prediction:AddRightGroupbox("Anti Bait V2")
AddBindableToggle(PG2,"AntiBaitToggle","Enable Anti Bait V2",false,function(v) antiBaitCFG.enabled=v; if v then startAntiBaitV2() else RCLR_Functions.stopAntiBait() end end)
PG2:AddDropdown("AntiBaitDodgeMode",{Text="Dodge Mode",Default="Perpendicular",Values={"Perpendicular","Away","Random"},Callback=function(v) antiBaitCFG.dodgeMode=v end})
AddBindableToggle(PG2,"AntiBaitBaitEnabled","Bait Enemy Shots",true,function(v) antiBaitCFG.baitEnabled=v end)
AddBindableToggle(PG2,"AntiBaitVel","Vel Spike Detect",true,function(v) antiBaitCFG.velSpikeEnabled=v end)
AddBindableToggle(PG2,"AntiBaitFlicker","Flicker Detect",true,function(v) antiBaitCFG.flickerEnabled=v end)
AddBindableToggle(PG2,"AntiBaitNotify","Notify on Dodge",true,function(v) antiBaitCFG.notifyOnDodge=v end)
AddBindableToggle(PG2,"AntiBaitShoot","Dodge On Shoot",true,function(v) antiBaitCFG.dodgeOnShoot=v end)
AddBindableToggle(PG2,"AntiBaitGunPredict","Gun Prediction Dodge",true,function(v) antiBaitCFG.gunPredEnabled=v end)
AddBindableToggle(PG2,"AntiBaitInfiniteRange","Infinite Range Anti-Bait",false,function(v) antiBaitCFG.infiniteRange=v end)
end
do
local AG=Tabs.Defense:AddLeftGroupbox("Anti-Aim")
AddBindableToggle(AG,"AaToggle","Enable Anti-Aim",false,function(v) aaSettings.enabled=v; if v then RCLR_Functions.startAntiAim() else RCLR_Functions.stopAntiAim() end end)
AG:AddDropdown("AaMode",{Text="Mode",Default="RandomSpin",Values={"Spin","Jitter","Static","Up","Down","Side","RandomSpin","Custom"},Callback=function(v) aaSettings.mode=v end})
AG:AddSlider("AaSpeed",{Text="Speed (deg/s)",Default=5000,Min=100,Max=5000,Rounding=0,Callback=function(v) aaSettings.speed=v end})
AddBindableToggle(AG,"AaRandomSpeed","Randomize Speed",true,function(v) aaSettings.randomSpeed=v end)
AddBindableToggle(AG,"AaDesyncMode","Desync Mode",false,function(v) aaSettings.desyncMode=v end)
AG:AddSlider("AaDesyncOffset",{Text="Desync Yaw Offset",Default=180,Min=0,Max=360,Rounding=0,Callback=function(v) aaSettings.desyncOffset=v end})
AddBindableToggle(AG,"AaRollEnabled","Roll Axis",false,function(v) aaSettings.rollEnabled=v end)
end
do
local SE=Tabs.Defense:AddRightGroupbox("Smart Evasion")
AddBindableToggle(SE,"SmartEvasionToggle","Enable Smart Evasion",false,function(v) CFG.SMART_EVASION=v end)
AddBindableToggle(SE,"SmartEvasionInf","Infinite Threat Range",false,function(v) CFG.SMART_EVASION_INF=v end)
SE:AddSlider("SmartEvasionRange",{Text="Threat Range (studs)",Default=80,Min=10,Max=500,Rounding=0,Callback=function(v) CFG.EVASION_RANGE=v end})
SE:AddSlider("SmartEvasionPower",{Text="Dodge Power",Default=100,Min=5,Max=400,Rounding=0,Callback=function(v) CFG.EVASION_DODGE_POWER=v end})
AddBindableToggle(SE,"SmartEvasionLayered","Layered Dodge",true,function(v) CFG.EVASION_LAYERED=v end)
AddBindableToggle(SE,"SmartEvasionNotify","Notify on Dodge",false,function(v) CFG.EVASION_NOTIFY=v end)
end
do
local TL=Tabs.Translocation:AddLeftGroupbox("Translocation")
AddBindableToggle(TL,"TranslocToggle","Enable Translocation",false,function(v) translocCFG.enabled=v; if v then RCLR_Functions.startTransloc() else RCLR_Functions.stopTransloc() end end)
TL:AddDropdown("TranslocMode",{Text="Offset Mode",Default="Ahead",Values={"Ahead","Behind","Perpendicular","Above","Below","AboveBelow","Diagonal"},Callback=function(v) translocCFG.offsetMode=v end})
TL:AddSlider("TranslocFreq",{Text="Frequency (Hz)",Default=256,Min=1,Max=1000,Rounding=0,Callback=function(v) translocCFG.frequency=v end})
TL:AddSlider("TranslocLayers",{Text="Fake Layers",Default=5,Min=1,Max=10,Rounding=0,Callback=function(v) translocCFG.layers=v end})
AddBindableToggle(TL,"TranslocFakeVel","Fake Velocity",true,function(v) translocCFG.fakeVel=v end)
AddBindableToggle(TL,"TranslocSnapBack","Snap Back",true,function(v) translocCFG.snapBack=v end)
AddBindableToggle(TL,"TranslocJitter","Position Jitter",true,function(v) translocCFG.jitter=v end)
AddBindableToggle(TL,"TranslocNetOwner","Network Owner Fix",true,function(v) translocCFG.networkOwnerFix=v end)
end
do
local RG=Tabs.Riot:AddLeftGroupbox("Riot Godmode")
AddBindableToggle(RG,"RiotGodmodeToggle","Enable Riot Godmode",false,function(v) riotGodmodeCFG.enabled=v; if v then RCLR_Functions.startRiotGodmode() else RCLR_Functions.stopRiotGodmode() end end)
RG:AddSlider("RGSpeed",{Text="Teleport Delay (s)",Default=0.03,Min=0.01,Max=0.5,Rounding=2,Callback=function(v) riotGodmodeCFG.speed=v end})
RG:AddSlider("RGMinJump",{Text="Min Jump Range",Default=10,Min=1,Max=100,Rounding=0,Callback=function(v) riotGodmodeCFG.minJump=v end})
RG:AddSlider("RGMaxJump",{Text="Max Jump Range",Default=200,Min=10,Max=2000,Rounding=0,Callback=function(v) riotGodmodeCFG.maxJump=v end})
AddBindableToggle(RG,"RGAvoidBullet","Avoid Bullets",true,function(v) riotGodmodeCFG.avoidBullets=v end)
AddBindableToggle(RG,"RGPhaseMode","Phase Mode",false,function(v) riotGodmodeCFG.phaseMode=v end)
end
do
local RA=Tabs.Riot:AddRightGroupbox("Riot Abuser")
AddBindableToggle(RA,"RiotAbuserToggle","Enable Riot Abuser",false,function(v) riotAbuserCFG.enabled=v; if v then RCLR_Functions.startRiotAbuser() else RCLR_Functions.stopRiotAbuser() end end)
RA:AddDropdown("RAMode",{Text="Mode",Default="Stick",Values={"Stick","Bounce","Orbit","Phase"},Callback=function(v) riotAbuserCFG.mode=v end})
RA:AddSlider("RAHeight",{Text="Height Offset",Default=3,Min=-50,Max=50,Rounding=1,Callback=function(v) riotAbuserCFG.height=v end})
RA:AddSlider("RAAttackRange",{Text="Attack Range",Default=10,Min=1,Max=50,Rounding=0,Callback=function(v) riotAbuserCFG.attackRange=v end})
AddBindableToggle(RA,"RAAutoShoot","Auto Shoot",true,function(v) riotAbuserCFG.autoShoot=v end)
AddBindableToggle(RA,"RAForceFace","Force Face Target",true,function(v) riotAbuserCFG.forceFaceTarget=v end)
end

-- Rage tab
local ueCFG={enabled=false,interval=2,yMax=10000000,randY=true,fixedY=0,lockXZ=true}
local ueConn=nil; local ueAcc=0; local ueHoldY=0
function RCLR_Functions.startUECounter()
    if ueConn then ueConn:Disconnect(); ueConn=nil end; ueAcc=0
    local step=RunService.PreSimulation or RunService.Heartbeat
    ueConn=step:Connect(function(dt)
        if not ueCFG.enabled then return end
        local hrp=getLocalRoot(); if not hrp then return end
        ueAcc=ueAcc+dt
        if ueAcc>=ueCFG.interval then
            ueAcc=ueAcc%ueCFG.interval
            ueHoldY=ueCFG.randY and math.random(0,ueCFG.yMax) or ueCFG.fixedY
            pcall(function() hrp:SetNetworkOwner(LocalPlayer) end)
        end
        local tx=ueCFG.lockXZ and 0 or hrp.Position.X; local tz=ueCFG.lockXZ and 0 or hrp.Position.Z
        pcall(function() hrp.CFrame=CFrame.new(tx,ueHoldY,tz); hrp.AssemblyLinearVelocity=Vector3.zero; hrp.AssemblyAngularVelocity=Vector3.zero end)
    end)
end
function RCLR_Functions.stopUECounter() if ueConn then ueConn:Disconnect(); ueConn=nil end; ueCFG.enabled=false end

do
local RAG=Tabs.Rage:AddLeftGroupbox("UE Counter")
AddBindableToggle(RAG,"UECounterToggle","Enable UE Counter",false,function(v) ueCFG.enabled=v; if v then RCLR_Functions.startUECounter() else RCLR_Functions.stopUECounter() end end)
RAG:AddSlider("UEInterval",{Text="Pulse Interval (s)",Default=2,Min=0.1,Max=10,Rounding=1,Callback=function(v) ueCFG.interval=v end})
AddBindableToggle(RAG,"UERandY","Randomize Y",true,function(v) ueCFG.randY=v end)
AddBindableToggle(RAG,"UELockXZ","Freeze X/Z To 0",true,function(v) ueCFG.lockXZ=v end)
end

-- Settings tab
do
local MenuG=Tabs.Settings:AddLeftGroupbox("Menu")
MenuG:AddButton("HVH LOCK IN",function()
    CFG.VOID_ENABLED=true; CFG.VOID_METHOD="Quantum"; CFG.VOID_ANTIFLING=true
    cfgDodge.predEnabled=true; cfgDodge.predInfiniteRange=true
    antiBaitCFG.enabled=true; antiBaitCFG.infiniteRange=true
    aaSettings.enabled=true; translocCFG.enabled=true; CFG.SMART_EVASION=true
    if Toggles.VoidToggle then Toggles.VoidToggle:SetValue(true) end
    if Toggles.PredToggle then Toggles.PredToggle:SetValue(true) end
    if Toggles.AntiBaitToggle then Toggles.AntiBaitToggle:SetValue(true) end
    if Toggles.AaToggle then Toggles.AaToggle:SetValue(true) end
    if Toggles.TranslocToggle then Toggles.TranslocToggle:SetValue(true) end
    if Toggles.SmartEvasionToggle then Toggles.SmartEvasionToggle:SetValue(true) end
    RCLR_Functions.startVoid(); startPredictionV2(); startAntiBaitV2(); RCLR_Functions.startAntiAim(); RCLR_Functions.startTransloc()
    Notify("HVH LOCK IN engaged",3)
end)
MenuG:AddButton("Kill Every (Disable All)",function()
    CFG.VOID_ENABLED=false; RCLR_Functions.stopVoid()
    cfg.orbitEnabled=false; RCLR_Functions.stopOrbit()
    cfgDodge.predEnabled=false; RCLR_Functions.stopPredictionV2()
    antiBaitCFG.enabled=false; RCLR_Functions.stopAntiBait()
    aaSettings.enabled=false; RCLR_Functions.stopAntiAim()
    translocCFG.enabled=false; RCLR_Functions.stopTransloc()
    riotGodmodeCFG.enabled=false; RCLR_Functions.stopRiotGodmode()
    riotAbuserCFG.enabled=false; RCLR_Functions.stopRiotAbuser()
    ueCFG.enabled=false; RCLR_Functions.stopUECounter()
    Notify("All systems off",3)
end)
MenuG:AddButton("Reload Character",function()
    if LocalPlayer.Character then LocalPlayer.Character:BreakJoints() end
end)
MenuG:AddButton("Server Hop",function()
    pcall(function()
        local Http=game:GetService("HttpService"); local TS=game:GetService("TeleportService")
        local data=Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _,srv in ipairs(data.data) do
            if srv.playing<srv.maxPlayers and srv.id~=game.JobId then TS:TeleportToPlaceInstance(game.PlaceId,srv.id,LocalPlayer); break end
        end
    end)
end)
end
