local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- GUI PRINCIPAL
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- IMAGE LABEL BOTÃO REDONDO
local openButton = Instance.new("ImageLabel", screenGui)
openButton.Size = UDim2.new(0, 60, 0, 60)
openButton.Position = UDim2.new(0, 20, 0, 20)
openButton.BackgroundTransparency = 1
openButton.Image = "rbxassetid://72721797847451"
openButton.Name = "OpenButton"

-- UICORNER E UISTROKE PARA O BOTÃO REDONDO
local uiCorner = Instance.new("UICorner", openButton)
uiCorner.CornerRadius = UDim.new(0, 30)
local uiStroke = Instance.new("UIStroke", openButton)
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Transparency = 0.8

-- TEXTO NO IMAGE LABEL
local buttonText = Instance.new("TextLabel", openButton)
buttonText.Size = UDim2.new(1, 0, 1, 0)
buttonText.BackgroundTransparency = 1
buttonText.Text = "UniverseX"
buttonText.TextColor3 = Color3.new(1, 1, 1)
buttonText.Font = Enum.Font.SourceSansBold
buttonText.TextSize = 14
buttonText.TextStrokeTransparency = 0.7
buttonText.TextStrokeColor3 = Color3.new(0, 0, 0)
buttonText.TextWrapped = true
buttonText.TextYAlignment = Enum.TextYAlignment.Center
buttonText.TextXAlignment = Enum.TextXAlignment.Center

-- TORNAR O IMAGE LABEL ARRASTÁVEL
local draggingButton = false
local dragInputButton = nil
local dragStartButton = Vector2.zero
local startPosButton = UDim2.new(0, 0, 0, 0)

openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingButton = true
        dragStartButton = input.Position
        startPosButton = openButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingButton = false
            end
        end)
    end
end)

openButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputButton = input
    end
end)

RunService.RenderStepped:Connect(function()
    if draggingButton and dragInputButton then
        local delta = dragInputButton.Position - dragStartButton
        openButton.Position = UDim2.new(
            startPosButton.X.Scale,
            startPosButton.X.Offset + delta.X,
            startPosButton.Y.Scale,
            startPosButton.Y.Offset + delta.Y
        )
    end
end)

-- FRAME PRINCIPAL
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

local mainFrameCorner = Instance.new("UICorner", mainFrame)
mainFrameCorner.CornerRadius = UDim.new(0, 15)

--- ADICIONANDO BORDA AZUL ESCURA E ANIMADA AO mainFrame ---
local mainFrameStroke = Instance.new("UIStroke", mainFrame)
mainFrameStroke.Thickness = 2
mainFrameStroke.Transparency = 0
mainFrameStroke.Color = Color3.fromRGB(0, 50, 150)

local lightBlue = Color3.fromRGB(0, 150, 255)
local darkBlue = Color3.fromRGB(0, 50, 150)

local tweenInfo = TweenInfo.new(
    2,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.InOut,
    -1,
    true,
    0
)

local colorTween = TweenService:Create(mainFrameStroke, tweenInfo, {Color = lightBlue})
colorTween:Play()

-- CABEÇALHO COM TEXTOS
local headerFrame = Instance.new("Frame", mainFrame)
headerFrame.Size = UDim2.new(1, 0, 0, 35)
headerFrame.BackgroundTransparency = 1
headerFrame.Position = UDim2.new(0, 0, 0, 0)

local universeXLabel = Instance.new("TextLabel", headerFrame)
universeXLabel.Size = UDim2.new(0, 120, 1, 0)
universeXLabel.Position = UDim2.new(0, 10, 0, 0)
universeXLabel.BackgroundTransparency = 1
universeXLabel.Text = "UniverseX"
universeXLabel.TextColor3 = Color3.new(1, 0, 0)
universeXLabel.Font = Enum.Font.SourceSansBold
universeXLabel.TextSize = 18
universeXLabel.TextXAlignment = Enum.TextXAlignment.Left

local byLabel = Instance.new("TextLabel", headerFrame)
byLabel.Size = UDim2.new(0, 170, 1, 0)
byLabel.Position = UDim2.new(0, 135, 0, 0)
byLabel.BackgroundTransparency = 1
byLabel.Text = "By Guest-and-ValueX"
byLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
byLabel.Font = Enum.Font.SourceSans
byLabel.TextSize = 14
byLabel.TextXAlignment = Enum.TextXAlignment.Left
byLabel.TextYAlignment = Enum.TextYAlignment.Center

local gameNameLabel = Instance.new("TextLabel", headerFrame)
gameNameLabel.Size = UDim2.new(0, 150, 1, 0)
gameNameLabel.Position = UDim2.new(0, 290, 0, 0)
gameNameLabel.BackgroundTransparency = 1
gameNameLabel.Text = "Residence Massacre"
gameNameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
gameNameLabel.Font = Enum.Font.SourceSans
gameNameLabel.TextSize = 12
gameNameLabel.TextXAlignment = Enum.TextXAlignment.Left
gameNameLabel.TextYAlignment = Enum.TextYAlignment.Center

