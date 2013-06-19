#!/bin/bash

# Run L4D2 Beta via Optirun on Optimus Systems.
# Version 2.3
# SimonOmega

clear

ulimit -u 2048

cd ${HOME}/.local/share/Steam/SteamApps/common/L4D2_Beta/

# For Texture Compression
echo "Setting S3TC Texture Conpression"
export force_s3tc_enable=true
#echo "  Set: ${force_s3tc_enable}"

#For Nvidia OpenGL Thread Optimizations
echo "Setting OpenGL Thread Optimizations (for NVidia)"
export __GL_THREADED_OPTIMIZATIONS=1
#echo "  Set: ${__GL_THREADED_OPTIMIZATIONS}"

# Common L4D2_Beta Libraries and Match Maker Libraries.
echo "Setting LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=${HOME}/.local/share/Steam/ubuntu12_32/:$LD_LIBRARY_PATH

# TO RESET CONFIG
#  vblank_mode=0 optirun ./hl2_linux -game left4dead2_beta -steam -autoconfig "$@"
# Restrict Memory Usage to 1.5GB
#  vblank_mode=0 optirun ./hl2_linux -game left4dead2_beta -steam -refresh 120 -high -heapsize 1572864 -console "$@"

echo "Setting L4D2 Arguments/Options"
_L4D2_ARGS='-lv -sv_lan 1 -sv_allow_lobby_connect_only 0 -novid -console'

# L4D2 is 32Bit - May help to limit Memory 1/2 of the 3.2 GB max addressable.
echo "Checking available RAM"
_MEMORY=$(free -h | grep Mem: | awk '{print $2}' | grep G | awk -F. '{print $1}')
if [ ${_MEMORY} -gt 3 ]; then 
  echo "  Setting Heap to 1.5GB as more than 3GB is present."
  _L4D2_ARGS=${_L4D2_ARGS}' -heapsize 1572864'
fi

read -p "Enter Y to enable MSAA (Anti Alias) Features: " -n 1 _ANSWER
if [ "$_ANSWER" == "Y" ]; then
  _L4D2_ARGS=${_L4D2_ARGS}' -nomsaa'
fi

echo -e "\nExecute L4D2 via Optirun."
echo "Arguments:  ${_L4D2_ARGS}"
if [ -n "$(which optirun)" ]; then 
  vblank_mode=0 optirun ./hl2_linux -game left4dead2_beta -steam ${_L4D2_ARGS} "$@"
else 
  ./hl2_linux -game left4dead2_beta -steam ${_L4D2_ARGS} "$@"
fi