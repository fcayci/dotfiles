export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_UPDATE_PROMPT="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export LANG=en_US.UTF-8
#export ARCHFLAGS="-arch x86_64"

# make neovim default
[ -f /opt/homebrew/bin/nvim ] && export EDITOR='nvim' && alias vim=nvim

# dotfiles git support
alias config='$(which git) --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

# add homebrew
[ -d "/opt/homebrew/bin" ] && path+=('/opt/homebrew/bin')
#[ -d "/opt/homebrew/bin" ] && path=('/opt/homebrew/bin' $path)

# use homebrew ctags
[ -x "`brew --prefix`/bin/ctags" ] && alias ctags="`brew --prefix`/bin/ctags"

# setup fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  # default fzf command
  if [ -x "$(which ag)" ]; then
      export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  fi
fi

# Vi mode
bindkey -v

# add local bin directory
[ -d "$HOME/.local/bin" ] && path+=$HOME/.local/bin

export PATH

