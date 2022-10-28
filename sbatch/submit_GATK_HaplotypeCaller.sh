#!/bin/bash

#SBATCH --mem-per-cpu=4000 -c2 --time=12:0:0

ml gatk/4.2.4.0

# ml samtools
# samtools faidx trinity_out_dir.Trinity.fasta
# gatk CreateSequenceDictionary -R trinity_out_dir.Trinity.fasta
# gatk HaplotypeCaller -R trinity_out_dir.Trinity.fasta -I bowtie2/control_sorted.bam  -O control.gvcf 
# gatk HaplotypeCaller -R trinity_out_dir.Trinity.fasta -I bowtie2/elevated_sorted.bam  -O elevated.gvcf
gatk HaplotypeCaller -R trinity_out_dir.Trinity.fasta -I bowtie2/co-treated_sorted.bam  -O co-treated.gvcf
