-- Script de AutoFarm para Restaurant Tycoon 2 com botão de ativação

local autofarmEnabled = false

-- Função para automatizar a coleta de dinheiro
local function collectMoney()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "Money" then
            v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end

-- Função para automatizar a cozinha
local function autoCook()
    local Cooking = game.Players.LocalPlayer.PlayerScripts.CookingNew
    local CookProgress = require(Cooking.CookProgress)
    CookProgress.run = function(...)
        local args = {...}
        args[3] = 0
        return CookProgress.run(unpack(args))
    end
end

-- Loop para executar as funções de autofarm
spawn(function()
    while true do
        if autofarmEnabled then
            collectMoney()
            autoCook()
        end
        wait(1) -- Espera 1 segundo antes de repetir
    end
end)

-- Cria um botão para ativar/desativar o autofarm
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F then
        autofarmEnabled = not autofarmEnabled
        print("AutoFarm " .. (autofarmEnabled and "Ativado" or "Desativado"))
    end
end)
