#!/bin/bash

#SBATCH --time 3:0:0 --mem-per-cpu=4000

source /project/def-orajora/software/env-busco/bin/activate

busco -m transcriptome\
 --offline\
 -i /project/def-orajora/svassili/BlackSpruce_Needle-Cambium/TRINITY/trinity_out_dir.Trinity.fasta\
 -o BUSCO_OUTPUT\
 -l /project/def-orajora/software/busco_downloads/lineages/embryophyta_odb10 

