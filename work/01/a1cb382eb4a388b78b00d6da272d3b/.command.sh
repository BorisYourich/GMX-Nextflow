#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm furious_celsius             -cpo ${WORKDIR}/furious_celsius            -cpt 1 -pf ${WORKDIR}/furious_celsius_pf.xvg            -px ${WORKDIR}/furious_celsius_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
