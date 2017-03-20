#!/bin/bash

samtools view mix.worker0_1.bam | cut -f 3,16 | awk '{print substr($1,0,5) ":"$2}' | awk -F: '{print $4,$1}' OFS="\t" | sort -gk 1 | uniq -c > ../../combined_mix.C2_S3.txt