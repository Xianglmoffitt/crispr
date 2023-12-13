#!/bin/bash

#SBATCH --job-name="gunzip"
#SBATCH --time=48:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6

export PROJECT_DIR="/share/lab_teng/xiangliu/crispr_bo"

cd $PROJECT_DIR
/home/4472271/bowtie2/bowtie2-2.4.2-sra-linux-x86_64/bowtie2-build sgRNA.fa bowtie_index/sgRNA_Brunello_libary
