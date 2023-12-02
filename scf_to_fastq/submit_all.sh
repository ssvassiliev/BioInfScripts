#!/bin/bash
#SBATCH --time 2:0:0 --mem-per-cpu=4000 -A def-orajora

./run_phred.sh BSCP32C
./run_phred.sh BSCP32N
./run_phred.sh BSCP40C
./run_phred.sh BSCP40N
./run_seqclean.sh BSCP32C
./run_seqclean.sh BSCP32N
./run_seqclean.sh BSCP40C
./run_seqclean.sh BSCP40N
