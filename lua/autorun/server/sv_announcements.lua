local ADDON = ADDON or {}
ADDON.Commands = {}

-- Network setup
util.AddNetworkString("SendAnnouncement")

-- Command registration system
function ADDON:RegisterCommand(cmd, callback)
    self.Commands[cmd:lower()] = callback
end

-- Message broadcaster
function ADDON:Broadcast(message, sender)
    if not message or message:Trim() == "" then return false end
    
    net.Start("SendAnnouncement")
    net.WriteString(message)
    net.Broadcast()
    
    MsgC(Color(0, 255, 0), 
        string.format("[Announcements] %s: %s\n", 
        IsValid(sender) and sender:Nick() or "Console",
        message))
        
    return true
end

-- Register default announcement command
local function HandleAnnouncement(ply, message)
    if not IsValid(ply) or not ply:IsAdmin() then
        if IsValid(ply) then
            ply:ChatPrint("You don't have permission to use this command!")
        end
        return false
    end
    
    return ADDON:Broadcast(message, ply)
end

-- Register all command variants
local commands = {
    "!announce",
    "!a",
    "/announce",
    "!broadcast"
}

for _, cmd in ipairs(commands) do
    ADDON:RegisterCommand(cmd, HandleAnnouncement)
end

-- Command handler
hook.Add("PlayerSay", "HandleAnnouncementCommand", function(ply, text)
    local args = string.Split(text, " ")
    local cmd = args[1]:lower()
    
    if ADDON.Commands[cmd] then
        table.remove(args, 1)
        local message = table.concat(args, " ")
        
        if ADDON.Commands[cmd](ply, message) then
            return ""
        end
    end
end)

-- Initialization
hook.Add("Initialize", "AnnouncementsInit", function()
    MsgC(Color(0, 255, 0), "\n[Announcements] Addon initialized!\n")
    MsgC(Color(255, 255, 0), "Available commands: " .. table.concat(commands, ", ") .. "\n\n")
end)
