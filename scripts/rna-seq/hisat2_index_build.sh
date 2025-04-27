#!/bin/bash
#SBATCH --mem-per-cpu=12G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mail-type=END,FAIL

module load hisat2

hisat2_extract_exons.py /home/aagans/Bcop_V2_RefSeq.gtf > Bcop_V2_RefSeq_exons_hisat2.txt
hisat2_extract_splice_sites.py /home/aagans/Bcop_V2_RefSeq.gtf > Bcop_V2_RefSeq_splicesites_hisat2.txt

hisat2-build -p 32 --ss Bcop_V2_RefSeq_splicesites_hisat2.txt \
--exon Bcop_V2_RefSeq_exons_hisat2.txt \
/mnt/research/jbateman/students/aagans/ref_genome/Bcop_V2.fna bcop