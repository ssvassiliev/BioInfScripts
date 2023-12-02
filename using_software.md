
## QuickMerge
ml mummer/4.0.0beta2
merge_wrapper.py -v -l 300 RedSpruce_out.unpadded.fasta trinity_out_dir.Trinity.fasta

## NGS QC Toolkit 
installed in: 
projects/def-orajora/rajni/software/NGSQCToolkit

Running Tools:
ml perl/5.30.2 gcc/9.3.0
perl $NGSQC_HOME/QC/454QC_PE.pl 


## FastQC
~/bin/FastQC/fastqc first_100.fastq

## EdgeR, WGCNA
ml StdEnv/2020 gcc/9.3.0 r-bundle-bioconductor/3.14

## MetaAssembler
cd  /home/rajni/METAASSEMBLER_INSTALL
source  load_metaassembler.sh

## Ntjoin 
ml bedtools/2.30.0 samtools/1.12 
source ~/projects/def-orajora/rajni/software/env-ntjoin/bin/activate 
~/ntJoin/ntJoin assemble target=merged_out.fasta target_weight=1 references=BlackSpruceAssembly.txt reference_weights=2 prefix=redspruce k=32 w=500

## Installing ntJoin
### Cannot be installed in projects because it resets setGID bit
ml python/3.8.10
virtualenv env-ntjoin
source env-ntjoin/bin/activate
pip install --no-index python-igraph pybedtools
pip install pymannkendall meson==0.52.1
git clone https://github.com/bcgsc/ntJoin.git
cd ntJoin/src && make

## Manual MIRA install

module load boost/1.80.0 expat/2.4.1 
./configure --prefix=/project/def-orajora/software/MIRA/ --with-boost=$EBROOTBOOST --with-expat=$EBROOTEXPAT 
make -j8
make install

## FastStructure
ml python/2.7.18 scipy-stack/2020a gsl
export PYTHONPATH=$PYTHONPATH:$HOME/projects/def-orajora/rajni/software/fastStructure:$HOME/projects/def-orajora/rajni/software/fastStructure/vars

