#!/bin/bash

DATADIR=$HOME/projects/def-orajora/rajni/software/kofamscan/kofam_scan/splits

for FILE in $DATADIR/chunk_*
do
SCRIPT=$DATADIR/submit_`basename $FILE .fasta`.sh
OUTPUT=$DATADIR/kofamscan_`basename $FILE .fasta`.out
cat > $SCRIPT << END
#!/bin/bash
#SBATCH -c16 --mem-per-cpu=4000 --time=3:0:0

ml hmmer

./exec_annotation \
-f detail-tsv \
--cpu \$SLURM_CPUS_PER_TASK \
--tmp-dir \$SLURM_TMPDIR \
-o $OUTPUT \
$FILE
END
echo Submitting $FILE
sbatch $SCRIPT
done	
