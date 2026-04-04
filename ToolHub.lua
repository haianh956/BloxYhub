--// LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// WINDOW + KEY SYSTEM
local Window = Rayfield:CreateWindow({
    Name = "Tool Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by HẢI ANH",
    
    ConfigurationSaving = {
        Enabled = false
    },

    KeySystem = true, -- bật key system
    KeySettings = {
        Title = "Nhập Key",
        Subtitle = "Tool Hub",
        Note = "LẤY KEY Ở @taoscriptsharresoucre", -- dòng nhỏ
        FileName = "Key", -- lưu key
        SaveKey = true, -- nhớ key
        GrabKeyFromSite = false, -- không lấy web
        Key = {"BLOXY-JQKA"} -- key của bạn
    }
})

--// TAB
local Tab = Window:CreateTab("Main", 4483362458)

--// SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// STATE
local enabled = false
local tool = nil

--// CREATE TOOL (GIỮ TELEPORT CŨ)
local function createTool()
    if tool then tool:Destroy() end

    tool = Instance.new("Tool")
    tool.Name = "Teleport Tool"
    tool.RequiresHandle = false
    tool.Parent = player.Backpack

    tool.Activated:Connect(function()
        if not enabled then return end

        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local mouse = player:GetMouse()
        if not mouse then return end

        local pos = mouse.Hit.Position
        if pos then
            hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
        end
    end)
end

--// AUTO RESPAWN TOOL
player.CharacterAdded:Connect(function()
    if enabled then
        task.wait(1)
        createTool()
    end
end)

--// TOGGLE TOOL
Tab:CreateToggle({
    Name = "Create Teleport Tool",
    Description = "Click để teleport (bản cũ)",
    CurrentValue = false,
    Callback = function(value)
        enabled = value

        if enabled then
            createTool()
        else
            if tool then
                tool:Destroy()
                tool = nil
            end
        end
    end,
})
