#!/bin/bash

## This script use SALMON to determine for each transcripts assembled by TRINITY wheter it is more express in white skin or orange skin.

# Create a working directory:
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a new folder to store salmon datas
mkdir -p data_salmon
cd data_salmon

# Index the transcriptome
salmon index -k 27 -t $SRA_data/SRA_data_trinity/Trinity.fasta -i $SRA_data/transcript_index 

# Quantification
fastq=$SRA_data/*.fastq

for f in $fastq
do

# Rename the SRR without .fastq
NewName=$(basename -s .fastq $f)

salmon quant -gcBias -validateMappings -l SR -p 16 -i $SRA_data/SRA_data_trinity/transcript_index \
-o $SRA_data/data_salmon/$NewName -r $f

# $f: output write in a folder name as the treated fastq


done

# Give the editing rights to the script (only the 1st time) : chmod +x salmon.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./salmon.sh >& nohup.salmon &
# See the advance/error of the running script by opening the file nohup.salmon