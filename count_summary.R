setwd("~/Projects/crispr_bo/")
library(ggplot2)






file_list <- c("mageck_bam_unique_count")

sample_list <- c("A02_R1_N2_1_A04_R1_i2_1","A03_R1_P_1_A04_R1_i2_1","A05_R2_N2_1_B02_R2_i2_1",
                 "A06_R3_N2_1_B03_R3_i2_1","A07_R4_N2_1_B04_R4_i2_1","A08_R2_P2_1_B02_R2_i2_1",
                 "A09_R3_P2_1_B03_R3_i2_1","A10_R4_P2_1_B04_R4_i2_1")

summary_df <- data.frame()
for (m in 1:length(file_list)) {
  for (s in 1:length(sample_list)) {
    in_tmp <- read.table(paste0("results/",file_list[m],"/",sample_list[s],"_unique.countsummary.txt"),sep="\t",header=T)
    
    in_tmp$File <- gsub(".*\\/","",in_tmp$File)
    in_tmp$method <- file_list[m]
    summary_df <- rbind(summary_df,in_tmp)
  }
}

#write.table(summary_df,"results/read_count_summary.txt",sep="\t",row.names = F,quote = F)

#--------------------------
# raw count scatter plot
#--------------------------
# merge raw count
raw_count_m <- read.table("Brunello_libary/broadgpp-brunello-library-corrected.txt",sep="\t",header=T)
raw_count_m <- raw_count_m[,c(1,3)]
colnames(raw_count_m) <- c("sgRNA","Gene")
for (s in 1:length(sample_list)) {
  in_tmp <- read.table(paste0("results/",file_list[m],"/",sample_list[s],"_unique.count.txt"),sep="\t",header=T)
  
  raw_count_m <- merge(raw_count_m,in_tmp[,-2],by="sgRNA")
}

# remove duplicate control column
raw_count_m <- raw_count_m[,-c(6,14,16,18)]
write.table(raw_count_m,"results/bam_uniqu_raw_count_matrix.txt",sep="\t",row.names = F,quote = F)

# scatter plot of negative and positive samples seperately
raw_count_m <- read.table("results/bam_uniqu_raw_count_matrix.txt",sep="\t",header=T)
neg_sample <- c("A02_R1_N2_1","A05_R2_N2_1","A06_R3_N2_1","A07_R4_N2_1")
pos_sample <- c("A03_R1_P_1","A08_R2_P2_1","A09_R3_P2_1","A10_R4_P2_1")
input_sample <- c("A04_R1_i2_1.x","B02_R2_i2_1.x","B03_R3_i2_1.x","B04_R4_i2_1.x")

comb <- combn(input_sample,m=2)
par(mfrow=c(2,3))
for (i in 1:6) {
  plot(log2(raw_count_m[,which(colnames(raw_count_m)==comb[1,i])]+1),
       log2(raw_count_m[,which(colnames(raw_count_m)==comb[2,i])])+1,
       pch=16,
       col=alpha("black", 0.5),
       cex=0.2,
       xlab=comb[1,i],
       ylab=comb[2,i])
}





