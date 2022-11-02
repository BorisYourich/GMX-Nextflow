#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
REPLICAS=`ls -d -- /home/boris/GMX-Nextflow/RE/*/`
gmx mdrun -v -deffnm compassionate_watson             -cpo ${WORKDIR}/compassionate_watson            -cpt 1 -pf ${WORKDIR}/compassionate_watson_pf.xvg            -px ${WORKDIR}/compassionate_watson_px.xvg            -plumed -multidir ${REPLICAS}            -replex 2000 -hrex -noappend -quiet
