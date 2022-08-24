#!/bin/bash
#SBATCH -c8 --mem-per-cpu=4000 --time=3:0:0

ml bowtie2 samtools


DATA_DIR=$HOME/scratch/RedSprucetranscriptome/illumina/originalfiles/filteringtrimmomatic
DATA_DIR2=$HOME/scratch/RedSprucetranscriptome/454/originalfiles/filteringsolexa

ln -s $DATA_DIR/RS_ambient_CO2.fastq.trimmed control_illumina.fastq
ln -s $DATA_DIR/ElevatedCO2.fastq.trimmed elevated_illumina.fastq
ln -s $DATA_DIR/RS_co-treated.fastq.trimmed co-treated_illumina.fastq

ln -s $DATA_DIR2/RSControl.fastqsanger.trimmed.single control_454.fastq
ln -s $DATA_DIR2/RSelevatedCO2.fastqsanger.trimmed.single elevated_454.fastq
ln -s $DATA_DIR2/RSCotreated.fastqsanger.trimmed.single co-treated_454.fastq

# Make the index file
#bowtie2-build --threads $SLURM_CPUS_PER_TASK $HOME/scratch/RedSprucetranscriptome/Trinity_combined/trinity_out_dir.Trinity.fasta Combined.index

# Align the reads to the index
#bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index \
#-U control_454.fastq,control_illumina.fastq -S control.sam

#bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index \
#-U elevated_454.fastq,elevated_illumina.fastq -S elevated.sam

#bowtie2 --threads $SLURM_CPUS_PER_TASK  -x Combined.index \
#-U co-treated_454.fastq,co-treated_illumina.fastq -S co-treated.sam

#samtools view --threads $SLURM_CPUS_PER_TASK -uhS control.sam | \
#samtools sort --threads $SLURM_CPUS_PER_TASK -o control_sorted.bam

#samtools view --threads $SLURM_CPUS_PER_TASK  -uhS elevated.sam | \
#samtools sort --threads $SLURM_CPUS_PER_TASK  -o elevated_sorted.bam

#samtools view --threads $SLURM_CPUS_PER_TASK -uhS co-treated.sam  | \
#samtools sort --threads $SLURM_CPUS_PER_TASK  -o co-treated_sorted.bam

# Convert gff3 to gtf
#gffread  /home/rajni/scratch/RedSprucetranscriptome/CD_hitclust_com_Trinity/clustered_contigs.transdecoder.gff3 -T > contigs.gtf

#$HOME/projects/def-orajora/rajni/software/TPMCalculator/bin/TPMCalculator -b control_sorted.bam -g contigs.gtf 
$HOME/projects/def-orajora/rajni/software/TPMCalculator/bin/TPMCalculator -b elevated_sorted.bam -g contigs.gtf  
$HOME/projects/def-orajora/rajni/software/TPMCalculator/bin/TPMCalculator -b co-treated_sorted.bam -g contigs.gtf  

