#!/bin/bash -ue
if [ ! -z  ]; then
    CPI="-cpi ""/"".cpt"
else
    CPI=""
fi

echo ${CPI}

REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm confident_bhaskara             ${CPI}             -cpo confident_bhaskara            -cpt 1 -pf confident_bhaskara_pf.xvg            -px confident_bhaskara_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet

# capture process environment
set +u
echo REPLICAS=${REPLICAS[@]} > .command.env
