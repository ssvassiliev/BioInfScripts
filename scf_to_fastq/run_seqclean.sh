#!/bin/bash
#SBATCH --time 1:0:0 --mem-per-cpu=4000 -A def-orajora

DATA=$1
DB_DIR=/project/def-orajora/databases/
BIN_DIR=/project/def-orajora/software/seqclean-x86_64/
source /project/def-orajora/svassili/BlackSpruce_Needle-Cambium/env-bio/bin/activate
module load fastqc

mkdir -p ${DATA}/SeqClean && cd ${DATA}/SeqClean
${BIN_DIR}/seqclean \
../seqs_fasta_trimmed \
-s ${DB_DIR}/Ecoli.fasta \
-v ${DB_DIR}/UniVec.fasta,${DB_DIR}/vector.seq
${BIN_DIR}/cln2qual \
seqs_fasta_trimmed.cln ../seqs_fasta_trimmed.qual
mv ../seqs_fasta_trimmed.qual.clean ./

python ../../fasta_qual_to_fastq.py seqs_fasta_trimmed.clean seqs_fasta_trimmed.qual.clean
mkdir -p fastqc
fastqc -o fastqc/ seqs_fasta_trimmed.clean.fastq


