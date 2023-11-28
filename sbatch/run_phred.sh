PHREDROOT=/project/def-orajora/software/phred/
PHRAPROOT=/project/def-orajora/software/phrap
export PATH=$PATH:$PHREDROOT/bin/:$PHRAPROOT/bin/
export PHRED_PARAMETER_FILE=$PHREDROOT/phredpar.dat

DATA=BSCP32C.zip 
#unzip $DATA *.scf -d scf_files 
mkdir -p phd_untrimmed

phred -id scf_files -pd phd_untrimmed 
phd2fasta -id phd_untrimmed -os seqs_fasta_no_trim -oq seqs_fasta_no_trim.qual

#phred -id data -trim_alt "" -trim_phd -pd phd_trim_dir
#phd2fasta -id phd_trim_dir -os seqs_fasta_trimmed -oq seqs_fasta_trimmed.qual
#cross_match seqs_fasta_trimmed vector.seq -minmatch 14 -minscore 30 -screen

#   Flags                        Screened
# -minmatch 14 -minscore 30        180908
# -minmatch 10 -minscore 20        186525
# -minmatch 8 -minscore  10        194631

# Locate X's:
#seqkit locate -P -d -p 'X+' seqs_fasta_trimmed.screen > x-match.screen
#echo -n "Screened base pairs: "
#cut -f7 x-match.screen | wc -c
