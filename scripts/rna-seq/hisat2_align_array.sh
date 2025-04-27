#!/bin/bash
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --array=1-12%4
#SBATCH --mail-type=END,FAIL

config=config.txt
sample=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

hisat2 -p 16 --very-sensitive -x /mnt/research/jbateman/students/aagans/outputs/rna-seq/hisat2_index/bcop \
-1 /mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/$sample/"$sample"_1.fq.gz \
-2 /mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/$sample/"$sample"_2.fq.gz \
-S $sample.sam
    
samtools view -b $sample.sam > $sample.bam
samtools sort $sample.bam > $sample.sorted.bam
samtools index $sample.sorted.bam

