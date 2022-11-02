#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm angry_kalman             -cpo ${WORKDIR}/angry_kalman            -cpt 1 -pf ${WORKDIR}/angry_kalman_pf.xvg            -px ${WORKDIR}/angry_kalman_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
