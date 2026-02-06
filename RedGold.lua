local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = redzlib:MakeWindow({
    Title = "Red Gold Hub : Blox Fruits",
    SubTitle = "by Red Gold Team",
    SaveFolder = "RedGoldHub_BloxFruits.lua"
})

-- ════════════════════════════════════════════════════════════════
-- VARIABLES & CONFIGURATIONS
-- ════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Anti AFK
LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Config Variables
_G.AutoFarm = false
_G.AutoFarmBone = false
_G.AutoKatakuriV1 = false
_G.AutoKatakuriV2 = false
_G.AutoRaid = false
_G.SelectWeapon = "Combat"
_G.FastAttack = false
_G.AutoHaki = false
_G.AutoBuso = false
_G.BringMob = false

-- ════════════════════════════════════════════════════════════════
-- TABS CREATION
-- ════════════════════════════════════════════════════════════════

local TabMain = Window:MakeTab({"Main", "home"})
local TabAutoFarm = Window:MakeTab({"Auto Farm", "sword"})
local TabBoss = Window:MakeTab({"Boss Farm", "skull"})
local TabMastery = Window:MakeTab({"Mastery", "zap"})
local TabCombat = Window:MakeTab({"Combat", "shield"})
local TabStats = Window:MakeTab({"Stats", "activity"})
local TabPlayer = Window:MakeTab({"Player", "user"})
local TabTeleport = Window:MakeTab({"Teleport", "map-pin"})
local TabDungeon = Window:MakeTab({"Dungeon/Raid", "home"})
local TabShop = Window:MakeTab({"Shop", "shopping-cart"})
local TabFruit = Window:MakeTab({"Devil Fruit", "cherry"})
local TabESP = Window:MakeTab({"ESP/Visuals", "eye"})
local TabMisc = Window:MakeTab({"Misc", "settings"})
local TabCredits = Window:MakeTab({"Credits", "info"})

-- ════════════════════════════════════════════════════════════════
-- FUNCTIONS
-- ════════════════════════════════════════════════════════════════

function EquipWeapon(ToolSe)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(0.5)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

function AutoHaki()
    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function BringMobFunction(Name, CFrameMon)
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == Name and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if (v.HumanoidRootPart.Position - CFrameMon.Position).Magnitude <= 350 then
                v.HumanoidRootPart.CFrame = CFrameMon
                v.HumanoidRootPart.CanCollide = false
                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                if v.Humanoid:FindFirstChild("Animator") then
                    v.Humanoid.Animator:Destroy()
                end
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
        end
    end
end

function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

