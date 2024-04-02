#!/bin/bash

# Description: Run fastp for fastq files from sequencing

input_dir="/Scratch/jill/slug/sequencing"
output_dir="/Scratch/jill/alignment_results"
sample_file="/Scratch/jill/tools/Samples"

awk 'NR > 1' "$sample_file" | while read -r line1; do
    # Read the next line for the pair
    read -r line2

    file_r1=$(echo "$line1" | awk '{print $1}')
    file_r2=$(echo "$line2" | awk '{print $1}')
    sample_name=$(echo "$line1" | awk '{print $2}')

    path_r1="${input_dir}/${file_r1}"
    path_r2="${input_dir}/${file_r2}"

    output_r1="${output_dir}/${sample_name}_1.fq.gz"
    output_r2="${output_dir}/${sample_name}_2.fq.gz"
    unpaired1="${output_dir}/${sample_name}.fq.gz"
    unpaired2="${output_dir}/${sample_name}.fq.gz"

    echo "fastp --thread 10 -i \"$path_r1\" -I \"$path_r2\" -o \"$output_r1\" -O \"$output_r2\" --detect_adapter_for_pe --unpaired1 \"$unpaired1\" --unpaired2 \"$unpaired2\""
done | parallel -j 5
