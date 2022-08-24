#!/bin/bash

#SBATCH -c8 --nodes=1 --mem-per-cpu=4000 --time=20:0:0
ml cd-hit

cd-hit-est \
-i $HOME/scratch/RedSprucetranscriptome/Trinity_combined/trinity_out_dir.Trinity.fasta \
-o clustered_contigs \
-n 7 \
-M 0 \
-T $SLURM_CPUS_PER_TASK 
