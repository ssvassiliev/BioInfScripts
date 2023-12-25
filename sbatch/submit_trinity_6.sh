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

-----


#!/bin/bash
#SBATCH --account=def-srazul
#SBATCH --mem=0
#SBATCH --time=6-23:59        # expect run time (DD-HH:MM)
#SBATCH --nodes=1            
#SBATCH --cpus-per-task=24    # There are 24 CPU cores on P100 Cedar GPU nodes
#SBATCH --gpus-per-node=p100l:4
module load StdEnv/2020  intel/2020.1.217  openmpi/4.0.3
module load nwchem/7.0.2
cp ABCD.nw $SLURM_TMPDIR
sed -i s"#\/home\/bviswana\/scratch#$SLURM_TMPDIR#g" $SLURM_TMPDIR/ABCD.nw
sed -i s'/maxiter 200/maxiter 2000/' $SLURM_TMPDIR/ABCD.nw

srun nwchem $SLURM_TMPDIR/ABCD.nw > $PWD/ABCD.nwo

