import pandas as pd
import openpyxl


pd.options.mode.chained_assignment = None

#Cut-off values
max_eval=0.01
min_bitscore=40
min_qcovs=50

# Function to find the longest query sequences in the dataframe
# qseqids - list of unique qseqids
def find_longest_qseq(qseqids):
    new_df=dfs.iloc[0:0].copy()
    nseq=len([*set(dfs['qseqid'])])
    for idx, seq in enumerate([*set(dfs['qseqid'])]):
        slice=dfs.loc[dfs['qseqid'] == seq]
        print('processing ', idx, '/' , nseq, sep='', flush=True)
        new_df=pd.concat([new_df, pd.DataFrame(slice.loc[slice['qlen'].idxmax()]).T])
    return new_df


df=pd.read_table("annotations_NT.fasta")
#df=pd.read_table("test.txt")
df.columns=['qseqid', 'salltitles', 'slen', 'qstart', 'qend', 'sstart', 'send', 'qseq', 'sseq', 'evalue', 'bitscore', 'length', 'pident', 'nident', 'mismatch', 'gapopen', 'gaps', 'qcovs']
# Apply cut-offs
dfs=df.loc[(df['evalue'] <= max_eval) & (df['qcovs'] >= min_qcovs) & (df['bitscore'] >= min_bitscore)]

# Compute query length column and add to the dataframe
dfs['qlen']=list(abs(dfs.qend - dfs.qstart))

# Compile the list of unique sequence IDs
qseqids=[*set(dfs['qseqid'])]

new_df=find_longest_qseq(qseqids)

new_df.to_csv("filtered_blast_t.csv", sep =';')
#new_df.to_excel("filtered_blast.xlsx")
