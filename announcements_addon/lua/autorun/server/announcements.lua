-- announcements.lua

util.AddNetworkString("SendAnnouncement")

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