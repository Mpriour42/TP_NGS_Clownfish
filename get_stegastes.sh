#! /bin/bash

## This script download the genome of Stegastes partitus 

data=/home/rstudio/data/mydatalocal/data

#wget dowload coding sequences of stegastes partisus from ensembl database
wget ftp://ftp.ensembl.org/pub/release-102/fasta/stegastes_partitus/cds/Stegastes_partitus.Stegastes_partitus-1.0.2.cds.all.fa.gz -O $data/stegastes_coding.fa.gz 
                        
# Give the editing rights to the script (only the 1st time) : chmod +x get_stegastes.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./get_stegastes.sh >& nohup.get_stegastes &
# See the advance/error of the running script by opening the file nohup.get_stegastes