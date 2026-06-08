local applications = require("settings.applications")

local ipc_call = "qs -c noctalia-shell ipc call"
local mainMod = "SUPER"
local mainModRel = "SUPER_L"

-- Noctalia Shell
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(ipc_call .. " launcher emoji"))
hl.bind(mainMod .. " + " .. mainModRel, hl.dsp.exec_cmd(ipc_call .. " launcher toggle"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(ipc_call .. " controlCenter toggle"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(ipc_call .. " settings toggle"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(ipc_call .. " lockScreen lock"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(ipc_call .. " sessionMenu toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc_call .. " plugin:clipboard toggle"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(ipc_call .. " plugin:linux-wallpaperengine-controller toggle"))

-- Noctalia Shell - Quick Actions
hl.bind(mainMod .. " + f1", hl.dsp.exec_cmd(ipc_call .. " notifications toggleDND"))
hl.bind(mainMod .. " + f2", hl.dsp.exec_cmd(ipc_call .. " powerProfile cycle"))
hl.bind(mainMod .. " + f3", hl.dsp.exec_cmd(ipc_call .. " idleInhibitor toggle"))
hl.bind(mainMod .. " + f4", hl.dsp.exec_cmd(ipc_call .. " nightLight toggle"))

-- Applications bindings
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(applications.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(applications.file_manager))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(applications.services.screenshot_cmd))
hl.bind("Print", hl.dsp.exec_cmd(applications.services.screenshot_cmd))

-- Window Bindings
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + f4", hl.dsp.window.close())
hl.bind(mainMod .. " + C", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace bindings
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ workspace = "e-1" }))

-- Layout bindings
hl.bind(mainMod .. " + equal", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + minus", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.layout("move -col"))

hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.layout("swapcol l"))

-- Media bindings
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc_call .. " brightness increase"), { locked = true, repeating = true })
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(ipc_call .. " brightness decrease"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc_call .. " media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc_call .. " media playPause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc_call .. " media playPause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc_call .. " media previous"), { locked = true })
