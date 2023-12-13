#!/bin/bash

#SBATCH --job-name="mageck_bam_count"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export BAM_DIR_1="$PROJECT_DIR/bowtie_trim_1_out"
#export BAM_DIR_2="$PROJECT_DIR/bowtie_trim_2_out"
export FILE_LIST="$PROJECT_DIR/mageck_compare_list"
export OUT_DIR_1="$PROJECT_DIR/mageck_bam_unique_count"
#export OUT_DIR_2="$PROJECT_DIR/magec_bam_count_trim_2"

cd $PROJECT_DIR

while read INPUT CONTROL; do
	mageck count -l $PROJECT_DIR/sgRNA_library/broadgpp-brunello-library-corrected.txt -n $OUT_DIR_1/"$INPUT"_"$CONTROL"_unique --sample-label $INPUT,$CONTROL --fastq $BAM_DIR_1/"$INPUT"_trim.fq_unique.bam $BAM_DIR_1/"$CONTROL"_trim.fq_unique.bam
#	mageck count -l $PROJECT_DIR/sgRNA_library/broadgpp-brunello-library-corrected.txt -n $OUT_DIR_2/"$INPUT"_"$CONTROL" --sample-label $INPUT,$CONTROL --fastq $BAM_DIR_2/"$INPUT"_trim.fq.bam $BAM_DIR_2/"$CONTROL"_trim.fq.bam
done < $FILE_LIST

