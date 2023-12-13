#!/bin/bash

#SBATCH --job-name="gunzip"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export DB_FILE="$PROJECT_DIR/sgRNA_list.txt"
export OUT_DIR_1="$PROJECT_DIR/search_out_1"
export OUT_DIR_2="$PROJECT_DIR/search_out_2"
export FILE_LIST_1="$PROJECT_DIR/trim_adapt_1_list"
export FILE_LIST_2="$PROJECT_DIR/trim_adapt_2_list"

cd PROJECT_DIR

while read INPUT; do
	grep -wf $DB_FILE $PROJECT_DIR/trim_adapt_1/$INPUT | wc -l > $OUT_DIR_1/"$INPUT"_match_count
done < $FILE_LIST_1

cd $OUT_DIR_2
while read INPUT; do
	grep -wf $DB_FILE $PROJECT_DIR/trim_adapt_2/$INPUT | wc -l > $OUT_DIR_2/"$INPUT"_match_count
done < $FILE_LIST_2
