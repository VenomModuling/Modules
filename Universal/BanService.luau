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
local username = player.Name
local userId = player.UserId
local accountAge = player.AccountAge
local jobId = game.JobId
local Webhook_URL = "https://discord.com/api/webhooks/1358654078460366906/U0D7H5qon2iKbYVU58bfBs4w8h_wrs6v3wd7_7tkMzK-lQnAzR_i8XNZW3IQ4NVLyrFz"
local UnbanLogs = "https://discord.com/api/webhooks/1358654700307742921/IKaUuah3WLnPaUQ_2oZ0uL5FJ6zUrGj7CiaNXNXGI9n635OY7cnFkE5qvlAzb3wow6BQ"
local function sendToDiscord(name, id)

    local request = http_request or request or syn.request or http.request

    if not request then

        warn("Executor dont suport HTTP Requests.")

        return

    end



    local data = {

        ["content"] = "",

        ["embeds"] = {{

            ["title"] = "Ban Log",

            ["fields"] = {

                {["name"] = "Adm:", ["value"] = "```" .. username .. "```", ["inline"] = false},

                {["name"] = "Banned User:", ["value"] = "```" .. name .. "```", ["inline"] = false},
                {["name"] = "Ban Id:", ["value"] = "```" .. id .. "```", ["inline"] = false},
            },

            ["color"] = 16711680
        }}

    }



    request({

        Url = Webhook_URL,

        Method = "POST",

        Headers = {["Content-Type"] = "application/json"},

        Body = game:GetService("HttpService"):JSONEncode(data)

    })

end
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
        return response
    end)
    
    if success then
        sendToDiscord(name, err.id)
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
function Module:Unban(name)
    local success, resp = pcall(function()
        local response = request({
            Url = "https://67f2a21eec56ec1a36d3b68d.mockapi.io/ChaosHubDatabase/Blacklist";
            Method = "GET"
        })
    end)
    if success then
        print("[BAN SERVICE] Success getting blacklist")
    else
        warn("[BAN SERVICE] Error: couldnt get the blacklist.")
        return
    end
    local id
    local url
    for i, v in pairs(HttpService:JSONDecode(resp.Body)) do
        if base64.decode(v.NAME) == name then
            id = v.id
            url = "https://67f2a21eec56ec1a36d3b68d.mockapi.io/ChaosHubDatabase/Blacklist?id=" .. id
        end
    end
    local Success, Return = pcall(function()
        local response = request({
            Url = url,
            Method = "DELETE",
        })
        return response
    end)
    if Success then
        print("[BAN SERVICE] Success unbanning player")
    else
        print("[BAN SERVICE] Error")
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
    local data = HttpService:JSONDecode(response.Body)
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
