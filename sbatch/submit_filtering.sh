#!/bin/bash
#SBATCH --mem=16000 --time=12:0:0
ml python scipy-stack
python filter_blast_output.py
