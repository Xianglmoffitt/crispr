#!/bin/bash

#SBATCH --job-name="gunzip"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export RAW_DATA="/share/lab_teng/data/sequencing/CRISPR_bo/RawData"
export OUT_DIR_1="$PROJECT_DIR/trim_adapt_1"
export OUT_DIR_2="$PROJECT_DIR/trim_adapt_2"
export FILE_LIST_1="$PROJECT_DIR/trim_adapt_1_list"
export FILE_LIST_2="$PROJECT_DIR/trim_adapt_2_list"

cd $OUT_DIR_1

while read INPUT; do
	gunzip $INPUT
done < $FILE_LIST_1

cd $OUT_DIR_2
while read INPUT; do
	gunzip $INPUT
done < $FILE_LIST_2
