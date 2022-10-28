#!/bin/bash
# Usage: $0

for file in *.gff3
do
NAME=`basename $file .gff3`

## Converting input file from GenBank format to a cleaned GFF3 format
grep "gene=" ${NAME}.gff3 | \
    awk -F';' '{print $1}' | \
    grep -vE "remark|intron|misc_feature|repeat_region" | \
    sed  's/[tr]RNA/gene/'  > ${NAME}.gff.clean

## Converting input file from clean GFF3 format to VISTA format
grep -v "^#" ${NAME}.gff.clean | \
    grep -v "rps12" | \
    awk '{if ($3 ~ /gene/) {print $7" "$4" "$5" "$3" "$9} else {print $7" "$4" "$5" "$3} }' | \
    awk '{if ($4 ~ /gene/) {gsub(/\+/, ">", $1); gsub(/\-/, "<", $1); print $0} else {$1=""; print $0} }' | \
    sed 's/gene=//' | \
    sed 's/gene/agene/' | \
    sort -n -k2 | \
    sed 's/agene/gene/' | \
    awk '{$1=$1}1' | \
    sed 's/CDS/exon/' | \
    sed 's/tRNA/utr/' | \
    sed 's/rRNA/utr/' | \
    perl -pe 's/ID.*?_//' | \
    sed 's/_.*$/ /' | \
    sed 's/gene//' > ${NAME}.mvista 
done