function GetQuestTitle()
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    if game:GetService("Workspace").Map:FindFirstChild("Jungle") then
        -- First Sea
        if MyLevel == 1 or MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
        elseif MyLevel == 10 or MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
        elseif MyLevel == 15 or MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
        elseif MyLevel == 30 or MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
        elseif MyLevel == 40 or MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
        elseif MyLevel == 60 or MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
        elseif MyLevel == 75 or MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
        elseif MyLevel == 90 or MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
        elseif MyLevel == 100 or MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
        elseif MyLevel == 120 or MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
        elseif MyLevel == 150 or MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
        elseif MyLevel == 175 or MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
        elseif MyLevel == 190 or MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
        elseif MyLevel == 210 or MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
        elseif MyLevel == 250 or MyLevel <= 274 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
        elseif MyLevel == 275 or MyLevel <= 299 then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
        elseif MyLevel == 300 or MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
        elseif MyLevel == 325 or MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
        end
    elseif game:GetService("Workspace").Map:FindFirstChild("New World") then
        -- Second Sea
        if MyLevel == 700 or MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
        elseif MyLevel == 725 or MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188)
        elseif MyLevel == 775 or MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
        elseif MyLevel == 800 or MyLevel <= 874 then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898)
        elseif MyLevel == 875 or MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
        elseif MyLevel == 900 or MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
        elseif MyLevel == 950 or MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
        elseif MyLevel == 975 or MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061)
        elseif MyLevel == 1000 or MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
        elseif MyLevel == 1050 or MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928)
        elseif MyLevel == 1100 or MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
        elseif MyLevel == 1125 or MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
        elseif MyLevel == 1175 or MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5428.03174, 15.0819492, -5299.43457)
        elseif MyLevel == 1200 or MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5428.03174, 15.0819492, -5299.43457)
        elseif MyLevel == 1250 or MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
        elseif MyLevel == 1275 or MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
        elseif MyLevel == 1300 or MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
        elseif MyLevel == 1325 or MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
        elseif MyLevel == 1350 or MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
        elseif MyLevel == 1375 or MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984)
        elseif MyLevel == 1425 or MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193)
        end
    elseif game:GetService("Workspace").Map:FindFirstChild("Boat Castle") then
        -- Third Sea
        if MyLevel == 1500 or MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
        elseif MyLevel == 1525 or MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
        elseif MyLevel == 1575 or MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "AmazonQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
        elseif MyLevel == 1600 or MyLevel <= 1624 then
            Mon = "Dragon Crew Archer"
            NameQuest = "AmazonQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
        elseif MyLevel == 1625 or MyLevel <= 1649 then
            Mon = "Female Islander"
            NameQuest = "AmazonQuest2"
            LevelQuest = 1
            NameMon = "Female Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
        elseif MyLevel == 1650 or MyLevel <= 1699 then
            Mon = "Giant Islander"
            NameQuest = "AmazonQuest2"
            LevelQuest = 2
            NameMon = "Giant Islander"
            CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
        elseif MyLevel == 1700 or MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
        elseif MyLevel == 1725 or MyLevel <= 1774 then
            Mon = "Marine Rear Admiral"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
        elseif MyLevel == 1775 or MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
        elseif MyLevel == 1800 or MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
        elseif MyLevel == 1825 or MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
        elseif MyLevel == 1850 or MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
        elseif MyLevel == 1900 or MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
        elseif MyLevel == 1925 or MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
        elseif MyLevel == 1975 or MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
        elseif MyLevel == 2000 or MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277)
        elseif MyLevel == 2025 or MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
        elseif MyLevel == 2050 or MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533)
        elseif MyLevel == 2075 or MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
        elseif MyLevel == 2100 or MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875)
        elseif MyLevel == 2125 or MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
        elseif MyLevel == 2150 or MyLevel <= 2199 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438)
        elseif MyLevel == 2200 or MyLevel <= 2224 then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
        elseif MyLevel == 2225 or MyLevel <= 2249 then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295)
        elseif MyLevel == 2250 or MyLevel <= 2274 then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
        elseif MyLevel == 2275 or MyLevel <= 2299 then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391)
        elseif MyLevel == 2300 or MyLevel <= 2324 then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303711, 29.876001358032, -12201.2333984375)
        elseif MyLevel == 2325 or MyLevel <= 2349 then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303711, 29.876001358032, -12201.2333984375)
        elseif MyLevel == 2350 or MyLevel <= 2374 then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732, 30.693693161011, -12774.5078125)
        elseif MyLevel == 2375 or MyLevel <= 2399 then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732, 30.693693161011, -12774.5078125)
        elseif MyLevel == 2400 or MyLevel <= 2424 then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229, -14446.3349609375)
        elseif MyLevel == 2425 or MyLevel <= 2449 then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229, -14446.3349609375)
        elseif MyLevel >= 2450 then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16545.9355, 55.6863556, -173.230499)
        end
    end
end

-- ════════════════════════════════════════════════════════════════
-- MAIN TAB
-- ════════════════════════════════════════════════════════════════

TabMain:AddParagraph({"Welcome!", "Welcome to Red Gold Hub for Blox Fruits!\nEnjoy the best features!"})

local MainSection = TabMain:AddSection({"Main Information"})

TabMain:AddButton({"Check Your Level", function()
    local Dialog = Window:Dialog({
        Title = "Player Info",
        Text = "Your Level: " .. tostring(LocalPlayer.Data.Level.Value) .. "\nBeli: " .. tostring(LocalPlayer.Data.Beli.Value) .. "\nFragments: " .. tostring(LocalPlayer.Data.Fragments.Value),
        Options = {
            {"OK", function() end}
        }
    })
end})

-- ════════════════════════════════════════════════════════════════
-- AUTO FARM TAB
-- ════════════════════════════════════════════════════════════════

TabAutoFarm:AddSection({"Auto Farm Settings"})

local WeaponList = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
    table.insert(WeaponList,v.Name)
end

