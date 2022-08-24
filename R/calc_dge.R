# Load bioconductor
#module load gcc/9.3.0 r-bundle-bioconductor/3.14

library("edgeR")

df=read.table("count_matrix.csv")

# ???
#L=unlist(strsplit(row.names(df), split="~~"))
#rNames=L[c(seq(1,length(L),2))]

bcv=0.2

M=cbind(df$elevated_sorted.bam, df$control_sorted.bam)
row.names(M)=row.names(df)
y=DGEList(count=M, group=1:2)
keep=filterByExpr(y)
y=y[keep, keep.lib.sizes=FALSE]
y=calcNormFactors(y)
et=exactTest(y, dispersion=bcv^2)
topTags(et)
write.table(et$table, file="cont_vs_elev.csv")

M=cbind(df$co.treated_sorted.bam, df$control_sorted.bam)
row.names(M)=row.names(df)
y=DGEList(count=M, group=1:2)
keep=filterByExpr(y)
y=y[keep, keep.lib.sizes=FALSE]
y=calcNormFactors(y)
et=exactTest(y, dispersion=bcv^2)
topTags(et)
write.table(et$table, file="cont_vs_cotreated.csv")


M=cbind(df$co.treated_sorted.bam, df$elevated_sorted.bam)
row.names(M)=row.names(df)
y=DGEList(count=M, group=1:2)
keep=filterByExpr(y)
y=y[keep, keep.lib.sizes=FALSE]
y=calcNormFactors(y)
et=exactTest(y, dispersion=bcv^2)
topTags(et)
write.table(et$table, file="elev_vs_cotreated.csv")

