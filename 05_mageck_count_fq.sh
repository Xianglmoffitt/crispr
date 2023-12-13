#!/bin/bash

#SBATCH --job-name="mageck_fq_count"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export FASTA_DIR="$PROJECT_DIR/trim_adapt_1"
export FILE_LIST="$PROJECT_DIR/mageck_compare_list"
export OUT_DIR="$PROJECT_DIR/mageck_fq_count_trim_1"

cd $PROJECT_DIR

while read INPUT CONTROL; do
	mageck count -l $PROJECT_DIR/sgRNA_library/broadgpp-brunello-library-corrected.txt -n $OUT_DIR/"$INPUT"_"$CONTROL" --sample-label $INPUT,$CONTROL --fastq $FASTA_DIR/"$INPUT"_trim.fq $FASTA_DIR/"$CONTROL"_trim.fq
done < $FILE_LIST

