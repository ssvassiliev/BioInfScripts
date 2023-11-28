


DGE:
projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/DGE

1. Build bowtie2 index from the assembled transcriptome.
projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/Trinity_combined/Trinity_combined_14082022.fasta (134336 contigs)

2. Align the reads to the index.
Filtered Illumina + 454 reads (6 files) assembled with Trinity.
control_454.fastq,control_illumina.fastq        ---> control.sam
elevated_454.fastq,elevated_illumina.fastq      ---> elevated.sam
co-treated_454.fastq,co-treated_illumina.fastq  ---> co-treated.sam
...
Not sure if these files are still available, they were on scratch


3. Sort ---> control_sorted.bam, elevated_sorted.bam, co-treated_sorted.bam


4. CD-hit clustering:
projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/CD_hitclust_com_Trinity

Input /scratch/RedSprucetranscriptome/Trinity_combined/trinity_out_dir.Trinity.fasta 

projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/illumina/originalfiles/filteringtrimmomatic/Trinity/trinity_out_dir.Trinity.fasta  (133371) ? (91602 >= 300) - This is illumina - only assembly.

seqkit seq -m 300 trinity_out_dir.Trinity.fasta -g  > Trinity_min_300.fasta


We have. 
projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/Trinity_combined/Trinity_combined_14082022.fasta (134336 contigs) (93359 >= 300)

In Manuscript 93324 contigs (≥300bp) 

Result: clustered_contigs.transdecoder.gff3 
The output of CD-Hit analysis clustered_contigs.clstr has 114808 clusters. 

Convert clustered_contigs.transdecoder.gff3 to gtf ---> contigs.gtf (46728 transcripts)

projects/def-orajora/rajni/SEPT22_RedSpruceTRANS_Data_scratch/DGE

4. Make counts Matrix
Inputs:  sorted .bam files + contigs.gtf
Output:  count_matrix.csv

5. EdgeR


Select_contigs:
~~~
import pandas as pd
from glob import glob
from pathlib import PurePosixPath

FC_cut=2
PValue_cut=0.05

for i in glob("*.csv"):
    df=pd.read_csv(i, sep=' ')
    out=df[(abs(df["logFC"]) > FC_cut) & (df["PValue"] < PValue_cut)]
    out.to_csv(f'{PurePosixPath(i).stem}-trimmed.csv', sep=' ')
~~~