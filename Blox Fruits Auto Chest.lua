repeat wait() until game:IsLoaded()
local Character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
while true and task.wait() do
    local W = game:GetService("Workspace")
    if W:FindFirstChild("Chest1") or W:FindFirstChild("Chest2") or W:FindFirstChild("Chest3") then
        pcall(function()
            Character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
            for i,v in ipairs(W:GetChildren()) do
                if v.Name:match("Chest") and Character then
                    repeat
                        if Character then Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 1.25, -1) end
                        task.wait()
                    until Character.Humanoid.Health <= 0 or not v.Parent
                end
            end
        end)
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

