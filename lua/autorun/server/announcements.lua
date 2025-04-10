-- announcements.lua

util.AddNetworkString("SendAnnouncement")
util.AddNetworkString("UpdateAnnouncementColors")

-- ULX Command Registration
if ulx then
    function ulx.announce(calling_ply, message)
        net.Start("SendAnnouncement")
        net.WriteString(message)
        net.Broadcast()
        ulx.fancyLogAdmin(calling_ply, "#A announced: #s", message)
    end
    local announce = ulx.command("Chat", "ulx announce", ulx.announce, "!announce")
    announce:addParam{type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine}
    announce:defaultAccess(ULib.ACCESS_ADMIN)
    announce:help("Broadcasts an announcement to all players")
end

-- Original chat command handler (fallback for non-ULX servers)
local function HandleAnnouncement(ply, text)
    -- Only process if ULX is not present
    if ulx then return end
    
    if string.sub(text, 1, #ANNOUNCEMENT.Command) ~= ANNOUNCEMENT.Command then return end
    
    if not ply:IsAdmin() then
        ply:ChatPrint("You do not have permission to make announcements.")
        return ""
    end

    local message = string.sub(text, #ANNOUNCEMENT.Command + 2)
    
    if message and message ~= "" then
        net.Start("SendAnnouncement")
        net.WriteString(message)
        net.Broadcast()
    else
        ply:ChatPrint("Please provide a message for the announcement.")
    end
    
    return ""
end

hook.Add("PlayerSay", "HandleAnnouncementCommand", HandleAnnouncement)

-- Add new function to handle color updates
function UpdateAnnouncementColors(ply, startColor, endColor)
    net.Start("UpdateAnnouncementColors")
    net.WriteColor(startColor)
    net.WriteColor(endColor)
    net.Broadcast()
end

-- Add chat command for color updating
local function HandleColorChange(ply, text)
    if string.sub(text, 1, 13) ~= "!announcecolor" then return end
    
    if not ply:IsAdmin() then
        ply:ChatPrint("You do not have permission to change announcement colors.")
        return ""
    end

    -- Simple command format: !announcecolor <startR> <startG> <startB> <endR> <endG> <endB>
    local args = string.Split(text, " ")
    if #args == 7 then
        local startColor = Color(tonumber(args[2]), tonumber(args[3]), tonumber(args[4]))
        local endColor = Color(tonumber(args[5]), tonumber(args[6]), tonumber(args[7]))
        UpdateAnnouncementColors(ply, startColor, endColor)
        ply:ChatPrint("Announcement colors updated!")
    else
        ply:ChatPrint("Usage: !announcecolor <startR> <startG> <startB> <endR> <endG> <endB>")
    end
    
    return ""
end

hook.Add("PlayerSay", "HandleColorChangeCommand", HandleColorChange)