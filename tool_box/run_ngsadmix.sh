#!/bin/bash

# Description: Performs population structure analysis using NGSadmix tool for different values of K and replicates for each K.

NGSADMIX_PATH="/home/jill/NGSadmix"
INPUT=/Scratch/jill/alignment_results_angsd/final.genolike.beagle.gz
OUTPUT_DIR="/Scratch/jill/alignment_results_ngs" 
K_MIN=1                                
K_MAX=8                               
NUM_REPLICATES=5 # Number of replicates for each K

for (( K=K_MIN; K<=K_MAX; K++ )); do
    for (( R=1; R<=NUM_REPLICATES; R++ )); do
        OUTPUT_FILE="${OUTPUT_DIR}/K${K}.${R}"
        ERROR_FILE="${OUTPUT_FILE}.err"
        echo "Running NGSadmix for K=${K}, replicate ${R}..."
        ${NGSADMIX_PATH} -likes "${INPUT}" -K "$K" -o "${OUTPUT_FILE}" -P 25 2>"${ERROR_FILE}"
        if [ $? -ne 0 ]; then
            echo "NGSadmix encountered an error for K=${K}, replicate ${R}. Check the error log: ${ERROR_FILE}"
        else
            echo "NGSadmix completed successfully for K=${K}, replicate ${R}."
        fi
    done
done
