#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm tiny_hodgkin             -cpo ${WORKDIR}/tiny_hodgkin            -cpt 1 -pf ${WORKDIR}/tiny_hodgkin_pf.xvg            -px ${WORKDIR}/tiny_hodgkin_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
