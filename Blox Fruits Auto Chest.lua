repeat wait() until game:IsLoaded()
game:GetService"CoreGui".RobloxPromptGui.promptOverlay.ChildAdded:Connect(function (v)
    if (v.Name == "ErrorPrompt" and v:FindFirstChild("MessageArea")) and v.MessageArea:FindFirstChild("ErrorFrame") then
        repeat
            game:GetService("TeleportService"):Teleport(game.PlaceId)
            wait(1)
        until not v.Parent
    end
end)
while true and task.wait() do
    if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
        local Q = game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame
        game:GetService"VirtualInputManager":SendMouseButtonEvent(Q.AbsolutePosition.X + 27.5, Q.AbsolutePosition.Y + 50, 0, not game:GetService"UserInputService":IsMouseButtonPressed(Enum.UserInputType.MouseButton1), game, 0)
    else
        local W = game:GetService("Workspace")
        if W:FindFirstChild("Chest1") or W:FindFirstChild("Chest2") or W:FindFirstChild("Chest3") then
            pcall(function()
                local Character = game:GetService("Players").LocalPlayer.Character
                for i,v in ipairs(W:GetChildren()) do
                    if v.Name:match("Chest") and Character then
                        repeat
                            if Character then Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 1.25, -1) end
                            task.wait()
                        until not v.Parent or not Character or Character.Humanoid.Health <= 0
                    end
                end
            end)
        else
            if getgenv()["HOP AFRER CHEST IsA NONE"] then
                function ListServers(cursor)
                    local RAW = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=10" .. ((cursor and "&cursor=" .. cursor) or ""))
                    return game:GetService("HttpService"):JSONDecode(RAW)
                end
                local Servers = ListServers()
                for i,v in pairs(Servers.data) do
                    if v.playing < v.maxPlayers and v.id ~= game.JobId then
                        local S, E = pcall(game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id , game:GetService("Players").LocalPlayer))
                        if S then break end
                    end
                end
                -- local TeleportPlace = Servers.data[math.random(1, #Servers.data)]
                -- game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, TeleportPlace.Id, game:GetService("Players").LocalPlayer)
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Notification!";
                    Text = "There Server has no Chest Please Rejoin Server";
                    Duration = 9e9;
                    Button1 = "Close";
                })
                task.wait(5)
                break
            end
        end
    end
end
