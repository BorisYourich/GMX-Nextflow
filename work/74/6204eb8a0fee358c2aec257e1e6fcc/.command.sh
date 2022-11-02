#!/bin/bash -ue
MDP=`find /home/boris/GMX-Nextflow/RE/03/ -name "*.mdp"`
GRO=`find /home/boris/GMX-Nextflow/RE/03/ -name "*.gro"`
TOP=`find /home/boris/GMX-Nextflow/RE/03/ -name "*.top"`
NDX=`find /home/boris/GMX-Nextflow/RE/03/ -name "*.ndx"`
if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' ${MDP}`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi
gmx grompp -f ${MDP}              -c ${GRO}              -r ${GRO}              -p ${TOP}              -n ${NDX}              -o /home/boris/GMX-Nextflow/RE/03/topol.tpr -quiet -maxwarn ${MAXWARN}
