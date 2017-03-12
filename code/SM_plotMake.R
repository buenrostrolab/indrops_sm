library(tidyverse)
if (basename(getwd()) != "code") setwd("code")

getMetrics <- function(sample){
  # Import data
  sampledir <- paste0("../metrics/", sample ,"/")
  mousestats <- read.table(paste0(sampledir, "mouse.worker0_1.metrics.tsv"), header =TRUE, sep = "\t")
  humanstats <- read.table(paste0(sampledir, "worker0_1.metrics.tsv"), header = TRUE, sep = "\t")
  overlapstats <- read.table(paste0(sampledir, "overlappingBarcodeCounts.txt"), header = FALSE, sep = "\t")
  
  # Make data frames of mapped reads then merge overlapping reads
  df <- data.frame(barcode = humanstats[,1], mouse = mousestats[,3], human = humanstats[,3], sample = sample)
  df2 <- merge(df, overlapstats, by.x = c("barcode"), by.y = c("V1"), all.x = TRUE)
  
  # Set missing values to zero and then subtract off overlapping reads
  df2$V2[is.na(df2$V2)] <- 0
  df_final <- data.frame(human = df2$human - df2$V2, mouse = df2$mouse - df2$V2, sample = df2$sample)
  return(df_final)
}

# make plots
lma <- lapply(list("C1_S2", "C2_S3"), getMetrics)
ldf <- data.frame(data.table::rbindlist(lma))
nl <- theme_bw() + theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank()) 

ggplot(ldf, aes(mouse, human, col = sample)) + geom_point() + nl
