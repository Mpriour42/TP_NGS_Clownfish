#!/bin/bash

# Go in the working directory
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a folder for the fastqc
mkdir -p SRA_data_quality

# Make a list of SRR accessions:
SRR="SRR7591064.fastq
SRR7591065.fastq
SRR7591066.fastq
SRR7591067.fastq
SRR7591068.fastq
SRR7591069.fastq"

# Pour chaque fastq 
for f in $SRR
do

fastqc -o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality -t 16 $f

done
