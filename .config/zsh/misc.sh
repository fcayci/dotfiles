# Set Xilinx path
if [ -d "/opt/Xilinx/Vivado/2018.3" ]; then
  export PATH=$PATH:/opt/Xilinx/Vivado/2018.3/bin
fi

if [ -d "/opt/apps/Xilinx/Vivado/2019.1" ]; then
  export PATH=$PATH:/opt/Xilinx/Vivado/2019.1/bin
fi

# QT message suppress
export QT_LOGGING_RULES="qt5ct.debug=false"

# set GO path
if [ -d "/tank/go" ]; then
  export GOPATH="/tank/go"
  export PATH=$PATH:$GOPATH/bin
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

if [ -d "/opt/dynalist" ]; then
    export PATH=$PATH:/opt/dynalist
fi


# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR=vim

export PATH="$HOME/.local/bin:$PATH"

export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.7:/usr/lib/python3.7/lib-dynload:/usr/lib/python3.7/site-packages

