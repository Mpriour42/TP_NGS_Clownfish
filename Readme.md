#TP NGS Clownfish

Readme du projet NGS Marthe 

##Specie: _Amphiprion ocellaris_ 
IMAGE

##Problem of interest: 
analysis of the skin transcriptome to find _saiyan_, a candidate gene involved in the presence of iridophores in white skin.

##Data-set: 
for each skin color (orange and white), 3 individuals have been sampled: 3x2 = 6 samples. Each sample has been sequenced using Illumina Single-End (50 bases reads).

##Analyses steps:
###1) Raw RNA-seq data download. 
&nbsp
--> Dowloading the data from the NCBI database. See the script **RNAseq_data_download.sh** 
&nbsp
--> Control of the quality of the reads using FASTQC function. See the script **fastqc.sh**
&nbsp
--> Assembly and comparison of all the FASTQC quality reports for all the sequences using MULTIQC function. See the script **multiqc.sh**
&nbsp

###2) Data assembly
&nbsp
--> Assemby of the reads using Trinity tool. See the script **trinity.sh**
&nbsp

###3) Transcript expression quantification
&nbsp
--> For each transcript, determine wheter it is more express in white skin or orange skin. See the script **salmon.sh**