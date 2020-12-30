# TP NGS Clownfish

Readme du projet NGS Marthe 

## Specie: _Amphiprion ocellaris_ 
![nemo](https://celebrationspress.com/wp-content/uploads/2017/11/112717Nemo.png)

## Problem of interest: 
Compared to mammals that only have one pigment cell type (melanocytes), actinopterygians fishes harbor at least eight types of pigment cells (melanophores, iridophores, xanthophores, ect.). Our study focus on the clownfish _Amphiprion ocellaris_, which exhibits a specific color pattern of vertical white bars alternate with orange bars. We conduct a transcriptomic analysis of the fish skin in order to determine the genetic basis of this pattern and the type of pigment cells implicated in the white tissue (iridophores or leucophores). The presence of the gene _saiyan_ would potentially inform on the presence of iridophores in white skin. 

**Reference paper**: Salis, P, Lorin, T, Lewis, V, et al. Developmental and comparative transcriptomic identification of iridophore contribution to white barring in clownfish. _Pigment Cell Melanoma Res._ 2019; 32: 391– 402. https://doi.org/10.1111/pcmr.12766

## Data-set: 
For each skin color (orange and white), 3 individuals have been sampled: 3x2 = 6 samples. Each sample has been sequenced using Illumina Single-End (50 bases reads).

---
## Analyses steps:
### 1) Raw RNA-seq data download. 

  * **Downloading the data from the NCBI database**. The reads are available on NCBI database, under BioProject PRJNA482393 and BioProject PRJNA482578. Our 6 samples of interest can be found from SRR7591064 to SRR7591069. See the script `RNAseq_data_download.sh`. We download fastq files stored in a SRA_data_folder.
  See the image below for an example of how a fastq file looks:
  ![fastq_example](fastq_example.PNG)
  
    One read is four lines, with the first line carrying the name of the read, the second line carrying the genetic code, the third line is the name again and the fourth is the ASCII code that informs on the reliability of the sequencing associated to each nucleotide. The "/1" after the name of the read indicade that the single read is sequenced as anti-sense (reverse(R)).

  * **Control of the quality of the reads using FASTQC function**. See the script `fastqc.sh`. To better understand the fastq format and how to check the data quality, see the page: https://en.wikipedia.org/wiki/FASTQ_format/
  
    For each file we obtained the basic statistics, per base sequence quality, per sequence quality scores, per base sequence content, per sequence GC content, per base N content, sequence lenght distribution, sequence duplication levels, overrepresented sequences and adapter content. 
  See the image below for an example of basic statistics for one file:
  
    ![basics_statistics](basics_statistics.PNG)

  * **Assembly and comparison of all the FASTQC quality reports for all the sequences using MULTIQC function**. See the script `multiqc.sh`.The quality of the data is very good (see image below) so no need to clean them.
  ![fastqc_per_sequence_quality_scores_plot](fastqc_per_sequence_quality_scores_plot.png)


### 2) Data assembly
  * **Assemby of the reads using TRINITY**. See the script `trinity.sh`. The reads are then assembled into a FASTA file. To get to know how to use trinity, see the page: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity. Basically, Trinity combines three modules: Inchworm, Chrysalis and Butterfly, that together assemble reads in linear sequences, then make a graph and distribute the reads between clusters for each gene, and finally reconstruct isoforms and separate paralogs. One should use the `nohup`command to run the script because Trinity can take long.
  
    See the image below for an example of how a fasta file looks:
  ![fasta_example](fasta_example.PNG)
  
    The first line begin with ">" and indicate the name of the read, then follow the genetic code of the sequence. 


### 3) Transcript expression quantification
  * **For each transcript, we determine with SALMON whether it is more express in white skin or orange skin**. See the script `salmon.sh`. To get to know how to use salmon, see the page: https://salmon.readthedocs.io/en/latest/salmon.html. Based on the assumption that the more reads a gene has, the more expressed he is, Salmon index the transcriptom from our fasta files (output of Trinity) and then quantify the expression of the transcripts from the index and fastq files. 
  
    See the image below for an example of salmon quantification table:
  ![quant_salmon_file](quant_salmon_file.PNG)
  
    The first column indicates the name of the transcript assemble by Trinity.
    The second column indicates the lenght of the transcript and the third column the effective lenght.
    The fourth column indicates the TPM (transcripts per million), which is the total number of reads normalized by the overall lenght.
    The last column indicates the number of reads associated with the transcript.
  
### 4) Data annotation
  * **Get a genome of reference**: downloading of the genome of _Stegastes partitus_ that was the closest sequenced genome of the clownfish at the time of our paper (Salis et al., 2019). See the script `get_stegastes.sh`. The script `Rename_stegastes.awk` renames the downloaded sequences (to execute this script, use the command `awk`. The command `gunzip`followed by the file name unzip the downloaded genome. 
  
  * **Recover proteomic data from our transcripts with TRANSDECODER**, as coding regions are the most conserved sequences accross species and thus are already associated to a known function. See the script `transdecoder.sh`. To get to know how to use TansDecoder, see the page: https://github.com/TransDecoder/TransDecoder/wiki.
Rename Transdecoder's output files before the blast with the line:
`awk '{print $1}' Trinity.fasta.transdecoder cds > rename.cds`

  * **Detect the homologies between our transcripts (coding sequences of _Amphiprion ocellaris_) and references genes (genome of _Stegastes partitus_) using BLAST** 
See the script `blast.sh`. To understand columns in blast table: http://www.metagenomics.wiki/tools/blast/blastn-output-format-6. 
    See the image below for an example of blast output:
  ![](.PNG)
  
  The command `cut -f1 blast |sort |uniq |wc -l`to see how many hit the blast found. 
  
  * **Script to create a csv annotation table**

  
### 5) Differential expression analysis
  DeSseq2.R

Tuto DESeq: https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

  ![table_differential_expression](table_differential_expression.PNG)
  ![top_10_genes_most_differentially_expressed](top_10_genes_most_differentially_expressed.PNG)
  ![maplot](maplot.PNG)
  ![volcanoplot](volcanoplot.PNG)
  ![ACP](ACP.PNG)
  
Interpretation /!\
