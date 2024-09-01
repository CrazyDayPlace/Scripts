repeat task.wait() until game:IsLoaded()
if game.PlaceId ~= 18583778121 and game.PlaceId ~= 12886143095 then return end
local MyGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrazyDayPlace/Collections/main/Gui/main(no%20search).lua"))()
local Options = MyGui.Options
local Windows = MyGui:CreateWindow({
    Title = "Anime Last Stand",
    SubTitle = "Auto Reroll",
    UpdateDate = nil,
    UpdateLog = nil,
    IconVisual = nil,
    TabWidth = 100,
    Size = UDim2.fromOffset(500, 380),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftAlt,
    BlackScreen = false
})

local RollsUsed = 0
local Tabs = Windows:AddTab({Title = "Reroll", Name = nil, Icon = "rbxassetid://111047899585675"})
local Sections = Tabs:AddSection("Reroll Sections")
Sections:AddDropdown(
    "Selected Traits",
    {
        Title = "Select Traits",
        Multi = true,
        Values = {"Scoped 1", "Sturdy 1", "Accelerate 1", "Scoped 2", "Sturdy 2", "Accelerate 2", "Shining", "Scoped 3", "Sturdy 3", "Accelerate 3", "Eagle Eye", "Golden", "Hyper Speed", "Juggernaut", "Elemental Master", "Vulture", "Diamond", "Cosmic", "Demi God", "All Seeing", "Entrepreneur", "Shinigami", "Overlord", "Avatar", "Glitched"},
        Default = {},
        Callback = function()
           if #Options["Selected Traits"].Tables >= 1 then
           Options["Auto Reroll"]:UnLock()
           else
           if Options["Auto Reroll"] then
           Options["Auto Reroll"]:Lock()
           Options["Auto Reroll"]:SetValue(false)
           end
        end
    end
    }
)
Sections:AddToggle(
    "Auto Reroll",
    {
        Title = "Auto Reroll",
        Default = false,
        Callback = function(Values)
            if Values and #Options["Selected Traits"].Tables >= 1 then
                Options["Selected Traits"]:Lock()
                RollsUsed = 0
                while true and task.wait() do
                    if not Options["Auto Reroll"].Value or table.find(ItsTraits(), game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.BG.Content.Selection.QuirkIcon.Image) then
                        MyGui:Notify(
                            {
                                Title = "Interfaces",
                                SubContent = "You Just Roll The " .. tostring(WhatisTraits()) .. ", Rolls Used: " .. tostring(RollsUsed)
                            }
                        )
                        Options["Selected Traits"]:UnLock()
                        Options["Auto Reroll"]:SetValue(false)
                        break
                    else
                        if game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.Enabled and game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.BG.Content.Selection.UnitName.Text ~= "" then
                            game:GetService("ReplicatedStorage").Remotes.Quirks.Roll:InvokeServer()
                            RollsUsed += 1
                            task.wait(0.0015)
                        end
                    end
                end
            end
        end
    }
)

function ItsTraits()
    local TraitsOfTable = {}
    if #Options["Selected Traits"].Tables >= 1 then
        for _ , Quirks in next, game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.Index.Content.ScrollingFrame:GetChildren() do
            if table.find(Options["Selected Traits"].Tables, Quirks.Name) then
                table.insert(TraitsOfTable, Quirks.Icon.Image.Image)
            end
        end
    end
    return TraitsOfTable
end


function WhatisTraits()
    local Name = "None"
    for _ , Quirks in next, game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.Index.Content.ScrollingFrame:GetChildren() do
        if Quirks:IsA("Frame") and Quirks.Icon.Image.Image == game:GetService("Players").LocalPlayer.PlayerGui.QuirksUI.BG.Content.Selection.QuirkIcon.Image then
            Name = Quirks.Name
        end
    end
    return Name
end

do
    Options["Auto Reroll"]:Lock()
    Windows:SelectTab(1)
    Windows:Minimize("Loaded")
end
