local Module = {}
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
function Module.Goto(sp, position)
    local character = Player.Character
    if not character or not character.PrimaryPart then return end
    if not character.HumanoidRootPart then return end
    local hrp = character.PrimaryPart
    local distance = (hrp.Position - position).Magnitude
    local speed = sp
    local duration = distance / speed

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local goal = {CFrame = CFrame.new(position.X, hrp.Position.Y, position.Z)}
    local tween = TweenService:Create(hrp, tweenInfo, goal)
    
    tween:Play()
    return tween
end
function Module.waitForTween(tween)
    local completed = false

    tween.Completed:Connect(function()
        completed = true
    end)

    repeat
        task.wait()
    until completed
end
return Module
