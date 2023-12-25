# Black spruce transcriptomics
Original data:
https://unbcloud-my.sharepoint.com/:f:/g/personal/orajora_unb_ca/EjNENTRtwZpGsc1szD0QbBUB4YAOqSqND1n-lTlGhvyz2A?email=Serguei.Vassiliev%40unb.ca&e=5%3a0ZlNXi&fromShare=true&at=9

## Installing phred
phred-dist-071220.c-acd.tar.gz 
phd2fasta-acd-dist.130911.tar.gz 

Original fasta file: 
Fasta_Sequence_Files/BSCP32C_seqs_fasta:

1750 l,  31982 w, 1164213 c


module load seqkit
seqkit stats *.fasta

file                       format  type  num_seqs    sum_len  min_len  avg_len  max_len
seqs_fasta_no_trim         FASTA   DNA      1,750  1,449,641      137    828.4    3,130
seqs_fasta_trim_alt        FASTA   DNA      1,711  1,032,224       19    603.3      942
../Phred match/seqs_fasta  FASTA   DNA      1,750  1,032,481        0      590      930 

* in the last one 0 length sequences are not trimmed

run_phred.sh
~~~
PHREDROOT=/project/def-orajora/software/phred/
PHRAPROOT=/project/def-orajora/software/phrap
export PATH=$PATH:$PHREDROOT/bin/:$PHRAPROOT/bin/
export PHRED_PARAMETER_FILE=$PHREDROOT/phredpar.dat



#phred -id data -pd phd_no_trim_dir 
#phd2fasta -id phd_no_trim_dir -os seqs_fasta_no_trim -oq seqs_fasta_no_trim.qual

#phred -id data -trim_alt "" -trim_phd -pd phd_trim_dir
#phd2fasta -id phd_trim_dir -os seqs_fasta_trimmed -oq seqs_fasta_trimmed.qual
cross_match seqs_fasta_trimmed vector.seq -minmatch 14 -minscore 30 -screen

#   Flags                        Screened
# -minmatch 14 -minscore 30        180908
# -minmatch 10 -minscore 20        186525
# -minmatch 8 -minscore  10        194631

# Locate X's:
seqkit locate -P -d -p 'X+' seqs_fasta_trimmed.screen > x-match.screen
echo -n "Screened base pairs: "
cut -f7 x-match.screen | wc -c
~~~

## Bioconvert

module load gcc/9.3.0 python/3.10.2 arrow/11.0.0
pip install --upgrade pip
pip install bioconvert

bioconvert fasta_qual2fastq seqs_fasta_untrimmed seqs_fasta_untrimmed.qual seqs_fasta_untrimmed.fastq
fastqc seqs_fasta_untrimmed.fastq 

!! Bioconvert does not encode phred scores !!


## Biopython 
pip install --no-index biopython

fasta_qual_to_fastq.py
~~~
from Bio import SeqIO
import sys

print("Usage: python $0 file.fasta file.qual")

fasta=sys.argv[1]
qual=sys.argv[2]

reads = SeqIO.to_dict(SeqIO.parse(fasta, "fasta"))
for rec in SeqIO.parse(qual, "qual"):
   reads[rec.id].letter_annotations["phred_quality"]=rec.letter_annotations["phred_quality"]
fout=open(f'{fasta}.fastq', "w") 
SeqIO.write(reads.values(), fout, 'fastq')
fout.close()
~~~

## SeqClean
/project/def-orajora/software/seqclean-x86_64/seqclean
module load blast/2.2.26 

### Prepare databases
formatdb -i Ecoli.fasta -p F
formatdb -i vectors.seq -p F

~~~
DB_DIR=/project/def-orajora/databases/
/project/def-orajora/software/seqclean-x86_64/seqclean \
../seqs_fasta_trimmed \
-s ${DB_DIR}/Ecoli.fasta \
-v ${DB_DIR}/UniVec.fasta,${DB_DIR}/vector.seq
/project/def-orajora/software/seqclean-x86_64/cln2qual seqs_fasta_trimmed.cln ../seqs_fasta_trimmed.qual
mv ../seqs_fasta_trimmed.qual.clean ./
python ../fasta_qual_to_fastq.py seqs_fasta_trimmed.clean seqs_fasta_trimmed.qual.clean
mkdir fastqc
fastqc -o fastqc/ seqs_fasta_trimmed.clean.fastq
~~~

