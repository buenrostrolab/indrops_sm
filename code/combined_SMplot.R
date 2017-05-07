library(tidyverse)
library(BuenColors)
library(reshape2)

if (basename(getwd()) != "code") setwd("code")

c1 <- read.table("../metrics/May/may07_C1.txt", header = FALSE)
c2 <- read.table("../metrics/May/may07_C2.txt", header = FALSE)

c1$source <- "C1"
c2$source <- "C2"

mdf <- rbind(c1, c2)
wdf <- dcast(mdf,source + V2  ~ V3, value.var = "V1", fun.aggregate = mean)

p <- ggplot(wdf, aes(mouse, human, col = source)) + geom_point() + pretty_plot()
ggsave(p, file="MaySpeciesMix.png")
