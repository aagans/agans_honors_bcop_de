library(edgeR)
library(stringr)
library(DBI)
library(readr)
library(tibble)
library(goseq)
library(AnnotationDbi)

#Load feature_counts data
feature_counts <- readRDS("feature_counts.RData")

#Early M&F vs Late M&F
el_sample_types <- c(rep("E", 3), rep("L", 3), rep("E", 3), rep("L", 3))

el_de_results <- de_analysis(feature_counts, el_sample_types)

bcop_txdb <- loadDb("bcop_txdb.sqlite")
el_go_results <- go_analysis(bcop_txdb, el_de_results, go_assign_vec, 2)
