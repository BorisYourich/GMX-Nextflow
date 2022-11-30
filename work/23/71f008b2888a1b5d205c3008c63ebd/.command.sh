#!/bin/bash -ue
if [ ! -z  ]; then
    CPI="-cpi ""/"".cpt"
else
    CPI=""
fi

echo ${CPI}

REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm deadly_nobel             ${CPI}             -cpo deadly_nobel            -cpt 1 -pf deadly_nobel_pf.xvg            -px deadly_nobel_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet

# capture process environment
set +u
echo REPLICAS=${REPLICAS[@]} > .command.env
