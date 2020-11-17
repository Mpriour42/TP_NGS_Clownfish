#!/bin/bash

# Go in the working directory that stores the fastqc datas
SRA_data_quality=/home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality
cd $SRA_data_quality

multiqc -o /home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_quality_combined $SRA_data_quality