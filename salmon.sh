#!/bin/bash

## This script use SALMON to determine for each transcripts assembled by TRINITY wheter it is more express in white skin or orange skin.

#Create a working directory:
data="/home/rstudio/data/mydatalocal/data"
cd $data

#Create a new folder to store salmon datas
mkdir -p data_salmon
cd data_salmon

# Index the transcriptome
salmon index -t FASTA.fa -i trasncript_index

# Quantification
fastq=$sra_data/*.fastq

for f in $fastq
do

salmon quant -i $data/SRA_data_trinity/transcript_index \
-o /home/rstudio/data/mydatalocal/data/data_salmon -r $f

done

# Give the editing rights to the script (only the 1st time) : chmod +x salmon.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./salmon.sh >& nohup.salmon &
# See the advance/error of the running script by opening the file nohup.salmon