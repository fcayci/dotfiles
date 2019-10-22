# dotfiles git support
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias sysinfo="inxi -F"
alias open="xdg-open"

# macbook specific
alias morepower="sudo cpupower frequency-set -g performance && cpupower frequency-info"
alias lesspower="sudo cpupower frequency-set -g powersave && cpupower frequency-info"
alias checkfan="cat /sys/devices/platform/applesmc.768/fan1_manual && cat /sys/devices/platform/applesmc.768/fan1_output"
alias checktemp="cat /sys/devices/platform/coretemp.0/hwmon/hwmon*/temp*_input"
alias net1000="sudo ethtool -s enp2s0f0 speed 1000 duplex full autoneg on"

# do not rename files, check renames
check_rename(){
  p=$(pwd); b=$(basename $p); i=1; for file in *; do t=$(basename $file); e=${t##*.}; name=`printf "%s - %02d.%s" $b $i $e`; echo $file, $name; ((i++)); done
}

# rename files
rename_files(){
  p=$(pwd); b=$(basename $p); i=1; for file in *; do t=$(basename $file); e=${t##*.}; name=`printf "%s - %02d.%s" $b $i $e`; mv -n $file $name; ((i++)); done
}

