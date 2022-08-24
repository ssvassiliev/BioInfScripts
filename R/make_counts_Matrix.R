library("Rsubread")

cont=featureCounts(files="control_sorted.bam", annot.ext=
"contigs.gtf", isGTFAnnotationFile=TRUE, GTF.featureType="exon", GTF.attrType="gene_id", nthreads=4)
elev=featureCounts(files="elevated_sorted.bam", annot.ext=
"contigs.gtf", isGTFAnnotationFile=TRUE, GTF.featureType="exon", GTF.attrType="gene_id", nthreads=4)
cotreated=featureCounts(files="co-treated_sorted.bam", annot.ext=
"contigs.gtf", isGTFAnnotationFile=TRUE, GTF.featureType="exon", GTF.attrType="gene_id", nthreads=4)


M=cbind(cont$counts, elev$counts, cotreated$counts)
write.table(M, file="count_matrix.csv")


