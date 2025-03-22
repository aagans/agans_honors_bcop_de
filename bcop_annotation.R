library(AnnotationForge)
library(DBI)
library(tidyverse)
library(goseq)
library(txdbmaker)
library(readr)
library(GO.db)

makeOrgPackageFromNCBI(version = "1.0",
                       author = "Aale J. Agans <aale.agans@uconn.edu>",
                       maintainer = "Aale J. Agans <aale.agans@uconn.edu>",
                       outputDir = "/Users/aale/Desktop/bcop_files",
                       NCBIFilesDir = "/Users/aale/Desktop/bcop_files",
                       tax_id = "38358",
                       genus = "Bradysia",
                       species = "coprophila")

install.packages("/Users/aale/Desktop/bcop_files/org.Bcoprophila.eg.db", repos=NULL, type = "source")
library(org.Bcoprophila.eg.db)

bcop_chrom_info <- read_csv("chr_tbl.csv")
bcop_txdb <- makeTxDbFromGFF("Bcop_V2_RefSeq.gff",
                             dataSource = "GFF Annotation from RefSeq of Whole Genome",
                             organism = "Bradysia coprophila",
                             chrominfo = bcop_chrom_info)
saveDb(bcop_txdb, file="bcop_txdb.sqlite")
txsByGene <- transcriptsBy(bcop_txdb, "gene")
txsByGene <- txsByGene[names(txsByGene) %in% gene_names_2,]
lengthData <- median(width(txsByGene))

#genes <- as.integer(p.adjust(el_results$table$PValue,
#                             method = "BH") < .05)

genes <- as.integer(emef_results$table$logFC > 2)
gene_names_2 <- row.names(emef_results$table) |> 
  str_remove("gene-")
gene_names_3 <- row.names(emef_results$table)
gene_names <- row.names(emef_results$table) |> 
  str_remove("gene-LOC")

names(genes) <- gene_names_3
pwf <- nullp(genes, "Bradysia coprophila", "knownGene", lengthData)
GO.wall <- goseq(pwf, "Bradysia coprophila", "knownGene", go_assign_vec)

enriched.GO <- GO.wall$category[p.adjust(GO.wall$over_represented_pvalue,
method = "BH") < .05]
head(enriched.GO)

for (go in enriched.GO[1:25]) {
  print(GOTERM[[go]])
  cat("--------------------------------------\n")
}
