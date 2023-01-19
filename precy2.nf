#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// precission of the calculation
params.GMX="gmx"	// set to gmx_d for double precision
params.RE="RE"		// directory name, every subdir is considered a replica workdir
params.PREV=""	// mnemonic name of the previous workflow from which to use a .cpt file

// names of optional input files
params.REF=""	// reference coordinates for restraints; leave empty if not needed

// runtime variables
params.NTOMP=""		// number of OpenMP threads per MPI rank; leave empty to set default
params.MAXWARN=""	// maximum number of warnings; leave empty to determine automatically (gen-vel)

// plumed can be used only if the module version enables it
params.PLUMED="plumed.dat"	// name of the plumed script; leave empty if not used
params.PLUMED_THREADS=""	// number of plumed openMP threads; leave empty to set default 


process get_replicas {
  
  output:
  stdout

  """
  ls -d -- ${workflow.launchDir}/${params.RE}/*/
  """
}

process grompp_params {

  input:
  val replica
  output:
  tuple env(MDP), env(GRO), env(TOP), env(NDX), env(CPT), env(REF), env(MAXWARN)
  
  """
  MDP=`find ${replica} -maxdepth 1 -name "*.mdp"`
  GRO=`find ${replica} -maxdepth 1 -name "*.gro"`
  TOP=`find ${replica} -maxdepth 1 -name "*.top"`
  NDX=`find ${replica} -maxdepth 1 -name "*.ndx"`
  CPT=`find ${replica} -maxdepth 1 -name "*.cpt"`
  
  if [ -z \${CPT} ]; then
      CPT="None"
  fi
  
  if [ ! -z ${params.REF} ]; then
      REF="${params.REF}"
  else
      REF="\${GRO}"
  fi
  
  if [ -z ${params.MAXWARN} ]; then
    GEN_VEL=`awk 'BEGIN {i = 0} /gen[-_]vel/ {if (toupper(\$3) == "YES") i = 1} END {print i}' \${MDP}`
    if [ \${GEN_VEL} -eq 0 ]; then MAXWARN=0; else MAXWARN=1; fi
  else
    MAXWARN=${params.MAXWARN}
  fi
  """
}

process grompp {
  memory '2 GB'

  input:
  val replica
  tuple (val(MDP), val(GRO), val(TOP), val(NDX), val(CPT), val(REF), val(MAXWARN))

  output:
  stdout

  script:
  if (params.PREV != "")
    """
    ${params.GMX} convert-tpr -s ${replica}${params.PREV}/${params.PREV}.tpr \
                              -o ${replica}${workflow.runName}.tpr\
                              -nsteps `awk 'BEGIN {nsteps = 0} /nsteps/ {nsteps = \$3} END {print nsteps}' ${replica}us.mdp`
    """
  else if (CPT == "None")
    """
    ${params.GMX} grompp -f ${MDP} \
               -c ${GRO} \
               -r ${REF} \
               -p ${TOP} \
               -n ${NDX} \
               -o ${replica}${workflow.runName}.tpr -quiet -maxwarn ${MAXWARN}
    """
  else
    """
    ${params.GMX} grompp -f ${MDP} \
               -c ${GRO} \
               -r ${REF} \
               -t ${CPT} \
               -p ${TOP} \
               -n ${NDX} \
               -o ${replica}${workflow.runName}.tpr -quiet -maxwarn ${MAXWARN}
    """
}

process mdrun {
  // memory '16 GB'
  // cpus 15
  debug true
  // scratch true
  
  input:
  val x
  
  output:
  env REPLICAS
  
  """
  if [ ! -z ${params.PREV} ]; then
      CPI="-cpi "${params.PREV}"/"${params.PREV}".cpt"
  else
      CPI=""
  fi
  
  REPLICAS=`ls -d -- ${workflow.launchDir}/${params.RE}/*/`
  NP=`ls -d -- ${workflow.launchDir}/${params.RE}/*/ | wc -l`
  mpirun -iface eth0 -hosts \$(cat /etc/mpi/hostfile | paste -sd "," -) \
         -np \${NP} ${params.GMX} mdrun -ntomp ${OMP_NUM_THREADS} -v -deffnm ${workflow.runName} \
         -cpo ${workflow.runName}.cpt \${CPI} \
         -cpt 15 -pf ${workflow.runName}_pf.xvg \
         -px ${workflow.runName}_px.xvg \
         -plumed ${params.PLUMED} -multidir \${REPLICAS} \
         -replex 2000 -hrex -noappend -quiet
  """
}

process archive {

  input:
  val replica
  each dummy

  output:
  stdout
  
  script:
  if (params.PREV == "")
    """
    mkdir ${replica}${workflow.runName}
    mv ${replica}${workflow.runName}.tpr    ${replica}${workflow.runName}/${workflow.runName}.tpr
    mv ${replica}${workflow.runName}*.edr   ${replica}${workflow.runName}/${workflow.runName}.edr
    mv ${replica}${workflow.runName}*.log   ${replica}${workflow.runName}/${workflow.runName}.log
    mv ${replica}${workflow.runName}*.cpt   ${replica}${workflow.runName}/${workflow.runName}.cpt
    mv ${replica}${workflow.runName}*.xtc   ${replica}${workflow.runName}/${workflow.runName}.xtc
    mv ${replica}${workflow.runName}*.trr   ${replica}${workflow.runName}/${workflow.runName}.trr
    mv ${replica}${workflow.runName}_pf*.xvg   ${replica}${workflow.runName}/${workflow.runName}_pf.xvg
    mv ${replica}${workflow.runName}_px*.xvg   ${replica}${workflow.runName}/${workflow.runName}_px.xvg
    mv ${replica}${workflow.runName}*.gro   ${replica}${workflow.runName}/${workflow.runName}.gro
    """
  else
    """
    mkdir ${replica}${workflow.runName}
    mv ${replica}${workflow.runName}.tpr    ${replica}${workflow.runName}/${workflow.runName}.tpr
    mv ${replica}${workflow.runName}*.edr   ${replica}${workflow.runName}/${workflow.runName}.edr
    mv ${replica}${workflow.runName}*.log   ${replica}${workflow.runName}/${workflow.runName}.log
    mv ${replica}${workflow.runName}*.xtc   ${replica}${workflow.runName}/${workflow.runName}.xtc
    mv ${replica}${workflow.runName}*.trr   ${replica}${workflow.runName}/${workflow.runName}.trr
    mv ${replica}${workflow.runName}_pf*.xvg   ${replica}${workflow.runName}/${workflow.runName}_pf.xvg
    mv ${replica}${workflow.runName}_px*.xvg   ${replica}${workflow.runName}/${workflow.runName}_px.xvg
    cp ${replica}${params.PREV}/${params.PREV}*.cpt   ${replica}${workflow.runName}/${workflow.runName}.cpt
    cp ${replica}${params.PREV}/${params.PREV}*.gro ${replica}${workflow.runName}/${workflow.runName}.gro
    """
}


workflow {
  Replicas = get_replicas().splitText().map{it -> it.trim()}
  input = grompp(Replicas, grompp_params(Replicas))
  Dummy = mdrun(input.min()).splitCsv(sep:" ")  // .min() is used for the mdrun to wait until all grompp jobs finnish
  archive(Replicas, Dummy) | view { it.trim() } // Dummy is used for archive to wait until mdrun is finnished
}
