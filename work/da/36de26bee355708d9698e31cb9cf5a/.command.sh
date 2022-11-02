#!/bin/bash -ue
if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' DataflowVariable(value=null)us.mdp`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi
gmx grompp -f DataflowVariable(value=null)us.mdp -c DataflowVariable(value=null)01.gro -r DataflowVariable(value=null)01.gro -p DataflowVariable(value=null)topol.top -n DataflowVariable(value=null)index.ndx -o DataflowVariable(value=null)topol.tpr -quiet -maxwarn ${MAXWARN}
