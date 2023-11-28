# Black spruce transcriptomics
Original data:
https://unbcloud-my.sharepoint.com/:f:/g/personal/orajora_unb_ca/EjNENTRtwZpGsc1szD0QbBUB4YAOqSqND1n-lTlGhvyz2A?email=Serguei.Vassiliev%40unb.ca&e=5%3a0ZlNXi&fromShare=true&at=9

## Installing phred
phred-dist-071220.c-acd.tar.gz 
phd2fasta-acd-dist.130911.tar.gz 

Running phred:

PHREDROOT=/project/def-orajora/software/phred/
export PATH=$PATH:$PHREDROOT/bin/
export PHRED_PARAMETER_FILE=$PHREDROOT/phredpar.dat

BSCP32C
1829 SCF files, 80 unusable.

Original fasta file: 
Fasta_Sequence_Files/BSCP32C_seqs_fasta:

1750 l,  31982 w, 1164213 c

Fasta created from SCF files:

phred -id data -trim_alt "" -trim_fasta -pd phd_dir 

1750 l,  31982 w, 1163946 c


phd2fasta -id phd_dir -os seqs_fasta -oq seqs_fasta.screen.qual 

cross_match seqs_fasta vector.seq -minmatch 12 -minscore 20 -screen 

defaults: -minmatch 14 -minscore 30


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




## Red Spruce Transcriptome Folders
https://unbcloud-my.sharepoint.com/:f:/g/personal/orajora_unb_ca/EprQCvuHLAJEmue2aiYool4BFSflX0dzDC6BJkPn1hHuBQ?email=Serguei.Vassiliev%40unb.ca&e=5%3aNFo45e&fromShare=true&at=9


## SeqClean
module load blast

### UniVec
https://ftp.ncbi.nlm.nih.gov/pub/UniVec/

### Escherichia coli str. K-12 substr. DH10B, complete sequence
https://www.ncbi.nlm.nih.gov/nuccore/NC_010473.1?report=fasta
makeblastdb -in Ecoli.genome.fas -dbtype nucl
