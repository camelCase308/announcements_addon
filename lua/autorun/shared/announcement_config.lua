ANNOUNCEMENT = ANNOUNCEMENT or {}
ANNOUNCEMENT.Command = "!announce"
ANNOUNCEMENT.DefaultStartColor = Color(0, 0, 255) -- Blue
ANNOUNCEMENT.DefaultEndColor = Color(0, 0, 0)    -- Black

-- Configuration
ANNOUNCEMENT.Prefix = "[Announcement]"
ANNOUNCEMENT.Color = Color(255, 255, 0) -- Yellow color for announcements

-- Command Configuration
ANNOUNCEMENT.Commands = {
    ["!announce"] = true,
    ["!a"] = true,         -- Short alias
    ["/announce"] = true,  -- Slash command support
    ["!broadcast"] = true  -- Alternative command
}

-- Permission Settings
ANNOUNCEMENT.RequireAdmin = true      -- Require admin status
ANNOUNCEMENT.AllowSuperAdmin = true   -- Allow superadmins
ANNOUNCEMENT.AllowUserGroups = {      -- Additional allowed groups
    ["operator"] = true,
    ["moderator"] = true
}
