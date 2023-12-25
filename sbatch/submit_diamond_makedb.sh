#!/bin/bash

#SBATCH -c4 --mem-per-cpu=4000 --time=24:0:0

# Script to make DIAMOND DB with taxa information
# Input: 
# nr.gz
# prot.accession2taxid.FULL.gz

# wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.FULL.gz
# wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip
# wget ftp://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz

# lftp -c "open ftp://ftp.ncbi.nlm.nih.gov; get /blast/db/FASTA/nr.gz"
# diamond blastx -d reference -q reads.fasta -o matches.tsv --taxonlist 3193
#  Embryophyta 3193   

module load gcc diamond
#gunzip -c /project/def-orajora/rajni/nr.gz > nr.fasta && \
diamond makedb --in nr.fasta -d diamond_nrt --taxonmap prot.accession2taxid.FULL.gz \
--taxonnodes nodes.dmp --taxonnames names.dmp
gzip -c diamond_nrt.dmnd > diamond_nrt.dmnd.gz

