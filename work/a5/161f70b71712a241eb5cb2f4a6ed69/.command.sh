#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
gmx mdrun -v -deffnm nostalgic_euler             -cpo ${WORKDIR}/nostalgic_euler            -cpt 1 -pf ${WORKDIR}/nostalgic_euler_pf.xvg            -px ${WORKDIR}/nostalgic_euler_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
