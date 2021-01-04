#! /bin/bash

## This script uses Transdecoder to recover coding sequences out of our transcripts

data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a folder to store the output of TransDecoder
mkdir -p transdecoder_data
cd transdecoder_data

# Pay attention that transdecoder generates files in the current directory
# Launch Transdecoder

# Step 1: extracts the long open reading frames (TransDecoder.LongOrfs)
TransDecoder.LongOrfs -t $data/SRA_data/SRA_data_trinity/Trinity.fasta -S --gene_trans_map $data/SRA_data/SRA_data_trinity/Trinity.fasta.gene_trans_map -O $data/transdecoder_data

# Step 2: blasts to identify peptides with homology to known proteins (optionnal) 

# Step 3: predicts the likely coding regions (TransDecoder.Predict)
TransDecoder.Predict -t $data/SRA_data/SRA_data_trinity/Trinity.fasta --single_best_only -O $data/transdecoder_data

# Give the editing rights to the script (only the 1st time) : chmod +x transdecoder.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./transdecoder.sh >& nohup.transdecoder &
# See the advance/error of the running script by opening the file nohup.transdecoder