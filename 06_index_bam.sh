#!/bin/bash

#SBATCH --job-name="index_bam"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export FASTA_DIR="$PROJECT_DIR/bowtie_out"
export FILE_LIST="$PROJECT_DIR/bowtie_fq_list"

cd $PROJECT_DIR
module load SAMtools

while read INPUT; do
	samtools index -b $FASTA_DIR/"$INPUT"_sort.bam
done < $FILE_LIST

