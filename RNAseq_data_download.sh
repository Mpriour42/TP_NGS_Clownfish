#!/bin/bash

# Create a working directory:
data="/home/rstudio/data/mydatalocal/data"
mkdir -p $data #Si le dossier existe déjà, il ne recrée pas de nouveau folder
cd $data

# Create a directory where the data will be downloaded
mkdir -p SRA_data
cd SRA_data

# Make a list of SRR accessions:
SRR="SRR7591064
SRR7591065
SRR7591066
SRR7591067
SRR7591068
SRR7591069
"

# For each SRR accession, download the data :
for A in $SRR
do

fastq-dump $A 

# Rename sequence names, trinity need that their name ends with "/1" for R1 and "/2" for R2.

awk  '{ if (NR%2 == 1 ) {gsub("\\.","_");print $1"/1"}  else  { print $0}}' $A.fastq > $A.fastq.modif

mv $A.fastq.modif $A.fastq

# To execute the script even when the machine isn't running use "nohup"
done