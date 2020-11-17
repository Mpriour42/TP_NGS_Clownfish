#!/bin/bash

# Go in the working directory that stores the datas
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a folder for the fastqc output files
mkdir -p SRA_data_quality

# Define a variable that contains the fastq files (1st way)
#SRR="SRR7591064.fastq
#SRR7591065.fastq
#SRR7591066.fastq
#SRR7591067.fastq
#SRR7591068.fastq
#SRR7591069.fastq"

# Define a variable that contains the fastq files (2nd way)
fastq=$SRA_data/*.fastq

# For each fastq file (1st way): 
#for f in $SRR
#do

# For each fastq file (2nd way):
for f in $fastq
do

fastqc -o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality -t 16 $f

done
