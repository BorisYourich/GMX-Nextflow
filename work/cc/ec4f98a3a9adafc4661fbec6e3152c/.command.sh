#!/bin/bash -ue
echo /home/boris/GMX-Nextflow 
gmx_mpi mdrun -h 2> /dev/null | grep -q plumed && echo ok
