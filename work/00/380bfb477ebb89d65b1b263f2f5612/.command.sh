#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
mpirun gmx mdrun -v -deffnm exotic_hopper             -cpo ${WORKDIR}/exotic_hopper            -cpt 1 -pf ${WORKDIR}/exotic_hopper_pf.xvg            -px ${WORKDIR}/exotic_hopper_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
