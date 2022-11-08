#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm tender_thompson             -cpo ${WORKDIR}/tender_thompson            -cpt 1 -pf ${WORKDIR}/tender_thompson_pf.xvg            -px ${WORKDIR}/tender_thompson_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
