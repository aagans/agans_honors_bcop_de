#!/bin/bash
#SBATCH --mem-per-cpu=6G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=22
#SBATCH --mail-type=END,FAIL

fastqc -o /mnt/research/jbateman/students/aagans/outputs/rna-seq/qc/ \
--noextract \
-t 22 \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FE2/FE2_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FE2/FE2_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FE3/FE3_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FE3/FE3_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL1/FL1_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL1/FL1_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL2/FL2_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL2/FL2_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL3/FL3_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/FL3/FL3_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME1/ME1_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME1/ME1_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME2/ME2_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME2/ME2_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME3/ME3_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ME3/ME3_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML1/ML1_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML1/ML1_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML2/ML2_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML2/ML2_2.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML3/ML3_1.fq.gz \
/mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/ML3/ML3_2.fq.gz