# dotfiles git support
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias sysinfo="inxi -F"
alias open="xdg-open"
alias diff='diff --color=auto'
alias cs='xclip -selection clipboard'
alias vs='xclip -o -selection clipboard'
alias encrypt='gpg --encrypt --sign --armor -r furkanca02@gmail.com'
alias mutt='cd ~;mutt'
alias diffy="kitty +kitten diff"
alias gitdiff="git difftool --no-symlinks --dir-diff"

note() {
  nvim "+Note $*"
}

alias todo='task'

task() {
    if [[ $# -gt 1 ]] || ([[ $# -eq 1 ]] && [[ $1 != "list" ]])
    then
        echo "* $*" >> ~/notebooks/content/tasks.md
        echo "'$*' added to agenda"
    elif [[ $# -eq 1 ]] && [[ $1 -eq "list" ]]
    then
        echo "Tasks"
        cat ~/notebooks/content/tasks.md | grep -v "#"
    else
        cd ~/notebooks
        vim content/tasks.md
    fi
}

# do not rename files, check renames
check_rename(){
  p=$(pwd); b=$(basename $p); i=1; for file in *; do t=$(basename $file); e=${t##*.}; name=`printf "%s - %02d.%s" $b $i $e`; echo $file, $name; ((i++)); done
}

# rename files
rename_files(){
  p=$(pwd); b=$(basename $p); i=1; for file in *; do t=$(basename $file); e=${t##*.}; name=`printf "%s - %02d.%s" $b $i $e`; mv -n $file $name; ((i++)); done
}
