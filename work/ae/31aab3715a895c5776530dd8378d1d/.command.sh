#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
gmx mdrun -v -deffnm ridiculous_coulomb             -cpo ${WORKDIR}/ridiculous_coulomb            -cpt 1 -pf ${WORKDIR}/ridiculous_coulomb_pf.xvg            -px ${WORKDIR}/ridiculous_coulomb_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
