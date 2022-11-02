#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
gmx mdrun -v -deffnm deadly_williams             -cpo ${WORKDIR}/deadly_williams            -cpt 1 -pf ${WORKDIR}/deadly_williams_pf.xvg            -px ${WORKDIR}/deadly_williams_px.xvg            -plumed ${WORKDIR}/plumed.dat            -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
