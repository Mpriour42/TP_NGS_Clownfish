#DE analysis:

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
# head(tx2gene) pour afficher première colonnes du tableau
#[,c(2,1)]permet d'inverser les deux colonnes

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

# Pour exécuter la ligne, se placer à la fin et faire ctrl+entrée

