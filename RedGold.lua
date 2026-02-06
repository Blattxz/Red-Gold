--[[
    Red Gold Hub - Blox Fruits
    Script completo com todas as funcionalidades
    UI baseada no W Azure Hub
]]

-- Carregando a biblioteca de UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/V.G-Hub/main/im-lazy-so-i-just-use-my-own-ui-lib"))()

-- Criando a janela principal
local Window = Library:CreateWindow({
    Name = "Red Gold Hub | Blox Fruits",
    Themeable = {
        Info = "Red Gold Hub - Premium Script"
    }
})

-- Variáveis globais
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

-- Anti-AFK
Player.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Funções auxiliares
local function GetDistance(pos)
    return (Player.Character.HumanoidRootPart.Position - pos).Magnitude
end

local function Teleport(pos)
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = pos
    end
end

local function GetEnemies()
    local enemies = {}
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            table.insert(enemies, v)
        end
    end
    return enemies
end

local function GetQuest()
    local MyLevel = Player.Data.Level.Value
    
    -- Lista de quests por nível
    local QuestList = {
        {Level = 1, Name = "Bandit", QuestName = "BanditQuest1"},
        {Level = 10, Name = "Monkey", QuestName = "JungleQuest"},
        {Level = 15, Name = "Gorilla", QuestName = "JungleQuest"},
        {Level = 20, Name = "Pirate", QuestName = "BuggyQuest1"},
        {Level = 30, Name = "Brute", QuestName = "BuggyQuest1"},
        {Level = 40, Name = "Desert Bandit", QuestName = "DesertQuest"},
        {Level = 60, Name = "Desert Officer", QuestName = "DesertQuest"},
        {Level = 75, Name = "Snow Bandit", QuestName = "SnowQuest"},
        {Level = 90, Name = "Snowman", QuestName = "SnowQuest"},
        {Level = 100, Name = "Chief Petty Officer", QuestName = "MarineQuest2"},
        {Level = 120, Name = "Sky Bandit", QuestName = "SkyQuest"},
        {Level = 150, Name = "Dark Master", QuestName = "SkyQuest"},
        {Level = 175, Name = "Prisoner", QuestName = "PrisonerQuest"},
        {Level = 190, Name = "Dangerous Prisoner", QuestName = "PrisonerQuest"},
        {Level = 210, Name = "Toga Warrior", QuestName = "ColosseumQuest"},
        {Level = 225, Name = "Gladiator", QuestName = "ColosseumQuest"},
        {Level = 250, Name = "Military Soldier", QuestName = "MagmaQuest"},
        {Level = 275, Name = "Military Spy", QuestName = "MagmaQuest"},
        {Level = 300, Name = "Fishman Warrior", QuestName = "FishmanQuest"},
        {Level = 325, Name = "Fishman Commando", QuestName = "FishmanQuest"},
        {Level = 350, Name = "God's Guard", QuestName = "SkyExp1Quest"},
        {Level = 375, Name = "Shanda", QuestName = "SkyExp1Quest"},
        {Level = 400, Name = "Royal Squad", QuestName = "SkyExp2Quest"},
        {Level = 425, Name = "Royal Soldier", QuestName = "SkyExp2Quest"},
        {Level = 450, Name = "Galley Pirate", QuestName = "FountainQuest"},
        {Level = 475, Name = "Galley Captain", QuestName = "FountainQuest"},
    }
    
    local SelectedQuest = nil
    for _, quest in pairs(QuestList) do
        if MyLevel >= quest.Level then
            SelectedQuest = quest
        end
    end
    
    return SelectedQuest
end

-- Configurações
_G.Settings = {
    AutoFarm = false,
    AutoLevel = false,
    AutoBone = false,
    AutoKatakuriV1 = false,
    AutoKatakuriV2 = false,
    AutoSeaBeast = false,
    AutoRaid = false,
    SelectWeapon = "Combat",
    FastAttack = false,
    BringMobs = false,
    AutoHaki = false,
    AutoObservation = false,
}

