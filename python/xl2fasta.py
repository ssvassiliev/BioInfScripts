import pandas as pd
import openpyxl as xl
import csv

wb=xl.load_workbook(filename = 'filtered_blast.xlsx') 
wb.sheetnames
ws=wb['Sheet1']
df = pd.DataFrame(ws.values)
df.columns=df.loc[0,:].to_list()
df=df.drop(labels=0, axis=0)
df['qseq'] = df['qseq'].str.replace('-','')
df['Unnamed: 0'] = '>'
df['qstart']='\n' 
df['qseqid']=df['Unnamed: 0']+df['qseqid']+df['qstart']+df['qseq']
col_to_keep=['qseqid']
output=df.loc[:,col_to_keep]
output.to_csv('filtered_blast.fasta', sep=' ', header=False,  index=False, quoting=csv.QUOTE_NONE, quotechar="", escapechar=" ")
