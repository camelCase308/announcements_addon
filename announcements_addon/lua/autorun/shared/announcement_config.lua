ANNOUNCEMENT = ANNOUNCEMENT or {}

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
