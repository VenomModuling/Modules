--// Module
local Module = {}
--// Debug
print("[UNIVERSAL SERVICE] Loading...")
--// Variables
local players = game:GetService("Players")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
--// Functions
function Module:Teleport(position)
										hrp.Position = position
end
function Module:MoveTo(position)
										humanoid:MoveTo(position)
end
function Module:ChangeWalkSpeed(speed)
										humanoid.WalkSpeed = speed
end
function Module:ChangeGravity(gravity)
										workspace.Gravity = gravity
end
function Module:ChangeJumpPower(power)
										humanoid.JumpPower = power
end
function Module:Vector3ToArray(position)
										return {position.X, position.Y, position.Z}
end
function Module:ArrayToVector3(array)
										return Vector3.new(unpack(array))
end
function Module:CFrameToArray(cframe)
										local ar = {}
										for i, v in next, {cframe:components()} do
																				ar[i] = v
										end
										return ar
end
function Module:ArrayToCFrame(array)
										return CFrame.new(unpack(array))
end
--// Returning module and debugging
print("[UNIVERSAL SERVICE]")
return Module
