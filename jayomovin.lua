-- [[ Jayomovin.noob | Professional Dark Goth Theme ]]
print("Jayomovin.noob Loaded")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("JayomovinCast") then PlayerGui.JayomovinCast:Destroy() end

-- ===== SETTINGS =====
local Settings = {
    UI_Rainbow = false, AimbotEnabled = true, FOVRadius = 267, FOVMode = "Mobile",
    SkeletonESP = false, ESP_Box = false, ESP_Health = false, ESP_Tracker = false, ESP_Name = false, ESP_Distance = false, MaxESPDistance = 500,
    SpeedEnabled = false, SpeedValue = 20, 
    SpinEnabled = false, SpinSpeed = 30,
    HitboxEnabled = false, HitboxSize = 5,
}

-- ===== CONFIG SAVER =====
local ConfigFile = "JayomovinConfig.json"
local function SaveConfig()
    if writefile then
        pcall(function()
            writefile(ConfigFile, HttpService:JSONEncode(Settings))
        end)
    end
end

local function LoadConfig()
    if isfile and isfile(ConfigFile) then
        pcall(function()
            local data = HttpService:JSONDecode(readfile(ConfigFile))
            for k, v in pairs(data) do
                if Settings[k] ~= nil then
                    Settings[k] = v
                end
            end
        end)
    end
end
LoadConfig()

-- ===== SCOPING VARIABLES =====
local TitleLabel = nil
local ToggleBtn = nil
local desyncCFrame = CFrame.new()
local isDesyncing = false
local RainbowUI = { Texts = {}, Toggles = {}, Sliders = {} }
local AutoTarget = nil
local originalHitboxSizes = {}

-- ===== THEME PALETTE (DARK GOTH) =====
local GothTheme = {
    Background = Color3.fromRGB(10, 10, 12),      -- Deep Obsidian Black
    Sidebar = Color3.fromRGB(15, 13, 15),         -- Dark Ash
    TopBar = Color3.fromRGB(18, 14, 18),          -- Crypt Grey
    Accent = Color3.fromRGB(150, 0, 20),          -- Crimson Blood Red
    TextMain = Color3.fromRGB(220, 220, 225),     -- Silver Mist
    TextDim = Color3.fromRGB(130, 120, 125),      -- Shadow Grey
    ToggleOn = Color3.fromRGB(180, 0, 25),        -- Active Crimson
    ToggleOff = Color3.fromRGB(40, 20, 22),       -- Dried Blood
}

-- ===== ADVANCED DESYNC HOOK =====
local oldIndex
pcall(function()
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if isDesyncing and not checkcaller() and key == "CFrame" and LocalPlayer.Character and self == LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return desyncCFrame
        end
        return oldIndex(self, key)
    end))
end)

-- ===== SAFE MODULE LOADING =====
local cast = nil
pcall(function() cast = require(game.ReplicatedStorage:WaitForChild("SimpleCast")) end)

-- ===== DRAWING API =====
local FOVCircle
pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 1.5; FOVCircle.Color = GothTheme.Accent; FOVCircle.Filled = false; FOVCircle.Transparency = 1; FOVCircle.Visible = true
end)

local function GetFOVCenter()
    if Settings.FOVMode == "PC" then
        return UserInputService:GetMouseLocation()
    else
        return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
end

-- ===== AUTO TARGET LOGIC =====
local function GetClosestEnemy()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local center = GetFOVCenter()
    local closest = nil
    local shortest = Settings.FOVRadius
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and plr.Team ~= LocalPlayer.Team then
                local screenPos, onScreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = plr
                    end
                end
            end
        end
    end
    return closest
end

-- ===== HOOK CAST (SILENT AIM) =====
if cast and cast.Fire then
    local origFire = cast.Fire
    cast.Fire = function(self, origin, direction, speed, data)
        if Settings.AimbotEnabled and AutoTarget and AutoTarget.Character then
            local targetRoot = AutoTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                if isDesyncing then origin = desyncCFrame.Position end
                local v = targetRoot.Position - origin
                if v.Magnitude > 0.001 then direction = v.Unit end
            end
        end
        return origFire(self, origin, direction, speed, data)
    end
end

