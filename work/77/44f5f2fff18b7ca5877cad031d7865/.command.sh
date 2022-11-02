#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
mpirun -np ${NP} gmx mdrun -v -deffnm trusting_descartes             -cpo ${WORKDIR}/trusting_descartes            -cpt 1 -pf ${WORKDIR}/trusting_descartes_pf.xvg            -px ${WORKDIR}/trusting_descartes_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
