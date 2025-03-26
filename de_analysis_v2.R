library(edgeR)
library(stringr)
library(DBI)
library(readr)
library(tibble)
library(goseq)
library(AnnotationDbi)
library(GenomicFeatures)

#Load feature_counts data
feature_counts <- readRDS("feature_counts.RData")
early_bcop_dgelist <- bcop_dgelist[,c(1:3, 7:9)]
emef_sample_types <- c(rep("F", 3), rep("M", 3))

#Early M&F vs Late M&F
el_sample_types <- c(rep("E", 3), rep("L", 3), rep("E", 3), rep("L", 3))

el_de_results <- de_analysis(feature_counts, el_sample_types)
el_de_results_tbl <- de_analysis(feature_counts, el_sample_types, export = TRUE)

bcop_txdb <- loadDb("data/bcop_txdb.sqlite")
el_go_results <- go_analysis(bcop_txdb, el_de_results, go_assign_vec, 2)

emef_de_results <- de_analysis(early_bcop_dgelist, emef_sample_types)

emef_de_results_tbl <- de_analysis(early_bcop_dgelist, emef_sample_types, de_p.val = 0.05, export = TRUE)

emef_go_results <- go_analysis(bcop_txdb, emef_de_results, go_assign_vec, 2)

emef_de_results_tbl <- de_analysis(early_bcop_dgelist, emef_sample_types, export = TRUE)

emef_res_fil <- emef_de_results_tbl[which(emef_de_results_tbl$logFC >= 2 & emef_de_results_tbl$PValue <= 0.05),]
