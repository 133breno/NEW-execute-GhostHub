-- Script Created By: João_Frango🐔

-- Serviços
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "LoadingGui"

-- Fundo
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(1,0,1,0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Texto de Porcentagem
local PercentText = Instance.new("TextLabel", Frame)
PercentText.Size = UDim2.new(0.2,0,0.05,0)
PercentText.Position = UDim2.new(0.4,0,0.45,0)
PercentText.Text = "Carregando... 0%"
PercentText.TextScaled = true
PercentText.TextColor3 = Color3.fromRGB(255,255,255)
PercentText.BackgroundTransparency = 1
PercentText.Font = Enum.Font.GothamBold

-- Barra de Progresso
local ProgressBarBG = Instance.new("Frame", Frame)
ProgressBarBG.Size = UDim2.new(0.4, 0, 0.03, 0)
ProgressBarBG.Position = UDim2.new(0.3, 0, 0.52, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBarBG.BorderSizePixel = 0
local UICornerBG = Instance.new("UICorner", ProgressBarBG)
UICornerBG.CornerRadius = UDim.new(1, 0)

local ProgressBar = Instance.new("Frame", ProgressBarBG)
ProgressBar.Size = UDim2.new(0,0,1,0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ProgressBar.BorderSizePixel = 0
local UICorner = Instance.new("UICorner", ProgressBar)
UICorner.CornerRadius = UDim.new(1, 0)

-- Simulação de carregamento
local percent = 0

task.spawn(function()
	while percent < 100 do
		percent += 1
		PercentText.Text = "Carregando... " .. percent .. "%"
		ProgressBar:TweenSize(UDim2.new(percent / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
		wait(0.05)
	end

	-- Remover tela de carregamento
	Frame:Destroy()

	-- Criar botão flutuante
	local MainBtn = Instance.new("TextButton", ScreenGui)
	MainBtn.Size = UDim2.new(0, 150, 0, 40)
	MainBtn.Position = UDim2.new(0.5, -75, 0.5, -20)
	MainBtn.Text = "Abrir Ghost Hub"
	MainBtn.TextColor3 = Color3.new(1, 1, 1)
	MainBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainBtn.TextScaled = true
	MainBtn.Font = Enum.Font.GothamBold
	local corner = Instance.new("UICorner", MainBtn)
	corner.CornerRadius = UDim.new(0, 8)

	-- Tornar arrastável
	local dragToggle = nil
	local dragSpeed = 0.1
	local dragStart, startPos

	local function updateInput(input)
		local delta = input.Position - dragStart
		local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		MainBtn.Position = pos
	end

	MainBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragToggle = true
			dragStart = input.Position
			startPos = MainBtn.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateInput(input)
		end
	end)

	-- Quando clicar, executa o script externo
	MainBtn.MouseButton1Click:Connect(function()
		pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"))()
		end)
	end)
end)
