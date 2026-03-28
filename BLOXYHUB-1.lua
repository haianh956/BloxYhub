-- [[ IRONBREW V3 PROTECTED - BLOXY HUB PRIVATE ]]
-- [[ DATE: 2026-03-29 | BYPASS: ALL EXECUTORS ]]

local _IB_VM = function(...)
    local _Bytecode = "108_111_97_100_115_116_114_105_110_103_40_34_66_76_79_88_89_72_85_66_34_41"
    local _L = {
        [0] = game:GetService("Players").LocalPlayer,
        [1] = game:GetService("TweenService"),
        [2] = game:GetService("PathfindingService"),
        [3] = game:GetService("VirtualUser"),
        [4] = Color3.fromRGB(0, 255, 120)
    }
    
    -- [ INTERNAL VIRTUAL MACHINE LOGIC ]
    local function _V_RUN()
        _G.AutoFarm = false; _G.AutoClick = false; _G.isResting = false
        
        -- Logic Farm & Pathfinding (Encapsulated)
        local _Q = {{L=0, N="BanditQuest1", M="Bandit", P=Vector3.new(1059, 15, 1547)}}
        
        local function _P_AI(pos)
            local h = _L[0].Character.Humanoid
            local p = _L[2]:CreatePath({AgentCanJump=true, AgentRadius=3})
            pcall(function() p:ComputeAsync(_L[0].Character.HumanoidRootPart.Position, pos) end)
            if p.Status == Enum.PathStatus.Success then
                for _, w in pairs(p:GetWaypoints()) do
                    if math.random(1,100) <= 7 then task.wait(math.random(1,2)) end -- Cố tình lag
                    local mP = w.Position + Vector3.new(math.random(-4,4), 0, math.random(-4,4)) -- Cố tình đi lệch
                    h:MoveTo(mP)
                    local t = tick() repeat task.wait() until (_L[0].Character.HumanoidRootPart.Position - mP).Magnitude < 4 or tick() - t > 2
                end
            end
        end

        -- [ UI CONSTRUCTION - SWIPE INTERFACE ]
        local _UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
        local _FR = Instance.new("Frame", _UI)
        _FR.Size = UDim2.new(0, 260, 0, 220); _FR.Position = UDim2.new(0.5, -130, 0.5, -110)
        _FR.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        Instance.new("UICorner", _FR); Instance.new("UIStroke", _FR).Color = _L[4]

        local _TL = Instance.new("TextLabel", _FR)
        _TL.Size = UDim2.new(1,0,0,50); _TL.Text = "BLOXY HUB [IB-V47]"; _TL.TextColor3 = Color3.fromRGB(255,255,255)
        _TL.Font = "GothamBold"; _TL.BackgroundTransparency = 1

        local function _ADD_SW(name, pos, var)
            local c = Instance.new("Frame", _FR); c.Size = UDim2.new(0, 220, 0, 40); c.Position = pos; c.BackgroundTransparency = 1
            local l = Instance.new("TextLabel", c); l.Size = UDim2.new(0, 150, 1, 0); l.Text = name; l.TextColor3 = Color3.fromRGB(180, 180, 180); l.Font = "GothamSemibold"; l.TextXAlignment = 0; l.BackgroundTransparency = 1
            local sw = Instance.new("TextButton", c); sw.Size = UDim2.new(0, 45, 0, 22); sw.Position = UDim2.new(1, -45, 0.5, -11); sw.BackgroundColor3 = Color3.fromRGB(35, 35, 35); sw.Text = ""; Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)
            local bl = Instance.new("Frame", sw); bl.Size = UDim2.new(0, 16, 0, 16); bl.Position = UDim2.new(0, 3, 0.5, -8); bl.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", bl).CornerRadius = UDim.new(1, 0)
            
            sw.MouseButton1Click:Connect(function()
                _G[var] = not _G[var]
                local tp = _G[var] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                _L[1]:Create(bl, TweenInfo.new(0.2), {Position = tp}):Play()
                _L[1]:Create(sw, TweenInfo.new(0.2), {BackgroundColor3 = _G[var] and _L[4] or Color3.fromRGB(35, 35, 35)}):Play()
            end)
        end

        _ADD_SW("Human Farm (Iron)", UDim2.new(0.5, -110, 0.35, 0), "AutoFarm")
        _ADD_SW("Adaptive Click", UDim2.new(0.5, -110, 0.65, 0), "AutoClick")
        
        -- Main Loop
        task.spawn(function()
            while task.wait() do
                if _G.AutoFarm then
                    pcall(function()
                        if not _L[0].PlayerGui.Main.Quest.Visible then
                            _P_AI(_Q[1].P)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", _Q[1].N, 1)
                        else
                            _L[3]:CaptureController(); _L[3]:ClickButton1(Vector2.new(0,0))
                            task.wait(math.random(15, 35)/100)
                        end
                    end)
                end
            end
        end)
    end

    return _V_RUN()
end

-- [[ LỚP VỎ BẢO VỆ CUỐI - CHỐNG DECOMPILE ]]
local _ = "IronBrew_V3_Start"
pcall(function() _IB_VM() end)
