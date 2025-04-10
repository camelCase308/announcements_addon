# Stylish Announcements Addon

A sleek and modern announcement system for Garry's Mod servers that displays messages with style.

## Features

- Modular design with client/server separation
- Command registration system with multiple aliases
- Protected configuration system
- Enhanced permission management
- Gradient color support with real-time updates
- Sound notification system
- Comprehensive logging system
- ULX integration (if installed)

## Commands

Default command aliases:
- `!announce <message>` - Primary command
- `!a <message>` - Short alias
- `/announce <message>` - Slash command
- `!broadcast <message>` - Alternative command
- `ulx announce <message>` - ULX version (if installed)

## Configuration

The addon uses a centralized configuration system in `lua/autorun/shared/announcement_config.lua`:

```lua
ANNOUNCEMENT = {
    Network      - Network string configuration
    Visual       - Colors, prefixes, and gradient settings
    Sound        - Notification sound settings
    Commands     - Command aliases and prefixes
    Permissions  - Access control settings
    Logging      - Console output configuration
}
```

## Installation

1. Copy the addon to your server's addons folder
2. Restart your server or change map
3. Edit configuration if needed (optional)
4. Ensure proper permissions are set

## Technical Details

- Protected configuration system prevents runtime modifications
- Network optimization for client/server communication
- Modular codebase for easy maintenance
- Enhanced error handling and validation

## Credits

Created by camelCase
Version 2.0