local hue = 0
RunService.RenderStepped:Connect(function(delta)
    hue = (hue + delta) % 1
    local color = Color3.fromHSV(hue, 1, 1)
    universeXLabel.TextColor3 = color
end)

-- LÓGICA PARA ARRASTAR O mainFrame PELO headerFrame
local draggingMainFrame = false
local dragInputMainFrame = nil
local dragStartMainFrame = Vector2.zero
local startPosMainFrame = UDim2.new(0, 0, 0, 0)

headerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMainFrame = true
        dragStartMainFrame = input.Position
        startPosMainFrame = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMainFrame = false
            end
        end)
    end
end)

headerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMainFrame = input
    end
end)

RunService.RenderStepped:Connect(function()
    if draggingMainFrame and dragInputMainFrame then
        local delta = dragInputMainFrame.Position - dragStartMainFrame
        mainFrame.Position = UDim2.new(
            startPosMainFrame.X.Scale,
            startPosMainFrame.X.Offset + delta.X,
            startPosMainFrame.Y.Scale,
            startPosMainFrame.Y.Offset + delta.Y
        )
    end
end)

-- BOTÃO DE FECHAR (X)
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20

local closeCorner = Instance.new("UICorner", closeButton)
closeCorner.CornerRadius = UDim.new(0, 8)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)
closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end)

-- LÓGICA PARA ABRIR/FECHAR GUI E CONTROLAR O MOUSE
local mouseMonitorConnection = nil
local isRightMouseDown = false
local currentKey = Enum.KeyCode.G
local isSelectingKey = false
local isGUIOpen = false

local camera = Workspace.CurrentCamera
local lastMousePos = nil
local sensitivity = 0.008
local cameraConnection = nil

local function updateMouseBehavior()
    if isGUIOpen then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        player.CameraMinZoomDistance = 0.5
        player.CameraMaxZoomDistance = 128
        if not mouseMonitorConnection then
            mouseMonitorConnection = RunService.Heartbeat:Connect(function()
                if isGUIOpen and UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
                end
            end)
        end
    else
        if mouseMonitorConnection then
            mouseMonitorConnection:Disconnect()
            mouseMonitorConnection = nil
        end
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        player.CameraMinZoomDistance = 0.5
        player.CameraMaxZoomDistance = 128
    end
end

local function toggleGUI()
    isGUIOpen = not isGUIOpen
    mainFrame.Visible = isGUIOpen
    openButton.Visible = not isGUIOpen
    updateMouseBehavior()
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 and isGUIOpen then
        isRightMouseDown = true
        lastMousePos = UserInputService:GetMouseLocation()
        if not cameraConnection then
            cameraConnection = UserInputService.InputChanged:Connect(function(inputChanged)
                if inputChanged.UserInputType == Enum.UserInputType.MouseMovement and isRightMouseDown then
                    local currentMousePos = UserInputService:GetMouseLocation()
                    if lastMousePos then
                        local deltaX = (currentMousePos.X - lastMousePos.X) * sensitivity
                        local deltaY = (currentMousePos.Y - lastMousePos.Y) * sensitivity
                        local currentCFrame = camera.CFrame
                        local yaw = -deltaX
                        local pitch = -deltaY
                        local yRotation = CFrame.Angles(0, yaw, 0)
                        local xRotation = CFrame.Angles(pitch, 0, 0)
                        camera.CFrame = currentCFrame * yRotation * xRotation
                    end
                    lastMousePos = currentMousePos
                end
            end)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isRightMouseDown = false
        lastMousePos = nil
        if cameraConnection then
            cameraConnection:Disconnect()
            cameraConnection = nil
        end
    end
end)

local clickStartedOnButton = false
openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local mousePosition = input.Position
        local buttonAbsolutePosition = openButton.AbsolutePosition
        local buttonAbsoluteSize = openButton.AbsoluteSize
        if mousePosition.X >= buttonAbsolutePosition.X and mousePosition.X <= buttonAbsolutePosition.X + buttonAbsoluteSize.X and
            mousePosition.Y >= buttonAbsolutePosition.Y and mousePosition.Y <= buttonAbsolutePosition.Y + buttonAbsoluteSize.Y then
            clickStartedOnButton = true
        else
            clickStartedOnButton = false
        end
    end
end)

openButton.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and clickStartedOnButton then
        local mousePosition = input.Position
        local buttonAbsolutePosition = openButton.AbsolutePosition
        local buttonAbsoluteSize = openButton.AbsoluteSize
        if mousePosition.X >= buttonAbsolutePosition.X and mousePosition.X <= buttonAbsolutePosition.X + buttonAbsoluteSize.X and
            mousePosition.Y >= buttonAbsolutePosition.Y and mousePosition.Y <= buttonAbsolutePosition.Y + buttonAbsoluteSize.Y then
            toggleGUI()
        end
    end
    clickStartedOnButton = false
