#!/bin/bash
#SBATCH --time 1:0:0 --mem-per-cpu=4000 -A def-orajora

PHREDROOT=/project/def-orajora/software/phred/
PHRAPROOT=/project/def-orajora/software/phrap
export PATH=$PATH:$PHREDROOT/bin/:$PHRAPROOT/bin/
export PHRED_PARAMETER_FILE=$PHREDROOT/phredpar.dat

DATA=$1

mkdir -p ${DATA} && cd ${DATA} 
unzip ../${DATA}.zip *.scf -d scf_files
mkdir -p phd_untrimmed phd_trimmed 

phred -id scf_files -pd phd_untrimmed 
phd2fasta -id phd_untrimmed -os seqs_fasta_untrimmed -oq seqs_fasta_untrimmed.qual

phred -id scf_files -trim_alt "" -trim_phd -pd phd_trimmed
phd2fasta -id phd_trimmed -os seqs_fasta_trimmed -oq seqs_fasta_trimmed.qual
cross_match seqs_fasta_trimmed ../vector.seq -minmatch 14 -minscore 30 -screen > x-match.log

# Locate and count screened base pairs (X):
module load seqkit
seqkit locate -P -d -p 'X+' -t unlimit seqs_fasta_trimmed.screen > x-match.screen
echo ""; echo -n "Screened base pairs: " >> x-match.screen
cut -f7 x-match.screen | wc -c >> x-match.screen

# Convert fasta + qual to fastq
source /project/def-orajora/svassili/BlackSpruce_Needle-Cambium/env-bio/bin/activate
python ../fasta_qual_to_fastq.py seqs_fasta_untrimmed seqs_fasta_untrimmed.qual
python ../fasta_qual_to_fastq.py  seqs_fasta_trimmed  seqs_fasta_trimmed.qual

# Quality control
module load fastqc
mkdir -p fastqc
fastqc -o fastqc/  seqs_fasta_untrimmed.fastq
fastqc -o fastqc/  seqs_fasta_trimmed.fastq 
