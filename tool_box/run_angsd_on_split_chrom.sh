#!/bin/bash

# Description: Run angsd on split chroms to reduce memeroy load

output_dir="/Scratch/jill/alignment_results_angsd/chrom_subset_results"
bamlist_path="/Scratch/jill/tools/bamlist.txt"
chrom_list="/Scratch/jill/tools/contigs.bslug.final.txt"

if [ -f "chrom_commands.sh" ]; then
    rm "chrom_commands.sh"
fi

awk '{print $1}' "$chrom_list" | while read -r chrom; do

    echo "angsd -GL 2 -out ${output_dir}/${chrom} -nThreads 10 -doGlf 2 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -minMaf 0.05 -minQ 30 -minInd 108 -minMapQ 40 -bam ${bamlist_path} -r ${chrom}: 2>${output_dir}/${chrom}.err" >> "chrom_commands.sh"

done

chmod +x "chrom_commands.sh"
