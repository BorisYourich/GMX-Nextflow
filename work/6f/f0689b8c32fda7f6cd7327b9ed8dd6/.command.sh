#!/bin/bash -ue
WORKDIR=/home/boris/GMX-Nextflow/RE
gmx mdrun -v -deffnm silly_mendel             -cpo ${WORKDIR}/silly_mendel            -cpt 1 -pf ${WORKDIR}/silly_mendel_pf.xvg            -px ${WORKDIR}/silly_mendel_px.xvg            -plumed ${WORKDIR}/plumed.dat            -multidir ${WORKDIR}/            -replex 2000 -hrex -noappend -quiet
