#!/bin/bash
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=END,FAIL

while IFS= read -r line; do
    hisat2 -p 16 --very-sensitive -x /mnt/research/jbateman/students/aagans/outputs/rna-seq/hisat2_index/bcop \
    -1 /mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/$line/"$line"_1.fq.gz \
    -2 /mnt/research/jbateman/students/aagans/bcop_rnaseq/early_embryo_RNAseq/$line/"$line"_2.fq.gz \
    -S $line.sam
    
    samtools view -b $line.sam > $line.bam
    samtools sort $line.bam > $line.sorted.bam
    samtools index $line.sorted.bam
    
done < rna_seq_list.txt