### UniVec
wget https://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec 

### Escherichia coli str. K-12 substr. DH10B, complete sequence
https://www.ncbi.nlm.nih.gov/nuccore/NC_010473.1?report=fasta


#### FastQC
fastqc -o fastqc/  seqs_fasta_untrimmed.fastq 



## Red Spruce Transcriptome Folders
https://unbcloud-my.sharepoint.com/:f:/g/personal/orajora_unb_ca/EprQCvuHLAJEmue2aiYool4BFSflX0dzDC6BJkPn1hHuBQ?email=Serguei.Vassiliev%40unb.ca&e=5%3aNFo45e&fromShare=true&at=9


Trim read names:
awk -F '\\ CHROMAT_FILE: '  '{print $1}' BSCP32C.fastq  > BSCP32C_sn.fastq 
awk -F '\\ CHROMAT_FILE: '  '{print $1}' BSCP32N.fastq  > BSCP32N_sn.fastq 
awk -F '\\ CHROMAT_FILE: '  '{print $1}' BSCP40N.fastq  > BSCP40N_sn.fastq 
awk -F '\\ CHROMAT_FILE: '  '{print $1}' BSCP40C.fastq  > BSCP40C_sn.fastq 


P40N 3 types of files:
BSCP40N*, im_bscp40n*, om1_230902*.

Supported MIRA tachnologies: sanger, 454, solexa, iontor, pcbiolq, pcbiohq, text

## Stats before and after cleaning
           40C   40N    32C   32N
scf        1926  1758   1829  1628
untrimmed  1926  1750   1750  1628
trimmed    1849  1514   1711  1588
clean      1712  1310   1326  1444

BSCP40C.fastq  FASTQ   DNA      1,712  827,073      100    483.1      837
BSCP40N.fastq  FASTQ   DNA      1,310  576,484      100    440.1      773
BSCP32C.fastq  FASTQ   DNA      1,326  590,139      107    445.1      832
BSCP32N.fastq  FASTQ   DNA      1,444  728,333      102    504.4      904

1. Used cross_match to screen vectors (vector.c)
2. Used SeqClean to scan for contaminations (-s Ecoli,UniVec). SeqClean -v did not screen anything.

Should vector databases (UniVec and vector.seq) be used for end-trimming (-v option), or screening sequences for contamination (-s option)? I think in the analysis described in the manuscript -v option was used. SeqClean, however, does not trim anything if I use this option. On the other hand, cross_match (which is distributed with phrap) screens vector sequences even if they are in the middle.  

For example, for the BSCP32C sample, I get 1582 valid sequences when vectors are trimmed only from ends. I also get 1326 valid sequences when complete sequences are scanned for vectors. 
vvcccbefchvkdjhktrludfhviihfbnechgrciekgvubf


MIRA:
  Length assessment:
  ------------------
  Number of contigs:    372
  Total consensus:      198977
  Largest contig:       1420
  N50 contig size:      571
  N90 contig size:      385
  N95 contig size:      325


TRINITY:
format  type  num_seqs  sum_len  min_len  avg_len  max_len  
FASTA   DNA        334  197,688      205    591.9    1,797



http://bioinfo.bti.cornell.edu/ftp/program/iAssembler/
iAssembler results:
/project/def-orajora/software/iAssembler-v1.3.3.x64/combined.fasta_output/unigene_seq.fasta

for i in `seq 1 1645`; do printf "UN%0*i\n" 4 $i; done > list_all.txt
cut -f1 unigene_matches_embriophyta.tsv | uniq > list_embryophyta.txt

diff list_embryophyta.txt list_all.txt  | grep '^>' | sed 's/^>\ //' > list_no_embryophyta.txt

seqtk subseq unigene_seq.fasta list_no_embryophyta.txt > unigene_seq_no_embryophyta.fasta