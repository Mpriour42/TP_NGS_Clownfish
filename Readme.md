# TP NGS Clownfish

Readme du projet NGS Marthe 

## Specie: _Amphiprion ocellaris_ 
![nemo](https://celebrationspress.com/wp-content/uploads/2017/11/112717Nemo.png)

## Problem of interest: 
analysis of the fish skin transcriptome to find _saiyan_, a candidate gene involved in the presence of iridophores in white skin.

## Data-set: 
for each skin color (orange and white), 3 individuals have been sampled: 3x2 = 6 samples. Each sample has been sequenced using Illumina Single-End (50 bases reads).

---
## Analyses steps:
### 1) Raw RNA-seq data download. 

  * Dowloading the data from the NCBI database. See the script `RNAseq_data_download.sh`. We download fastq files stored in a SRA_data_folder.

  * Control of the quality of the reads using FASTQC function. See the script `fastqc.sh`. To better understand the fastq format and how to check the data quality, see the page: https://en.wikipedia.org/wiki/FASTQ_format

  * Assembly and comparison of all the FASTQC quality reports for all the sequences using MULTIQC function. See the script `multiqc.sh`


### 2) Data assembly
  * Assemby of the reads using TRINITY. See the script `trinity.sh`. The reads are then assembled into a FASTA file. To get to know how to use trinity, see the page: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity


### 3) Transcript expression quantification
  * For each transcript, we determine with SALMON whether it is more express in white skin or orange skin. See the script `salmon.sh`. To get to know how to use salmon, see the page: https://salmon.readthedocs.io/en/latest/salmon.html
  
### 4) Data annotation
  * Recover proteomic data from our transcripts with TRANSDECODER, as coding regions are the most conserved sequences accross species and thus are already associated to a known function. See the script `transdecoder.sh. To get to know how to use TansDecoder, see the page: https://github.com/TransDecoder/TransDecoder/wiki