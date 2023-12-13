#!/bin/bash

#SBATCH --job-name="mageck_test"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"
export COUNT_DIR_1="$PROJECT_DIR/magec_bam_count_trim_1"
export COUNT_DIR_2="$PROJECT_DIR/magec_bam_count_trim_2"
export FILE_LIST="$PROJECT_DIR/mageck_compare_list"
export OUT_DIR_1="$PROJECT_DIR/magec_bam_test_out_1"
export OUT_DIR_2="$PROJECT_DIR/magec_bam_test_out_2"

cd $PROJECT_DIR

while read INPUT CONTROL; do
	mageck test -k $COUNT_DIR_1/"$INPUT"_"$CONTROL".count.txt -t $INPUT -c $CONTROL -n $OUT_DIR_1/"$INPUT"_"$CONTROL"_mageck_test
	mageck test -k $COUNT_DIR_2/"$INPUT"_"$CONTROL".count.txt -t $INPUT -c $CONTROL -n $OUT_DIR_2/"$INPUT"_"$CONTROL"_mageck_test
done < $FILE_LIST

