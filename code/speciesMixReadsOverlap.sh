#!/bin/bash

# Get read ID (column 1) and sample barcode (column 16) from bam files
samtools view worker0_1.bam | cut -f 1,16 > human.readlist.txt
samtools view mouse.worker0_1.bam | cut -f 1,16 > mouse.readlist.txt

# Find overlaps
awk 'a[$0]++' human.readlist.txt mouse.readlist.txt >  overlap.readlist.txt 

# Produce summary table of number of overlaps per cell barcode
cat overlap.readlist.txt | cut -f 2 | cut -d : -f 3 | sort -gk 1 | uniq -c | awk '{print $2"\t"$1}' > overlappingBarcodeCounts.txt

