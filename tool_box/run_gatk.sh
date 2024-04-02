#!/bin/bash

# Description: get list of commands to generate vcf files from high coverage bamlist

output_dir="/Scratch/jill/alignment_results_vcf/"
bamlist_path="/Scratch/jill/tool_box/sample_order_high_cov.txt"

if [ -f "/Scratch/jill/tool_box/vcf_commands.sh" ]; then
    rm "/Scratch/jill/tool_box/vcf_commands.sh"
fi

awk '{print $1}' "$bamlist_path" | while read -r name; do

    echo "/home/jill/gatk-4.5.0.0/gatk --java-options "-Xmx4g" HaplotypeCaller -R /Scratch/jill/reference/bslug.final.fa -I /Scratch/jill/alignment_results_bwa/${name}.bam -O ${output_dir}${name}.vcf.gz" >> "/Scratch/jill/tool_box/vcf_commands.sh"

done

chmod +x "/Scratch/jill/tool_box/vcf_commands.sh"