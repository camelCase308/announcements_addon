ANNOUNCEMENT = {
    Network = {
        Strings = {
            Announce = "SendAnnouncement",
            Colors = "UpdateAnnouncementColors"
        }
    },
    
    Visual = {
        Prefix = "[Announcement]",
        Colors = {
            Prefix = Color(255, 100, 100),
            Message = Color(255, 255, 255),
            Console = {
                Success = Color(0, 255, 0),
                Info = Color(255, 255, 0)
            }
        },
        Gradient = {
            Start = Color(0, 0, 255),
            End = Color(0, 0, 0)
        }
    },
    
    Sound = {
        Enabled = true,
        Path = "buttons/button15.wav"
    },
    
    Commands = {
        Primary = "!announce",
        Aliases = {
            ["!announce"] = true,
            ["!a"] = true,
            ["/announce"] = true,
            ["!broadcast"] = true
        }
    },
    
    Permissions = {
        RequireAdmin = true,
        AllowSuperAdmin = true,
        AllowUserGroups = {
            ["operator"] = true,
            ["moderator"] = true
        }
    },
    
    Logging = {
        Enabled = true,
        Format = "[Announcements] %s: %s"
    }
}

-- Prevent override after initialization
if SERVER then
    hook.Add("Initialize", "AnnouncementConfig", function()
        local protected = table.Copy(ANNOUNCEMENT)
        setmetatable(ANNOUNCEMENT, {
            __newindex = function() end,
            __index = protected
        })
    end)
end
