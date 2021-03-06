--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")

-- leave notifications to another notification daemon
--local _dbus = dbus; dbus = nil
local naughty = require("naughty")
--dbus = _dbus

local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

naughty.config.defaults.opacity = 0.9;
naughty.config.defaults.bg = "#ffffff";
naughty.config.defaults.fg = "#353535";
naughty.config.defaults.icon_size = 64;

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

--run_once({ "urxvtd", "unclutter -root" }) -- entries must be separated by commas

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = os.getenv("TERMINAL") or "lxterminal"
local editor       = os.getenv("EDITOR") or "vim"
local browser      = "firefox"
local filemanager  = "thunar"
local scrlocker    = "xlock -mousemotion +description -mode blank -bg black -fg grey30"
local spplaying = false

-- icon fix
beautiful.notification_icon_size = "32x32"
beautiful.notification_max_height = "32"


--naughty.config.default_preset.timeout          = 5
--naughty.config.default_preset.position         = "top_right"
--naughty.config.default_preset.margin           = 10
---naughty.config.default_preset.height           = 50
---naughty.config.default_preset.width            = 100
--naughty.config.default_preset.gap              = 1
--naughty.config.default_preset.ontop            = true
--naughty.config.default_preset.icon_size        = 16
--naughty.config.default_preset.fg               = beautiful.fg_focus
--naughty.config.default_preset.bg               = beautiful.bg_normal
--naughty.config.presets.normal.border_color     = beautiful.fg_focus
--naughty.config.default_preset.border_width     = 2
--naughty.config.default_preset.hover_timeout    = nil


awful.util.terminal = terminal
awful.util.tagnames = { "web", "hax", "code", "rsch", "lec" , "misc"}
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/theme.lua", os.getenv("HOME")))
-- }}}

-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart }
}
local myexitmenu = {
    { "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
    { "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
    { "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
    { "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
    { "shutdown", "poweroff", menubar.utils.lookup_icon("system-shutdown") }
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "terminal", terminal },
        { "browser", browser },
        { "file manager", filemanager },
        -- other triads can be put here
    },
    after = {
        { "Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome32.png" },
        { "Exit", myexitmenu, menubar.utils.lookup_icon("system-shutdown") },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = my_table.join(

    -- Non-empty tag browsing
    awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "Tab",
    function ()
        awful.client.focus.byidx(1)
        if awful.client.ismarked() then
            awful.screen.focus_relative(-1)
            awful.client.getmarked()
        end
        if client.focus then
            client.focus:raise()
        end
        awful.client.togglemarked()
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey            }, "o", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "=",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "-",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey,           }, "`", function () awful.layout.inc(-1)                end,
              {description = "select next", group = "layout"}),

    awful.key({ modkey, "Shift" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- awesome controls
    awful.key({ modkey }, "Escape", function () awful.util.mymainmenu:show() end,
        {description = "show main menu", group = "awesome"}),
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    -- custom helpers
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey }, "t", function () awful.spawn(filemanager) end,
        {description = "open file manager", group = "launcher"}),
    awful.key({ modkey }, "b", function () awful.spawn(browser) end,
        {description = "run browser", group = "launcher"}),
    awful.key({ }, "XF86LaunchA", function () awful.spawn("/opt/dynalist/dynalist") end,
        {description = "typora", group = "launcher"}),
    awful.key({ modkey }, "XF86LaunchA", function () awful.spawn("zotero") end,
        {description = "zotero", group = "launcher"}),
    awful.key({ }, "XF86LaunchB", function () awful.spawn("lxterminal -e htop") end,
        {description = "show htop", group = "launcher"}),
    awful.key({ }, "XF86Tools", function () awful.spawn("/usr/bin/mendeleydesktop") end,
        {description = "show readings", group = "launcher"}),
    awful.key({ }, "XF86Launch5", function () awful.spawn("thunar /tank/readings") end,
        {description = "show readings", group = "launcher"}),
    awful.key({ }, "XF86Launch6", function () awful.spawn("thunar /tank/courses") end,
        {description = "show courses", group = "launcher"}),
    awful.key({ }, "XF86Launch7", function () awful.spawn("thunar /tank/tablet") end,
        {description = "show courses", group = "launcher"}),

    -- screenshot
    awful.key({ modkey }, "XF86Eject", function () awful.spawn("/usr/bin/i3-scrot -d") end,
        {description = "capture a screenshot", group = "hotkeys"}),
    awful.key({"Control" }, "XF86Eject", function () awful.spawn("/usr/bin/i3-scrot -w") end,
        {description = "capture a screenshot of active window", group = "hotkeys"}),
    awful.key({"Shift" }, "XF86Eject", function () awful.util.spawn_with_shell("sleep 0.2 && /usr/bin/i3-scrot -s") end,
        {description = "capture a screenshot of selection", group = "hotkeys"}),

    -- audio control
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn("pulseaudio-ctl up")
        naughty.notify({ title = "Volume", text = "up", icon = "/usr/share/icons/Arc/apps/32/multimedia-volume-control.png", timeout = 0.5 }) end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn("pulseaudio-ctl down")
        naughty.notify({ title = "Volume", text = "down", icon = "/usr/share/icons/Arc/apps/32/multimedia-volume-control.png", timeout = 0.5 }) end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute", function () awful.spawn("pulseaudio-ctl mute")
        naughty.notify({ title = "Volume", text = "mute/unmute", icon = "/usr/share/icons/Arc/apps/32/multimedia-volume-control.png", timeout = 0.5 }) end,
        {description = "toggle mute", group = "hotkeys"}),

    -- media control
    awful.key({ }, "XF86AudioPrev", function () awful.spawn("playerctl previous")
        naughty.notify({ title = "Media Player", text = "previous", icon = "/usr/share/icons/Arc/actions/24/gtk-media-previous-ltr.png", timeout = 0.5 }) end,
        {description = "play previous", group = "hotkeys"}),
    awful.key({ }, "XF86AudioNext", function () awful.spawn("playerctl next")
        naughty.notify({ title = "Media Player", text = "next", icon = "/usr/share/icons/Arc/actions/24/gtk-media-next-ltr.png", timeout = 0.5 }) end,
        {description = "play next", group = "hotkeys"}),
    awful.key({ }, "XF86AudioPlay", function () awful.spawn("playerctl play-pause")
        naughty.notify({ title = "Media Player", text = "play", icon = "/usr/share/icons/Arc/actions/24/gtk-media-play-ltr.png", timeout = 0.5 }) end,
        {description = "play/pause", group = "hotkeys"}),

    -- X screen locker
    awful.key({ modkey }, "F1", function () os.execute(scrlocker) end,
              {description = "lock screen", group = "hotkeys"}),

    -- menubar
    awful.key({ modkey }, "space", function () awful.spawn("/usr/bin/rofi -show drun -modi window,drun,run,find:~/.config/rofi/finder.sh") end,
              {description = "launch rofi", group = "launcher"}),

    -- prompt
    awful.key({ modkey }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"})

)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    -- awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
    --           {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift"   }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
    --           {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
       function (c)
           c.maximized = not c.maximized
           c:raise()
       end ,
       {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- set galculator free
    { rule = { name = "galculator" },
      properties = { floating = true } },

    -- Set Firefox to always map on the first tag on screen 1.
    { rule = { class = "firefox" },
      -- properties = { screen = 1, tag = awful.util.tagnames[1] } },
      properties = { tag = awful.util.tagnames[1] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 2, function() c:kill() end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 16}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = true})
-- end)

-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end

client.connect_signal("property::maximized", border_adjust)
client.connect_signal("focus", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("~/.config/awesome/autorun.sh")
