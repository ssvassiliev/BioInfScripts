#!/bin/bash

#SBATCH --ntasks=8 --mem-per-cpu 4000 --time 12:0:0 
ml gcc/9.3.0  openmpi/4.0.3 ray/3.0.1

srun Ray -k 21 -s 1.fastq  2.fastq  3.fastq 
