#!/bin/bash -ue
MDP=`find /home/boris/GMX-Nextflow/RE/05/ -name "*.mdp"`
GRO=`find /home/boris/GMX-Nextflow/RE/05/ -name "*.gro"`
TOP=`find /home/boris/GMX-Nextflow/RE/05/ -name "*.top"`
NDX=`find /home/boris/GMX-Nextflow/RE/05/ -name "*.ndx"`

if [ ! -z  ]; then
    CPT="-t "`find /home/boris/GMX-Nextflow/RE/05// -name ".cpt"`
else
    CPT=""
fi

echo ${CPT}

if [ ! -z  ]; then
    REF=""
else
    REF="${GRO}"
fi

if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' ${MDP}`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi

gmx grompp -f ${MDP}              -c ${GRO}              -r ${REF}              ${CPT}              -p ${TOP}              -n ${NDX}              -o /home/boris/GMX-Nextflow/RE/05/confident_bhaskara.tpr -quiet -maxwarn ${MAXWARN}