end)

closeButton.MouseButton1Click:Connect(function()
    toggleGUI()
end)

-- ABA LATERAL
local sideMenu = Instance.new("Frame", mainFrame)
sideMenu.Size = UDim2.new(0, 100, 1, -35)
sideMenu.Position = UDim2.new(0, 0, 0, 35)
sideMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
local sideMenuCorner = Instance.new("UICorner", sideMenu)
sideMenuCorner.CornerRadius = UDim.new(0, 15)

-- CONTEÚDO DAS ABAS
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -100, 1, -35)
contentFrame.Position = UDim2.new(0, 100, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local contentFrameCorner = Instance.new("UICorner", contentFrame)
contentFrameCorner.CornerRadius = UDim.new(0, 12)

local function createTabButton(name, order)
    local button = Instance.new("TextButton", sideMenu)
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, 0, (order - 1) * 45)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 10)
    button.TextStrokeTransparency = 0.8
    button.TextStrokeColor3 = Color3.new(0, 0, 0)
    return button
end

local autoFarmTab = createTabButton("AutoFarm", 1)
local teleportTab = createTabButton("Teleport", 2)
local miscTab = createTabButton("Misc", 3)
local espTab = createTabButton("ESP", 4)

local autoFarmFrame = Instance.new("Frame", contentFrame)
autoFarmFrame.Size = UDim2.new(1, 0, 1, 0)
autoFarmFrame.BackgroundTransparency = 1
autoFarmFrame.Visible = true

local teleportFrame = Instance.new("Frame", contentFrame)
teleportFrame.Size = UDim2.new(1, 0, 1, 0)
teleportFrame.BackgroundTransparency = 1
teleportFrame.Visible = false

-- SCROLLING FRAME PARA A ABA MISC
local miscScrollingFrame = Instance.new("ScrollingFrame", contentFrame)
miscScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
miscScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
miscScrollingFrame.BackgroundTransparency = 1
miscScrollingFrame.Visible = false
miscScrollingFrame.ScrollBarThickness = 8
miscScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
miscScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
miscScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

-- UIListLayout para organizar os botões verticalmente
local miscListLayout = Instance.new("UIListLayout", miscScrollingFrame)
miscListLayout.Padding = UDim.new(0, 10)
miscListLayout.SortOrder = Enum.SortOrder.LayoutOrder
miscListLayout.FillDirection = Enum.FillDirection.Vertical
miscListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
miscListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local espFrame = Instance.new("Frame", contentFrame)
espFrame.Size = UDim2.new(1, 0, 1, 0)
espFrame.BackgroundTransparency = 1
espFrame.Visible = false

local keyButton = Instance.new("TextButton", miscScrollingFrame)
keyButton.Size = UDim2.new(0, 150, 0, 30)
keyButton.Position = UDim2.new(0, 20, 0, 20)
keyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyButton.TextColor3 = Color3.new(1, 1, 1)
keyButton.Font = Enum.Font.SourceSansBold
keyButton.TextSize = 16
keyButton.Text = "Set Key: " .. currentKey.Name
keyButton.LayoutOrder = 1
local keyBtnCorner = Instance.new("UICorner", keyButton)
keyBtnCorner.CornerRadius = UDim.new(0, 8)

keyButton.MouseButton1Click:Connect(function()
    isSelectingKey = true
    keyButton.Text = "Press a Key..."
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if isSelectingKey and input.UserInputType == Enum.UserInputType.Keyboard then
        currentKey = input.KeyCode
        isSelectingKey = false
        keyButton.Text = "Set Key: " .. currentKey.Name
        print("Nova tecla de atalho: " .. currentKey.Name)
    elseif input.KeyCode == currentKey and not isSelectingKey then
        toggleGUI()
    end
end)

local function showTab(frame)
    for _, f in ipairs(contentFrame:GetChildren()) do
        if f:IsA("Frame") or f:IsA("ScrollingFrame") then
            f.Visible = false
        end
    end
    frame.Visible = true
end

autoFarmTab.MouseButton1Click:Connect(function() showTab(autoFarmFrame) end)
teleportTab.MouseButton1Click:Connect(function() showTab(teleportFrame) end)
miscTab.MouseButton1Click:Connect(function() showTab(miscScrollingFrame) end)
espTab.MouseButton1Click:Connect(function() showTab(espFrame) end)

local function createTeleportButton(parent, text, position, order)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 200, 0, 35)
    btn.Position = UDim2.new(0, 20, 0, (order - 1) * 45 + 20)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = text
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 10)
    btn.TextStrokeTransparency = 0.7
    btn.TextStrokeColor3 = Color3.new(0, 0, 0)
    btn.MouseButton1Click:Connect(function()
        local character = Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(position)
        end
    end)
    return btn
end

