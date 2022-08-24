#!/bin/bash

echo "Usage: $0 <input_filename>"
FILENAME=$1

module load r
rm ${FILENAME}.*
rm ${FILENAME}_*

SolexaQA++ dynamictrim ${FILENAME} -h 20 -t 
SolexaQA++ lengthsort ${FILENAME}.trimmed  -l 35 
~/bin/FastQC/fastqc ${FILENAME}.trimmed.single    

