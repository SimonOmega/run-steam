#!/bin/bash
# Version 1.6
# SimonOmega

clear

ulimit -u 2048

echo -e "Written for CrunchBang and other Debian Based Distros.\n"

echo "Setting S3TC Texture Compression"
export force_s3tc_enable=true
#echo "  Set: ${force_s3tc_enable}"

echo "Setting OpenGL Thread Optimizations (for NVidia)"
export __GL_THREADED_OPTIMIZATIONS=1
#echo "  Set: ${__GL_THREADED_OPTIMIZATIONS}"

echo "Setting LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=${HOME}/.local/share/Steam/ubuntu12_32/:$LD_LIBRARY_PATH
#echo "  Set: ${LD_LIBRARY_PATH}"

echo "Execute Steam"
if [ -n "$(which optirun)" ]; then 
  vblank_mode=0 optirun /usr/bin/steam "$@"
else 
  /usr/bin/steam "$@"
fi