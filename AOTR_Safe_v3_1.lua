-- AOTR SAFE GUI v3.1
-- Roblox Studio LocalScript (interface demonstrativa)
-- NOT an AOTR exploit/automation. Toggles are UI-only.
-- No HTTP, loadstring, remote code, or data collection.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("AOTRSafe")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(17, 18, 22),
    panel = Color3.fromRGB(25, 26, 31),
    panel2 = Color3.fromRGB(35, 36, 42),
    red = Color3.fromRGB(190, 35, 48),
    white = Color3.fromRGB(240, 240, 245),
    gray = Color3.fromRGB(160, 162, 170),
    green = Color3.fromRGB(65, 190, 115)
}

local gui = Instance.new("ScreenGui")
gui.Name = "AOTRSafe"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(600, 390)
main.Position = UDim2.new(0.5, -300, 0.5, -195)
main.BackgroundColor3 = C.bg
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local outline = Instance.new("UIStroke", main)
outline.Color = C.red
outline.Thickness = 1.5

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
header.BorderSizePixel = 0
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -130, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "AOTR SAFE  |  GUI v3.1"
title.TextColor3 = C.white
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local function button(parent, text, size, pos, color)
    local b = Instance.new("TextButton")
    b.Size, b.Position = size, pos
    b.BackgroundColor3 = color or C.panel2
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = C.white
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    return b
end

local minimize = button(header, "—", UDim2.fromOffset(35, 30), UDim2.new(1, -80, 0, 8))
local close = button(header, "X", UDim2.fromOffset(35, 30), UDim2.new(1, -40, 0, 8), C.red)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 145, 1, -46)
sidebar.Position = UDim2.fromOffset(0, 46)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 13, 16)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -155, 1, -56)
content.Position = UDim2.fromOffset(150, 51)
content.BackgroundTransparency = 1
content.Parent = main

local pages = {}
local logs = {}
local settings = {Farm = false, Waves = false, Combat = false, MultiHit = false}
local function log(msg)
    table.insert(logs, os.date("%H:%M:%S") .. "  " .. tostring(msg))
    if #logs > 50 then table.remove(logs, 1) end
    print("[AOTR SAFE] " .. tostring(msg))
end

local function newPage(name)
    local p = Instance.new("Frame")
    p.Name = name
    p.Size = UDim2.fromScale(1, 1)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.Parent = content
    pages[name] = p
    return p
end

local function label(parent, text, pos, size, color)
    local l = Instance.new("TextLabel")
    l.Size = size or UDim2.new(1, -20, 0, 28)
    l.Position = pos
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.white
    l.Font = Enum.Font.Gotham
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

local function toggle(parent, caption, key, y)
    local b = button(parent, "", UDim2.new(1, -20, 0, 36), UDim2.fromOffset(10, y))
    local function refresh()
        b.Text = caption .. " : " .. (settings[key] and "ON" or "OFF")
        b.BackgroundColor3 = settings[key] and C.red or C.panel2
    end
    b.Activated:Connect(function()
        settings[key] = not settings[key]
        refresh()
        log(caption .. " " .. (settings[key] and "ativado (visual)" or "desativado"))
    end)
    refresh()
    return b
end

local home = newPage("Principal")
label(home, "Bem-vindo ao AOTR Safe", UDim2.fromOffset(10, 12), nil, C.white)
label(home, "Interface demonstrativa; não controla o AOTR.", UDim2.fromOffset(10, 48), nil, C.gray)
label(home, "Use as abas para visualizar as configurações.", UDim2.fromOffset(10, 80), nil, C.gray)

local farm = newPage("Farm")
label(farm, "FARM (somente estado visual)", UDim2.fromOffset(10, 10))
toggle(farm, "Farm", "Farm", 50)

local waves = newPage("Waves")
label(waves, "WAVES (somente estado visual)", UDim2.fromOffset(10, 10))
toggle(waves, "Waves", "Waves", 50)

local combat = newPage("Combate")
label(combat, "COMBATE (somente estado visual)", UDim2.fromOffset(10, 10))
toggle(combat, "Combate", "Combat", 50)

local mh = newPage("Multi Hit")
label(mh, "MULTI HIT — PRESETS VISUAIS", UDim2.fromOffset(10, 10))
toggle(mh, "Multi Hit", "MultiHit", 48)
label(mh, "Alvos por hit: 10", UDim2.fromOffset(10, 100))
label(mh, "Distância: 300–600", UDim2.fromOffset(10, 132))
label(mh, "Velocidade configurada: 500", UDim2.fromOffset(10, 164))
label(mh, "Estes valores não executam ataques.", UDim2.fromOffset(10, 210), nil, C.gray)

local perf = newPage("Desempenho")
label(perf, "MONITOR LOCAL", UDim2.fromOffset(10, 10))
local fpsLabel = label(perf, "FPS: calculando...", UDim2.fromOffset(10, 50))
local elapsedLabel = label(perf, "Tempo: 00:00", UDim2.fromOffset(10, 82))
local start = os.clock()
local frames, last = 0, os.clock()
local perfConn = RunService.RenderStepped:Connect(function()
    frames += 1
    local now = os.clock()
    if now - last >= 1 then
        fpsLabel.Text = "FPS aproximado: " .. frames
        frames = 0
        last = now
        local seconds = math.floor(now - start)
        elapsedLabel.Text = string.format("Tempo: %02d:%02d", math.floor(seconds/60), seconds%60)
    end
end)

local safety = newPage("Segurança")
label(safety, "AUDITORIA DA PRÓPRIA GUI", UDim2.fromOffset(10, 10))
label(safety, "HTTP externo: não usado", UDim2.fromOffset(10, 50), nil, C.green)
label(safety, "loadstring: não usado", UDim2.fromOffset(10, 82), nil, C.green)
label(safety, "Código remoto: não usado", UDim2.fromOffset(10, 114), nil, C.green)
label(safety, "Dados enviados: nenhum", UDim2.fromOffset(10, 146), nil, C.green)

local logPage = newPage("Logs")
label(logPage, "LOGS (últimos eventos)", UDim2.fromOffset(10, 10))
local logText = label(logPage, "GUI inicializada.", UDim2.fromOffset(10, 45), UDim2.new(1, -20, 1, -55), C.gray)
logText.TextYAlignment = Enum.TextYAlignment.Top
logText.TextWrapped = true

local tabs = {"Principal", "Farm", "Waves", "Combate", "Multi Hit", "Desempenho", "Segurança", "Logs"}
local function navigate(name)
    for pageName, p in pairs(pages) do p.Visible = (pageName == name) end
    log("Aba: " .. name)
    logText.Text = table.concat(logs, "\n")
end
for i, name in ipairs(tabs) do
    local b = button(sidebar, name, UDim2.new(1, -10, 0, 35), UDim2.fromOffset(5, 7+(i-1)*41))
    b.Activated:Connect(function() navigate(name) end)
end

local float = button(gui, "SAFE", UDim2.fromOffset(55, 55), UDim2.new(0, 18, 0.5, 0), C.red)
float.Visible = false
Instance.new("UICorner", float).CornerRadius = UDim.new(1, 0)
float.Activated:Connect(function() main.Visible = true; float.Visible = false end)
minimize.Activated:Connect(function() main.Visible = false; float.Visible = true end)

-- Arrastar cabeçalho (mouse/toque)
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

local function cleanup()
    perfConn:Disconnect()
    gui:Destroy()
end
close.Activated:Connect(cleanup)

navigate("Principal")
log("AOTR Safe GUI v3.1 carregada")
