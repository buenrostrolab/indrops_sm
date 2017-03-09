library(tidyverse)
if (basename(getwd()) != "code") setwd("code")

getMetrics <- function(sample){
  sampledir <- paste0("../metrics/", sample ,"/")
  mousestats <- read.table(paste0(sampledir, "mouse.worker0_1.metrics.tsv"), header =TRUE, sep = "\t")
  humanstats <- read.table(paste0(sampledir, "worker0_1.metrics.tsv"), header = TRUE, sep = "\t")
  df <- data.frame(mouse = mousestats[,3], human = humanstats[,3], sample = sample)
  return(df)
}

lma <- lapply(list("B1_S1", "C1_S2", "C2_S3"), getMetrics)
ldf <- data.frame(data.table::rbindlist(lma))
nl <- theme_bw() + theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank()) 

ggplot(ldf, aes(mouse, human, col = sample)) + geom_point() + nl