createTeleportButton(teleportFrame, "Living Room", Vector3.new(-35, 8, -47), 1)
createTeleportButton(teleportFrame, "Room", Vector3.new(-31, 24, -73), 2)
createTeleportButton(teleportFrame, "Front - Fuel Tank", Vector3.new(-80, 4, -115), 3)
createTeleportButton(teleportFrame, "Fuel Tank", Vector3.new(-80, 5, -130), 4)
createTeleportButton(teleportFrame, "Bathroom", Vector3.new(-33, 24, -53), 5)

--- Lógica ESP ---
local espMutantEnabled = false
local espItemEnabled = false
local espPlayersEnabled = false
local activeHighlights = {}

local ITEM_NAMES_FOR_ESP = {
    "Battery",
    "BloxyCola",
    "Wrench"
}

local function createHighlight(instance, color, name)
    local highlight = Instance.new("Highlight")
    highlight.Name = name or "ESP_Highlight"
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = color
    highlight.Adornee = instance
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = screenGui
    return highlight
end

local function removeHighlight(instance)
    if activeHighlights[instance] then
        activeHighlights[instance]:Destroy()
        activeHighlights[instance] = nil
    end
end

local function updateMutantESP()
    local mutant = Workspace:FindFirstChild("Mutant") or ReplicatedStorage:FindFirstChild("Mutant")
    if espMutantEnabled and mutant then
        if not activeHighlights[mutant] then
            local highlight = createHighlight(mutant, Color3.new(1, 0, 0), "MutantESP")
            activeHighlights[mutant] = highlight
        end
    else
        removeHighlight(mutant)
    end
end

local function getESPHandle(instance)
    if not instance then return nil end
    if instance:IsA("Part") and instance.Name == "Handle" then
        local current = instance.Parent
        while current and current ~= game do
            if table.find(ITEM_NAMES_FOR_ESP, current.Name) then
                return instance
            end
            current = current.Parent
        end
    end
    if (instance:IsA("Model") or instance:IsA("Tool")) and table.find(ITEM_NAMES_FOR_ESP, instance.Name) then
        local handle = instance:FindFirstChild("Handle")
        if handle and handle:IsA("Part") then
            return handle
        end
    end
    if instance:IsA("Model") or instance:IsA("Folder") or (instance:IsA("Part") and instance.Name == "Spot") then
        for _, child in ipairs(instance:GetChildren()) do
            local handle = getESPHandle(child)
            if handle then
                return handle
            end
        end
    end
    return nil
end

local function handleItemHighlight(targetHandle, enable)
    if enable and targetHandle then
        if not activeHighlights[targetHandle] then
            local highlight = createHighlight(targetHandle, Color3.new(0, 1, 0), "ItemESP")
            activeHighlights[targetHandle] = highlight
        end
    else
        if activeHighlights[targetHandle] then
            removeHighlight(targetHandle)
        end
    end
end

local function updateItemESP()
    if not espItemEnabled then
        for instance, highlight in pairs(activeHighlights) do
            if highlight.Name == "ItemESP" then
                removeHighlight(instance)
            end
        end
        return
    end

    local foundHandles = {}
    local function findAndCollectHandles(parentInstance)
        for _, descendant in ipairs(parentInstance:GetDescendants()) do
            local handle = getESPHandle(descendant)
            if handle then
                foundHandles[handle] = true
            end
        end
    end

    findAndCollectHandles(Workspace)
    findAndCollectHandles(player.Backpack)
    if player.Character then
        findAndCollectHandles(player.Character)
    end

    local itemSpotsFolder = Workspace:FindFirstChild("ItemSpots")
    if itemSpotsFolder then
        findAndCollectHandles(itemSpotsFolder)
    end

    for handle, _ in pairs(foundHandles) do
        handleItemHighlight(handle, true)
    end

    for instance, highlight in pairs(activeHighlights) do
        if highlight.Name == "ItemESP" and not foundHandles[instance] then
            removeHighlight(instance)
        end
    end
end

local function updatePlayersESP()
    for instance, highlight in pairs(activeHighlights) do
        if highlight.Name == "PlayerESP" then
            highlight:Destroy()
            activeHighlights[instance] = nil
        end
    end

    if espPlayersEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp and not activeHighlights[hrp] then
                    local highlight = createHighlight(hrp, Color3.new(0, 0, 1), "PlayerESP")
                    activeHighlights[hrp] = highlight
                end
            end
        end
    end
end

local espMutantButton = Instance.new("TextButton", espFrame)
espMutantButton.Size = UDim2.new(0, 250, 0, 40)
espMutantButton.Position = UDim2.new(0, 20, 0, 20)
espMutantButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espMutantButton.TextColor3 = Color3.new(1, 1, 1)
espMutantButton.Font = Enum.Font.SourceSansBold
espMutantButton.TextSize = 20
espMutantButton.Text = "ESP Mutant disabled"

local espMutantBtnCorner = Instance.new("UICorner", espMutantButton)
espMutantBtnCorner.CornerRadius = UDim.new(0, 10)

