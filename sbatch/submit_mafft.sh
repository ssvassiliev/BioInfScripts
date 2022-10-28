#!/bin/bash
#SBATCH -c4 --mem-per-cpu=8000 --time=3:0:0

# When concatenating file ensure there is a newline character between them.
# mafft fails without it.

ml mafft
mafft --clustalout --thread $SLURM_CPUS_PER_TASK seqs.fasta > aligment.aln