-- ABA: MAIN/AUTO FARM
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998"
})

local AutoFarmSection = MainTab:CreateSection({
    Name = "Auto Farm"
})

AutoFarmSection:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoLevel = Value
        
        spawn(function()
            while _G.Settings.AutoLevel do
                pcall(function()
                    local Quest = GetQuest()
                    if Quest then
                        -- Pegar quest
                        local QuestGiver = game.Workspace.Map.Locations:FindFirstChild(Quest.QuestName)
                        if QuestGiver then
                            Teleport(QuestGiver.CFrame)
                            wait(0.5)
                            
                            local Remote = ReplicatedStorage.Remotes.CommF_
                            Remote:InvokeServer("StartQuest", Quest.QuestName, 1)
                        end
                        
                        wait(0.5)
                        
                        -- Farmar mobs
                        for _, enemy in pairs(GetEnemies()) do
                            if enemy.Name == Quest.Name then
                                repeat
                                    wait()
                                    if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                        Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        
                                        if _G.Settings.AutoHaki then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                        end
                                        
                                        -- Atacar
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    end
                                until not _G.Settings.AutoLevel or not enemy or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

AutoFarmSection:AddToggle({
    Name = "Auto Farm Bones",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoBone = Value
        
        spawn(function()
            while _G.Settings.AutoBone do
                pcall(function()
                    local BoneMobs = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                    
                    for _, enemy in pairs(GetEnemies()) do
                        for _, boneMob in pairs(BoneMobs) do
                            if enemy.Name == boneMob then
                                repeat
                                    wait()
                                    if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                        Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        
                                        if _G.Settings.AutoHaki then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                        end
                                        
                                        game:GetService("VirtualUser"):CaptureController()
                                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                    end
                                until not _G.Settings.AutoBone or not enemy or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

AutoFarmSection:AddToggle({
    Name = "Auto Farm Katakuri V1",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoKatakuriV1 = Value
        
        spawn(function()
            while _G.Settings.AutoKatakuriV1 do
                pcall(function()
                    -- Teleportar para Katakuri
                    if game.Workspace.Enemies:FindFirstChild("Cake Prince") then
                        local katakuri = game.Workspace.Enemies:FindFirstChild("Cake Prince")
                        
                        repeat
                            wait()
                            if katakuri and katakuri:FindFirstChild("HumanoidRootPart") and katakuri.Humanoid.Health > 0 then
                                Teleport(katakuri.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                                if _G.Settings.AutoHaki then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                end
                                
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            end
                        until not _G.Settings.AutoKatakuriV1 or not katakuri or katakuri.Humanoid.Health <= 0
                    else
                        -- Spawnar Katakuri
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    end
                end)
                wait()
            end
        end)
    end    
})

AutoFarmSection:AddToggle({
    Name = "Auto Farm Katakuri V2",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoKatakuriV2 = Value
        
        spawn(function()
            while _G.Settings.AutoKatakuriV2 do
                pcall(function()
                    if game.Workspace.Enemies:FindFirstChild("Dough King") then
                        local doughKing = game.Workspace.Enemies:FindFirstChild("Dough King")
                        
                        repeat
                            wait()
                            if doughKing and doughKing:FindFirstChild("HumanoidRootPart") and doughKing.Humanoid.Health > 0 then
                                Teleport(doughKing.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                                if _G.Settings.AutoHaki then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                end
                                
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            end
                        until not _G.Settings.AutoKatakuriV2 or not doughKing or doughKing.Humanoid.Health <= 0
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                    end
                end)
                wait()
            end
        end)
    end    
})

AutoFarmSection:AddToggle({
    Name = "Auto Farm Sea Beast",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoSeaBeast = Value
        
        spawn(function()
            while _G.Settings.AutoSeaBeast do
                pcall(function()
                    for _, seaBeast in pairs(game.Workspace.SeaBeasts:GetChildren()) do
                        if seaBeast:FindFirstChild("HumanoidRootPart") and seaBeast.Humanoid.Health > 0 then
                            repeat
                                wait()
                                Teleport(seaBeast.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))
                                
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until not _G.Settings.AutoSeaBeast or seaBeast.Humanoid.Health <= 0
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

-- Configurações de Combat
local CombatSection = MainTab:CreateSection({
    Name = "Combat Settings"
})

CombatSection:AddToggle({
    Name = "Auto Haki",
    Default = false,
    Callback = function(Value)
        _G.Settings.AutoHaki = Value
    end    
})

CombatSection:AddToggle({
    Name = "Fast Attack",
    Default = false,
    Callback = function(Value)
        _G.Settings.FastAttack = Value
        
        spawn(function()
            local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
            Camera:Stop()
            
            while _G.Settings.FastAttack do
                pcall(function()
                    repeat wait()
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 300 then
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                end
                            end
                        end
                    until not _G.Settings.FastAttack
                end)
            end
        end)
    end    
})

CombatSection:AddToggle({
    Name = "Bring Mobs",
    Default = false,
    Callback = function(Value)
        _G.Settings.BringMobs = Value
        
        spawn(function()
            while _G.Settings.BringMobs do
                pcall(function()
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 300 then
                                v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -10)
                                v.HumanoidRootPart.CanCollide = false
                                v.Head.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.Humanoid.JumpPower = 0
                                if v.Humanoid:FindFirstChild("Animator") then
                                    v.Humanoid.Animator:Destroy()
                                end
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            end
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

-- ABA: QUESTS
local QuestTab = Window:CreateTab({
    Name = "Quests",
    Icon = "rbxassetid://4483345998"
})

local QuestSection = QuestTab:CreateSection({
    Name = "Quest Automation"
})

QuestSection:AddToggle({
    Name = "Auto Accept Quest",
    Default = false,
    Callback = function(Value)
        _G.AutoQuest = Value
        
        spawn(function()
            while _G.AutoQuest do
                pcall(function()
                    local Quest = GetQuest()
                    if Quest then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", Quest.QuestName, 1)
                    end
                end)
                wait(1)
            end
        end)
    end    
})

QuestSection:AddButton({
    Name = "Complete Current Quest",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
        wait(0.5)
        local Quest = GetQuest()
        if Quest then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", Quest.QuestName, 1)
        end
    end    
})

-- ABA: ESP
local ESPTab = Window:CreateTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998"
})

local ESPSection = ESPTab:CreateSection({
    Name = "ESP Options"
})

_G.ESPSettings = {
    Player = false,
    Fruit = false,
    Chest = false,
    Flower = false,
    NPC = false
}

ESPSection:AddToggle({
    Name = "ESP Players",
    Default = false,
    Callback = function(Value)
        _G.ESPSettings.Player = Value
        
        spawn(function()
            while _G.ESPSettings.Player do
                pcall(function()
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "PlayerESP"
                                billboard.Parent = player.Character.HumanoidRootPart
                                billboard.Size = UDim2.new(0, 100, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 3, 0)
                                billboard.AlwaysOnTop = true
                                
                                local textLabel = Instance.new("TextLabel")
                                textLabel.Parent = billboard
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.BackgroundTransparency = 1
                                textLabel.Text = player.Name
                                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                                textLabel.TextStrokeTransparency = 0
                            end
                        end
                    end
                end)
                wait(1)
            end
            
            -- Remover ESP quando desativado
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local esp = player.Character.HumanoidRootPart:FindFirstChild("PlayerESP")
                    if esp then esp:Destroy() end
                end
            end
        end)
    end    
})

ESPSection:AddToggle({
    Name = "ESP Fruits",
    Default = false,
    Callback = function(Value)
        _G.ESPSettings.Fruit = Value
        
        spawn(function()
            while _G.ESPSettings.Fruit do
                pcall(function()
                    for _, fruit in pairs(game.Workspace:GetChildren()) do
                        if string.find(fruit.Name, "Fruit") and fruit:FindFirstChild("Handle") then
                            if not fruit.Handle:FindFirstChild("FruitESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "FruitESP"
                                billboard.Parent = fruit.Handle
                                billboard.Size = UDim2.new(0, 100, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 3, 0)
                                billboard.AlwaysOnTop = true
                                
                                local textLabel = Instance.new("TextLabel")
                                textLabel.Parent = billboard
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.BackgroundTransparency = 1
                                textLabel.Text = fruit.Name
                                textLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
                                textLabel.TextStrokeTransparency = 0
                            end
                        end
                    end
                end)
                wait(1)
            end
        end)
    end    
})

ESPSection:AddToggle({
    Name = "ESP Chests",
    Default = false,
    Callback = function(Value)
        _G.ESPSettings.Chest = Value
        
        spawn(function()
            while _G.ESPSettings.Chest do
                pcall(function()
                    for _, chest in pairs(game.Workspace:GetChildren()) do
                        if chest.Name == "Chest" or chest.Name == "Chest1" or chest.Name == "Chest2" then
                            if not chest:FindFirstChild("ChestESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "ChestESP"
                                billboard.Parent = chest
                                billboard.Size = UDim2.new(0, 100, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 3, 0)
                                billboard.AlwaysOnTop = true
                                
                                local textLabel = Instance.new("TextLabel")
                                textLabel.Parent = billboard
                                textLabel.Size = UDim2.new(1, 0, 1, 0)
                                textLabel.BackgroundTransparency = 1
                                textLabel.Text = "Chest"
                                textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                                textLabel.TextStrokeTransparency = 0
                            end
                        end
                    end
                end)
                wait(1)
            end
        end)
    end    
})

-- ABA: FRUITS
local FruitTab = Window:CreateTab({
    Name = "Fruits",
    Icon = "rbxassetid://4483345998"
})

local FruitSection = FruitTab:CreateSection({
    Name = "Devil Fruit Options"
})

FruitSection:AddToggle({
    Name = "Auto Store Fruits",
    Default = false,
    Callback = function(Value)
        _G.AutoStoreFruit = Value
        
        spawn(function()
            while _G.AutoStoreFruit do
                pcall(function()
                    for _, fruit in pairs(Player.Backpack:GetChildren()) do
                        if string.find(fruit.Name, "Fruit") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", fruit.Name)
                        end
                    end
                end)
                wait(1)
            end
        end)
    end    
})

FruitSection:AddToggle({
    Name = "Auto Collect Fruits",
    Default = false,
    Callback = function(Value)
        _G.AutoCollectFruit = Value
        
        spawn(function()
            while _G.AutoCollectFruit do
                pcall(function()
                    for _, fruit in pairs(game.Workspace:GetChildren()) do
                        if string.find(fruit.Name, "Fruit") and fruit:FindFirstChild("Handle") then
                            Teleport(fruit.Handle.CFrame)
                            wait(0.3)
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

FruitSection:AddButton({
    Name = "Random Fruit",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
    end    
})

-- ABA: RAID
local RaidTab = Window:CreateTab({
    Name = "Raid",
    Icon = "rbxassetid://4483345998"
})

local RaidSection = RaidTab:CreateSection({
    Name = "Raid Options"
})

RaidSection:AddToggle({
    Name = "Auto Start Raid",
    Default = false,
    Callback = function(Value)
        _G.AutoStartRaid = Value
        
        spawn(function()
            while _G.AutoStartRaid do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", "Flame")
                    wait(1)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Buy")
                end)
                wait(120)
            end
        end)
    end    
})

RaidSection:AddToggle({
    Name = "Auto Farm Raid",
    Default = false,
    Callback = function(Value)
        _G.AutoRaid = Value
        
        spawn(function()
            while _G.AutoRaid do
                pcall(function()
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible then
                        for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                            if enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    
                                    if _G.Settings.AutoHaki then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                    end
                                    
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                until not _G.AutoRaid or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

RaidSection:AddButton({
    Name = "Teleport to Raid",
    Callback = function()
        pcall(function()
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible then
                local island = game.Workspace.Map.Boat:FindFirstChild("SafeZone")
                if island then
                    Teleport(island.CFrame)
                end
            end
        end)
    end    
})

-- ABA: MISC
local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998"
})

local TeleportSection = MiscTab:CreateSection({
    Name = "Teleport"
})

local Islands = {
    "Starter Island",
    "Jungle",
    "Pirate Village",
    "Desert",
    "Frozen Village",
    "Marine Fortress",
    "Skylands",
    "Prison",
    "Colosseum",
    "Magma Village",
    "Underwater City",
    "Upper Skylands",
    "Fountain City",
}

TeleportSection:AddDropdown({
    Name = "Select Island",
    Default = "Starter Island",
    Options = Islands,
    Callback = function(Value)
        pcall(function()
            local island = game.Workspace.Map.Locations:FindFirstChild(Value)
            if island then
                Teleport(island.CFrame)
            end
        end)
    end    
})

local SettingsSection = MiscTab:CreateSection({
    Name = "Settings"
})

SettingsSection:AddToggle({
    Name = "Walk on Water",
    Default = false,
    Callback = function(Value)
        _G.WalkOnWater = Value
        
        spawn(function()
            while _G.WalkOnWater do
                pcall(function()
                    game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
                end)
                wait(1)
            end
            
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
        end)
    end    
})

SettingsSection:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(Value)
        _G.NoClip = Value
        
        spawn(function()
            game:GetService("RunService").Stepped:Connect(function()
                if _G.NoClip then
                    for _, v in pairs(Player.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end)
    end    
})

SettingsSection:AddToggle({
    Name = "Infinite Energy",
    Default = false,
    Callback = function(Value)
        _G.InfEnergy = Value
        
        spawn(function()
            while _G.InfEnergy do
                wait()
                pcall(function()
                    Player.Character.Energy.Value = Player.Character.Energy.MaxValue
                end)
            end
        end)
    end    
})

SettingsSection:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 400,
    Default = 16,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    Callback = function(Value)
        Player.Character.Humanoid.WalkSpeed = Value
    end    
})

SettingsSection:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 400,
    Default = 50,
    Color = Color3.fromRGB(255, 0, 0),
    Increment = 1,
    Callback = function(Value)
        Player.Character.Humanoid.JumpPower = Value
    end    
})

-- ABA: STATS
local StatsTab = Window:CreateTab({
    Name = "Stats",
    Icon = "rbxassetid://4483345998"
})

local StatsSection = StatsTab:CreateSection({
    Name = "Auto Stats"
})

_G.AutoStats = {
    Melee = false,
    Defense = false,
    Sword = false,
    Gun = false,
    Fruit = false
}

StatsSection:AddToggle({
    Name = "Auto Melee",
    Default = false,
    Callback = function(Value)
        _G.AutoStats.Melee = Value
        
        spawn(function()
            while _G.AutoStats.Melee do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
                end)
                wait(0.1)
            end
        end)
    end    
})

StatsSection:AddToggle({
    Name = "Auto Defense",
    Default = false,
    Callback = function(Value)
        _G.AutoStats.Defense = Value
        
        spawn(function()
            while _G.AutoStats.Defense do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
                end)
                wait(0.1)
            end
        end)
    end    
})

StatsSection:AddToggle({
    Name = "Auto Sword",
    Default = false,
    Callback = function(Value)
        _G.AutoStats.Sword = Value
        
        spawn(function()
            while _G.AutoStats.Sword do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1)
                end)
                wait(0.1)
            end
        end)
    end    
})

StatsSection:AddToggle({
    Name = "Auto Gun",
    Default = false,
    Callback = function(Value)
        _G.AutoStats.Gun = Value
        
        spawn(function()
            while _G.AutoStats.Gun do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", 1)
                end)
                wait(0.1)
            end
        end)
    end    
})

StatsSection:AddToggle({
    Name = "Auto Fruit",
    Default = false,
    Callback = function(Value)
        _G.AutoStats.Fruit = Value
        
        spawn(function()
            while _G.AutoStats.Fruit do
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1)
                end)
                wait(0.1)
            end
        end)
    end    
})

-- ABA: BOSSES
local BossTab = Window:CreateTab({
    Name = "Bosses",
    Icon = "rbxassetid://4483345998"
})

local BossSection = BossTab:CreateSection({
    Name = "Boss Farming"
})

local BossList = {
    "The Gorilla King",
    "Bobby",
    "Yeti",
    "Mob Leader",
    "Vice Admiral",
    "Warden",
    "Chief Warden",
    "Swan",
    "Magma Admiral",
    "Fishman Lord",
    "Wysper",
    "Thunder God",
    "Cyborg",
    "Saber Expert",
}

BossSection:AddDropdown({
    Name = "Select Boss",
    Default = "The Gorilla King",
    Options = BossList,
    Callback = function(Value)
        _G.SelectedBoss = Value
    end    
})

BossSection:AddToggle({
    Name = "Auto Farm Selected Boss",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmBoss = Value
        
        spawn(function()
            while _G.AutoFarmBoss do
                pcall(function()
                    if game.Workspace.Enemies:FindFirstChild(_G.SelectedBoss) then
                        local boss = game.Workspace.Enemies:FindFirstChild(_G.SelectedBoss)
                        
                        repeat
                            wait()
                            if boss and boss:FindFirstChild("HumanoidRootPart") and boss.Humanoid.Health > 0 then
                                Teleport(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                                if _G.Settings.AutoHaki then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                                end
                                
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            end
                        until not _G.AutoFarmBoss or not boss or boss.Humanoid.Health <= 0
                    end
                end)
                wait()
            end
        end)
    end    
})

-- ABA: MASTERY
local MasteryTab = Window:CreateTab({
    Name = "Mastery",
    Icon = "rbxassetid://4483345998"
})

local MasterySection = MasteryTab:CreateSection({
    Name = "Auto Mastery"
})

MasterySection:AddToggle({
    Name = "Auto Farm Mastery",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmMastery = Value
        
        spawn(function()
            while _G.AutoFarmMastery do
                pcall(function()
                    local Quest = GetQuest()
                    if Quest then
                        for _, enemy in pairs(GetEnemies()) do
                            if enemy.Name == Quest.Name then
                                repeat
                                    wait()
                                    if enemy and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                        Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                        
                                        -- Usar habilidades da fruta
                                        for _, skill in pairs(Player.Character:GetChildren()) do
                                            if skill:IsA("Tool") and skill:FindFirstChild("Level") then
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                            end
                                        end
                                    end
                                until not _G.AutoFarmMastery or not enemy or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
                wait()
            end
        end)
    end    
})

-- ABA: SHOP
local ShopTab = Window:CreateTab({
    Name = "Shop",
    Icon = "rbxassetid://4483345998"
})

local ShopSection = ShopTab:CreateSection({
    Name = "Buy Items"
})

ShopSection:AddButton({
    Name = "Buy Bisento",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
    end    
})

ShopSection:AddButton({
    Name = "Buy Saber",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Saber")
    end    
})

ShopSection:AddButton({
    Name = "Buy Black Cape",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
    end    
})

-- ABA: CREDITS
local CreditsTab = Window:CreateTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998"
})

local CreditsSection = CreditsTab:CreateSection({
    Name = "Script Info"
})

CreditsSection:AddLabel({
    Text = "Red Gold Hub v1.0"
})

CreditsSection:AddLabel({
    Text = "Created for Blox Fruits"
})

CreditsSection:AddLabel({
    Text = "UI: W Azure Style"
})

CreditsSection:AddButton({
    Name = "Join Discord",
    Callback = function()
        setclipboard("discord.gg/redgoldhub")
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Red Gold Hub";
            Text = "Discord link copied!";
            Duration = 5;
        })
    end    
})

-- Notificação de carregamento
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Red Gold Hub";
    Text = "Script loaded successfully!";
    Duration = 5;
})

print("Red Gold Hub - Loaded Successfully!")
