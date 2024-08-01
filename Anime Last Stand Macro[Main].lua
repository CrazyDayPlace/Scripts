repeat wait() until game:IsLoaded()
local Configs, Games, Time, Players =
    getgenv(),
    "Anime Last Stand",
    tick(),
    game:GetService("Players")

    if game:GetService"CoreGui":FindFirstChild("CrazyDay") or Configs.Loading then return end
    Configs.Loading = true
    local Macro, Paragraph, Notify = {Money = nil, Start = nil, Time = "0.000", Step = {__len = function(tbl) local count = 0 for i,v in pairs(tbl) do if i ~= "Units" then count += 1 end end return count end }, Values = {["Data"] = {}}, Files = "CrazyDay/"..Games.."/"..Players:GetUserIdFromNameAsync(Players.LocalPlayer.Name)}, {}, {}
    local GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/GuiTestPlace.lua"))()
    local SAVE = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/Save.lua"))()
    local INT = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/interfaces.lua"))()
    local FILES = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/files.lua"))()
    local FUNCTIONS = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Place-One-/main/function.lua"))()
    local OPTIONS = GUI.Options
    local WINDOW = GUI:CreateWindow({
        Title = Games.." V 1.0.0",
        SubTitle = " [YT: @crazyday3693]",
        UpdateDate = "07/30/2024 [V 1.0.0]",
        UpdateLog = "● Release",
        IconVisual = nil,
        TabWidth = 100,
        Size = UDim2.fromOffset(500, 380),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftAlt,
        BlackScreen = false
    })

    local TABS = {
        A = WINDOW:AddTab({Title = "Macro", Name = nil, Icon = "video"}),
        B = WINDOW:AddTab({ Title = "Settings", Icon = "settings"})
    }
    local SECTIONS = {
        A = {TABS.A:AddSection("Configs"), TABS.A:AddSection("Macro")}
    }

    Paragraph["MacroInformation"] =
    SECTIONS.A[1]:AddParagraph({
        Title = "MacroInformation",
        Content = "Selected File: None\nCurrent Time: 0.000\nMacro Status: None\nMacro Step: 0",
    })

    FILES:MakeFolder("CrazyDay/"..Games.."/Macro")
    FILES:CheckFiles("CrazyDay/"..Games.."/Macro/Start.json",game:GetService("HttpService"):JSONEncode({}))
    SECTIONS.A[1]:AddDropdown("Selected File", {
        Title = "Select File: ",
        Description = nil,
        Values = FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro"),
        Multi = false,
        Default = 1,
        Callback = function (v)
            if not Configs.Loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
            Paragraph["MacroInformation"]:SetDesc("Selected File: "..(v or "None").."\nCurrent Time: 0.000\nMacro Status: None\nMacro Step: 0") Macro.Values["Data"] = {}
            if not Configs.Loading and OPTIONS["Play Macro"].Value then OPTIONS["Play Macro"]:SetValue(false) OPTIONS["Play Macro"]:SetValue(true) end
        end
    })

    SECTIONS.A[1]:AddInput("Create File", {
        Title = "Create File: ",
        Description = nil,
        Default = nil,
        Placeholder = "File Name.",
        Numeric = false,
        Finished = false,
        Callback = function(v)

        end
    })

    SECTIONS.A[1]:AddButton({
        Title = "Create",
        Description = nil,
        Callback = function()
            if OPTIONS["Create File"].Value == "" then return end
            local currentplace
            local create, error = pcall(function()
                FILES:CheckFiles(string.format("CrazyDay/"..Games.."/Macro/".."%s.json",tostring(OPTIONS["Create File"].Value)),game:GetService("HttpService"):JSONEncode({}))
                OPTIONS["Selected File"]:SetValues(FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro"))
                OPTIONS["Selected File"]:SetValue(OPTIONS["Create File"].Value)
            end)
            local unplace, place = pcall(function() delfile('') end)
            if place and tostring(place:match([["]])) then
                currentplace = place:split([["]])[2]
            end
            if create then
                GUI:Notify({
                    Title = "Successfully Create at: "..(currentplace or "")..string.format("CrazyDay/"..Games.."/Macro/".."%s.json", OPTIONS["Create File"].Value),
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = 5
                })
            elseif error then
                GUI:Notify({
                    Title = "Error Create at: "..tostring(error),
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = 5
                })
            end
        end
    })

    SECTIONS.A[1]:AddButton({
        Title = "Delete",
        Description = nil,
        Callback = function()
            if not OPTIONS["Selected File"].Value then return end
            local currentplace
            local LastDelete = OPTIONS["Selected File"].Value
            local create, error = pcall(function()
                FILES:DeleteFile(string.format("CrazyDay/"..Games.."/Macro/".."%s.json", LastDelete))
                if #FILES:ListFiles("CrazyDay/"..Games.."/Macro") > 0 then
                    OPTIONS["Selected File"]:SetValues(FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro"))
                    OPTIONS["Selected File"]:SetValue(FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro")[math.random(1, #FILES:ListFiles("CrazyDay/"..Games.."/Macro"))])
                else
                    OPTIONS["Selected File"]:SetValue(nil)
                    OPTIONS["Selected File"]:SetValues({})
                end
            end)
            local unplace, place = pcall(function() delfile('') end)
            if place and tostring(place:match([["]])) then
                currentplace = place:split([["]])[2]
            end
            if create then
                GUI:Notify({
                    Title = "Successfully Delete at: "..(currentplace or "")..string.format("CrazyDay/"..Games.."/Macro/".."%s.json", LastDelete),
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = 5
                })
            elseif error then
                GUI:Notify({
                    Title = "Error Delete at: "..tostring(error),
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = 5
                })
            end
        end
    })

    SECTIONS.A[1]:AddToggle("Show MacroInformation", {
        Title = "Show MacroInformation",
        Description = nil,
        Default = true,
        Callback = function (v)
            if not Configs.Loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
            Paragraph["MacroInformation"].Frame.Visible = v
            if not v and Notify["MacroInformation"] then Notify["MacroInformation"]:Close() Notify["MacroInformation"] = nil end
        end
    })

    SECTIONS.A[2]:AddToggle("Record Macro", {
        Title = "Record Macro",
        Description = nil,
        Default = false,
        Callback = function (v)

        end
    })

    SECTIONS.A[2]:AddToggle("Play Macro", {
        Title = "Play Macro",
        Description = nil,
        Default = false,
        Callback = function (v)
            if not Configs.Loading and OPTIONS["Auto Save"].Value then SAVE:Save("Configs") end
        end
    })

    OPTIONS["Record Macro"]:OnChanged(function ()
        if not OPTIONS["Record Macro"].Value and Notify["Macro2"] then Notify["Macro2"]:Close() Notify["Macro2"] = nil end
        if OPTIONS["Record Macro"].Value and OPTIONS["Play Macro"].Value then
            OPTIONS["Record Macro"]:SetValue(false)
            if not Notify["Macro1"] then
                Notify["Macro1"] =
                GUI:Notify({
                    Title = "Make Sure You Has Disable Play Macro",
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = (9e9 * 9e9) + (9e9 * 9e9)
                })
            end
        else
            if Notify["Macro1"] then
                Notify["Macro1"]:Close()
                Notify["Macro1"] = nil
            end
        end
    end)

    OPTIONS["Play Macro"]:OnChanged(function ()
        if not OPTIONS["Play Macro"].Value and Notify["Macro1"] then Notify["Macro1"]:Close() Notify["Macro1"] = nil end
        if OPTIONS["Play Macro"].Value and OPTIONS["Record Macro"].Value then
            OPTIONS["Play Macro"]:SetValue(false)
            if not Notify["Macro2"] then
                Notify["Macro2"] =
                GUI:Notify({
                    Title = "Make Sure You Has Disable Record Macro",
                    Content = nil,
                    SubContent = nil,
                    Show = false,
                    Duration = (9e9 * 9e9) + (9e9 * 9e9)
                })
            end
        else
            if Notify["Macro2"] then
                Notify["Macro2"]:Close()
                Notify["Macro2"] = nil
            end
        end
    end)

    INT:SetLibrary(GUI)
    INT:SetFolder(Macro.Files)
    INT:BuildInterfaceSection(TABS.B)
    SECTIONS.SX = TABS.B:AddSection("Settings")
    SECTIONS.SX:AddToggle("Auto Save",{
        Title = "Auto Save",
        Description = "Automatically saves all configuration settings.",
        Default = true,
        Callback = function (v)
            if not Configs.Loading then SAVE:Save("Configs") end
        end
    })

    do
        SAVE:SetLibrary(GUI)
        SAVE:SetFolder(Macro.Files)
        SAVE:SetIgnoreIndexes({"Record Macro", "Create File"})
        SAVE:IgnoreThemeSettings()
        WINDOW:SelectTab(1)
        WINDOW:Minimize()
        SAVE:Load("Configs")
        Configs.Loading = false
        Paragraph["MacroInformation"]:SetDesc("Selected File: "..(OPTIONS["Selected File"].Value or "None").."\nCurrent Time: 0.000\nMacro Status: None\nMacro Step: 0")
        if OPTIONS["Selected File"].Value == nil and table.find(FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro"), "Start") then
            OPTIONS["Selected File"]:SetValue("Start")
        end
    end

    do
        local Tick = tick() - Time
        local Secs = math.floor(Tick) % 9e9
        local Mils = string.format(".%.03d", (Tick % 1) * 1000)
        Notify["Loaded"] =
        GUI:Notify({
            Title = "Successfully loaded",
            Content = "Loaded Ui In "..tostring(Secs .. Mils)..".s Press "..(OPTIONS["MenuKeybind"].Value or GUI.MinimizeKey.Name).." For Show, Hide Ui",
            SubContent = nil,
            Show = false,
            Duration = (9e9 * 9e9) + (9e9 * 9e9)
        })
        FUNCTIONS.Signals["Loaded"] = WINDOW.Root:GetPropertyChangedSignal("Visible"):Connect(function()
            Notify["Loaded"]:Close() FUNCTIONS.Signals["Loaded"]:Disconnect() FUNCTIONS.Signals["Loaded"] = nil
        end)
    end

    local function stringtocf(str)
        return CFrame.new(table.unpack(str:gsub(" ", ""):split(",")))
    end
    local function stringtopos(str)
        return Vector3.new(table.unpack(str:gsub(" ", ""):split(",")))
    end

    local function Wave()
        return game:GetService("ReplicatedStorage").Wave.Value
    end

    local function MacroOfStep()
        setmetatable(Macro.Values["Data"], Macro.Step)
        return #Macro.Values["Data"]
    end

    local function writemacro()
        writefile(string.format("CrazyDay/"..Games.."/Macro/".."%s.json",OPTIONS["Selected File"].Value), game:GetService("HttpService"):JSONEncode(Macro.Values))
    end

    local function UnitsSlot(X)
        local XSlot = "Slot1"
        for i,v in ipairs(game:GetService("Players").LocalPlayer.Slots:GetChildren()) do
            if v.Value == X then XSlot = v.Name end
        end
        for i,v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.SlotsBG.Slots[XSlot]:GetChildren()) do
            if v:IsA("TextLabel") and v.Name == "Cost" then
                return v.Text:split("$")[2]
            end
        end
    end

    local function UpgradeCost(X)
        local Upgrade = false
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Upgrade") and game:GetService("Players").LocalPlayer.PlayerGui.Upgrade.BG.Bottom.Upgrade.Value.Text ~= "" then
            local Values = game:GetService("Players").LocalPlayer.PlayerGui.Upgrade.BG.Bottom.Upgrade.Value.Text:split("$")[2]
            if tonumber(X) >= tonumber(FUNCTIONS:StringToNum(Values)) then
                Upgrade = Values
            end
        end
        return Upgrade
    end

    local function UnitPlacement(Units, Position)
        if type(Position) == "string" then
            Position = stringtopos(Position)
        end
        for i,v in ipairs(game:GetService("Workspace").Towers:GetChildren()) do
            if v.Name == Units and v:WaitForChild("Owner").Value == Players.LocalPlayer then
                if v:WaitForChild("UnitHighlight").Position == Position or (v:WaitForChild("UnitHighlight").Position - Position).Magnitude < 2 then
                    return v
                end
            end
        end
    end

    local function UnitPlaceRequest(Q, X)
        if tonumber(X) >= tonumber(UnitsSlot(Q)) then
            return true
        end
    end

    local function ItsLimitedUnit(X)
        local Count = 0
        for i,v in ipairs(game:GetService("Workspace").Towers:GetChildren()) do
            if v.Name == X and v:WaitForChild("Owner").Value == Players.LocalPlayer then
                Count += 1
                if Count >= v:WaitForChild("PlacementLimit").Value then
                    return true
                end
            end
        end
    end

    local function ListFinds(X)
        if table.find(FILES:ListFiles("CrazyDay/"..Games.."/Macro", "CrazyDay"..Games.."Macro"), X) then
            return true
        else
            return false
        end
    end

    function MacroOfStepTables(str)
        if not Macro.Values["Data"][tostring(MacroOfStep() + 1)] then
            Macro.Values["Data"][tostring(MacroOfStep() + 1)] = str
        end
    end

    coroutine.resume(
        coroutine.create(
            function()
                while true and wait() do
                    if GUI.Unloaded then
                        for i = 1,#FUNCTIONS.Signals do
                            for i,v in pairs(FUNCTIONS.Signals[i]) do
                                if v then v:Disconnect() end
                            end
                        end
                        for i,v in pairs(FUNCTIONS.Signals) do
                            if type(v) == "userdata" and FUNCTIONS.Signals[v] then FUNCTIONS.Signals[v]:Disconnect() end
                        end
                        for i,v in pairs(Notify) do
                            if v and type(v) == "table" then
                                Notify[i]:Close()
                                Notify[i] = nil
                            end
                        end
                        break
                    end
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true and wait() do
                    if not WINDOW.Root.Visible and OPTIONS["Show MacroInformation"].Value and not Notify["MacroInformation"] then
                        Notify["MacroInformation"] =
                        GUI:Notify({
                            Title = "MacroInformation",
                            Content = nil,
                            SubContent = "\nNone",
                            Show = false,
                            LabelPos = 30,
                            Duration = (9e9 * 9e9) + (9e9 * 9e9)
                        })
                    elseif WINDOW.Root.Visible and OPTIONS["Show MacroInformation"].Value and Notify["MacroInformation"] then
                        Notify["MacroInformation"]:Close()
                        Notify["MacroInformation"] = nil
                    end
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true and wait() do
                    if not getgenv().Loading and not Macro.Start and game:GetService("ReplicatedStorage"):FindFirstChild("GameStarted") and game:GetService("ReplicatedStorage").GameStarted.Value then
                        Macro.Start = tick()
                    elseif Macro.Start then
                        local Tick = tick() - Macro.Start
                        local Secs = math.floor(Tick) % ((9e9 * 9e9) + (9e9 * 9e9))
                        local Mills = string.format(".%.03d", (Tick % 1) * 1000)
                        Macro.Time = Secs .. Mills
                    end
                end
            end
        )
    )

    coroutine.resume(
        coroutine.create(
            function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("GameStarted") == nil then return end
                local raw = getrawmetatable(game:GetService("ReplicatedStorage"):WaitForChild("Remotes"));
                local hook = raw.__namecall;
                setreadonly(raw,false)
                raw.__namecall = newcclosure(function(self,...)
                    local arg = {...};
                    local method = getnamecallmethod();
                    task.spawn(
                        function()
                            local LastMoney = Players.LocalPlayer.Cash.Value
                            if not GUI.Unloaded and OPTIONS["Record Macro"].Value and ((self.Name == "PlaceTower" and method == "FireServer") or (self.Name == "Upgrade" and method == "InvokeServer") or (self.Name == "Sell" and method == "InvokeServer") or (self.Name == "ChangeTargeting" and method == "InvokeServer")) then
                                if self.Name == "PlaceTower" and UnitPlaceRequest(arg[1],LastMoney) then
                                    if ItsLimitedUnit(arg[1]) then return end
                                    local Unit, UCFrame = arg[1], arg[2]
                                    MacroOfStepTables({
                                        ["Type"] = tostring(self.Name),
                                        ["Time"] = tostring(Macro.Time),
                                        ["Wave"] = tostring(Wave()),
                                        ["Money"] = tostring(UnitsSlot(Unit)),
                                        ["Unit"] = tostring(Unit),
                                        ["CFrame"] = tostring(UCFrame)
                                    })
                                    writemacro()
                                elseif self.Name == "Upgrade" and UpgradeCost(LastMoney) then
                                    local Unit = arg[1]
                                    MacroOfStepTables({
                                        ["Type"] = tostring(self.Name),
                                        ["Time"] = tostring(Macro.Time),
                                        ["Wave"] = tostring(Wave()),
                                        ["Money"] = tostring(UpgradeCost(LastMoney)),
                                        ["Unit"] = tostring(Unit.Name),
                                        ["CFrame"] = tostring(Unit:WaitForChild("UnitHighlight").Position)
                                    })
                                    writemacro()
                                elseif self.Name == "Sell" or self.Name == "ChangeTargeting" then
                                    local Unit = arg[1]
                                    MacroOfStepTables({
                                        ["Type"] = tostring(self.Name),
                                        ["Time"] = tostring(Macro.Time),
                                        ["Wave"] = tostring(Wave()),
                                        ["Unit"] = tostring(Unit.Name),
                                        ["CFrame"] = tostring(Unit:WaitForChild("UnitHighlight").Position)
                                    })
                                    writemacro()
                                end
                            end
                        end
                    )
                    return hook(self,...)
                end)
                setreadonly(raw,true)
            end
        )
    )

    OPTIONS["Play Macro"]:OnChanged(
        function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("GameStarted") == nil then return end task.wait(0.025)
            if OPTIONS["Play Macro"].Value and ListFinds(OPTIONS["Selected File"].Value) then Configs.LastPlaying = OPTIONS["Selected File"].Value
                Configs.Playing = game:GetService("HttpService"):JSONDecode(readfile(string.format("CrazyDay/"..Games.."/Macro/".."%s.json",Configs.LastPlaying)))
                if (Configs.LastPlaying and Configs.LastPlaying ~= OPTIONS["Selected File"].Value) or Configs.Playing.Data == nil or not ListFinds(Configs.LastPlaying) then
                    return
                else
                    setmetatable(Configs.Playing.Data, Macro.Step)
                    for index = 1, #Configs.Playing.Data do
                        Configs.Data, Configs.Status = Configs.Playing.Data[tostring(index)], "\nMacro Status: Playing\nMacro Step: "..tostring(index.."/"..#Configs.Playing.Data)
                        if Configs.Data.Wave then
                            repeat
                                if tonumber(Wave()) >= tonumber(Configs.Data.Wave) then
                                    break
                                elseif (Configs.LastPlaying and Configs.LastPlaying ~= OPTIONS["Selected File"].Value) or not OPTIONS["Play Macro"].Value or not Configs.Playing or not ListFinds(Configs.LastPlaying) then
                                    break
                                end
                                task.wait()
                            until nil == true
                        end
                        if Configs.Data.Time then
                            repeat
                                if tonumber(Macro.Time) >= tonumber(Configs.Data.Time) then
                                    break
                                elseif (Configs.LastPlaying and Configs.LastPlaying ~= OPTIONS["Selected File"].Value) or not OPTIONS["Play Macro"].Value or not Configs.Playing or not ListFinds(Configs.LastPlaying) then
                                    break
                                end
                                task.wait()
                            until nil == true
                        end
                        if Configs.Data.Money then
                            repeat
                                if tonumber(MoneyCost()) >= tonumber(FUNCTIONS:StringToNum(Configs.Data.Money)) then
                                    break
                                elseif (Configs.LastPlaying and Configs.LastPlaying ~= OPTIONS["Selected File"].Value) or not OPTIONS["Play Macro"].Value or not Configs.Playing or not ListFinds(Configs.LastPlaying) then
                                    break
                                end
                                task.wait()
                            until nil == true
                        end
                        if (Configs.LastPlaying and Configs.LastPlaying ~= OPTIONS["Selected File"].Value) or not OPTIONS["Play Macro"].Value or not Configs.Playing or not ListFinds(Configs.LastPlaying) then
                            if not OPTIONS["Play Macro"].Value then
                                Configs.Playing = nil
                                Configs.Data = nil
                                Configs.Status = nil
                                Configs.LastPlaying = nil
                                break
                            elseif OPTIONS["Play Macro"].Value then
                                OPTIONS["Play Macro"]:SetValue(false)
                                Configs.Playing = nil
                                Configs.Data = nil
                                Configs.Status = nil
                                Configs.LastPlaying = nil
                                task.wait(1)
                                OPTIONS["Play Macro"]:SetValue(true)
                                break
                            end
                        end
                        if Configs.Data.Type then
                            if Configs.Data.Type == "PlaceTower" then
                                game:GetService("ReplicatedStorage").Remotes.PlaceTower:FireServer(
                                    Configs.Data.Unit,
                                    stringtocf(Configs.Data.CFrame)
                                )
                            else
                                local Unit = UnitPlacement(Configs.Data.Unit, Configs.Data.CFrame)
                                if Unit then
                                    game:GetService("ReplicatedStorage").Remotes[Configs.Data.Type]:InvokeServer(Unit)
                                end
                            end
                        end
                        if index >= #Configs.Playing.Data then
                                    Configs.Status = "\nMacro Status: Playing Ended\nMacro Step: "..tostring("End/End")
                            end
                        task.wait(0.25)
                    end
                end
            end
        end
    )

    coroutine.resume(
        coroutine.create(
            function()
                while true and wait() do
                    if GUI.Unloaded then break end
                    if Notify["MacroInformation"] then local cl, cn = string.gsub(Notify["MacroInformation"].SubContentLabel.Text, "\n", "")
                        if OPTIONS["Record Macro"].Value and game:GetService("ReplicatedStorage"):FindFirstChild("GameStarted") then local Data = Macro.Values.Data[tostring(MacroOfStep())]
                            local LastValue = ""
                            if Data and table.find({"PlaceTower","Upgrade"}, Data.Type) then
                                LastValue = "\nAction: "..Data.Type.."\nWave: "..Data.Wave.."\nTime: "..Data.Time.."\nMoney: "..Data.Money.."\nUnit: "..Data.Unit
                            elseif Data and table.find({"Sell","ChangeTargeting"}, Data.Type) then
                                LastValue = "\nAction: "..Data.Type.."\nWave: "..Data.Wave.."\nTime: "..Data.Time.."\nUnit: "..Data.Unit
                            end
                            Notify["MacroInformation"].SubContentLabel.Text = "Selected File: "..(OPTIONS["Selected File"].Value or "None").."\nCurrent Time: "..tostring(Macro.Time).."\nMacro Status: Recording\nMacro Step: "..tostring(MacroOfStep())..LastValue
                        elseif OPTIONS["Play Macro"].Value and Configs.Playing and Configs.Data and Configs.Status and Configs.LastPlaying then
                            local LastValue = ""
                            if Configs.Data and table.find({"PlaceTower","Upgrade"}, Configs.Data.Type) and not Configs.Status.find(Configs.Status,"End") then
                                LastValue = "\nAction: "..tostring(Configs.Data.Type).."\nWating For Wave: "..tostring(Configs.Data.Wave).."\nWating For Time: "..tostring(Configs.Data.Time).."\nWating For Money: "..tostring(Configs.Data.Money).."\nUnit: "..tostring(Configs.Data.Unit)
                            elseif Configs.Data and table.find({"Sell","ChangeTargeting"}, Configs.Data.Type) and not Configs.Status.find(Configs.Status,"End") then
                                LastValue = "\nAction: "..tostring(Configs.Data.Type).."\nWating For Wave: "..tostring(Configs.Data.Wave).."\nWating For Time: "..tostring(Configs.Data.Time).."\nUnit: "..tostring(Configs.Data.Unit)
                            end
                            Notify["MacroInformation"].SubContentLabel.Text = "Selected File: "..(Configs.LastPlaying or "None").."\nCurrent Time: "..tostring(Macro.Time)..Configs.Status..LastValue
                        else
                            Notify["MacroInformation"].SubContentLabel.Text = "Selected File: "..(OPTIONS["Selected File"].Value or "None").."\nCurrent Time: "..tostring(Macro.Time).."\nMacro Status: None\nMacro Step: None"
                        end
                        Notify["MacroInformation"].Holder.Size = UDim2.new(1,0,0,(80 + (10.5 * cn)))
                    else
                        if OPTIONS["Record Macro"].Value and game:GetService("ReplicatedStorage"):FindFirstChild("GameStarted") then local Data = Macro.Values.Data[tostring(MacroOfStep())]
                            local LastValue = ""
                            if Data and table.find({"PlaceTower","Upgrade"}, Data.Type) then
                                LastValue = "\nAction: "..Data.Type.."\nWave: "..Data.Wave.."\nTime: "..Data.Time.."\nMoney: "..Data.Money.."\nUnit: "..Data.Unit
                            elseif Data and table.find({"Sell","ChangeTargeting"}, Data.Type) then
                                LastValue = "\nAction: "..Data.Type.."\nWave: "..Data.Wave.."\nTime: "..Data.Time.."\nUnit: "..Data.Unit
                            end
                            Paragraph["MacroInformation"]:SetDesc("Selected File: "..(OPTIONS["Selected File"].Value or "None").."\nCurrent Time: "..tostring(Macro.Time).."\nMacro Status: Recording\nMacro Step: "..tostring(MacroOfStep())..LastValue)
                        elseif OPTIONS["Play Macro"].Value and Configs.Playing and Configs.Data and Configs.Status and Configs.LastPlaying then
                            local LastValue = ""
                            if Configs.Data and table.find({"PlaceTower","Upgrade"}, Configs.Data.Type) and not Configs.Status.find(Configs.Status,"End") then
                                LastValue = "\nAction: "..tostring(Configs.Data.Type).."\nWating For Wave: "..tostring(Configs.Data.Wave).."\nWating For Time: "..tostring(Configs.Data.Time).."\nWating For Money: "..tostring(Configs.Data.Money).."\nUnit: "..tostring(Configs.Data.Unit)
                            elseif Configs.Data and table.find({"Sell","ChangeTargeting"}, Configs.Data.Type) and not Configs.Status.find(Configs.Status,"End") then
                                LastValue = "\nAction: "..tostring(Configs.Data.Type).."\nWating For Wave: "..tostring(Configs.Data.Wave).."\nWating For Time: "..tostring(Configs.Data.Time).."\nUnit: "..tostring(Configs.Data.Unit)
                            end
                            Paragraph["MacroInformation"]:SetDesc("Selected File: "..(Configs.LastPlaying or "None").."\nCurrent Time: "..tostring(Macro.Time)..Configs.Status..LastValue)
                        else
                            Paragraph["MacroInformation"]:SetDesc("Selected File: "..(OPTIONS["Selected File"].Value or "None").."\nCurrent Time: "..tostring(Macro.Time).."\nMacro Status: None\nMacro Step: None")
                        end
                    end
                end
            end
        )
    )