espMutantButton.MouseButton1Click:Connect(function()
    espMutantEnabled = not espMutantEnabled
    espMutantButton.Text = espMutantEnabled and "ESP Mutant activated" or "ESP Mutant disabled"
    updateMutantESP()
end)

local espItemButton = Instance.new("TextButton", espFrame)
espItemButton.Size = UDim2.new(0, 250, 0, 40)
espItemButton.Position = UDim2.new(0, 20, 0, 70)
espItemButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espItemButton.TextColor3 = Color3.new(1, 1, 1)
espItemButton.Font = Enum.Font.SourceSansBold
espItemButton.TextSize = 20
espItemButton.Text = "ESP Item disabled"

local espItemBtnCorner = Instance.new("UICorner", espItemButton)
espItemBtnCorner.CornerRadius = UDim.new(0, 10)

espItemButton.MouseButton1Click:Connect(function()
    espItemEnabled = not espItemEnabled
    espItemButton.Text = espItemEnabled and "ESP Item activated" or "ESP Item disabled"
    updateItemESP()
end)

local espPlayersButton = Instance.new("TextButton", espFrame)
espPlayersButton.Size = UDim2.new(0, 250, 0, 40)
espPlayersButton.Position = UDim2.new(0, 20, 0, 120)
espPlayersButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espPlayersButton.TextColor3 = Color3.new(1, 1, 1)
espPlayersButton.Font = Enum.Font.SourceSansBold
espPlayersButton.TextSize = 20
espPlayersButton.Text = "ESP Players disabled"

local espPlayersBtnCorner = Instance.new("UICorner", espPlayersButton)
espPlayersBtnCorner.CornerRadius = UDim.new(0, 10)

espPlayersButton.MouseButton1Click:Connect(function()
    espPlayersEnabled = not espPlayersEnabled
    espPlayersButton.Text = espPlayersEnabled and "ESP Players activated" or "ESP Players disabled"
    updatePlayersESP()
end)

local infiniteStaminaEnabled = false
local staminaScript = nil
local defaultStamValue = 10
local infiniteStamValue = 50000

local function setupStamina()
    if player.Character then
        staminaScript = player.Character:FindFirstChild("Sprint")
        if staminaScript then
            local stamValue = staminaScript:FindFirstChild("Stam")
            if stamValue then
                if not infiniteStaminaEnabled then
                    stamValue.Value = defaultStamValue
                    stamValue:SetAttribute("Max", defaultStamValue)
                else
                    stamValue.Value = infiniteStamValue
                    stamValue:SetAttribute("Max", infiniteStamValue)
                end
            end
        end
    end
end

player.CharacterAdded:Connect(function(character)
    setupStamina()
end)

local infiniteStaminaButton = Instance.new("TextButton", miscScrollingFrame)
infiniteStaminaButton.Size = UDim2.new(0, 250, 0, 40)
infiniteStaminaButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infiniteStaminaButton.TextColor3 = Color3.new(1, 1, 1)
infiniteStaminaButton.Font = Enum.Font.SourceSansBold
infiniteStaminaButton.TextSize = 20
infiniteStaminaButton.Text = "Infinite Stamina: Disabled"
infiniteStaminaButton.LayoutOrder = 2

local infiniteStamBtnCorner = Instance.new("UICorner", infiniteStaminaButton)
infiniteStamBtnCorner.CornerRadius = UDim.new(0, 10)

infiniteStaminaButton.MouseButton1Click:Connect(function()
    infiniteStaminaEnabled = not infiniteStaminaEnabled
    setupStamina()
    if staminaScript and staminaScript:FindFirstChild("Stam") then
        local stamValue = staminaScript.Stam
        if infiniteStaminaEnabled then
            stamValue.Value = infiniteStamValue
            stamValue:SetAttribute("Max", infiniteStamValue)
            infiniteStaminaButton.Text = "Infinite Stamina: Enabled"
            print("Infinite Stamina Ativada!")
        else
            stamValue.Value = defaultStamValue
            stamValue:SetAttribute("Max", defaultStamValue)
            infiniteStaminaButton.Text = "Infinite Stamina: Disabled"
            print("Infinite Stamina Desativada!")
        end
    else
        print("Erro: 'Sprint' script ou 'Stam' NumberValue não encontrado.")
        infiniteStaminaButton.Text = "Stamina Error!"
    end
end)

