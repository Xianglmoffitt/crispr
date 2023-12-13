#!/bin/bash

#SBATCH --job-name="bowtie2_trim_2"
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export FASTA_DIR="$PROJECT_DIR/trim_adapt_2"
export FILE_LIST="$PROJECT_DIR/bowtie_fq_list"
export OUT_DIR="$PROJECT_DIR/bowtie_trim_2_out"

cd $PROJECT_DIR
module load SAMtools

while read INPUT; do
	bowtie2 -p 4 -x bowtie_index/brunello_library -U $FASTA_DIR/$INPUT --norc 2> $OUT_DIR/"$INPUT".log | samtools view -bS - > $OUT_DIR/"$INPUT".bam
done < $FILE_LIST

