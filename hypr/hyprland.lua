-- =============================================================================
--  __  __               _                 _   _               
-- |  \/  |_   _ _ __   | |    _   _  __ _| | | |   _   _  __ _ 
-- | |\/| | | | | '_ \  | |   | | | |/ _` | | | |  | | | |/ _` |
-- | |  | | |_| | |_) | | |___| |_| | (_| | | | |__| |_| | (_| |
-- |_|  |_|\__,_| .__/  |_____|\__,_|\__,_|_|_|_____\__,_|\__,_|
--              |_|                                             
-- Arch Linux - Custom Hyprland Configuration (API 0.55+ Lua Engine)
-- =============================================================================

--------------------------------------------------------------------------------
-- [1] PLATFORM / PERFORMANCE MONITORING
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

--------------------------------------------------------------------------------
-- [2] DEFAULT APPLICATIONS
--------------------------------------------------------------------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"
local browser     = "brave"

--------------------------------------------------------------------------------
-- [3] ENVIRONMENT VARIABLES (SYSTEM-WIDE & DARK MODE SETUP)
--------------------------------------------------------------------------------
-- System Interface UI Sizes
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force Native Dark Mode Everywhere (GTK & QT Core Applications)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("ADW_DISABLE_PORTAL", "1")

--------------------------------------------------------------------------------
-- [4] AUTOSTART ENGINE & DESKTOP PORTALS RECOVERY
--------------------------------------------------------------------------------
hl.on("hyprland.start", function () 
    -- Sincronizar D-Bus y Portales XDG al arranque (Corrige retrasos y fallas de Waybar)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk")

    -- Lanzar componentes del sistema de fondo
    hl.exec_cmd(terminal)
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar & hyprpaper")
end)

--------------------------------------------------------------------------------
-- [5] HARDWARE-ACCELERATED VISUAL LAYER RULES (WAYBAR BLUR EFFECT)
--------------------------------------------------------------------------------
-- Delega el efecto cristal esmerilado de Waybar directamente a la GPU
hl.layer_rule({
    name  = "blur",
    match = { namespace = "^waybar$" }
})

hl.layer_rule({
    name  = "ignorezero",
    match = { namespace = "^waybar$" }
})
--------------------------------------------------------------------------------
-- [6] LOOK AND FEEL (VISUAL CORE CONFIGURATION)
--------------------------------------------------------------------------------
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 2,
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
    
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

-- Default Curves & Springs
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- Animation Layout Mappings
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

--------------------------------------------------------------------------------
-- [7] INPUT & INTERACTION CONTROLS
--------------------------------------------------------------------------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = { natural_scroll = false },
    },
    dwindle   = { preserve_split = true },
    master    = { new_status = "master" },
    scrolling = { fullscreen_on_one_column = true },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

--------------------------------------------------------------------------------
-- [8] KEYBINDINGS REGISTRY (KEYMAPS)
--------------------------------------------------------------------------------
local mainMod = "SUPER"

-- Core System Shortcuts
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- Advanced Screencopy / Auditing Utilities (Saves file to Images & Syncs Clipboard)
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim - | tee ~/Imágenes/captura_$(date +'%Y%m%d_%H%M%S').png | wl-copy"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Imágenes/captura_$(date +'%Y%m%d_%H%M%S').png | wl-copy"))

-- Window Focus Management (Arrow Keys)
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspace Switching & Window Relocation
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special Scratchpad Workspaces (Sandbox / Floating Terminals)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspace Continuous Scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Window Manipulation (Drag & Resize)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Hardware Multimedia Keys (Locked and Repeating enabled for instant scrolling)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Media Player Remote Controllers
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------------------------------------------------------
-- [9] WINDOW ENGINE & XWAYLAND COMPATIBILITY RULES
--------------------------------------------------------------------------------
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})