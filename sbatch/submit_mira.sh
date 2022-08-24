#!/bin/bash

#SBATCH -c8 --mem-per-cpu 4000 --time 12:0:0

ml gcc mira
mira -t $SLURM_CPUS_PER_TASK  RedSpruce.manifest
