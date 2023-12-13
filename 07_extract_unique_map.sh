#!/bin/bash

#SBATCH --job-name="extract unique map"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export COUNT_DIR_1="$PROJECT_DIR/bowtie_trim_1_out"
export OUT_DIR_1="$PROJECT_DIR/bowtie_trim_1_out"
export FILE_LIST="$PROJECT_DIR/bowtie_fq_list"

cd $PROJECT_DIR

module load SAMtools

while read INPUT; do
	samtools view -F4 -h $OUT_DIR_1/"$INPUT".bam | grep -v "XS:i" | samtools view -b -o $OUT_DIR_1/"$INPUT"_unique.bam -
done < $FILE_LIST

