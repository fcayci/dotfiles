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

# You may need to manually set your language environment
export LANG=en_US.UTF-8