-- ===== ESP SETUP =====
local r15Bones = {{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"}, {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}}
local r6Bones = {{"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"}, {"Torso", "Left Leg"}, {"Torso", "Right Leg"}}
local espCache = {}

local function CreateESP(plr)
    if plr == LocalPlayer or espCache[plr] then return end
    local skeletonLines = {}
    for i = 1, 15 do local line = Drawing.new("Line"); line.Thickness = 1.5; line.Color = GothTheme.Accent; line.Transparency = 1; line.Visible = false; table.insert(skeletonLines, line) end
    local boxLines = {}
    for i = 1, 4 do local line = Drawing.new("Line"); line.Thickness = 1.5; line.Color = GothTheme.Accent; line.Visible = false; table.insert(boxLines, line) end
    local healthBg = Drawing.new("Line"); healthBg.Thickness = 3; healthBg.Color = Color3.fromRGB(0, 0, 0); healthBg.Visible = false
    local healthBar = Drawing.new("Line"); healthBar.Thickness = 3; healthBar.Color = GothTheme.Accent; healthBar.Visible = false
    local tracker = Drawing.new("Line"); tracker.Thickness = 1.5; tracker.Color = GothTheme.Accent; tracker.Visible = false
    
    local nameText = Drawing.new("Text"); nameText.Size = 14; nameText.Center = true; nameText.Outline = true; nameText.Color = Color3.fromRGB(255, 255, 255); nameText.Visible = false
    local distText = Drawing.new("Text"); distText.Size = 12; distText.Center = true; distText.Outline = true; distText.Color = GothTheme.Accent; distText.Visible = false

    espCache[plr] = {Skeleton = skeletonLines, Box = boxLines, HealthBg = healthBg, Health = healthBar, Tracker = tracker, NameTxt = nameText, DistTxt = distText}
end

local function RemoveESP(plr)
    if espCache[plr] then
        for _, line in pairs(espCache[plr].Skeleton) do line:Remove() end
        for _, line in pairs(espCache[plr].Box) do line:Remove() end
        espCache[plr].HealthBg:Remove(); espCache[plr].Health:Remove(); espCache[plr].Tracker:Remove()
        espCache[plr].NameTxt:Remove(); espCache[plr].DistTxt:Remove()
        espCache[plr] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

-- ===== UI BUILD =====
local uiSuccess, uiErr = pcall(function()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "JayomovinCast"; ScreenGui.Parent = PlayerGui; ScreenGui.ResetOnSpawn = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.DisplayOrder = 999

    ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = ScreenGui; ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
    ToggleBtn.Text = "JM"; ToggleBtn.TextColor3 = GothTheme.Accent; ToggleBtn.BackgroundColor3 = GothTheme.Background; ToggleBtn.Font = Enum.Font.FredokaOne; ToggleBtn.TextSize = 20; ToggleBtn.BorderSizePixel = 1; ToggleBtn.BorderColor3 = GothTheme.Accent
    local TCorner = Instance.new("UICorner"); TCorner.Parent = ToggleBtn; TCorner.CornerRadius = UDim.new(0, 4)

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui; MainFrame.Size = UDim2.new(0, 360, 0, 330); MainFrame.Position = UDim2.new(0.5, -180, 0.5, -165)
    MainFrame.BackgroundColor3 = GothTheme.Background; MainFrame.BorderSizePixel = 1; MainFrame.BorderColor3 = Color3.fromRGB(30, 25, 30); MainFrame.Visible = false; MainFrame.Active = true
    local MCorner = Instance.new("UICorner"); MCorner.Parent = MainFrame; MCorner.CornerRadius = UDim.new(0, 4)

    -- Subtle Gothic Shadow/Glow Border effect
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = MainFrame; UIStroke.Color = GothTheme.Accent; UIStroke.Thickness = 1.2; UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local TopBar = Instance.new("Frame")
    TopBar.Parent = MainFrame; TopBar.Size = UDim2.new(1, 0, 0, 40); TopBar.BackgroundColor3 = GothTheme.TopBar; TopBar.BorderSizePixel = 0
    local TopCorner = Instance.new("UICorner"); TopCorner.Parent = TopBar; TopCorner.CornerRadius = UDim.new(0, 4)
    
    ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        end
    end)
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TopBar; TitleLabel.Size = UDim2.new(1, -40, 1, 0); TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.Text = "JAYOMOVIN.NOOB"; TitleLabel.TextColor3 = GothTheme.Accent; TitleLabel.BackgroundTransparency = 1; TitleLabel.Font = Enum.Font.SpecialElite; TitleLabel.TextSize = 16; TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    table.insert(RainbowUI.Texts, TitleLabel)

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar; CloseBtn.Size = UDim2.new(0, 40, 0, 40); CloseBtn.Position = UDim2.new(1, -40, 0, 0); CloseBtn.Text = "✕"; CloseBtn.TextColor3 = GothTheme.TextDim; CloseBtn.BackgroundTransparency = 1; CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 14
    CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
    CloseBtn.MouseEnter:Connect(function() CloseBtn.TextColor3 = GothTheme.Accent end)
    CloseBtn.MouseLeave:Connect(function() CloseBtn.TextColor3 = GothTheme.TextDim end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Parent = MainFrame; Sidebar.Size = UDim2.new(0, 85, 1, -40); Sidebar.Position = UDim2.new(0, 0, 0, 40); Sidebar.BackgroundColor3 = GothTheme.Sidebar; Sidebar.BorderSizePixel = 0
    local SLayout = Instance.new("UIListLayout"); SLayout.Parent = Sidebar; SLayout.SortOrder = Enum.SortOrder.LayoutOrder; SLayout.Padding = UDim.new(0, 3)
    local SPad = Instance.new("UIPadding"); SPad.Parent = Sidebar; SPad.PaddingTop = UDim.new(0, 8); SPad.PaddingLeft = UDim.new(0, 4); SPad.PaddingRight = UDim.new(0, 4)

    local activeTab = nil
    local function CreateTabBtn(name, order)
        local btn = Instance.new("TextButton")
        btn.Parent = Sidebar; btn.Size = UDim2.new(1, 0, 0, 32); btn.Text = name; btn.TextColor3 = GothTheme.TextDim; btn.BackgroundColor3 = Color3.fromRGB(0,0,0); btn.BackgroundTransparency = 1; btn.Font = Enum.Font.GothamMedium; btn.TextSize = 12; btn.BorderSizePixel = 0; btn.LayoutOrder = order
        local btnCorner = Instance.new("UICorner"); btnCorner.CornerRadius = UDim.new(0, 4); btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function() if activeTab ~= btn then btn.TextColor3 = GothTheme.TextMain end end)
        btn.MouseLeave:Connect(function() if activeTab ~= btn then btn.TextColor3 = GothTheme.TextDim end end)
        return btn
    end

    local TabCombat = CreateTabBtn("Combat", 1)
    local TabPlayer = CreateTabBtn("Player", 2)
    local TabVisuals = CreateTabBtn("Visuals", 3)
    local TabHitbox = CreateTabBtn("Hitbox", 4)
    local TabSettings = CreateTabBtn("Settings", 5)

    local function CreateScrollFrame(parent)
        local scroll = Instance.new("ScrollingFrame")
        scroll.Parent = parent; scroll.Size = UDim2.new(1, -10, 1, -10); scroll.Position = UDim2.new(0, 5, 0, 5); scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = GothTheme.Accent; scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        local layout = Instance.new("UIListLayout"); layout.Parent = scroll; layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 10)
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10) end)
        return scroll
    end

    local function CreateToggle(parent, text, default, callback)
        local frame = Instance.new("Frame"); frame.Parent = parent; frame.Size = UDim2.new(1, 0, 0, 30); frame.BackgroundTransparency = 1
        local label = Instance.new("TextLabel"); label.Parent = frame; label.Size = UDim2.new(0.7, 0, 1, 0); label.Text = text; label.TextColor3 = GothTheme.TextMain; label.BackgroundTransparency = 1; label.Font = Enum.Font.Gotham; label.TextSize = 13; label.TextXAlignment = Enum.TextXAlignment.Left
        local btn = Instance.new("TextButton"); btn.Parent = frame; btn.Size = UDim2.new(0, 46, 0, 22); btn.Position = UDim2.new(1, -48, 0, 4); btn.Text = default and "ON" or "OFF"; btn.BackgroundColor3 = default and GothTheme.ToggleOn or GothTheme.ToggleOff; btn.TextColor3 = GothTheme.TextMain; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.BorderSizePixel = 1; btn.BorderColor3 = GothTheme.Accent
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 3); corner.Parent = btn
        
        table.insert(RainbowUI.Toggles, {btn = btn})
        btn.MouseButton1Click:Connect(function() 
            local state = not (btn.Text == "ON")
            btn.Text = state and "ON" or "OFF"
            btn.BackgroundColor3 = state and GothTheme.ToggleOn or GothTheme.ToggleOff
            if callback then callback(state) end 
            SaveConfig()
        end)
        return frame
    end

    local function CreateSlider(parent, text, min, max, default, callback)
        local frame = Instance.new("Frame"); frame.Parent = parent; frame.Size = UDim2.new(1, 0, 0, 42); frame.BackgroundTransparency = 1
        local label = Instance.new("TextLabel"); label.Parent = frame; label.Size = UDim2.new(1, 0, 0, 16); label.Text = text .. ": " .. tostring(default); label.TextColor3 = GothTheme.TextMain; label.BackgroundTransparency = 1; label.Font = Enum.Font.Gotham; label.TextSize = 12; label.TextXAlignment = Enum.TextXAlignment.Left
        local bar = Instance.new("Frame"); bar.Parent = frame; bar.Size = UDim2.new(1, -10, 0, 4); bar.Position = UDim2.new(0, 5, 0, 26); bar.BackgroundColor3 = Color3.fromRGB(25, 20, 25); bar.BorderSizePixel = 0
        local barCorner = Instance.new("UICorner"); barCorner.Parent = bar
        local fill = Instance.new("Frame"); fill.Parent = bar; fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = GothTheme.Accent; fill.BorderSizePixel = 0
        local fillCorner = Instance.new("UICorner"); fillCorner.Parent = fill
        
        table.insert(RainbowUI.Sliders, fill)
        local draggingSlider = false
        local function update(input)
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + ((max - min) * pos))
            fill.Size = UDim2.new(pos, 0, 1, 0); label.Text = text .. ": " .. tostring(val)
            if callback then callback(val) end
            SaveConfig()
        end
        bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = false end end)
        UserInputService.InputChanged:Connect(function(input) if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end end)
        return frame
    end

    local function CreateActionBtn(parent, text, callback)
        local btn = Instance.new("TextButton"); btn.Parent = parent; btn.Size = UDim2.new(1, 0, 0, 32); btn.Text = text
        btn.BackgroundColor3 = GothTheme.TopBar; btn.TextColor3 = GothTheme.Accent; btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.BorderSizePixel = 1; btn.BorderColor3 = GothTheme.Accent
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = btn
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local PageCombat = CreateScrollFrame(MainFrame)
    local PagePlayer = CreateScrollFrame(MainFrame)
    local PageVisuals = CreateScrollFrame(MainFrame)
    local PageHitbox = CreateScrollFrame(MainFrame)
    local PageSettings = CreateScrollFrame(MainFrame)

    for _, page in pairs({PageCombat, PagePlayer, PageVisuals, PageHitbox, PageSettings}) do
        page.Position = UDim2.new(0, 95, 0, 45); page.Size = UDim2.new(1, -100, 1, -50)
        page.Visible = false
    end

    local function SwitchTab(button, page)
        if activeTab then
            activeTab.BackgroundTransparency = 1
            activeTab.TextColor3 = GothTheme.TextDim
        end
        activeTab = button
        activeTab.BackgroundTransparency = 0
        activeTab.BackgroundColor3 = GothTheme.Background
        activeTab.TextColor3 = GothTheme.Accent
        
        for _, p in pairs({PageCombat, PagePlayer, PageVisuals, PageHitbox, PageSettings}) do
            p.Visible = (p == page)
        end
    end

    TabCombat.MouseButton1Click:Connect(function() SwitchTab(TabCombat, PageCombat) end)
    TabPlayer.MouseButton1Click:Connect(function() SwitchTab(TabPlayer, PagePlayer) end)
    TabVisuals.MouseButton1Click:Connect(function() SwitchTab(TabVisuals, PageVisuals) end)
    TabHitbox.MouseButton1Click:Connect(function() SwitchTab(TabHitbox, PageHitbox) end)
    TabSettings.MouseButton1Click:Connect(function() SwitchTab(TabSettings, PageSettings) end)
    
    SwitchTab(TabCombat, PageCombat)

    -- COMBAT
    CreateToggle(PageCombat, "Silent Aim", Settings.AimbotEnabled, function(s) Settings.AimbotEnabled = s end)
    CreateSlider(PageCombat, "FOV Radius", 50, 500, Settings.FOVRadius, function(v) Settings.FOVRadius = v end)
    
    local FOVModeBtn = CreateActionBtn(PageCombat, "FOV Mode: " .. Settings.FOVMode, function()
        if Settings.FOVMode == "Mobile" then Settings.FOVMode = "PC"; FOVModeBtn.Text = "FOV Mode: PC"
        else Settings.FOVMode = "Mobile"; FOVModeBtn.Text = "FOV Mode: Mobile" end
        SaveConfig()
    end)

    -- PLAYER
    CreateToggle(PagePlayer, "Velocity Speed", Settings.SpeedEnabled, function(s) Settings.SpeedEnabled = s end)
    CreateSlider(PagePlayer, "Speed Value (Max 150)", 16, 150, Settings.SpeedValue, function(v) Settings.SpeedValue = v end)
    CreateToggle(PagePlayer, "Spinbot", Settings.SpinEnabled, function(s) Settings.SpinEnabled = s end)
    CreateSlider(PagePlayer, "Spin Speed (0-65)", 0, 65, Settings.SpinSpeed, function(v) Settings.SpinSpeed = v end)

    -- VISUALS
    CreateSlider(PageVisuals, "Max ESP Distance", 50, 1500, Settings.MaxESPDistance, function(v) Settings.MaxESPDistance = v end)
    CreateToggle(PageVisuals, "Skeleton ESP", Settings.SkeletonESP, function(s) Settings.SkeletonESP = s end)
    CreateToggle(PageVisuals, "Box ESP", Settings.ESP_Box, function(s) Settings.ESP_Box = s end)
    CreateToggle(PageVisuals, "Health Bar", Settings.ESP_Health, function(s) Settings.ESP_Health = s end)
    CreateToggle(PageVisuals, "Tracker Line", Settings.ESP_Tracker, function(s) Settings.ESP_Tracker = s end)
    CreateToggle(PageVisuals, "Name ESP", Settings.ESP_Name, function(s) Settings.ESP_Name = s end)
    CreateToggle(PageVisuals, "Distance ESP", Settings.ESP_Distance, function(s) Settings.ESP_Distance = s end)

    -- ===== HITBOX TAB =====
    local WarningLabel = Instance.new("TextLabel")
    WarningLabel.Parent = PageHitbox
    WarningLabel.Size = UDim2.new(1, 0, 0, 55)
    WarningLabel.BackgroundColor3 = Color3.fromRGB(35, 10, 12)
    WarningLabel.TextColor3 = GothTheme.Accent
    WarningLabel.Font = Enum.Font.GothamBold
    WarningLabel.TextSize = 11
    WarningLabel.TextWrapped = true
    WarningLabel.Text = "⚠️ WARNING: It could take 3 to 4 taps to kill somebody because it is very strong. DOES NOT hit through walls (Character must be visible)."
    local wCorner = Instance.new("UICorner"); wCorner.CornerRadius = UDim.new(0, 4); wCorner.Parent = WarningLabel
    local wStroke = Instance.new("UIStroke"); wStroke.Parent = WarningLabel; wStroke.Color = GothTheme.Accent; wStroke.Thickness = 1

    CreateToggle(PageHitbox, "Hitbox Expander", Settings.HitboxEnabled, function(s) Settings.HitboxEnabled = s end)
    CreateSlider(PageHitbox, "Hitbox Size", 0, 30, Settings.HitboxSize, function(v) Settings.HitboxSize = v end)

    -- SETTINGS
    CreateToggle(PageSettings, "UI Rainbow Mode 🌈", Settings.UI_Rainbow, function(s) Settings.UI_Rainbow = s end)
