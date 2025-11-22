-- Discord Rich Presence
-- Edit the values below to match your Discord application and assets.
local appId = 475148313816186 -- Discord Application ID
local assetName = "your_banner_image" -- name of the large image asset in your Discord app
local assetText = "Your Roleplay Server Name" -- tooltip text for the asset
local discordLink = "https://discord.gg/vKtwK6kSWb" -- Discord server invite link
local serverIP = GetCurrentServerEndpoint() -- server endpoint (used for direct connect)

-- Server information shown in presence
local serverInfo = {
    name = "Your Roleplay Server Name",
    description = "Your new home in Los Santos",
    features = {
        "Realistic roleplay",
        "Active community",
        "Regular events",
        "Custom jobs & systems"
    }
}

-- Update Discord Rich Presence
local function UpdatePresence()
    local playerName = GetPlayerName(PlayerId())
    local playerId = GetPlayerServerId(PlayerId())

    -- Count active players
    local players = 0
    local maxPlayers = GetConvarInt("sv_maxClients", 8)
    for _, id in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(id) then
            players = players + 1
        end
    end

    -- Pick a random server feature for variety
    local randomFeature = serverInfo.features[math.random(1, #serverInfo.features)]

    -- Set Discord app & assets
    SetDiscordAppId(tostring(appId))
    SetDiscordRichPresenceAsset(assetName)
    SetDiscordRichPresenceAssetText(assetText)

    -- Buttons: direct join and Discord invite
    local joinUrl = "fivem://connect/" .. serverIP
    local discordUrl = discordLink
    SetDiscordRichPresenceAction(0, "🎮 Join Server", joinUrl)
    SetDiscordRichPresenceAction(1, "💬 Discord", discordUrl)

    -- Presence text (player, feature, player count)
    local presenceText = string.format("👤 %s [%d] | 🌍 %s | 👥 %d/%d players", 
        playerName,
        playerId,
        randomFeature,
        players,
        maxPlayers
    )
    SetRichPresence(presenceText)
end

-- Initialize when player becomes active
Citizen.CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            Citizen.Wait(2000) -- wait briefly for Discord initialization
            UpdatePresence()
            break
        end
        Citizen.Wait(1000)
    end
end)

-- Update on spawn
AddEventHandler('playerSpawned', function()
    Citizen.Wait(2000)
    UpdatePresence()
end)

-- Periodic updates for dynamic presence
Citizen.CreateThread(function()
    while true do
        if NetworkIsPlayerActive(PlayerId()) then
            UpdatePresence()
        end
        Citizen.Wait(15000) -- update every 15 seconds
    end
end)

-- Debug commands
RegisterCommand('checkpresence', function()
    print('Discord App ID: ' .. appId)
    print('Server IP: ' .. serverIP)
    print('Discord Link: ' .. discordLink)
    print('Join URL: fivem://connect/' .. serverIP)
    print('Active players: ' .. #GetActivePlayers())
    UpdatePresence()
end, false)

RegisterCommand('resetpresence', function()
    SetDiscordAppId(tostring(appId))
    Citizen.Wait(1000)
    UpdatePresence()
end, false)

