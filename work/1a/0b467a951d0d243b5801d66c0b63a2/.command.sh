#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun --allow-run-as-root -np ${NP} gmx mdrun -v -deffnm maniac_perlman             -cpo ${WORKDIR}/maniac_perlman            -cpt 1 -pf ${WORKDIR}/maniac_perlman_pf.xvg            -px ${WORKDIR}/maniac_perlman_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
