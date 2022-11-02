#!/bin/bash -ue
if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' /home/boris/GMX-Nextflow/us.mdp`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi
gmx grompp -f [ProcessDef[process get_replicas]]us.mdp -c [ProcessDef[process get_replicas]]01.gro -r [ProcessDef[process get_replicas]]01.gro -p [ProcessDef[process get_replicas]]topol.top -n [ProcessDef[process get_replicas]]index.ndx -o [ProcessDef[process get_replicas]]topol.tpr -quiet -maxwarn ${MAXWARN}