TabAutoFarm:AddDropdown({
    Name = "Select Weapon",
    Options = WeaponList,
    Default = "Combat",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

TabAutoFarm:AddToggle({
    Name = "Auto Farm Level",
    Description = "Automatically farm levels based on your current level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        StopTween(_G.AutoFarm)
    end
})

spawn(function()
    while wait() do
        if _G.AutoFarm then
            pcall(function()
                GetQuestTitle()
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    repeat wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                    until game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true or not _G.AutoFarm
                end
                if game:GetService("Workspace").Enemies:FindFirstChild(Mon) then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == Mon and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                Click()
                            until not _G.AutoFarm or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(CFrameQuest)
                end
            end)
        end
    end
end)

TabAutoFarm:AddToggle({
    Name = "Auto Farm Bone",
    Description = "Automatically farm bones",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmBone = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoFarmBone then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    Click()
                                until not _G.AutoFarmBone or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    topos(CFrame.new(-9516.99316, 172.017181, 6078.46533))
                end
            end)
        end
    end
end)

TabAutoFarm:AddToggle({
    Name = "Auto Katakuri V1",
    Description = "Auto farm Katakuri V1 Boss",
    Default = false,
    Callback = function(Value)
        _G.AutoKatakuriV1 = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoKatakuriV1 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Cake Prince" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    Click()
                                until not _G.AutoKatakuriV1 or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    topos(CFrame.new(-2077.35596, 252.852798, -12373.9199))
                end
            end)
        end
    end
end)

TabAutoFarm:AddToggle({
    Name = "Auto Katakuri V2",
    Description = "Auto farm Katakuri V2 Boss (Dough King)",
    Default = false,
    Callback = function(Value)
        _G.AutoKatakuriV2 = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoKatakuriV2 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Dough King" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    Click()
                                until not _G.AutoKatakuriV2 or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    topos(CFrame.new(-2151.82153, 149.315704, -12404.9053))
                end
            end)
        end
    end
end)

TabAutoFarm:AddToggle({
    Name = "Fast Attack",
    Description = "Enable fast attack speed",
    Default = false,
    Callback = function(Value)
        _G.FastAttack = Value
    end
})

TabAutoFarm:AddToggle({
    Name = "Bring Mobs",
    Description = "Bring mobs to you",
    Default = false,
    Callback = function(Value)
        _G.BringMob = Value
    end
})

-- ════════════════════════════════════════════════════════════════
-- BOSS FARM TAB
-- ════════════════════════════════════════════════════════════════

TabBoss:AddSection({"Boss Farm Options"})

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
    "Cake Prince",
    "Dough King",
    "Longma"
}

_G.SelectBoss = ""

TabBoss:AddDropdown({
    Name = "Select Boss",
    Options = BossList,
    Default = "The Gorilla King",
    Callback = function(Value)
        _G.SelectBoss = Value
    end
})

TabBoss:AddToggle({
    Name = "Auto Farm Selected Boss",
    Description = "Farm the selected boss automatically",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmBoss = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoFarmBoss then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == _G.SelectBoss then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    AutoHaki()
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    Click()
                                until not _G.AutoFarmBoss or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════════════
-- MASTERY TAB
-- ════════════════════════════════════════════════════════════════

TabMastery:AddSection({"Mastery Farm"})

TabMastery:AddToggle({
    Name = "Auto Farm Gun Mastery",
    Description = "Farm gun mastery automatically",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmGunMastery = Value
    end
})

TabMastery:AddToggle({
    Name = "Auto Farm Fruit Mastery",
    Description = "Farm devil fruit mastery",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmFruitMastery = Value
    end
})

TabMastery:AddToggle({
    Name = "Auto Farm Melee Mastery",
    Description = "Farm melee mastery automatically",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmMeleeMastery = Value
    end
})

-- ════════════════════════════════════════════════════════════════
-- COMBAT TAB
-- ════════════════════════════════════════════════════════════════

TabCombat:AddSection({"Combat Settings"})

TabCombat:AddToggle({
    Name = "Auto Haki",
    Description = "Automatically enable Haki",
    Default = false,
    Callback = function(Value)
        _G.AutoHaki = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoHaki then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

TabCombat:AddToggle({
    Name = "Auto Observation Haki",
    Description = "Auto use Observation Haki",
    Default = false,
    Callback = function(Value)
        _G.AutoObservation = Value
    end
})

TabCombat:AddButton({"Redeem All Codes", function()
    local Codes = {
        "Sub2CaptainMaui",
        "Sub2OfficialNoobie",
        "Sub2NoobMaster123",
        "Sub2Daigrock",
        "Axiore",
        "TantaiGaming",
        "StrawHatMaine",
        "Sub2UncleKizaru"
    }
    for i,v in pairs(Codes) do
        game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
    end
    local Dialog = Window:Dialog({
        Title = "Codes Redeemed",
        Text = "All codes have been redeemed!",
        Options = {{"OK", function() end}}
    })
end})

-- ════════════════════════════════════════════════════════════════
-- STATS TAB
-- ════════════════════════════════════════════════════════════════

TabStats:AddSection({"Auto Stats"})

_G.PointMelee = 0
_G.PointDefense = 0
_G.PointSword = 0
_G.PointGun = 0
_G.PointFruit = 0

TabStats:AddSlider({
    Name = "Melee Points",
    Min = 0,
    Max = 100,
    Increase = 1,
    Default = 0,
    Callback = function(Value)
        _G.PointMelee = Value
    end
})

TabStats:AddSlider({
    Name = "Defense Points",
    Min = 0,
    Max = 100,
    Increase = 1,
    Default = 0,
    Callback = function(Value)
        _G.PointDefense = Value
    end
})

TabStats:AddSlider({
    Name = "Sword Points",
    Min = 0,
    Max = 100,
    Increase = 1,
    Default = 0,
    Callback = function(Value)
        _G.PointSword = Value
    end
})

TabStats:AddSlider({
    Name = "Gun Points",
    Min = 0,
    Max = 100,
    Increase = 1,
    Default = 0,
    Callback = function(Value)
        _G.PointGun = Value
    end
})

TabStats:AddSlider({
    Name = "Fruit Points",
    Min = 0,
    Max = 100,
    Increase = 1,
    Default = 0,
    Callback = function(Value)
        _G.PointFruit = Value
    end
})

TabStats:AddToggle({
    Name = "Auto Stats",
    Description = "Automatically add stats based on sliders",
    Default = false,
    Callback = function(Value)
        _G.AutoStats = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoStats then
            pcall(function()
                if _G.PointMelee > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", _G.PointMelee)
                end
                if _G.PointDefense > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", _G.PointDefense)
                end
                if _G.PointSword > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", _G.PointSword)
                end
                if _G.PointGun > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", _G.PointGun)
                end
                if _G.PointFruit > 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", _G.PointFruit)
                end
            end)
        end
    end
end)

-- ════════════════════════════════════════════════════════════════
-- PLAYER TAB
-- ════════════════════════════════════════════════════════════════

TabPlayer:AddSection({"Player Modifications"})

TabPlayer:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 400,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

TabPlayer:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 400,
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

TabPlayer:AddToggle({
    Name = "Infinite Energy",
    Description = "Never run out of energy",
    Default = false,
    Callback = function(Value)
        _G.InfiniteEnergy = Value
        while _G.InfiniteEnergy do
            wait()
            game:GetService("Players").LocalPlayer.Character.Energy.Value = game:GetService("Players").LocalPlayer.Character.Energy.MaxValue
        end
    end
})

TabPlayer:AddToggle({
    Name = "Auto Rejoin",
    Description = "Auto rejoin when kicked",
    Default = false,
    Callback = function(Value)
        _G.AutoRejoin = Value
    end
})

-- ════════════════════════════════════════════════════════════════
-- DUNGEON/RAID TAB
-- ════════════════════════════════════════════════════════════════

TabDungeon:AddSection({"Raid Options"})

local RaidsList = {
    "Flame",
    "Ice",
    "Quake",
    "Light",
    "Dark",
    "Spider",
    "Rumble",
    "Magma",
    "Buddha",
    "Sand",
    "Phoenix",
    "Dough"
}

_G.SelectRaid = ""

TabDungeon:AddDropdown({
    Name = "Select Raid",
    Options = RaidsList,
    Default = "Flame",
    Callback = function(Value)
        _G.SelectRaid = Value
    end
})

TabDungeon:AddToggle({
    Name = "Auto Start Raid",
    Description = "Automatically start selected raid",
    Default = false,
    Callback = function(Value)
        _G.AutoStartRaid = Value
    end
})

TabDungeon:AddToggle({
    Name = "Auto Farm Raid",
    Description = "Auto farm in raids",
    Default = false,
    Callback = function(Value)
        _G.AutoRaid = Value
    end
})

TabDungeon:AddToggle({
    Name = "Auto Awaken Fruit",
    Description = "Automatically awaken your fruit",
    Default = false,
    Callback = function(Value)
        _G.AutoAwaken = Value
    end
})

-- ════════════════════════════════════════════════════════════════
-- FRUIT TAB
-- ════════════════════════════════════════════════════════════════

TabFruit:AddSection({"Devil Fruit Options"})

TabFruit:AddToggle({
    Name = "Auto Random Fruit",
    Description = "Auto buy random fruits",
    Default = false,
    Callback = function(Value)
        _G.AutoRandomFruit = Value
    end
})

spawn(function()
    while wait() do
        if _G.AutoRandomFruit then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
        end
    end
end)

TabFruit:AddToggle({
    Name = "Auto Store Fruit",
    Description = "Auto store fruits in inventory",
    Default = false,
    Callback = function(Value)
        _G.AutoStoreFruit = Value
    end
})

TabFruit:AddButton({"Teleport to Fruit Dealer", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2084.37939, 72.9875946, -12373.3223)
end})

-- ════════════════════════════════════════════════════════════════
-- ESP TAB
-- ════════════════════════════════════════════════════════════════

TabESP:AddSection({"ESP Options"})

TabESP:AddToggle({
    Name = "ESP Players",
    Description = "See players through walls",
    Default = false,
    Callback = function(Value)
        _G.ESPPlayers = Value
    end
})

TabESP:AddToggle({
    Name = "ESP Fruits",
    Description = "See fruits spawned on map",
    Default = false,
    Callback = function(Value)
        _G.ESPFruits = Value
    end
})

TabESP:AddToggle({
    Name = "ESP Chests",
    Description = "See chests on map",
    Default = false,
    Callback = function(Value)
        _G.ESPChests = Value
    end
})

TabESP:AddToggle({
    Name = "ESP Bosses",
    Description = "See bosses locations",
    Default = false,
    Callback = function(Value)
        _G.ESPBosses = Value
    end
})

-- ════════════════════════════════════════════════════════════════
-- MISC TAB
-- ════════════════════════════════════════════════════════════════

TabMisc:AddSection({"Miscellaneous Options"})

TabMisc:AddToggle({
    Name = "Remove Fog",
    Description = "Remove game fog for better visibility",
    Default = false,
    Callback = function(Value)
        if Value then
            game:GetService("Lighting").FogEnd = 9e9
        else
            game:GetService("Lighting").FogEnd = 2500
        end
    end
})

TabMisc:AddToggle({
    Name = "Remove Damage Text",
    Description = "Remove damage numbers",
    Default = false,
    Callback = function(Value)
        _G.RemoveDamageText = Value
    end
})

TabMisc:AddButton({"Unlock All Portals", function()
    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes:GetChildren()) do
        if v.Name == "CommF_" then
            v:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
        end
    end
end})

TabMisc:AddToggle({
    Name = "No Clip", 
    Description = "Walk through walls",
    Default = false,
    Callback = function(Value)
        _G.NoClip = Value
    end
})

spawn(function()
    while wait() do
        if _G.NoClip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)

-- ════════════════════════════════════════════════════════════════
-- TELEPORT TAB
-- ════════════════════════════════════════════════════════════════

TabTeleport:AddSection({"Teleport Locations"})

TabTeleport:AddButton({"Teleport to Fountain", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2843.32495, 72.9875946, -3584.82471)
end})

TabTeleport:AddButton({"Teleport to Mansion", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-390.436554, 350.188995, -7557.09277)
end})

TabTeleport:AddButton({"Teleport to Mirage Island", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5411.22021, 778.609863, -2682.27759)
end})

TabTeleport:AddButton({"Teleport to Colosseum", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1427.33154, 7.38933182, -2842.31592)
end})

