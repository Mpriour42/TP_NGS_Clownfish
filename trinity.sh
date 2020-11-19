#!/bin/bash

## This script assembles the reads from the raw SRA data with the TRINITY function
  
# Go in the working directory that stores the raw datas
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a folder for the trinity output files
mkdir -p SRA_data_trinity

FASTQ=$(ls $SRA_data/*.fastq |paste -s -d, -)

Trinity --seqType fq --SS_lib_type R --max_memory 50G --CPU 16 --single $FASTQ \
--normalize_by_read_set --output /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_trinity/

# Remove length and path in sequence names to avoid bug with blast (sequence name length > 1000)
# sed -re "s/(>[_a-zA-Z0-9]*)( len=[0-9]*)( path=.*)/\1/"

# Give the editing rights to the script (only the 1st time) : chmod +x trinity.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./trinity.sh >& nohup.trinity &
# See the advance/error of the running script by opening the file nohup.trinity