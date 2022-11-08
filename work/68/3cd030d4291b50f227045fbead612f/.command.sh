#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun --allow-run-as-root -np 4 gmx mdrun -v -deffnm clever_sammet             -cpo ${WORKDIR}/clever_sammet            -cpt 1 -pf ${WORKDIR}/clever_sammet_pf.xvg            -px ${WORKDIR}/clever_sammet_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
