#!/bin/bash
#SBATCH --mem-per-cpu=4000 -c1 --time=3:0:0

ml java

/project/def-orajora/rajni/software/interproscan-5.57-90.0/interproscan.sh -i chunk_9.fasta -goterms -dra -t n -f tsv -f xml -dp
