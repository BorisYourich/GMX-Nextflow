#!/bin/bash -ue
echo `nproc --all`
echo `gmx --version`

WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
NP=`ls -d -- /home/boris/GMX-Nextflow/RE/*/ | wc -l`
gmx mdrun -v -deffnm awesome_descartes             -cpo ${WORKDIR}/awesome_descartes            -cpt 1 -pf ${WORKDIR}/awesome_descartes_pf.xvg            -px ${WORKDIR}/awesome_descartes_px.xvg            -plumed plumed.dat -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
