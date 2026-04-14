# Linux WallpaperEngine Controller

A lightweight Noctalia plugin to browse and apply `linux-wallpaperengine` wallpapers.

Use it directly from the bar and panel to switch wallpapers quickly, with per-screen control and simple playback options.

## Highlights

- Apply wallpapers per display or to all displays
- Quick search, filter, and sort in panel
- Per-wallpaper options (scaling, volume, mute, audio reactive)
- One-click engine reload/stop from bar menu

## Requirements

- [linux-wallpaperengine](https://github.com/Almamu/linux-wallpaperengine) installed and available in `PATH`
- Wallpaper Engine projects available in your Steam Workshop folder

## Quick Start

1. Open plugin settings and set `Wallpapers source folder`
2. Open the plugin panel from the bar icon
3. Select a wallpaper and click `Apply`

## IPC Commands

General usage:

```bash
qs ipc call plugin:linux-wallpaperengine-controller <command> [args...]
```

```bash
# Toggle panel on current screen
qs ipc call plugin:linux-wallpaperengine-controller toggle

# Apply wallpaper path to a specific screen
qs ipc call plugin:linux-wallpaperengine-controller apply eDP-1 ~/.local/share/Steam/steamapps/workshop/content/431960/1234567890

# Stop wallpaper on all screens (or pass a screen name)
qs ipc call plugin:linux-wallpaperengine-controller stop all

# Reload engine with current settings
qs ipc call plugin:linux-wallpaperengine-controller reload
```

## Basic Troubleshooting

- Check binary in PATH: `command -v linux-wallpaperengine`
- If panel shows folder error: verify `Wallpapers source folder` exists and contains wallpaper project folders
- If engine fails to start: recheck dependencies and GPU/OpenGL environment
- For runtime logs: start shell with debug: `NOCTALIA_DEBUG=1 qs -c noctalia-shell`

## Notes

- This plugin controls the `linux-wallpaperengine` process and does not ship wallpapers itself.
