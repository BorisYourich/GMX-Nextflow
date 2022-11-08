#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm curious_borg             -cpo ${WORKDIR}/curious_borg            -cpt 1 -pf ${WORKDIR}/curious_borg_pf.xvg            -px ${WORKDIR}/curious_borg_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
