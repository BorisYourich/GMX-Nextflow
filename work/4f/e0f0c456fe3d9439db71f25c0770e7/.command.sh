#!/bin/bash -ue
gmx_mpi mdrun -h 2> /dev/null | grep -q plumed && echo ok
