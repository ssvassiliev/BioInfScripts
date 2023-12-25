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

sed '/^>/ s/ .*//' file.fasta 


#   Flags                        Screened
# -minmatch 14 -minscore 30        180908
# -minmatch 10 -minscore 20        186525
# -minmatch 8 -minscore  10        194631

# Locate X's:
seqkit locate -P -d -p 'X+' seqs_fasta_trimmed.screen > x-match.screen
echo -n "Screened base pairs: "
cut -f7 x-match.screen | wc -c
~~~


im_bscp32cx_0001b03.t7m.scf


## Red Spruce Transcriptome Folders
https://unbcloud-my.sharepoint.com/:f:/g/personal/orajora_unb_ca/EprQCvuHLAJEmue2aiYool4BFSflX0dzDC6BJkPn1hHuBQ?email=Serguei.Vassiliev%40unb.ca&e=5%3aNFo45e&fromShare=true&at=9


## SeqClean
module load blast

### UniVec
https://ftp.ncbi.nlm.nih.gov/pub/UniVec/

### Escherichia coli str. K-12 substr. DH10B, complete sequence
https://www.ncbi.nlm.nih.gov/nuccore/NC_010473.1?report=fasta
makeblastdb -in Ecoli.genome.fas -dbtype nucl


### Assembly_stats
pip install assembly_stats

Before cleaning:
file      format  type  num_seqs    sum_len  min_len  avg_len  max_len
BSCP40C   FASTA   DNA      1,926  1,869,302      171    970.6    5,120
BSCP40N   FASTA   DNA      1,750  1,501,223      148    857.8    2,715
BSCP32C   FASTA   DNA      1,750  1,449,641      137    828.4    3,130
BSCP32N   FASTA   DNA      1,628  1,430,003      156    878.4    3,859

Before cleaning (previous analysis):
P32C.fa  FASTA   DNA      1,551  856,004      100    551.9      903
P32N.fa  FASTA   DNA      1,479  848,333      104    573.6      861
P40C.fa  FASTA   DNA      1,693  1,052,865    102    621.9      901
P40N.fa  FASTA   DNA      1,273  577,033      100    453.3      815

After cleaning (present work):
BSCP32C.fastq  FASTQ   DNA      1,497  648,356      104    433.1      832
BSCP32N.fastq  FASTQ   DNA      1,508  777,122      102    515.3      904
BSCP40C.fastq  FASTQ   DNA      1,731  833,401      100    481.5      837
BSCP40N.fastq  FASTQ   DNA      1,312  576,928      100    439.7      773


After cleaning (previous work):
file           format  type  num_seqs  sum_len  min_len  avg_len  max_len
P40C.fa.clean  FASTA   DNA      1,652  781,703      102    473.2      825
P40N.fa.clean  FASTA   DNA      1,243  499,353      101    401.7      709
P32C.fa.clean  FASTA   DNA      1,306  556,899      100    426.4      795
P32N.fa.clean  FASTA   DNA      1,429  672,786      101    470.8      842

file                         format  type  num_seqs    sum_len  min_len  avg_len  max_len
all_unigenes_combined.fasta  FASTA   DNA      3,430  1,780,672      102    519.1    1,918

P32C_UN, contigs numbered from 1 to 328,
P32N_UN, contigs numbered from 1 to 730,
P40C_UN, contigs numbered from 1 to 434,
P40N_UN, contigs numbered from 1 to 223,
                                   1715
All contigs are duplicated!!


grep UN all_unigenes_combined.fasta | cut -c 9-16 | sort -n | uniq | wc
1715 unique unigenes combined
Manuscript: 1343

MIRA assembly:
  "Contig Stats": 
    "L10": 18,
    "L20": 44,
    "L30": 72,
    "L40": 103,
    "L50": 136,
    "N10": 861,
    "N20": 742,
    "N30": 684,
    "N40": 615,
    "N50": 571,
    "gc_content": 45.28010775114712,
    "longest": 1420,
    "mean": 534.8844086021505,
    "median": 507.0,
    "sequence_count": 372,
    "shortest": 147,
    "total_bps": 198977

technology=sanger 288 seq
technology=text   372 seq
-CL:qc=off -CL:cpat=off

TRINITY assembly:
  "Contig Stats": 
    "L10": 15,
    "L20": 36,
    "L30": 61,
    "L40": 88,
    "L50": 118,
    "N10": 1050,
    "N20": 876,
    "N30": 748,
    "N40": 696,
    "N50": 635,
    "gc_content": 44.49486058840193,
    "longest": 1797,
    "mean": 591.8802395209581,
    "median": 559.0,
    "sequence_count": 334,
    "shortest": 205,
    "total_bps": 197688

~~~
MIRA detected chimeric sequences in (at least) one of your readgroups. The
maximum percentage found was 4.87%, which is a complete catastrophe.

Your sequencing provider absolutely needs to get lower numbers, talk to them
about it.

Using a library with this amount of chimeric reads is very, very dangerous in
RNASeq/EST projects.
~~~

iAssembler

DATA_DIR=/project/def-orajora/svassili/BlackSpruce_Needle-Cambium/SCF_Sequence_Files/

cat \
${DATA_DIR}/BSCP32C/SeqClean/seqs_fasta_trimmed.qual.clean \
${DATA_DIR}/BSCP32N/SeqClean/seqs_fasta_trimmed.qual.clean \
${DATA_DIR}/BSCP40C/SeqClean/seqs_fasta_trimmed.qual.clean \
${DATA_DIR}/BSCP40N/SeqClean/seqs_fasta_trimmed.qual.clean > \
combined.fasta.qual

cat \
${DATA_DIR}/BSCP32C/SeqClean/seqs_fasta_trimmed.clean \
${DATA_DIR}/BSCP32N/SeqClean/seqs_fasta_trimmed.clean \
${DATA_DIR}/BSCP40C/SeqClean/seqs_fasta_trimmed.clean \
${DATA_DIR}/BSCP40N/SeqClean/seqs_fasta_trimmed.clean > \
combined.fasta

Cross_match screens with X. X is valid letter for protein sequences, so BioPerl routines do not work. So it is not possible to use cross_match for assembly with iassembler.

(env-bio) [svassili@narval1 combined.fasta_output]$ assembly_stats unigene_seq.fasta


My assembly:
    "N50": 605,
    "gc_content": 47.6625,
    "longest": 1987,
    "mean": 529.7492,
    "median": 520.0,
    "sequence_count": 1647,
    "shortest": 100,
    "total_bps": 872497

Previous work:
    "N50": 573,
    "gc_content": 48.332,
    "longest": 1918,
    "mean": 519.1463,
    "median": 508.0,
    "sequence_count": 1715,
    "shortest": 102,
    "total_bps": 890336
