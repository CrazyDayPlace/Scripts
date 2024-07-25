repeat wait() until game:IsLoaded()
local Configs, Games, Time =
    getgenv(),
    "Super Power Legends",
    tick()


    if game:GetService"CoreGui":FindFirstChild("CrazyDay") or Configs.loading then return end
    local Signals, Notify = {} , {}
    Configs.loading = true
    local Files = "CrazyDay/" .. Games .. "/" .. game:GetService"Players":GetUserIdFromNameAsync(game:GetService"Players".LocalPlayer.Name)
    function AddSignal(a, b, c, d, e, f)
        table.insert(Signals, {a, b, c, d, e, f})
    end
    AddSignal(
        game:GetService"Players".LocalPlayer.Idled:Connect(function ()
            game:GetService"VirtualUser":Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            game:GetService"VirtualUser":Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end),
        game:GetService"CoreGui".RobloxPromptGui.promptOverlay.ChildAdded:Connect(function (v)
            if (v.Name == "ErrorPrompt" and v:FindFirstChild("MessageArea")) and v.MessageArea:FindFirstChild("ErrorFrame") then
                repeat
                    game:GetService("TeleportService"):Teleport(15503291209)
                    wait(1)
                until not v.Parent
            end
        end)
    )
    local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/Gui.lua"))()
    local SAVE = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/Save.lua"))()
    local INT = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/interfaces.lua"))()
    local OPTIONS = GUI.Options
    local WINDOW = GUI:CreateWindow({
        Title = "Super Power Legends V 0.0.1",
        SubTitle = " [YT: @crazyday3693]",
        UpdateDate = "07/23/2024 [V 0.0.1]",
        UpdateLog = "● Release",
        IconVisual = nil,
        TabWidth = 100,
        Size = UDim2.fromOffset(500, 380),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftControl,
        BlackScreen = false
    })

    local TABS = {
        a = WINDOW:AddTab({Title = "General", Name = nil, Icon = "align-justify"}),
        b = WINDOW:AddTab({ Title = "Settings", Icon = "settings"})
    }
    local H = {
        a = {TABS.a:AddSection("Train Sections"), TABS.a:AddSection("Quest Sections")}
    }

    H.a[1]:AddToggle("Enabled Strength", {
        Title = "Enabled Strength",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    H.a[1]:AddToggle("Enabled Health", {
        Title = "Enabled Health",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    H.a[1]:AddToggle("Enabled Psychics", {
        Title = "Enabled Psychics",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    H.a[1]:AddToggle("Enabled Mobility", {
        Title = "Enabled Mobility",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    H.a[1]:AddToggle("Teleport Zone", {
        Title = "Auto Teleport Zone",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    -- {"BULLY", "MUSCLE GUY", "BANDIT", "GANGSTER", "CORRUPT SOLDIER"}
    H.a[2]:AddDropdown("Selected Quest", {
        Title = "Select Quest:",
        Description = nil,
        Values = {1, 2, 3, 4, 5},
        Multi = false,
        Default = 1,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    H.a[2]:AddToggle("Auto Quest", {
        Title = "Auto Quest",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })


    INT:SetLibrary(GUI)
    INT:SetFolder(Files)
    INT:BuildInterfaceSection(TABS.b)
    H.b = TABS.b:AddSection("Settings")

    H.b:AddToggle("Auto Save", {
        Title = "Auto Save",
        Description = "Automatically saves all configuration settings.",
        Default = true,
        Callback = function (v)
            if not Configs.loading then SAVE:Save("Configs") end
        end
    })

    H.b:AddButton({
        Title = "Reset all configs",
        Description = "Press the button to reset all configuration to default.",
        Callback = function()
            WINDOW:Dialog({
                Title = "Notify",
                Content = "Do you want to reset all configuration?",
                Buttons = {
                    {
                        Title = "Yes",
                        Callback = function()
                            Time = tick()
                            writefile(Files.."/settings/Configs.json",
                            [[
                            {"objects":[{"idx":"Enabled Mobility","type":"Toggle","value":false},{"idx":"Enabled Psychics","type":"Toggle","value":false},{"idx":"Enabled Strength","type":"Toggle","value":false},{"idx":"Auto Save","type":"Toggle","value":true},{"idx":"Teleport Zone","type":"Toggle","value":false},{"idx":"Enabled Health","type":"Toggle","value":false}]}
                            ]])
                            task.wait(0.35)
                            do
                                SAVE:Load("Configs")
                            end
                            local q = tick() - Time
                            local i = math.floor(q) % 60
                            local f = (q % 1) * 1000
                            local text = string.format("%.02d.%.03d", i, f)
                            GUI:Notify({
                                Title = "Successfully reseted configs",
                                Content = nil,
                                Show = false,
                                SubContent = "Loaded Config In "..(text)..".s",
                                Duration = 5
                            })
                        end
                    },
                    {
                        Title = "No",
                        Callback = function()
                           -- setclipboard(tostring(readfile(Files.."/settings/Configs.json")))
                        end
                    }
                }
            })
        end
    })


    do
        SAVE:SetLibrary(GUI)
        SAVE:SetFolder(Files)
        SAVE:IgnoreThemeSettings()
        WINDOW:SelectTab(1)
        WINDOW:Minimize()
        SAVE:Load("Configs")
        Configs.loading = false
    end

    do
        local q = tick() - Time
        local i = math.floor(q) % 60
        local f = (q % 1) * 1000
        local text = string.format("%.02d.%.03d", i, f)
        Notify["Hide"] =
        GUI:Notify({
            Title = "Successfully loaded",
            Content = "Loaded Ui In "..(text)..".s Press "..(OPTIONS["MenuKeybind"].Value or GUI.MinimizeKey.Name).." For Show, Hide Ui",
            SubContent = nil,
            Show = false,
            Duration = 9e9 * 9e9
        })

        Signals["Hide"] = WINDOW.Root:GetPropertyChangedSignal"Visible":Connect(function()
            Notify["Hide"]:Close()
            Signals["Hide"]:Disconnect()
            Signals["Hide"] = nil
        end)
    end

    local function Status(q)
        for i,v in ipairs(game:GetService("Workspace").TrainIndicators:GetChildren()) do
            if v.Name:match(q) and v:FindFirstChild("Top" .. q) then
                return v.Name:split(q)[2] or 0
            end
        end
    end

    local function QuestArea()
        local thing = false
        for i,v in ipairs(game:GetService("Workspace").Enemies["Area" .. tostring(OPTIONS["Selected Quest"].Value)]:GetChildren()) do
            if v.Humanoid.Health > 0 then
                thing = v
            end
        end
        return thing
    end

    function Disable()
        pcall(function()
            if game:GetService"Players".LocalPlayer.Character.Humanoid.PlatformStand then
                game:GetService"Players".LocalPlayer.Character.Humanoid.PlatformStand = false
            end
            local bv = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart:FindFirstChild("NameOfBodyVelocity")
            if bv then bv:Destroy() end
        end)
    end

    function CharacterOnAdded(q)
        local hum = q:WaitForChild("Humanoid", 5)
        if not hum then return end

        Signals["Deaded"] = hum.Died:Connect(function ()
            Configs.WaitForCharacter = true
            if Signals["Deaded"] then Signals["Deaded"]:Disconnect() Signals["Deaded"] = nil end
            Signals["Adding"] = game:GetService"Players".LocalPlayer.CharacterAdded:Connect(function()
                task.delay(1, function()
                    Configs.WaitForCharacter = false
                    if Signals["Adding"] then Signals["Adding"]:Disconnect() Signals["Adding"] = nil end
                end)
            end)
        end)
    end

    coroutine.resume(
        coroutine.create(
            function()
                local L = game:GetService"Players".LocalPlayer
                local Q = L.Character or L.CharacterAdded:Wait()
                L.CharacterAdded:Connect(CharacterOnAdded)
                if Q then CharacterOnAdded(Q) end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then
                        for i = 1,#Signals do
                            for i, v in pairs(Signals[i]) do
                                if v then
                                    v:Disconnect()
                                end
                            end
                        end
                        for i,v in pairs(Signals) do
                            if type(v) == "userdata" and v then
                                Signals[v]:Disconnect()
                            end
                        end
                        Configs.WaitForCharacter = false
                        Disable()
                        break
                    end
                    task.wait()
                end
            end
        )
    )


    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    pcall(function()
                        if Configs.WaitForCharacter then return end
                        if OPTIONS["Enabled Strength"].Value then
                            if not game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Toggled.Value then
                                firesignal(game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Button.MouseButton1Click)
                            else
                                game:GetService"ReplicatedStorage":WaitForChild("Events"):WaitForChild("GetPower"):FireServer(tonumber(Status("Power")))
                            end
                        end
                    end)
                    task.wait(0.35)
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    pcall(function()
                        local Stats = game:GetService("Players").LocalPlayer.Stats
                        if (OPTIONS["Auto Quest"].Value and QuestArea() and Stats.CurrentQuest.Value == OPTIONS["Selected Quest"].Value and Stats.QuestProgress1.Value < 100) or Configs.WaitForCharacter then return end
                        if OPTIONS["Enabled Psychics"].Value then
                            if not game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Toggled.Value then
                                firesignal(game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Button.MouseButton1Click)
                            else
                                game:GetService"ReplicatedStorage":WaitForChild("Events"):WaitForChild("GetPsychics"):FireServer(tonumber(Status("Psychics")))
                            end
                        end
                    end)
                    task.wait(0.35)
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    local Stats = game:GetService("Players").LocalPlayer.Stats
                    if (OPTIONS["Auto Quest"].Value and QuestArea() and Stats.CurrentQuest.Value == OPTIONS["Selected Quest"].Value and Stats.QuestProgress1.Value < 100) or Configs.WaitForCharacter then return end
                    if OPTIONS["Enabled Health"].Value and not (OPTIONS["Enabled Psychics"].Value or OPTIONS["Enabled Strength"].Value) then
                        if not game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Toggled.Value then
                            firesignal(game:GetService"Players".LocalPlayer.PlayerGui.MainGame.Menu.GetMore.Button.MouseButton1Click)
                        else
                            game:GetService"ReplicatedStorage":WaitForChild("Events"):WaitForChild("GetHealth"):FireServer()
                        end
                    end
                    task.wait(0.5)
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    pcall(function()
                        local Stats = game:GetService("Players").LocalPlayer.Stats
                        if (OPTIONS["Auto Quest"].Value and QuestArea() and Stats.CurrentQuest.Value == OPTIONS["Selected Quest"].Value and Stats.QuestProgress1.Value < 100) or Configs.WaitForCharacter then return end
                        if (OPTIONS["Teleport Zone"].Value and OPTIONS["Enabled Health"].Value) or (OPTIONS["Teleport Zone"].Value and OPTIONS["Enabled Psychics"].Value) then
                            if OPTIONS["Enabled Health"].Value then
                                for i,v in ipairs(game:GetService("Workspace").TrainIndicators:GetChildren()) do
                                    if v.Name:match("Health") and v:FindFirstChild("TopHealth") then
                                        game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage").Zones[v.Name].CFrame * CFrame.new(0,- 1.35,0)
                                    end
                                end
                            else
                                for i,v in ipairs(game:GetService("Workspace").TrainIndicators:GetChildren()) do
                                    if v.Name:match("Psychics") and v:FindFirstChild("TopPsychics") then
                                        game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage").Zones[v.Name].CFrame * CFrame.new(0,- 1.35,0)
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.25)
                end
            end
        )
    )


    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    pcall(function()
                        local Stats = game:GetService("Players").LocalPlayer.Stats
                        if (OPTIONS["Auto Quest"].Value and QuestArea() and Stats.CurrentQuest.Value == OPTIONS["Selected Quest"].Value and Stats.QuestProgress1.Value < 100) or Configs.WaitForCharacter then return end
                        if OPTIONS["Enabled Mobility"].Value and not game:GetService"Players".LocalPlayer.Character.Humanoid.PlatformStand then
                            if not (OPTIONS["Teleport Zone"].Value and OPTIONS["Enabled Health"].Value) and not (OPTIONS["Teleport Zone"].Value and OPTIONS["Enabled Psychics"].Value) then
                                local LastPost = game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame
                                local TableOfSet = {1, -1, 1, -1}
                                game:GetService"Players".LocalPlayer.Character.Humanoid:MoveTo(game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(TableOfSet[math.random(1, 2)], 0, TableOfSet[math.random(2, 4)]))
                                task.delay(1.75, function()
                                    game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = LastPost
                                end)
                            else
                                local LastPost = {1,-1}
                                game:GetService"Players".LocalPlayer.Character.Humanoid:MoveTo(game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.Position  + Vector3.new(LastPost[math.random(1, #LastPost)], 0, 0))
                            end
                        end
                    end)
                    task.wait()
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    if OPTIONS["Auto Quest"].Value and not Configs.WaitForCharacter then
                        local Stats = game:GetService("Players").LocalPlayer.Stats
                        if Stats.SideQuestCooldown.Value == 0 and Stats.CurrentQuest.Value ~= OPTIONS["Selected Quest"].Value then
                            Disable()
                            if Stats.CurrentQuest.Value == 0 then
                                game:GetService("ReplicatedStorage").Events.StartSideQuest:FireServer(OPTIONS["Selected Quest"].Value)
                            else
                                game:GetService("ReplicatedStorage").Events.EndSideQuest:FireServer()
                            end
                        else
                            if Stats.QuestProgress1.Value >= 100 then
                                game:GetService("ReplicatedStorage").Events.ClaimSideQuest:FireServer()
                                Disable()
                            end
                        end
                    end
                    task.wait()
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    if GUI.Unloaded then break end
                    pcall(function()
                        local Stats = game:GetService("Players").LocalPlayer.Stats
                        if OPTIONS["Auto Quest"].Value and QuestArea() and Stats.CurrentQuest.Value == OPTIONS["Selected Quest"].Value and Stats.QuestProgress1.Value < 100 and not Configs.WaitForCharacter then
                            game:GetService"Players".LocalPlayer.Character.Humanoid.PlatformStand = true
                            if game:GetService"Players".LocalPlayer.Character.HumanoidRootPart:FindFirstChild("NameOfBodyVelocity") == nil then
                                local bv = Instance.new("BodyVelocity")
                                bv.Name = "NameOfBodyVelocity"
                                bv.Parent =  game:GetService"Players".LocalPlayer.Character.HumanoidRootPart
                                bv.MaxForce = Vector3.new(3000, 3000, 3000)
                                bv.Velocity = Vector3.new(0, 0, 0)
                            end
                            repeat
                                game:GetService"Players".LocalPlayer.Character.HumanoidRootPart.CFrame = QuestArea().HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90),0,0)

                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Ability"):FireServer(7)
                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Ability"):FireServer(2)
                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Ability"):FireServer(1, QuestArea().HumanoidRootPart.Position)
                                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Ability"):FireServer(11, QuestArea().HumanoidRootPart.Position)

                                taks.wait()
                            until not OPTIONS["Auto Quest"].Value or game:GetService"Players".LocalPlayer.Character.Humanoid.Health <= 0 or not QuestArea() or Stats.CurrentQuest.Value == 0 or Stats.QuestProgress1.Value >= 100 or Configs.WaitForCharacter or GUI.Unloaded
                        else
                            Disable()
                        end
                    end)
                    task.wait()
                end
            end
        )
    )
