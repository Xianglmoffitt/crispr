#!/bin/bash

#SBATCH --job-name="cutadapt_01"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export RAW_DATA="/share/lab_teng/data/sequencing/CRISPR_bo/RawData"
export OUT_DIR_1="$PROJECT_DIR/trim_adapt_1"
export OUT_DIR_2="$PROJECT_DIR/trim_adapt_2"
export FILE_LIST="$PROJECT_DIR/cutadapt_list_1"

module load cutadapt

cd $PROJECT_DIR

while read INPUT OUTNAME; do

#cutadapt --quiet -g GGAAAGGACGAAACACCG -l 20 -o $OUT_DIR_1/$OUTNAME $RAW_DATA/$INPUT -j 0
cutadapt --quiet -a CACCG...GTTT -o $OUT_DIR_2/$OUTNAME $RAW_DATA/$INPUT -j 0

done < $FILE_LIST
