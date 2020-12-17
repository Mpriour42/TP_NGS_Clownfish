# DE analysis:

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
# samples pour voir le tableau

files <- file.path(dir, samples$run, "quant.sf")
names(files) <- samples$run

# Data frame to know association gene transcript:
tx2gene <- read.table(file = "/home/rstudio/data/mydatalocal/data/SRA_data/SRA_data_trinity/Trinity.fasta.gene_trans_map",
                              header = FALSE,sep ="\t",col.names = c("geneid","txname"))[,c(2,1)]
# head(tx2gene) pour afficher premières colonnes du tableau
# [,c(2,1)] ermet d'inverser les deux colonnes

# On importe les données qu'on stocke dans une variable txi
txi <- tximport(files,type="salmon",tx2gene=tx2gene)
# head(txi$counts) pour afficher la table de comptes qui sert de base à DeSseq2

# DE analysis:
ddsTxi <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ condition)
# ~ condition: en fonction de la condition, ici la couleur
keep <- rowSums(counts(ddsTxi)) >= 10
dds <- ddsTxi[keep,]
# la somme des valeurs de chaque ligne doit être supérieure ou égale à 10 pour poursuivre l'analyse: on supprime les gènes qui ont moins de 10 counts, gènes très très très peu exprimés
dds$condition <- relevel(dds$condition, ref = "white")
# on donne une référence (controle/traitement), au pif: écailles blanches donc nos résultats seront à intérpreter par rapport au blanc
dds <- DESeq(dds)
# commande DESeq
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_orange_vs_white", type="apeglm")
# resLFC <- results(dds) : la fonction result fait la même chose que lfcShrink mais n'ajuste pas la distorsion liée aux petits counts
# head(resLFC) pour afficher tableau
# la fonction result permet de générer le tableau de résultats

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
# dim(resLFC[is.na(resLFC$padj),]) pour savoir combien on basemean=na
# colour.de pour sélectionner d'autre couleurs

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

# Liste des 10 gènes les plus exprimés
resLFC[order(resLFC$padj),]
resLFC[is.na(resLFC$pajd),"pajd"] <- 1
top_DE_genes <- resLFC[resLFC$padj<1e-2 & abs(resLFC$log2FoldChange)>2,]
# abs() function computes the absolute value of numeric data
