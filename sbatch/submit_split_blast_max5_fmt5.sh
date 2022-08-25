#!/bin/bash

for FILE in chunk_*
do
SCRIPT=submit_`basename $FILE .fasta`.sh
OUTPUT=blast_`basename $FILE .fasta`.xml
cat > $SCRIPT << END
#!/bin/bash
#SBATCH -c1 --mem-per-cpu=4000 --time=12:0:0

module purge
module load gcc blast+/2.12.0
export BLASTDB=/cvmfs/bio-test.data.computecanada.ca/content/databases/Core/blast_dbs/2022_03_23

blastn -db nt \
-num_threads 1 \
-query $FILE \
-outfmt 5 \
-max_target_seqs 5 \
-out $OUTPUT 
END
echo Submitting $FILE
sbatch $SCRIPT
done	
