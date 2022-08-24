#!/bin/bash
#SBATCH -c32 --mem-per-cpu=4000 --time=72:0:0

ml gcc blast+/2.12.0
export BLASTDB=/cvmfs/bio-test.data.computecanada.ca/content/databases/Core/blast_dbs/2022_03_23

blastn -db nt \
-num_threads $SLURM_CPUS_PER_TASK \
-query $HOME/scratch/RedSprucetranscriptome/Trinity_combined/trinity_out_dir.Trinity.fasta \
-out C_trinity_blast.out