local function monitorWorkspaceAndPlayers()
    local function connectItemESPListeners(instance)
        instance.DescendantAdded:Connect(function(descendant)
            if espItemEnabled then
                local handle = getESPHandle(descendant)
                if handle then
                    handleItemHighlight(handle, true)
                end
            end
        end)
        instance.DescendantRemoving:Connect(function(descendant)
            if activeHighlights[descendant] and activeHighlights[descendant].Name == "ItemESP" then
                handleItemHighlight(descendant, false)
            else
                for handle, highlight in pairs(activeHighlights) do
                    if highlight.Name == "ItemESP" and handle:IsDescendantOf(descendant) then
                        handleItemHighlight(handle, false)
                    end
                end
            end
        end)
    end

    connectItemESPListeners(Workspace)
    connectItemESPListeners(player.Backpack)
    
    if player.Character then
        connectItemESPListeners(player.Character)
    end
    player.CharacterAdded:Connect(function(character)
        connectItemESPListeners(character)
        if espPlayersEnabled then
            updatePlayersESP()
        end
    end)
    
    Workspace.ChildAdded:Connect(function(child)
        if child.Name == "Mutant" and espMutantEnabled then
            updateMutantESP()
        end
    end)
    Workspace.ChildRemoved:Connect(function(child)
        if child.Name == "Mutant" then
            removeHighlight(child)
        end
    end)

    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(character)
            if espPlayersEnabled and newPlayer ~= player then
                updatePlayersESP()
            end
        end)
    end)

    Players.PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer.Character then
            local hrp = leavingPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                removeHighlight(hrp)
            end
        end
    end)
end

monitorWorkspaceAndPlayers()
updateMouseBehavior()
updateItemESP()

--- Lógica do botão SafeZone ---
local safeZoneActive = false
local noclipConnection = nil

local safeZoneButton = Instance.new("TextButton", autoFarmFrame)
safeZoneButton.Size = UDim2.new(0, 150, 0, 40)
safeZoneButton.Position = UDim2.new(0, 20, 0, 20)
safeZoneButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
safeZoneButton.TextColor3 = Color3.new(1, 1, 1)
safeZoneButton.Font = Enum.Font.SourceSansBold
safeZoneButton.TextSize = 18
safeZoneButton.Text = "SafeZone: Disabled"

local safeZoneBtnCorner = Instance.new("UICorner", safeZoneButton)
safeZoneBtnCorner.CornerRadius = UDim.new(0, 10)

local leaveHouseLabel = Instance.new("TextLabel", autoFarmFrame)
leaveHouseLabel.Size = UDim2.new(0, 150, 0, 30)
leaveHouseLabel.Position = UDim2.new(0, 180, 0, 25)
leaveHouseLabel.BackgroundTransparency = 1
leaveHouseLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
leaveHouseLabel.Font = Enum.Font.SourceSans
leaveHouseLabel.TextSize = 14
leaveHouseLabel.Text = "Leave the house"
leaveHouseLabel.TextXAlignment = Enum.TextXAlignment.Left

local function setNoclip(enabled)
    if enabled then
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

safeZoneButton.MouseButton1Click:Connect(function()
    safeZoneActive = not safeZoneActive
    
    if safeZoneActive then
        safeZoneButton.Text = "SafeZone: Enabled"
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            hrp.CFrame = CFrame.new(Vector3.new(-14, 30, -122))
            setNoclip(true)
            print("SafeZone Ativada! Noclip ativado e teleportado para (-14, 30, -122).")
        else
            warn("Personagem ou HumanoidRootPart não encontrado para SafeZone.")
            safeZoneActive = false
            safeZoneButton.Text = "SafeZone: Disabled"
        end
    else
        safeZoneButton.Text = "SafeZone: Disabled"
        setNoclip(false)
        print("SafeZone Desativada! Noclip desativado.")
    end
end)

--- Lógica do botão Noclip ---
local noclipActive = false
local noclipMiscConnection = nil

local noclipButton = Instance.new("TextButton", miscScrollingFrame)
noclipButton.Size = UDim2.new(0, 150, 0, 40)
noclipButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
noclipButton.TextColor3 = Color3.new(1, 1, 1)
noclipButton.Font = Enum.Font.SourceSansBold
noclipButton.TextSize = 18
noclipButton.Text = "Noclip: Disabled"
noclipButton.LayoutOrder = 3

local noclipBtnCorner = Instance.new("UICorner", noclipButton)
noclipBtnCorner.CornerRadius = UDim.new(0, 10)

local noclipWarningLabel = Instance.new("TextLabel", miscScrollingFrame)
noclipWarningLabel.Size = UDim2.new(0, 150, 0, 30)
noclipWarningLabel.Position = UDim2.new(0, 180, 0, 0) -- Will be adjusted by UIListLayout
noclipWarningLabel.BackgroundTransparency = 1
noclipWarningLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
noclipWarningLabel.Font = Enum.Font.SourceSans
noclipWarningLabel.TextSize = 14
noclipWarningLabel.Text = "Not recommended"
noclipWarningLabel.TextXAlignment = Enum.TextXAlignment.Left
noclipWarningLabel.LayoutOrder = 3

local function setNoclipMisc(enabled)
    if enabled then
        if not noclipMiscConnection then
            noclipMiscConnection = RunService.Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    else
        if noclipMiscConnection then
            noclipMiscConnection:Disconnect()
            noclipMiscConnection = nil
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

