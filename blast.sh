#! /bin/bash

#build reference database
makeblastdb 

#blast fasta against the ref db
blastn -db $db -query $query -evalue $evalue -outfmt 6 -out $out_blast


Rscript --vanilla  annote_fasta_from_blast.R $out_blast 