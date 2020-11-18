#! /bin/bash

## This script use TransDecoder to find the coding regions within the transcripts (fasta file output of trinity)

# Create a working directory:
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a new folder to store transcoder datas
mkdir -p data_transdecoder

# launch Transdecoder
# Step 1: extract the long open reading frames
TransDecoder.LongOrfs -t $SRA_data/SRA_data_trinity/Trinity.fasta -m ??? #m :By default, TransDecoder.LongOrfs will identify ORFs that are at least 100 amino acids long. You can lower this via the '-m' parameter, but know that the rate of false positive ORF predictions increases drastically with shorter minimum length criteria.

# Step 2 (facultative): identify ORFs with homology to known proteins via blast or pfam searches.

# Step 3: predict the likely coding regions
TransDecoder.Predict -t $SRA_data/SRA_data_trinity/Trinity.fasta [ homology options ] \
--output_dir $data/data_transdecoder

# Give the editing rights to the script (only the 1st time) : chmod +x transdecoder.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./transdecoder.sh >& nohup.transdecoder &
# See the advance/error of the running script by opening the file nohup.transdecoder