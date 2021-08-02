#! /bin/bash

#SBATCH -N {nodes}
#SBATCH -n {ntasks}
#SBATCH --mem=0
##SBATCH --mem-per-cpu={memory}G
#SBATCH -p {queuetype}
#SBATCH --requeue
#SBATCH -J {name}
#SBATCH -t {walltime}
#SBATCH -A {key}
#SBATCH -o job.oe
#SBATCH --mail-type=END,NONE,FAIL,REQUEUE
#SBATCH --mail-user=esandraz@u.northwestern.edu

#OpenMP settings:
export OMP_NUM_THREADS=1

#run the application:
module purge
module load mpi/openmpi-1.6.5-intel2013.2 

gunzip -f CHGCAR.gz WAVECAR.gz &> /dev/null
date +%s
ulimit -s unlimited

mpirun -np {ntasks} /projects/b1004/bin/vasp_53 > stdout.txt 2>stderr.txt

gzip -f CHGCAR OUTCAR PROCAR WAVECAR
rm -f CHG
date +%s
