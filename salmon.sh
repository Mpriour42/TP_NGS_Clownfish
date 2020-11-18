#!/bin/bash

## This script use SALMON to determine for each transcripts assembled by TRINITY wheter it is more express in white skin or orange skin.

#Go in the directory that stores trinity fasta
SRA_data_trinity="/home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_trinity"
cd $SRA_data_trinity

#Create a new folder to store salmon datas
mkdir -p SRA_data_salmon

# Index the transcriptome
salmon index -t FASTA.fa -i trasncript_index

# Quantification
For 
salmon quant -i $SRA_data_trinity/transcript_index \
-o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_salmon -r .../*fastq

# Give the editing rights to the script (only the 1st time) : chmod +x salmon.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./salmon.sh >& nohup.salmon &
# See the advance/error of the running script by opening the file nohup.salmon