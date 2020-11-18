#!/bin/bash

## This script combines the data quality reports made by FASTQC using MULTIQC function

# Go in the working directory that stores the fastqc datas
SRA_data_quality=/home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality
cd $SRA_data_quality

# Run Multiqc and send the output in a folder called "SRA_data_quality_combined"

multiqc -o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality_combined $SRA_data_quality

# Give the editing rights to the script (only the 1st time) : chmod +x multiqc.sh
# To execute the script even when the machine isn't running use "nohup" : nohup ./multiqc.sh >& nohup.multiqc &
# See the advance/error of the running script by opening the file nohup.multiqc