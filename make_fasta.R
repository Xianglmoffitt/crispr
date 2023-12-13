setwd("~/Projects/crispr_bo/")


infile <- read.table("Brunello_libary/broadgpp-brunello-library-contents.txt",sep="\t",header=T)

fa_header <- paste0(">",infile$Target.Gene.ID,"_",infile$Target.Gene.Symbol,"_",
                    infile$Target.Transcript,"_",infile$Genomic.Sequence,"_",infile$Position.of.Base.After.Cut..1.based.,
                    "_",infile$Strand)


fa_header[which(fa_header ==">NA_Non-Targeting Control___NA_")] <- paste0(">NA_Non-Targeting Control___NA_","_",
                                                                          which(fa_header ==">NA_Non-Targeting Control___NA_"))
outfile <- data.frame(dummy=rep(NA,2*nrow(infile)))

outfile$dummy[seq(1,nrow(outfile),2)] <- fa_header

outfile$dummy[seq(2,nrow(outfile),2)] <- infile$sgRNA.Target.Sequence


write.table(outfile,"sgRNA.fa",sep="\t",row.names = F,quote = F,col.names = F)
