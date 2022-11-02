#!/bin/bash -ue
echo !{projectDir}

# capture process environment
set +u
echo GMX_VER=${GMX_VER[@]} > .command.env