noclipButton.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    
    if noclipActive then
        noclipButton.Text = "Noclip: Enabled"
        setNoclipMisc(true)
        print("Noclip Ativado!")
    else
        noclipButton.Text = "Noclip: Disabled"
        setNoclipMisc(false)
        print("Noclip Desativado!")
    end
end)

--- Lógica do botão Notification ---
local notificationEnabled = false
local notificationSoundIds = {18317665126, 7383525713, 17582299860, 17208361335}
local notificationConnection = nil

local notificationButton = Instance.new("TextButton", miscScrollingFrame)
notificationButton.Size = UDim2.new(0, 150, 0, 40)
notificationButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
notificationButton.TextColor3 = Color3.new(1, 1, 1)
notificationButton.Font = Enum.Font.SourceSansBold
notificationButton.TextSize = 16
notificationButton.Text = "Notification: Disabled"
notificationButton.LayoutOrder = 4

local notificationBtnCorner = Instance.new("UICorner", notificationButton)
notificationBtnCorner.CornerRadius = UDim.new(0, 10)

local function createNotification()
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 200, 0, 50)
    notificationFrame.Position = UDim2.new(1, 0, 0.1, 0)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notificationFrame.BackgroundTransparency = 0.2
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = screenGui

    local notificationCorner = Instance.new("UICorner", notificationFrame)
    notificationCorner.CornerRadius = UDim.new(0, 8)

    local notificationText = Instance.new("TextLabel", notificationFrame)
    notificationText.Size = UDim2.new(1, -10, 1, -10)
    notificationText.Position = UDim2.new(0, 5, 0, 5)
    notificationText.BackgroundTransparency = 1
    notificationText.Text = "Spawned Entity"
    notificationText.TextColor3 = Color3.new(1, 1, 1)
    notificationText.Font = Enum.Font.SourceSansBold
    notificationText.TextSize = 18
    notificationText.TextXAlignment = Enum.TextXAlignment.Left

    local soundId = notificationSoundIds[math.random(1, #notificationSoundIds)]
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Volume = (soundId == 18317665126) and 2 or 1
    sound.Parent = screenGui
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)

    local slideIn = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(1, -210, 0.1, 0)})
    slideIn:Play()
    slideIn.Completed:Connect(function()
        wait(3)
        local slideOut = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Position = UDim2.new(1, 0, 0.1, 0)})
        slideOut:Play()
        slideOut.Completed:Connect(function()
            notificationFrame:Destroy()
        end)
    end)
end

local function setupNotificationListener()
    if notificationEnabled then
        if not notificationConnection then
            notificationConnection = Workspace.ChildAdded:Connect(function(child)
                if child.Name == "Mutant" then
                    createNotification()
                end
            end)
        end
    else
        if notificationConnection then
            notificationConnection:Disconnect()
            notificationConnection = nil
        end
    end
end

notificationButton.MouseButton1Click:Connect(function()
    notificationEnabled = not notificationEnabled
    notificationButton.Text = notificationEnabled and "Notification: Enabled" or "Notification: Disabled"
    setupNotificationListener()
    print(notificationEnabled and "Notificações Ativadas!" or "Notificações Desativadas!")
end)

--- Lógica do botão Infinite Flashlight ---
local infiniteFlashlightEnabled = false
local defaultBatteryValue = 100
local infiniteBatteryValue = 50000

local function setupFlashlightBattery()
    if player.Character then
        local flashlight = player.Character:FindFirstChild("Flashlight")
        if flashlight then
            local battery = flashlight:FindFirstChild("Battery")
            if battery and battery:IsA("NumberValue") then
                if infiniteFlashlightEnabled then
                    battery.Value = infiniteBatteryValue
                    battery:SetAttribute("Max", infiniteBatteryValue)
                else
                    battery.Value = defaultBatteryValue
                    battery:SetAttribute("Max", defaultBatteryValue)
                end
            end
        end
    end
end

player.CharacterAdded:Connect(function(character)
    setupFlashlightBattery()
    character.ChildAdded:Connect(function(child)
        if child.Name == "Flashlight" and infiniteFlashlightEnabled then
            local battery = child:WaitForChild("Battery", 5)
            if battery and battery:IsA("NumberValue") then
                battery.Value = infiniteBatteryValue
                battery:SetAttribute("Max", infiniteBatteryValue)
            end
        end
    end)
end)

local infiniteFlashlightButton = Instance.new("TextButton", miscScrollingFrame)
infiniteFlashlightButton.Size = UDim2.new(0, 250, 0, 40)
infiniteFlashlightButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infiniteFlashlightButton.TextColor3 = Color3.new(1, 1, 1)
infiniteFlashlightButton.Font = Enum.Font.SourceSansBold
infiniteFlashlightButton.TextSize = 20
infiniteFlashlightButton.Text = "Infinite Flashlight: Disabled"
infiniteFlashlightButton.LayoutOrder = 5

