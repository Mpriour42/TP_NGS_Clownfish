#!/bin/bash

## This script controls of the quality of the reads using FASTQC function

# Go in the working directory that stores the raw datas
SRA_data="/home/rstudio/data/mydatalocal/data/SRA_data"
cd $SRA_data

# Create a folder for the fastqc output files
mkdir -p SRA_data_quality

# Define a variable that contains the fastq files
fastq=$SRA_data/*.fastq

# For each fastq file, execute the fastqc function
for f in $fastq
do

fastqc -o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality -t 16 $f

done

# Give the editing rights to the script (only the 1st time) : chmod +x fastqc.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./fastqc.sh >& nohup.fastqc &
# See the advance/error of the running script by opening the file nohup.fastqc
