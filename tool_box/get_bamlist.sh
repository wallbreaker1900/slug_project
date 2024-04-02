#!/bin/bash

# Description: Generate bamlist (a list of bam file locations)

dir_prefix="/Scratch/jill/alignment_results_bwa"
sample_file="/Scratch/jill/tools/Samples"
output_dir="/Scratch/jill/tools"

if [ -f ${output_dir}/bamlist.txt ]; then
        rm ${output_dir}/bamlist.txt
    fi

awk 'NR > 1 && NR % 2 == 0 {print $2}' "$sample_file" | while read -r sample_name; do 

    file_path="${dir_prefix}/${sample_name}.bam"
    
    # Check file existence
    if ! [ -f ${file_path} ]; then
        echo "${sample_name}.bam dose not exist."
        exit 1
    fi

    echo "${file_path}" >> "${output_dir}/bamlist.txt"

done
