#!/bin/bash
#SBATCH -c16 --nodes=1 --mem-per-cpu=4000 --time=20:0:0

module load gcc salmon samtools jellyfish trinity python scipy-stack
DATA_DIR=$HOME/scratch/RedSprucetranscriptome/illumina/originalfiles/filteringtrimmomatic
DATA_DIR2=$HOME/scratch/RedSprucetranscriptome/454/originalfiles/filteringsolexa
WORKDIR=`pwd`
cd $SLURM_TMPDIR

Trinity --seqType fq --max_memory 60G --CPU $SLURM_CPUS_PER_TASK --single \
$DATA_DIR/RS_ambient_CO2.fastq.trimmed,\
$DATA_DIR/ElevatedCO2.fastq.trimmed,\
$DATA_DIR/RS_co-treated.fastq.trimmed,\
$DATA_DIR2/RSControl.fastqsanger.trimmed.single,\
$DATA_DIR2/RSCotreated.fastqsanger.trimmed.single,\
$DATA_DIR2/RSelevatedCO2.fastqsanger.trimmed.single

cp trinity_out_dir.Trinity.fasta trinity_out_dir.Trinity.fasta.gene_trans_map $WORKDIR
