#!/bin/bash

# Description: Merge the beagle files generated seperately according to chromosomes

BEAGLE_DIR="/Scratch/jill/alignment_results_angsd/chrom_subset_results"
OUTPUT_FILE="/Scratch/jill/alignment_results_angsd/final.genolike.beagle"
ORDER_FILE="/Scratch/jill/tools/contigs.bslug.final.txt"

FIRST_FILE=true

while IFS=$' ' read -r filename rest; do
    beagle_file="${BEAGLE_DIR}/${filename}.beagle.gz"
    
    echo $filename

    if [[ "$FIRST_FILE" = true ]]; then
        zcat "$beagle_file" > "$OUTPUT_FILE"
        FIRST_FILE=false
    else
        zcat "$beagle_file" | tail -n +2 >> "$OUTPUT_FILE"
    fi
done < "$ORDER_FILE"

echo "Merging complete. Output file: $OUTPUT_FILE"