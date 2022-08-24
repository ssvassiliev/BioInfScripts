#!/bin/bash
#SBATCH -c4 --nodes=1 --mem-per-cpu=4000 --time=12:0:0

module load gcc salmon samtools jellyfish trinity python scipy-stack
DATA_DIR=$HOME/scratch/454
WORKDIR=`pwd`

cp $DATA_DIR/RSControl/70bpcutoff/RSControl.fastqsanger.trimmed $SLURM_TMPDIR
cp $DATA_DIR/RSelevatedCO2/70bpcutoff/RSelevatedCO2.fastqsanger.trimmed $SLURM_TMPDIR
cp $DATA_DIR/RSCotreated/70bpcutoff/RSCotreated.fastqsanger.trimmed $SLURM_TMPDIR

cd $SLURM_TMPDIR

Trinity --seqType fq --max_memory 16G --CPU $SLURM_CPUS_PER_TASK --single \
RSControl.fastqsanger.trimmed,\
RSelevatedCO2.fastqsanger.trimmed,\
RSCotreated.fastqsanger.trimmed  

cp trinity_out_dir.Trinity.fasta* $WORKDIR

