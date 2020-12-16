#!/bin/bash

# Script inspiré de celui de Paul car absence pour raison médicale

# Create a working directory:
data="/home/rstudio/data/mydatalocal/data"
data_reference="$data/data_reference"??? Is that the stegastes_coding?
data_blast="$data/data_blast"
data_Trinity="$data/SRA_data/SRA_data_trinity"
out_blast="$data/data_blast/out_blast"
db="$data_blast/Spartitus_db"
data_transdecoder="$data/data_transdecoder"
mkdir -p $db
mkdir -p $data_blast
mkdir -p $out_blast
cd $data_blast

# On cherche à savoir pour chaque transcrit à quel gène il correspond
# Build reference database. On transforme nos data en une database que blast peut gérer:
makeblastdb -dbtype nucl -in $data_reference/spartitus_coding_format.fa -out $db

# Blast fasta against the ref database. On blaste nos données de transdecoder sur la base créée avant.
#Le fichier Trinity a été renommé avec la commande :    awk '{print $1}' Trinity.fasta.transdecoder.cds > Trinity.fasta.transdecoder.rename.cds
# e-value : si on fait seuil élévé on a plein de hits mais davantage de faux positifs. Pour homologie entre espèce on met en général 1e-10
# outfmt donne le type de format de sortie que l'on veut, le 6 est le plus utilisé (tableau pas mal)
blastn -db $db -query $data_transdecoder/Trinity.fasta.transdecoder.rename.cds -evalue 1e-10 -outfmt 6 -out $out_blast/blast_file
# On obtient : identifiant du transcrit / gene correspondant
# Pour déterminer le nombre de seq qui ont été alignées : cut -f1 blast_file |sort |uniq |wc -l (on compte le nombre de mots dans premiere colonne). On obitent 25000 gene, ca doit etre a peu pres nombre de genes codants dans la peau de poisson clown
# launch script with nohup ./blast.sh >& nohup.blast &