local infiniteFlashlightBtnCorner = Instance.new("UICorner", infiniteFlashlightButton)
infiniteFlashlightBtnCorner.CornerRadius = UDim.new(0, 10)

infiniteFlashlightButton.MouseButton1Click:Connect(function()
    infiniteFlashlightEnabled = not infiniteFlashlightEnabled
    setupFlashlightBattery()
    if player.Character and player.Character:FindFirstChild("Flashlight") then
        local flashlight = player.Character.Flashlight
        local battery = flashlight:FindFirstChild("Battery")
        if battery and battery:IsA("NumberValue") then
            if infiniteFlashlightEnabled then
                battery.Value = infiniteBatteryValue
                battery:SetAttribute("Max", infiniteBatteryValue)
                infiniteFlashlightButton.Text = "Infinite Flashlight: Enabled"
                print("Infinite Flashlight Ativada!")
            else
                battery.Value = defaultBatteryValue
                battery:SetAttribute("Max", defaultBatteryValue)
                infiniteFlashlightButton.Text = "Infinite Flashlight: Disabled"
                print("Infinite Flashlight Desativada!")
            end
        else
            print("Erro: 'Battery' NumberValue não encontrado na lanterna.")
            infiniteFlashlightButton.Text = "Flashlight Error!"
        end
    else
        print("Erro: Lanterna não encontrada no personagem.")
        infiniteFlashlightButton.Text = "Flashlight Error!"
    end
end)

--- Lógica do botão Infinite Breath ---
local infiniteBreathEnabled = false
local defaultBreathValue = 10
local infiniteBreathValue = 50000

local function setupBreath()
    if player.Character then
        local breath = player.Character:FindFirstChild("Breath")
        if breath and breath:IsA("NumberValue") then
            if infiniteBreathEnabled then
                breath.Value = infiniteBreathValue
                breath:SetAttribute("Max", infiniteBreathValue)
            else
                breath.Value = defaultBreathValue
                breath:SetAttribute("Max", defaultBreathValue)
            end
        end
    end
end

player.CharacterAdded:Connect(function(character)
    setupBreath()
    character.ChildAdded:Connect(function(child)
        if child.Name == "Breath" and infiniteBreathEnabled then
            local breath = child
            if breath and breath:IsA("NumberValue") then
                breath.Value = infiniteBreathValue
                breath:SetAttribute("Max", infiniteBreathValue)
            end
        end
    end)
end)

local infiniteBreathButton = Instance.new("TextButton", miscScrollingFrame)
infiniteBreathButton.Size = UDim2.new(0, 250, 0, 40)
infiniteBreathButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infiniteBreathButton.TextColor3 = Color3.new(1, 1, 1)
infiniteBreathButton.Font = Enum.Font.SourceSansBold
infiniteBreathButton.TextSize = 20
infiniteBreathButton.Text = "Infinite Breath: Disabled"
infiniteBreathButton.LayoutOrder = 6

local infiniteBreathBtnCorner = Instance.new("UICorner", infiniteBreathButton)
infiniteBreathBtnCorner.CornerRadius = UDim.new(0, 10)

local infiniteBreathWarningLabel = Instance.new("TextLabel", miscScrollingFrame)
infiniteBreathWarningLabel.Size = UDim2.new(0, 150, 0, 30)
infiniteBreathWarningLabel.Position = UDim2.new(0, 280, 0, 0) -- Will be adjusted by UIListLayout
infiniteBreathWarningLabel.BackgroundTransparency = 1
infiniteBreathWarningLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
infiniteBreathWarningLabel.Font = Enum.Font.SourceSans
infiniteBreathWarningLabel.TextSize = 14
infiniteBreathWarningLabel.Text = "Not recommended"
infiniteBreathWarningLabel.TextXAlignment = Enum.TextXAlignment.Left
infiniteBreathWarningLabel.LayoutOrder = 6

infiniteBreathButton.MouseButton1Click:Connect(function()
    infiniteBreathEnabled = not infiniteBreathEnabled
    setupBreath()
    if player.Character and player.Character:FindFirstChild("Breath") then
        local breath = player.Character.Breath
        if breath and breath:IsA("NumberValue") then
            if infiniteBreathEnabled then
                breath.Value = infiniteBreathValue
                breath:SetAttribute("Max", infiniteBreathValue)
                infiniteBreathButton.Text = "Infinite Breath: Enabled"
                print("Infinite Breath Ativada!")
            else
                breath.Value = defaultBreathValue
                breath:SetAttribute("Max", defaultBreathValue)
                infiniteBreathButton.Text = "Infinite Breath: Disabled"
                print("Infinite Breath Desativada!")
            end
        else
            print("Erro: 'Breath' NumberValue não encontrado no personagem.")
            infiniteBreathButton.Text = "Breath Error!"
        end
    else
        print("Erro: Breath não encontrado no personagem.")
        infiniteBreathButton.Text = "Breath Error!"
    end
end)

