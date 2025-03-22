library(Rsubread)
library(edgeR)

setwd("/mnt/research/jbateman/students/aagans/outputs/rna-seq/aligned")
SAF_tbl <- flattenGTF("/mnt/research/jbateman/students/aagans/ref_genome/Bcop_V2_RefSeq_gtfv2_2_formatted.gtf")
bam_files <- c("FE1.sorted.bam", 
               "FE2.sorted.bam", 
               "FE3.sorted.bam",
               "FL1.sorted.bam",
               "FL2.sorted.bam",
               "FL3.sorted.bam",
               "ME1.sorted.bam",
               "ME2.sorted.bam",
               "ME3.sorted.bam",
               "ML1.sorted.bam",
               "ML2.sorted.bam",
               "ML3.sorted.bam")

feature_counts <- featureCounts(files = bam_files,
                                annot.ext = SAF_tbl,
                                chrAliases = "/mnt/research/jbateman/students/aagans/ref_genome/chr_alias.csv",
                                useMetaFeatures = TRUE,
                                isPairedEnd = TRUE,
                                nthreads = 16)

saveRDS(feature_counts, "/mnt/research/jbateman/students/aagans/outputs/rna-seq/counts/feature_counts.RData")