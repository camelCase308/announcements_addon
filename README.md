# Garry's Mod Announcements Addon

A simple yet powerful announcements system for Garry's Mod servers with fancy chat effects and ULX integration.

## Features

- Custom chat announcements with fade effects
- Color transitions (black to blue) with 5-second duration
- Multiple command aliases (!announce, !a, /announce, !broadcast)
- ULX integration (if available)
- Permission-based system
- Network-optimized

## Installation

1. Download the addon
2. Place it in your server's `garrysmod/addons` folder
3. Restart your server

## Usage

### Standard Commands
- `!announce <message>` - Send an announcement
- `!a <message>` - Short version
- `/announce <message>` - Slash command version
- `!broadcast <message>` - Alternative command

### ULX Commands
If ULX is installed:
- `ulx announce <message>` - Send announcement through ULX
- Access through ULX menu system

## Permissions

- Requires admin status by default
- Configurable through `announcement_config.lua`
- ULX permissions if ULX is installed

## Configuration

Edit `lua/autorun/shared/announcement_config.lua` to customize:
- Command prefixes
- Colors
- Permission groups
- Announcement prefix

## License

MIT License - Feel free to use and modify as needed.
