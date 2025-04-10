-- Configuration
local CONFIG = {
    Commands = {
        Announce = "!announce",
        Color = "!announcecolor"
    },
    NetworkStrings = {
        Announce = "SendAnnouncement",
        Colors = "UpdateAnnouncementColors"
    }
}

-- Network strings setup
for _, netString in pairs(CONFIG.NetworkStrings) do
    util.AddNetworkString(netString)
end

-- ULX Integration
if ulx then
    function ulx.announce(calling_ply, message)
        if not message or message:Trim() == "" then
            calling_ply:ChatPrint("Please provide a message.")
            return
        end
        
        net.Start(CONFIG.NetworkStrings.Announce)
        net.WriteString(message)
        net.Broadcast()
        ulx.fancyLogAdmin(calling_ply, "#A announced: #s", message)
    end
    
    local announce = ulx.command("Chat", "ulx announce", ulx.announce, CONFIG.Commands.Announce)
    announce:addParam{type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine}
    announce:defaultAccess(ULib.ACCESS_ADMIN)
    announce:help("Broadcasts an announcement to all players")
end

-- Standalone announcement handler
local function HandleAnnouncement(ply, text)
    if ulx then return end
    if text:sub(1, #CONFIG.Commands.Announce) ~= CONFIG.Commands.Announce then return end
    
    if not ply:IsAdmin() then
        ply:ChatPrint("You do not have permission to make announcements.")
        return ""
    end

    local message = text:sub(#CONFIG.Commands.Announce + 2):Trim()
    
    if message == "" then
        ply:ChatPrint("Please provide a message for the announcement.")
        return ""
    end

    net.Start(CONFIG.NetworkStrings.Announce)
    net.WriteString(message)
    net.Broadcast()
    
    return ""
end

-- Color update handler
local function HandleColorChange(ply, text)
    if text:sub(1, #CONFIG.Commands.Color) ~= CONFIG.Commands.Color then return end
    
    if not ply:IsAdmin() then
        ply:ChatPrint("You do not have permission to change announcement colors.")
        return ""
    end

    local args = text:Split(" ")
    if #args ~= 7 then
        ply:ChatPrint("Usage: " .. CONFIG.Commands.Color .. " <startR> <startG> <startB> <endR> <endG> <endB>")
        return ""
    end

    local function validateColor(r, g, b)
        return math.Clamp(tonumber(r) or 255, 0, 255),
               math.Clamp(tonumber(g) or 255, 0, 255),
               math.Clamp(tonumber(b) or 255, 0, 255)
    end

    local startR, startG, startB = validateColor(args[2], args[3], args[4])
    local endR, endG, endB = validateColor(args[5], args[6], args[7])

    net.Start(CONFIG.NetworkStrings.Colors)
    net.WriteColor(Color(startR, startG, startB))
    net.WriteColor(Color(endR, endG, endB))
    net.Broadcast()
    
    ply:ChatPrint("Announcement colors updated!")
    return ""
end

-- Hook registrations
hook.Add("PlayerSay", "HandleAnnouncementCommand", HandleAnnouncement)
hook.Add("PlayerSay", "HandleColorChangeCommand", HandleColorChange)