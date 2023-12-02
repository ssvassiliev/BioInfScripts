from Bio import SeqIO
import sys

print("Usage: python $0 file.fasta file.qual")

fasta=sys.argv[1]
qual=sys.argv[2]

reads = SeqIO.to_dict(SeqIO.parse(fasta, "fasta"))
for rec in SeqIO.parse(qual, "qual"):
   reads[rec.id].letter_annotations["phred_quality"]=rec.letter_annotations["phred_quality"]
fout=open(f'{fasta}.fastq', "w") 
SeqIO.write(reads.values(), fout, 'fastq')
fout.close()