-- ════════════════════════════════════════════════════════════════
-- SHOP TAB
-- ════════════════════════════════════════════════════════════════

TabShop:AddSection({"Shop Options"})

TabShop:AddButton({"Buy Geppo", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
end})

TabShop:AddButton({"Buy Buso Haki", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
end})

TabShop:AddButton({"Buy Soru", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
end})

TabShop:AddButton({"Buy Observation Haki", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
end})

-- ════════════════════════════════════════════════════════════════
-- CREDITS TAB
-- ════════════════════════════════════════════════════════════════

TabCredits:AddParagraph({"Red Gold Hub", "Created by Red Gold Team\nVersion: 1.0.0\n\nThank you for using our script!\nJoin our Discord for updates"})

TabCredits:AddButton({"Dark Theme", function()
    redzlib:SetTheme("Dark")
end})

TabCredits:AddButton({"Purple Theme", function()
    redzlib:SetTheme("Purple")
end})

TabCredits:AddButton({"Darker Theme", function()
    redzlib:SetTheme("Darker")
end})

-- ════════════════════════════════════════════════════════════════
-- TWEEN FUNCTION
-- ════════════════════════════════════════════════════════════════

function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 250 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    elseif Distance >= 250 then
        local tween_s = game:service"TweenService"
        local info = TweenInfo.new((Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/325, Enum.EasingStyle.Linear)
        local tween = tween_s:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = Pos})
        tween:Play()
    end
end

function StopTween(target)
    if not target then
        _G.StopTween = true
        wait()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        _G.StopTween = false
    end
end

Window:SelectTab(TabMain)
