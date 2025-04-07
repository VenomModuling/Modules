local players = game:GetService("Players")
local player = players.LocalPlayer
local BanService = loadstring(game:HttpGet("https://raw.githubusercontent.com/VenomModuling/Modules/refs/heads/main/Universal/BanService.luau"))()
local isAdmin = (table.find({"Lusquinha_067", "Davi1901lucas"}, player.Name) ~= nil) and true or false
player.Chatted:Connect(function(msg)
										if not isAdmin then return end
										if msg:sub(1, 4) == "/ban" then
																				local target = msg:sub(6)
																				BanService:BanByIp(target)
										end
end)
