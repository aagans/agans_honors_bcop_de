library(edgeR)
library(readr)
library(tibble)

#Import counted data
bcop_dgelist <- featureCounts2DGEList(feature_counts)

#Normalize and filter
counts_per_mil <- cpm(bcop_dgelist) > 1
kept_genes <- which(rowSums(counts_per_mil) >= 1)
filtered_dgelist <- bcop_dgelist[kept_genes,]
fil_norm_dgelist <- normLibSizes(bcop_dgelist, method="TMM")

plotMDS(fil_norm_dgelist) #Visualize data

#Analyzing differences between early and late embryos
el_sample_types <- c(rep("E", 3), rep("L", 3), rep("E", 3), rep("L", 3))
age_model_matrix <- model.matrix(~el_sample_types)

#Dispersion modeling
fil_norm_dgelist <- estimateGLMCommonDisp(fil_norm_dgelist, design=age_model_matrix)
fil_norm_dgelist <- estimateGLMTrendedDisp(fil_norm_dgelist, design=age_model_matrix)
fil_norm_dgelist <- estimateGLMTagwiseDisp(fil_norm_dgelist, design=age_model_matrix)

#Modeling
el_glm_fitted_model <- glmFit(fil_norm_dgelist, age_model_matrix)
el_likelihood_ratio_test <- glmLRT(el_glm_fitted_model)
el_results <- topTags(el_likelihood_ratio_test, n =19848)

el_deGenes <- decideTests(el_likelihood_ratio_test, p=0.001)
el_deGenes <- rownames(el_likelihood_ratio_test)[as.logical(el_deGenes)]
plotSmear(el_likelihood_ratio_test, de.tags=el_deGenes)
abline(h=c(-1, 1), col=2)

el_results_export <- rownames_to_column(el_results$table, "gene_id")

write_csv(el_results_export, "el_de_rnaseq_tbl.csv")

#Analyzing differences between early male and early female
early_bcop_dgelist <- bcop_dgelist[,c(1:3, 7:9)]

emef_counts_per_mil <- cpm(early_bcop_dgelist) > 1
emef_kept_genes <- which(rowSums(emef_counts_per_mil) >= 1)
emef_filtered_dgelist <- early_bcop_dgelist[emef_kept_genes,]
emef_fil_norm_dgelist <- normLibSizes(early_bcop_dgelist, method="TMM")

emef_sample_types <- c(rep("F", 3), rep("M", 3))
emef_model_matrix <- model.matrix(~emef_sample_types)

#Dispersion modeling
emef_fil_norm_dgelist <- estimateGLMCommonDisp(emef_fil_norm_dgelist, design=emef_model_matrix)
emef_fil_norm_dgelist <- estimateGLMTrendedDisp(emef_fil_norm_dgelist, design=emef_model_matrix)
emef_fil_norm_dgelist <- estimateGLMTagwiseDisp(emef_fil_norm_dgelist, design=emef_model_matrix)

#Modeling
emef_glm_fitted_model <- glmFit(emef_fil_norm_dgelist, emef_model_matrix)
emef_likelihood_ratio_test <- glmLRT(emef_glm_fitted_model)
emef_results <- topTags(emef_likelihood_ratio_test, n =19848, p.value = 0.05)

emef_deGenes <- decideTests(emef_likelihood_ratio_test, p=0.001)
emef_deGenes <- rownames(emef_likelihood_ratio_test)[as.logical(emef_deGenes)]
plotSmear(emef_likelihood_ratio_test, de.tags=emef_deGenes)
abline(h=c(-1, 1), col=2)

emef_results_export <- rownames_to_column(emef_results$table, "gene_id")

write_csv(emef_results_export, "emef_de_rnaseq_tbl.csv")

#Analyzing differences between late male and late female
late_bcop_dgelist <- bcop_dgelist[,c(4:6, 10:12)]

lmlf_counts_per_mil <- cpm(late_bcop_dgelist) > 1
lmlf_kept_genes <- which(rowSums(lmlf_counts_per_mil) >= 1)
lmlf_filtered_dgelist <- late_bcop_dgelist[lmlf_kept_genes,]
lmlf_fil_norm_dgelist <- normLibSizes(lmlf_filtered_dgelist, method="TMM")

lmlf_sample_types <- c(rep("F", 3), rep("M", 3))
lmlf_model_matrix <- model.matrix(~lmlf_sample_types)

#Dispersion modeling
lmlf_fil_norm_dgelist <- estimateGLMCommonDisp(lmlf_fil_norm_dgelist, design=lmlf_model_matrix)
lmlf_fil_norm_dgelist <- estimateGLMTrendedDisp(lmlf_fil_norm_dgelist, design=lmlf_model_matrix)
lmlf_fil_norm_dgelist <- estimateGLMTagwiseDisp(lmlf_fil_norm_dgelist, design=lmlf_model_matrix)

#Modeling
lmlf_glm_fitted_model <- glmFit(lmlf_fil_norm_dgelist, lmlf_model_matrix)
lmlf_likelihood_ratio_test <- glmLRT(lmlf_glm_fitted_model)
lmlf_results <- topTags(lmlf_likelihood_ratio_test, n =19848, p.value = 0.05)

lmlf_deGenes <- decideTests(lmlf_likelihood_ratio_test, p=0.05)
lmlf_deGenes <- rownames(lmlf_likelihood_ratio_test)[as.logical(lmlf_deGenes)]
plotSmear(lmlf_likelihood_ratio_test, de.tags=lmlf_deGenes)
abline(h=c(-1, 1), col=2)

lmlf_results_export <- rownames_to_column(lmlf_results$table, "gene_id")

write_csv(lmlf_results_export, "lmlf_de_rnaseq_tbl.csv")

