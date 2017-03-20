library(tidyverse)
if (basename(getwd()) != "code") setwd("code")

b1 <- read.table("../metrics/combined/combined_mix.B1_S1.txt", header = FALSE)
c1 <-  read.table("../metrics/combined/combined_mix.C1_S2.txt", header = FALSE)
c2 <-  read.table("../metrics/combined/combined_mix.C2_S3.txt", header = FALSE)

b1$source <- "B1_S1"
c1$source <- "C1_S2"
c2$source <- "C2_S3"

mdf <- rbind(c1, c2)
#all(mdf[c(TRUE,FALSE),2] == mdf[c(FALSE,TRUE),2])
cdf <- data.frame(barcode = mdf[c(TRUE,FALSE),2], mouse = mdf[c(FALSE,TRUE),1], human = mdf[c(TRUE,FALSE),1], source = mdf[c(TRUE,FALSE),4])


nl <- theme_bw() + theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank()) 

ggplot(cdf, aes(mouse, human, col = source)) + geom_point() + nl
