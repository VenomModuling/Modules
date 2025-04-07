local players = game:GetService("Players")
local player = players.LocalPlayer
local BanService = loadstring(game:HttpGet("https://raw.githubusercontent.com/VenomModuling/Modules/refs/heads/main/Universal/BanService.luau"))()
local Admins = {
  "Davi1901lucas";
  "Luquinha_067"
}
local isAdmin = false
for i, v in next, Admins do
  if v == player.Name then
    isAdmin = true
  end
end
player.Chatted:Connect(function(msg)
		if msg:sub(1, 4) == "/ban" then
        if not isAdmin then return end
				local target = msg:sub(6)
				BanService:BanByIp(target)
		end
end)
