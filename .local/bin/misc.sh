# Set Xilinx path
if [ -d "/opt/Xilinx/Vivado/2019.1" ]; then
  export PATH=$PATH:/opt/Xilinx/Vivado/2019.1/bin
fi

if [ -d "/usr/local/cocotb-1.1.0" ]; then
    export COCOTB="/usr/local/cocotb-1.1.0"
fi

if [ -d "/opt/Quartus/19.1" ]; then
    export QSYS_ROOTDIR="/opt/Quartus/19.1/quartus/sopc_builder/bin"
fi

if [ -d "/tank/dev/fpga/tools/riscv-formal" ]; then
    export RISCV_FORMAL_ROOT="/tank/dev/fpga/tools/riscv-formal"
fi

if [ -d "./.local/share/nvim/site/pack/fcayci/start/fzf/bin" ];
then
    export PATH=$PATH:".local/share/nvim/site/pack/fcayci/start/fzf/bin"
    #export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi

# QT message suppress
export QT_LOGGING_RULES="qt5ct.debug=false"

# Vi mode
bindkey -v

export LANG=en_US.UTF-8
export EDITOR=nvim
export ARCHFLAGS="-arch x86_64"

export PATH="$HOME/.local/bin:$PATH"
