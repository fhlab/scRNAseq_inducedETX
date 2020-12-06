library(dplyr)
library(Matrix)
library(data.table)


setwd("PATH")


Count_matrix <- readRDS("INDEX.dgecounts.rds")


write.table(as.matrix(Count_matrix$umicount$inex$all),"INDEX.inex.txt",quote=F,sep="\t")
