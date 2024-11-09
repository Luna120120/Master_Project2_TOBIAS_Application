#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32_CD8                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

#$ -t 1-2
INDEX=$((SGE_TASK_ID))

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# Select sample from index
SAMPLE=$(awk "NR==$INDEX" /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/raw/clean_alignments/samples_CD8.txt)
file_name="$SAMPLE"  # Stores the full sample name
# Basename of sample
sample_name=$(echo "$file_name" | sed sed 's/^merged_//; s/\.bam$//')
echo "running on sample" "$sample_name" # Prints the sample being processed

# Defines the paths for various necessary files
BAM=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/merged_bam_files/"$file_name"    # Path to the BAM file for the current sample
GENOME=/mnt/jw01-aruk-home01/projects/functional_genomics/common_files/data/external/reference/Homo_sapiens/hg38/Sequence/WholeGenomeFasta/genome.fa    # Path to the reference genome
PEAKS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/test_run/data/clean/merged_peaks/CD8_merged_peaks.bed    # Path to the BED file containing the peaks !!!
BLACKLIST=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/common_files/data/external/Blacklist/lists/hg38-blacklist.v2.bed    # Path to the blacklist file
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/$sample_name # Output directory for the current sample

sleep $(($INDEX*20))    # Job Execution Delay. Sleep Command: Delays the job execution by INDEX * 20 seconds to stagger the starts of jobs, preventing resource contention

mkdir -p $OUTDIR    # Create Directory: Creates the output directory if it does not already exist

# Main functions
TOBIAS ATACorrect --bam $BAM \
    --genome $GENOME \
    --peaks $PEAKS \
    --blacklist $BLACKLIST \
    --outdir $OUTDIR \
    --cores $NSLOTS