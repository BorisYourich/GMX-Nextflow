#!/bin/bash -ue
if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' /home/boris/GMX-Nextflow/us.mdp`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi
gmx grompp -f *us.mdp -c *01.gro -r *01.gro -p *topol.top -n *index.ndx -o *topol.tpr -quiet -maxwarn ${MAXWARN}
