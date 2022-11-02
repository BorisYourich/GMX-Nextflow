#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`echo ${REPLICAS} | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm insane_wilson             -cpo ${WORKDIR}/insane_wilson            -cpt 1 -pf ${WORKDIR}/insane_wilson_pf.xvg            -px ${WORKDIR}/insane_wilson_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
