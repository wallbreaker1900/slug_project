#!/bin/bash

# Description: Process PE and SE reads, then combine them

input_dir="/Scratch/jill/alignment_results_fastp"
output_dir="/Scratch/jill/alignment_results_bwa"
sample_file="/Scratch/jill/tools/Samples"
reference_genome_file="/Scratch/jill/reference/bslug.final.fa.gz"

awk 'NR > 1 && NR % 2 == 0 {print $2}' "$sample_file" | while read -r sample_name; do

    # Define input
    input_pe1="${input_dir}/${sample_name}_1.fq.gz"
    input_pe2="${input_dir}/${sample_name}_2.fq.gz"
    input_se="${input_dir}/${sample_name}.fq.gz"

    # Define output
    output_bam_pe="${output_dir}/${sample_name}_PE.bam"
    output_bam_se="${output_dir}/${sample_name}_SE.bam"
    output_bam_final="${output_dir}/${sample_name}.bam"

    # Generate PE commands
    echo "bwa mem -t 5 -R '@RG\\tID:${sample_name}\\tSM:${sample_name}\\tPL:ILLUMINA' ${reference_genome_file} ${input_pe1} ${input_pe2} | samtools sort -@ 5 -o ${output_bam_pe}" >> "PE_commands.sh"
    
    # Generate SE commands
    echo "bwa mem -t 5 -R '@RG\\tID:${sample_name}\\tSM:${sample_name}\\tPL:ILLUMINA' ${reference_genome_file} ${input_se} | samtools sort -@ 5 -o ${output_bam_se}" >> "SE_commands.sh"

    # Combine PE and SE to final bam
    temp_sorted_bam="${output_dir}/${sample_name}_temp_sorted.bam"

    echo "samtools cat ${output_bam_pe} ${output_bam_se} | samtools sort -n --threads 5 | samtools fixmate - - | samtools sort --threads 5 -o ${temp_sorted_bam} && sambamba markdup -r -t 5 ${temp_sorted_bam} ${output_bam_final} && rm ${temp_sorted_bam}" >> "combine_commands.sh"

done

chmod +x "PE_commands.sh"
chmod +x "SE_commands.sh"
chmod +x "combine_commands.sh"
