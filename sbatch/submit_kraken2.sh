module load StdEnv/2020 gcc/9.3.0
module load kraken2/2.1.1

WORKDIR=`pwd`
RESULTS_DIR=test_results

cp -r kraken2database 06-270_S_p_R1.trim.fq  $SLURM_TMPDIR
cd $SLURM_TMPDIR
mkdir $RESULTS_DIR

kraken2 --threads $SLURM_CPUS_PER_TASK --db kraken2database \
--output  $RESULTS_DIR/06-267_S_p_R1.Krak.txt \
--report $RESULTS_DIR/06-267.kreport \
--classified-out $RESULTS_DIR/06-267.classified.fastq \
--unclassified-out $RESULTS_DIR/06-267.unclassified.fastq \
--use-names  --memory-mapping  --confidence 0.5 06-270_S_p_R1.trim.fq 

cp -r $RESULTS_DIR $WORKDIR
