#!/bin/bash

#SBATCH -c4 --mem-per-cpu=4000 --time=24:0:0

# Script to make DIAMOND DB with taxa information
# Input: 
# nr.gz
# prot.accession2taxid.FULL.gz

module load gcc diamond
#gunzip -c /project/def-orajora/rajni/nr.gz > nr.fasta && \
diamond makedb --in nr.fasta -d diamond_nrt --taxonmap prot.accession2taxid.FULL.gz \
--taxonnodes nodes.dmp --taxonnames names.dmp
gzip -c diamond_nrt.dmnd > diamond_nrt.dmnd.gz

