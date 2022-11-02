#!/bin/bash -ue
DIRS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`

# capture process environment
set +u
echo DIRS=${DIRS[@]} > .command.env
