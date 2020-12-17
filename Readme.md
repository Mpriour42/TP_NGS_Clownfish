# TP NGS Clownfish

Readme du projet NGS Marthe 

## Specie: _Amphiprion ocellaris_ 
![nemo](https://celebrationspress.com/wp-content/uploads/2017/11/112717Nemo.png)

## Problem of interest: 
Analysis of the fish skin transcriptome to find _saiyan_, a candidate gene involved in the presence of iridophores in white skin. Reference paper: Salis, P, Lorin, T, Lewis, V, et al. Developmental and comparative transcriptomic identification of iridophore contribution to white barring in clownfish. _Pigment Cell Melanoma Res._ 2019; 32: 391– 402. https://doi.org/10.1111/pcmr.12766

## Data-set: 
For each skin color (orange and white), 3 individuals have been sampled: 3x2 = 6 samples. Each sample has been sequenced using Illumina Single-End (50 bases reads).

---
## Analyses steps:
### 1) Raw RNA-seq data download. 

  * **Dowloading the data from the NCBI database**. See the script `RNAseq_data_download.sh`. We download fastq files stored in a SRA_data_folder.
  See the image below for an example of how a fastq file looks:
  ![fastq_example](fastq_example.PNG)
  
    One read is four lines, with the first line carrying the name of the read, the second line carrying the genetic code, the third line is the name again and the fourth is the ASCII code that informs on the reliability of the sequencing associated to each nucleotide.The "/1" after the name of the read indicade that the single read is sequenced as anti-sense (reverse(R)).

  * **Control of the quality of the reads using FASTQC function**. See the script `fastqc.sh`. To better understand the fastq format and how to check the data quality, see the page: https://en.wikipedia.org/wiki/FASTQ_format/
  
    For each file we obtained the basic statistics, per base sequence quality, per sequence quality scores, per base sequence content, per sequence GC content, per base N content, sequence lenght distribution, sequence duplication levels, overrepresented sequences and adapter content. 
  See the image below for an example of basic statistics for one file:
  
    ![basics_statistics](basics_statistics.PNG)

  * **Assembly and comparison of all the FASTQC quality reports for all the sequences using MULTIQC function**. See the script `multiqc.sh`.The quality of the data is very good (see image below) so no need to clean them.
  ![fastqc_per_sequence_quality_scores_plot](fastqc_per_sequence_quality_scores_plot.png)


### 2) Data assembly
  * **Assemby of the reads using TRINITY**. See the script `trinity.sh`. The reads are then assembled into a FASTA file. To get to know how to use trinity, see the page: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity
  
    See the image below for an example of how a fasta file looks:
  ![fasta_example](fasta_example.PNG)
  
    The first line begin with ">" and indicate the name of the read, then follow the genetic code of the sequence. 


### 3) Transcript expression quantification
  * **For each transcript, we determine with SALMON whether it is more express in white skin or orange skin**. See the script `salmon.sh`. To get to know how to use salmon, see the page: https://salmon.readthedocs.io/en/latest/salmon.html
  IMAGE QUANT SALMON
  
### 4) Data annotation
  * **Recover proteomic data from our transcripts with TRANSDECODER**, as coding regions are the most conserved sequences accross species and thus are already associated to a known function. See the script `transdecoder.sh`. To get to know how to use TansDecoder, see the page: https://github.com/TransDecoder/TransDecoder/wiki
  
  script get_stegastes pour avoir le génome le plus proche pour le blast
  
  transdecoder.sh
  
  rename files de transdecoder
  
  blast
  
  DeSseq2.R

Tuto DESeq: https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

http://www.metagenomics.wiki/tools/blast/blastn-output-format-6