# config.load_autoconfig()
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

c.tabs.position = 'left'

c.tabs.title.format = '{audio}{index}: {current_title}'

config.unbind("<ctrl+tab>")
config.bind("<ctrl+tab>", "tab-next")
config.bind("<ctrl+shift+tab>", "tab-prev")

c.tabs.width = '10%'

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

c.confirm_quit = ["downloads"]

# The editor (and arguments) to use for the `open-editor` command. `{}`
# gets replaced by the filename of the file to be edited.
c.editor.command = ["/usr/bin/kitty", "/usr/bin/nvim", "{}"]


# Open new tabs (middleclick/ctrl+click) in the background.
c.tabs.background = True
c.tabs.select_on_remove = "prev"

c.url.default_page = "about:blank"

c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']

c.completion.shrink = True
c.completion.scrollbar.width = 0
c.completion.scrollbar.padding = 0

c.hints.auto_follow = 'always'
c.hints.auto_follow_timeout = 400
c.hints.mode = 'number'

c.tabs.favicons.scale = 0.9
