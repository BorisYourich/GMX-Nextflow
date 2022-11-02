#!/bin/bash -ue
if [ -z  ]; then
      GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper($3) == "YES") i = 1} END {print i}' /home/boris/GMX-Nextflow/RE/01/us.mdp`
      if [ ${GEN_VEL} -eq 0 ]; then =0; else =1; fi
  fi
