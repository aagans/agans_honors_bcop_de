#!/bin/bash
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=17
#SBATCH --mail-type=END,FAIL

R CMD BATCH /mnt/research/jbateman/students/aagans/scripts/rna-seq/count_features.R