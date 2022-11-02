#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
mpirun -np 15 gmx mdrun -v -deffnm soggy_pauling             -cpo ${WORKDIR}/soggy_pauling            -cpt 1 -pf ${WORKDIR}/soggy_pauling_pf.xvg            -px ${WORKDIR}/soggy_pauling_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
