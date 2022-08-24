#!/bin/bash
#SBATCH --ntasks=1 -c1 --mem-per-cpu=4000 --time=0:20:0 

FILENAME=ElevatedCO2.fastq.gz
OUTPUT_FILENAME=`basename  $FILENAME .gz`.trimmed
rm $OUTPUT_FILENAME ${OUTPUT_FILENAME}_* 
module load trimmomatic

java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar SE -threads $SLURM_CPUS_PER_TASK $FILENAME $OUTPUT_FILENAME LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:64 AVGQUAL:30
~/bin/FastQC/fastqc $OUTPUT_FILENAME  
