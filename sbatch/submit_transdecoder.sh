#!/bin/bash

#SBATCH--mem-per-cpu=4000 --time=20:0:0
ml gcc transdecoder
#TransDecoder.LongOrfs -t clustered_contigs
TransDecoder.Predict -t clustered_contigs
