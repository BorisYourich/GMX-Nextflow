#!/bin/bash -ue
GMX_VER=`!{projectDir}/gmx --version`

# capture process environment
set +u
echo GMX_VER=${GMX_VER[@]} > .command.env
