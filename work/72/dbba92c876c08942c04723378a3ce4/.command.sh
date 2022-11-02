#!/bin/bash -ue
echo /home/boris/GMX-Nextflow 
gmx mdrun -h | grep -q plumed && echo ok
