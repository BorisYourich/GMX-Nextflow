#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm soggy_woese             -cpo ${WORKDIR}/soggy_woese            -cpt 1 -pf ${WORKDIR}/soggy_woese_pf.xvg            -px ${WORKDIR}/soggy_woese_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
