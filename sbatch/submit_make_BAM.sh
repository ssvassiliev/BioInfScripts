#!/bin/bash
#SBATCH -c8 --mem-per-cpu=4000 --time=3:0:0

ml bowtie2 samtools


#DATA_DIR=$HOME/scratch/RedSprucetranscriptome/illumina/originalfiles/filteringtrimmomatic

#ln -s $DATA_DIR/RS_ambient_CO2.fastq.trimmed control_illumina.fastq
#ln -s $DATA_DIR/ElevatedCO2.fastq.trimmed elevated_illumina.fastq
#ln -s $DATA_DIR/RS_co-treated.fastq.trimmed co-treated_illumina.fastq


# Make the index file
#bowtie2-build --threads $SLURM_CPUS_PER_TASK $HOME/scratch/RedSprucetranscriptome/SNPs/trinity_out_dir.Trinity.fasta Combined.index

# Align the reads to the index
bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index --rg-id control --rg LB:lib1 --rg SM:1 --rg PL:ILLUMINA -U control_illumina.fastq -S control.sam 
bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index --rg-id elevated --rg LB:lib1 --rg SM:1 --rg PL:ILLUMINA -U elevated_illumina.fastq -S elevated.sam
bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index --rg-id cotreated --rg LB:lib1 --rg SM:1 --rg PL:ILLUMINA  -U co-treated_illumina.fastq -S co-treated.sam

samtools view --threads $SLURM_CPUS_PER_TASK -uhS control.sam | \
samtools sort --threads $SLURM_CPUS_PER_TASK -o control_sorted.bam
samtools index control_sorted.bam

samtools view --threads $SLURM_CPUS_PER_TASK -uhS elevated.sam | \
samtools sort --threads $SLURM_CPUS_PER_TASK -o elevated_sorted.bam
samtools index elevated_sorted.bam

samtools view --threads $SLURM_CPUS_PER_TASK -uhS co-treated.sam | \
samtools sort --threads $SLURM_CPUS_PER_TASK -o co-treated_sorted.bam
samtools index co-treated_sorted.bam
