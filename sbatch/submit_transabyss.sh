#!/bin/bash

#SBATCH -c8 --mem-per-cpu=4000 --time=12:0:0

ml gcc trans-abyss
DATA_DIR=$HOME/scratch/454

transabyss --threads $SLURM_CPUS_PER_TASK --kmer 25 --se \
$DATA_DIR/transabyssillumina64bp/64_bp_cutoff_RS_ambient_CO2.fastq.trimmed \
$DATA_DIR/transabyssillumina64bp/64_bp_cutoff_RS_co-treated.fastq.trimmed \
$DATA_DIR/transabyssillumina64bp/64_bp_cutoff_RS_elevated_CO2.fastq.trimmed

