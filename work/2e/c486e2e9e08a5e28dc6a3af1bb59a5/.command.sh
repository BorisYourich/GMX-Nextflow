#!/bin/bash -ue
GMX_VER=`!{projectDir}/gmx --version | awk 'BEGIN {i = 0} tolower($0) ~ /gromacs version/ {split($NF, N, "."); if (N[1] > 6) i = 1} END {print i}'`
if [ ${GMX_VER} -eq 0 ]; then APPEND="-append"; fi

# capture process environment
set +u
echo GMX_VER=${GMX_VER[@]} > .command.env
