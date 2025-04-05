util.AddNetworkString("SendAnnouncement")

hook.Add("Initialize", "AnnouncementsInit", function()
    MsgC(Color(0, 255, 0), "\n[Announcements] Addon initialized!\n")
    MsgC(Color(255, 255, 0), "Available commands: !announce, !a, /announce, !broadcast\n\n")
end)

-- Remove conflicting configuration
ANNOUNCEMENT = ANNOUNCEMENT or {}

-- Command handler
hook.Add("PlayerSay", "HandleAnnouncementCommand", function(ply, text)
    local args = string.Split(text, " ")
    local cmd = args[1]:lower()
    
    local validCommands = {
        ["!announce"] = true,
        ["!a"] = true,
        ["/announce"] = true,
        ["!broadcast"] = true
    }
    
    if validCommands[cmd] then
        if not ply:IsAdmin() then
            ply:ChatPrint("You don't have permission to use this command!")
            return ""
        end
        
        table.remove(args, 1)
        local message = table.concat(args, " ")
        
        if #message > 0 then
            net.Start("SendAnnouncement")
            net.WriteString(message)
            net.Broadcast()
            
            print(string.format("[Announcements] %s used %s: %s", 
                ply:Nick(), cmd, message))
        end
        
        return ""
    end
end)