end)

if not uiSuccess then warn("Jayomovin.noob UI Error: " .. tostring(uiErr)) end

-- ===== RENDER LOOP (WITH RAINBOW UI) =====
RunService.RenderStepped:Connect(function()
    -- 1. RAINBOW UI LOGIC
    local rainbowColor = GothTheme.Accent -- Default Gothic Red
    if Settings.UI_Rainbow then
        local hue = (tick() * 0.2) % 1
        rainbowColor = Color3.fromHSV(hue, 1, 1)
        
        if TitleLabel then TitleLabel.TextColor3 = rainbowColor end
        if ToggleBtn then ToggleBtn.TextColor3 = rainbowColor; ToggleBtn.BorderColor3 = rainbowColor end
        for _, data in pairs(RainbowUI.Toggles) do
            if data.btn.Text == "ON" then data.btn.BackgroundColor3 = rainbowColor end
        end
        for _, fill in pairs(RainbowUI.Sliders) do fill.BackgroundColor3 = rainbowColor end
    else
        -- Reset to theme defaults when rainbow is off
        if TitleLabel then TitleLabel.TextColor3 = GothTheme.Accent end
        if ToggleBtn then ToggleBtn.TextColor3 = GothTheme.Accent; ToggleBtn.BorderColor3 = GothTheme.Accent end
        for _, data in pairs(RainbowUI.Toggles) do
            if data.btn.Text == "ON" then data.btn.BackgroundColor3 = GothTheme.ToggleOn end
        end
        for _, fill in pairs(RainbowUI.Sliders) do fill.BackgroundColor3 = GothTheme.Accent end
    end

    -- 2. FOV Circle
    if FOVCircle then
        FOVCircle.Position = GetFOVCenter()
        FOVCircle.Radius = Settings.FOVRadius
        FOVCircle.Visible = Settings.AimbotEnabled
        FOVCircle.Color = rainbowColor
    end

    -- 3. Aimbot Target
    AutoTarget = GetClosestEnemy()

    -- 4. ESP Loop
    for plr, cache in pairs(espCache) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if hrp and head and hum and hum.Health > 0 and plr ~= LocalPlayer then
            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
            
            if dist <= Settings.MaxESPDistance then
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen and headOnScreen then
                    if Settings.SkeletonESP then
                        local bones = char:FindFirstChild("UpperTorso") and r15Bones or r6Bones
                        for i, bone in ipairs(bones) do
                            local p1 = char:FindFirstChild(bone[1])
                            local p2 = char:FindFirstChild(bone[2])
                            if p1 and p2 and cache.Skeleton[i] then
                                local s1, on1 = Camera:WorldToViewportPoint(p1.Position)
                                local s2, on2 = Camera:WorldToViewportPoint(p2.Position)
                                if on1 and on2 then
                                    cache.Skeleton[i].From = Vector2.new(s1.X, s1.Y)
                                    cache.Skeleton[i].To = Vector2.new(s2.X, s2.Y)
                                    cache.Skeleton[i].Color = rainbowColor
                                    cache.Skeleton[i].Visible = true
                                else cache.Skeleton[i].Visible = false end
                            elseif cache.Skeleton[i] then cache.Skeleton[i].Visible = false end
                        end
                    else
                        for _, line in pairs(cache.Skeleton) do line.Visible = false end
                    end

                    if Settings.ESP_Box then
                        local height = math.abs(headPos.Y - screenPos.Y) + 15
                        local width = height / 1.5
                        local topLeft = Vector2.new(screenPos.X - (width / 2), headPos.Y - 10)
                        local topRight = Vector2.new(screenPos.X + (width / 2), headPos.Y - 10)
                        local bottomLeft = Vector2.new(screenPos.X - (width / 2), screenPos.Y + 5)
                        local bottomRight = Vector2.new(screenPos.X + (width / 2), screenPos.Y + 5)

                        cache.Box[1].From = topLeft; cache.Box[1].To = topRight
                        cache.Box[2].From = topRight; cache.Box[2].To = bottomRight
                        cache.Box[3].From = bottomRight; cache.Box[3].To = bottomLeft
                        cache.Box[4].From = bottomLeft; cache.Box[4].To = topLeft
                        for _, line in pairs(cache.Box) do line.Color = rainbowColor; line.Visible = true end
                    else
                        for _, line in pairs(cache.Box) do line.Visible = false end
                    end

                    if Settings.ESP_Health then
                        local healthPct = hum.Health / hum.MaxHealth
                        local barHeight = math.abs(headPos.Y - screenPos.Y) + 15
                        local startY = headPos.Y - 10
                        local endY = startY + barHeight
                        local barX = screenPos.X - (math.abs(headPos.Y - screenPos.Y) / 1.5 / 2) - 6
                        cache.HealthBg.From = Vector2.new(barX, startY); cache.HealthBg.To = Vector2.new(barX, endY); cache.HealthBg.Visible = true
                        local currentEndY = endY - (barHeight * healthPct)
                        cache.Health.From = Vector2.new(barX, endY); cache.Health.To = Vector2.new(barX, currentEndY); cache.Health.Visible = true
                        
                        if Settings.UI_Rainbow then
                            cache.Health.Color = rainbowColor
                        else
                            cache.Health.Color = Color3.fromRGB(255 * (1 - healthPct), 255 * healthPct, 0)
                        end
                    else
                        cache.HealthBg.Visible = false; cache.Health.Visible = false
                    end

                    if Settings.ESP_Tracker then
                        cache.Tracker.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        cache.Tracker.To = Vector2.new(screenPos.X, screenPos.Y)
                        cache.Tracker.Color = rainbowColor
                        cache.Tracker.Visible = true
                    else cache.Tracker.Visible = false end
                    
                    if Settings.ESP_Name then
                        cache.NameTxt.Text = plr.Name
                        cache.NameTxt.Position = Vector2.new(screenPos.X, headPos.Y - 30)
                        cache.NameTxt.Visible = true
                    else cache.NameTxt.Visible = false end
                    
                    if Settings.ESP_Distance then
                        cache.DistTxt.Text = math.floor(dist) .. "m"
                        cache.DistTxt.Position = Vector2.new(screenPos.X, screenPos.Y + 15)
                        cache.DistTxt.Visible = true
                    else cache.DistTxt.Visible = false end

                else
                    for _, line in pairs(cache.Skeleton) do line.Visible = false end
                    for _, line in pairs(cache.Box) do line.Visible = false end
                    cache.HealthBg.Visible = false; cache.Health.Visible = false; cache.Tracker.Visible = false
                    cache.NameTxt.Visible = false; cache.DistTxt.Visible = false
                end
            else
                for _, line in pairs(cache.Skeleton) do line.Visible = false end
                for _, line in pairs(cache.Box) do line.Visible = false end
                cache.HealthBg.Visible = false; cache.Health.Visible = false; cache.Tracker.Visible = false
                cache.NameTxt.Visible = false; cache.DistTxt.Visible = false
            end
        else
            for _, line in pairs(cache.Skeleton) do line.Visible = false end
            for _, line in pairs(cache.Box) do line.Visible = false end
            cache.HealthBg.Visible = false; cache.Health.Visible = false; cache.Tracker.Visible = false
            cache.NameTxt.Visible = false; cache.DistTxt.Visible = false
        end
    end

    -- 5. Advanced Velocity Bypass Movement
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hrp and hum then
        if Settings.SpeedEnabled and hum.MoveDirection.Magnitude > 0 then
            -- Bypass server position checks by injecting linear velocity into the physics assembly
            local targetVelocity = hum.MoveDirection * Settings.SpeedValue
            hrp.AssemblyLinearVelocity = Vector3.new(targetVelocity.X, hrp.AssemblyLinearVelocity.Y, targetVelocity.Z)
        end
        if Settings.SpinEnabled then hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(Settings.SpinSpeed), 0) end
    end
end)

-- ===== SEPARATE HITBOX LOOP =====
task.spawn(function()
    while task.wait(0.1) do
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hb = plr.Character:FindFirstChild("HeadHitbox")
                if hb then
                    if Settings.HitboxEnabled then
                        if not originalHitboxSizes[hb] then
                            originalHitboxSizes[hb] = hb.Size
                        end
                        
                        hb.Massless = true
                        hb.CanCollide = false
                        hb.CanTouch = false
                        
                        hb.Size = originalHitboxSizes[hb] * Settings.HitboxSize
                        hb.Transparency = 0.5
                    else
                        if originalHitboxSizes[hb] then
                            hb.Size = originalHitboxSizes[hb]
                            hb.Transparency = 1
                            hb.CanCollide = true
                            hb.CanTouch = true
                            hb.Massless = false
                            originalHitboxSizes[hb] = nil
                        end
                    end
                end
            end
        end
    end
end)