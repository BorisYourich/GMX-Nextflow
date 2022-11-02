#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
mpirun -np 15 gmx mdrun -v -deffnm distracted_marconi             -cpo ${WORKDIR}/distracted_marconi            -cpt 1 -pf ${WORKDIR}/distracted_marconi_pf.xvg            -px ${WORKDIR}/distracted_marconi_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
