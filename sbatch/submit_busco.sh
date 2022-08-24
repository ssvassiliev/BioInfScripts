#!/bin/bash

#SBATCH --time 12:0:0 --mem-per-cpu=4000

module purge
ml gcc busco

busco -m transcriptome -i trinity_out_dir.Trinity.fasta -o BUSCO_OUTPUT -l busco_downloads/lineages/embryophyta_odb10 
