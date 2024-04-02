# Description: Create stats.tsv from the alignment bam files
# Note: Modified from Max's code

import os
import subprocess

# Used directories
bam_dir = "/Scratch/jill/alignment_results_bwa"
stats_file = "/Scratch/jill/tools/stats.tsv"
sample_file = "/Scratch/jill/tools/sample_orders.txt"

def run_command(command):
    try:
        result = subprocess.run(command, shell=True, check=True, text=True, stdout=subprocess.PIPE)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"An error occurred: {e}")
        return None

# Get sample order
sample_order = []
with open(sample_file, "r") as f:
    for line in f: sample_order.append(line.strip())

# Calculalte stats
with open(stats_file, 'w') as fileO:

    # write header
    fileO.write("Sample\tReads\tMapped\tMap-Rate\tDuplicates\tDup-Rate\tDepth\tCoverage\tInsert-size\n")

    for sample in sample_order:
        # Get path
        bam_path = f"{bam_dir}/{sample}.bam"

        # Get temporary stats
        temp_stats = f"temp_{sample}.stats"
        run_command(f"samtools stats -q 10 {bam_path} --threads 30 > {temp_stats}")
        
        # Get genome size: grep -v '^>' bslug.final.fa | wc -m
        # 2056775138
        mapped = run_command(f"grep 'reads mapped:' {temp_stats} | awk '{{print $4}}'")
        reads = run_command(f"grep 'raw total sequences:' {temp_stats} | awk '{{print $5}}'")
        if reads == "0":
            fileO.write(f"{sample}\treads=0\n")
            continue
        else:
            depth = run_command(f"grep ^COV {temp_stats} | awk '{{ sum += $3 * $4 }} END {{ print sum/2056775138 }}'")
            coverage = run_command(f"grep ^COV {temp_stats} | awk '{{ sum += $4 }} END {{ print sum/2056775138 }}'")
            insert = run_command(f"grep 'insert size average' {temp_stats} | awk '{{print $5}}'")
            dup = run_command(f"grep 'reads duplicated' {temp_stats} | awk '{{print $4}}'")

        fileO.write(f"{sample}\t{reads}\t{mapped}\t{float(mapped)/float(reads):.3f}\t{dup}\t{float(dup)/float(reads):.3f}\t{depth}\t{coverage}\t{insert}\n")

        # Remove temporery file
        run_command(f"rm {temp_stats}")
