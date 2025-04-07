--// Loading
print("[BAN SERVICE] Loading...")

--// Module and variables
local Module = {}
local IPUrl = base64.decode("aHR0cHM6Ly9pcGluZm8uaW8vanNvbg==")
local PendingRequests = base64.decode("aHR0cHM6Ly82N2YyZTYxMGVjNTZlYzFhMzZkNDgzOWUubW9ja2FwaS5pby9DaGFvc0h1YklwQmFuUmVxdWVzdHMvUmVxdWVzdHM=") -- Name
local Blacklist = base64.decode("aHR0cHM6Ly82N2YyYTIxZWVjNTZlYzFhMzZkM2I2OGQubW9ja2FwaS5pby9DaGFvc0h1YkRhdGFiYXNlL0JsYWNrbGlzdA==") -- NAME and IP
local HttpService = game:GetService("HttpService")
local request = request or http_request or http.request or syn and syn.request
local players = game:GetService("Players")
local player = players.LocalPlayer

--// Functions
function Module:BanByIp(name)
    local body = {
        Name = base64.encode(name);
    }
    
    local success, err = pcall(function()
        local response = request({
            Url = PendingRequests,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(body)
        })
    end)
    
    if success then
        print("[BAN SERVICE] Success requesting the ban.")
    else
        warn("[BAN SERVICE] Error requesting: " .. tostring(err))
    end
end

function Module:ConcludeBanByIp()
    local response = request({
        Url = IPUrl;
        Method = "GET"
    })
    local ip = HttpService:JSONDecode(response.Body).ip
    local body = {
        NAME = base64.encode(player.Name);
        IP = base64.encode(ip)
    }
    
    local success, err = pcall(function()
        local response = request({
            Url = Blacklist,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(body)
        })
    end)
    
    if success then
        print("[BAN SERVICE] Success requesting the ban.")
    else
        warn("[BAN SERVICE] Error requesting: " .. tostring(err))
    end
end
function Module:IsBanned()
    local request = request or http_request or http.request or syn and syn.request
    local response = request({
        Url = "https://67f2a21eec56ec1a36d3b68d.mockapi.io/ChaosHubDatabase/Blacklist";
        Method = "GET"
    })
    local IPUrl = base64.decode("aHR0cHM6Ly9pcGluZm8uaW8vanNvbg==")
    local resp = request({
        Url = IPUrl;
        Method = "GET"
    })
    local ip = game:GetService("HttpService"):JSONDecode(resp.Body).ip
    local data = game:GetService("HttpService"):JSONDecode(response.Body);
    for i,v in pairs(data) do
        if base64.decode(v.IP) == ip then
            return true;
        end
    end
end
function Module:IsPendingRequest()
    local response = request({
        Url = PendingRequests;
        Method = "GET"
    })
    local data = HttpService:JSONDecode(response.Body).ip
    for i, v in next, data do
        if base64.decode(v.Name) == player.Name then
            return true
        end
    end
end
--// Debug
print("[BAN SERVICE] Fully loaded!")

--// Returning module
return Module
