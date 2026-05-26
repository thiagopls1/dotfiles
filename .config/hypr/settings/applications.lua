return {
	terminal = "kitty",
	file_manager = "nautilus",
	browser = "firefox",
	steam = "env LD_PRELOAD=/usr/lib32/libextest.so mangohud /usr/bin/steam",
	mail = "GDK_BACKEND=x11 evolution",
	spotify = "spotify-launcher",
	discord = "discord",
	services = {
		idle_inhibit = "wayland-pipewie-idle-inhibit",
		easy_effects = "easyeffects -w",
		window_switcher = "hyprshell run",
		shell = "qs -c noctalia-shell",
		kde_connect = "kdeconnectd",
		screenshot = "flameshot",
		screenshot_cmd = "flameshot gui",
		openrgb = "openrgb -p Default --startminimized",
	},
}
