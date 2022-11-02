#!/bin/bash -ue
if [ -z  ]; then
  GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' /home/boris/GMX-Nextflow/RE/07/us.mdp`
  if [ ${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
else
  MAXWARN=
fi
gmx grompp -f /home/boris/GMX-Nextflow/RE/07/us.mdp -c /home/boris/GMX-Nextflow/RE/07/01.gro -r /home/boris/GMX-Nextflow/RE/07/01.gro -p /home/boris/GMX-Nextflow/RE/07/topol.top -n /home/boris/GMX-Nextflow/RE/07/index.ndx -o /home/boris/GMX-Nextflow/RE/07/topol.tpr -quiet -maxwarn ${MAXWARN}
