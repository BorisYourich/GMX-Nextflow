#!/usr/bin/env nextflow
nextflow.enable.dsl=2

# names of compulsory input files
params.MDP="us.mdp" # simulation parameters
params.GRO="??.gro" # structure file

# names of optional input files
params.CPT="" # checkpoint file (e.g. from equilibration); leave empty if not needed
params.REF="??.gro" # reference coordinates for restraints; leave empty if not needed

# names of renamed input files
params.NDX="" # index file; leave empty string to set default (index.ndx)
params.TOP="" # topology file; leave empty string to set default (topol.top)

# runtime variables
params.NTOMP="" # number of OpenMP threads per MPI rank; leave empty to set default
params.MAXWARN="" # maximum number of warnings; leave empty to determine automatically (gen-vel)

# plumed can be used only if the module version enables it
params.PLUMED="plumed.dat" # name of the plumed script; leave empty if not used
params.PLUMED_THREADS="" # number of plumed openMP threads; leave empty to set default

process get_version {
  
  output:
  env GMX_VER

  '''
  GMX_VER=`conda --version | awk 'BEGIN {i = 0} tolower($0) ~ /gromacs version/ {split($NF, N, "."); if (N[1] > 6) i = 1} END {print i}'`
  if [ ${GMX_VER} -eq 0 ]; then APPEND="-append"; fi
  
  '''
}

process print_version {
  input:
    val GMX_VER
  output:
    stdout

  """
  echo $GMX_VER
  """
}

workflow {
  get_version | flatten | print_version | view { it.trim() }
}
