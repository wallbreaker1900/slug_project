#!/bin/bash

# Description: Run ANGSD on split chromosomes to generate MAF files, aiming to reduce memory issues

ANGSD_PATH="/home/jill/angsd/angsd"
BAMLIST_PATH="/more_storage/jill/alignment_updated_angsd/bamlist.txt"
OUTPUT_DIR="/more_storage/jill/"

# ${ANGSD_PATH} -GL 2 -out ${OUTPUT_DIR}/genolike -nThreads 8 -doGlf 3 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -minMaf 0.05 -minQ 30 -minInd 108 -minMapQ 40 -bam ${BAMLIST_PATH}
# ${ANGSD_PATH} -GL 2 -out ${OUTPUT_DIR}/${CHROM} -nThreads 8 -doGlf 2 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMaf 0.05 -minQ 30 -minInd 108 -minMapQ 40 -bam ${BAMLIST_PATH} -r ${CHROM}: 2>${OUTPUT_DIR}/${CHROM}.err
/home/jill/angsd/angsd -GL 2 -out genolike -nThreads 8 -doGlf 3 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -minMaf 0.05 -minQ 30 -minInd 108 -minMapQ 40 -bam /more_storage/jill/alignment_updated_angsd/bamlist.txt 
	