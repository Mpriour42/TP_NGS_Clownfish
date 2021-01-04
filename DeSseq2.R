## Differential expression statistical analysis:

# libraries:
library("tximport")
library("readr")
library(apeglm)
library("DESeq2",quietly = T)

# Location of the data:
dir <- "/home/rstudio/data/mydatalocal/data/SRA_data/data_salmon"

# Import the data:
samp.name <- c("SRR7591064","SRR7591065","SRR7591066","SRR7591067","SRR7591068","SRR7591069")
samp.type <- c("orange","white","orange","orange","white","white")
samples <- data.frame(run=samp.name,condition=samp.type)
# Use "samples" to see the table

files <- file.path(dir, samples$run, "quant.sf")
names(files) <- samples$run

# Data frame to know association gene transcript:
tx2gene <- read.table(file = "/home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_trinity/Trinity.fasta.gene_trans_map",
                              header = FALSE,sep ="\t",col.names = c("geneid","txname"))[,c(2,1)]
# head(tx2gene) to visualize the first columns of the table
# [,c(2,1)] inverts the two columns

# Import the data and store them in a txi variable:
txi <- tximport(files,type="salmon",tx2gene=tx2gene)
# head(txi$counts) to visualize the counts table (base of DeSeq2)

# DE analysis:
ddsTxi <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ condition)
# ~ condition: the condition here is the skin color
keep <- rowSums(counts(ddsTxi)) >= 10
dds <- ddsTxi[keep,]
# The sum of the values of each line must be > or = to 10 for the analyses to go on: we delete the genes that have less than 10 counts (very low expressed genes)
dds$condition <- relevel(dds$condition, ref = "white")
# The reference given here is white skin ("control condition" --> white vs. "treatment condition" --> orange)

# Run DESeq
dds <- DESeq(dds)

resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_orange_vs_white", type="apeglm")
# resLFC <- results(dds) : both functions "result" and "lfcShrink" are doing the same thing but lfcShrink adjust the distorsion due to little counts
# Use head(resLFC) to visualize the table
# The result function generates the tables of results

library(ggplot2)
# MAPLOT
ggplot(data = as.data.frame(resLFC),mapping = aes(x=log10(baseMean),
                                                  y = log2FoldChange,
                                                  color=padj<0.05,
                                                  size=padj<0.05,
                                                  shape=padj<0.05,
                                                  alpha=padj<0.05,
                                                  fill=padj<0.05))+
  geom_point() + 
  scale_color_manual(values=c("#999999","#cc8167"))+
  scale_size_manual(values=c(0.1,1))+
  scale_alpha_manual(values=c(0.5,1))+
  scale_shape_manual(values=c(21,21))+
  scale_fill_manual(values=c("#999999","#05100e"))+
  theme_bw()+theme(legend.position='none')
# Use dim(resLFC[is.na(resLFC$padj),]) to know how many basemean=na
# colour.de is a website to select other colors for the plot

# VOLCANOPLOT
ggplot(data = as.data.frame(resLFC),mapping = aes(x = log2FoldChange,
                                                  y = -log10(padj),
                                                  color=padj<0.05,
                                                  shape=padj<0.05,
                                                  fill=padj<0.05))+
                                              
  geom_point() + 
  scale_color_manual(values=c("#999999","#cc8167"))+
  scale_size_manual(values=c(0.1,1))+
  scale_alpha_manual(values=c(0.5,1))+
  scale_shape_manual(values=c(21,21))+
  scale_fill_manual(values=c("#999999","#05100e"))+
  theme_bw()+theme(legend.position='none')

# List of the 10 most differentially expressed genes:
resLFC[is.na(resLFC$padj),"padj"] <- 1
top_DE_genes <- resLFC[resLFC$padj<1e-2 & abs(resLFC$log2FoldChange)>2,]
print (top_DE_genes[0:10,])

top_DE_genes_order <- top_DE_genes[order(top_DE_genes$padj),]
# We order the table top_DE_genes and store that in a new table called top_DE_genes_order
print (top_DE_genes_order[0:10,])

# ACP
rld <- rlog(dds, blind=FALSE)
plotPCA(rld, intgroup=c("condition"))
