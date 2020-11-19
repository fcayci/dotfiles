c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']

c.content.javascript.enabled = True
c.content.autoplay = False
c.content.pdfjs = True

c.editor.command = ["/usr/bin/kitty", "/usr/bin/nvim", "{}"]

c.tabs.position = 'left'
c.tabs.width = '10%'
c.tabs.favicons.scale = 0.9
c.tabs.background = True
c.tabs.select_on_remove = "prev"
c.tabs.title.format = '{audio}{index}: {current_title}'
c.tabs.last_close = 'close'
c.tabs.mode_on_change = 'restore'
c.tabs.show = 'multiple'

c.completion.shrink = True
c.completion.scrollbar.width = 0
c.completion.scrollbar.padding = 0

c.confirm_quit = ["downloads"]

c.url.default_page = "about:blank"

c.hints.auto_follow = 'always'
c.hints.auto_follow_timeout = 400
c.hints.mode = 'number'

config.unbind("<ctrl+tab>")
config.bind("<ctrl+tab>", "tab-next")
config.bind("<ctrl+shift+tab>", "tab-prev")

# Bindings for normal mode
config.bind(',m', 'spawn mpv --force-window=immediate {url}')
config.bind(',f', 'spawn firefox {url}')
config.bind(',t', 'spawn --userscript tureng')

config.bind(',m', 'spawn ~/.local/bin/umpv {url}')
config.bind(',M', 'hint links spawn ~/.local/bin/umpv {hint-url}')
config.bind(';M', 'hint --rapid links spawn ~/.local/bin/umpv {hint-url}')

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
c.aliases = {
    "w": "session-save",
    "wq": "quit --save",
    "mpv": "spawn -d mpv --force-window=immediate {url}",
    "nicehash": "spawn --userscript nicehash",
    "pass": "spawn -d pass -c",
}

# Background color of unselected tabs.
c.colors.tabs.even.bg = "silver"
c.colors.tabs.odd.bg = "gainsboro"

# Foreground color of unselected tabs.
c.colors.tabs.even.fg = "#666666"
c.colors.tabs.odd.fg = c.colors.tabs.even.fg


