#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log_merged
#$ -N merge_bams_32                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

module load functional_genomics/tools/samtools/1.18

# Define the base directory for BAM files
BAM_DIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/raw/clean_alignments

# Define the sample groups along with their sample names
healthy_CD4=("NRHV014XCD4" "NRHV073CD4" "NRHV079CD4" "NRHV086CD4" "NRHV121CD4" "NRHV151_CD4" "NRHV168CD4" "NRHV171CD4" "NRHV238_CD4" "NRHV290CD4" "NRHV295CD4" "NRHV321_CD4" "NRHV322CD4" "NRHV324CD4" "NRHV325_CD4" "NRHV326CD4" "NRHV332_CD4")
healthy_CD8=("NRHV014XCD8" "NRHV073CD8" "NRHV079CD8" "NRHV086CD8" "NRHV121CD8" "NRHV151_CD8" "NRHV168_CD8" "NRHV171CD8" "nrhv238_CD8_" "NRHV290_CD8" "NRHV295CD8" "NRHV321_CD8" "NRHV322CD8" "NRHV324CD8" "NRHV325_CD8" "NRHV326_CD8" "NRHV332CD8")
patient_CD4=("PsA4920_CD4" "PsA4944_CD4" "PSA4945_CD4" "PSA4947CD4" "PsA4949_CD4" "PsA4950_CD4" "psa4951_CD4" "PsA4952CD4" "PsA4954CD4" "PsA4956CD4" "PsA4957CD4" "PsA4958CD4" "PsA4959CD4" "PSA4962CD4" "PsA4963_CD4" "PSA4964CD4" "PSA4967CD4" "PSA4968CD4" "PSA5006CD4" "PSA5007CD4" "PsA5008_CD4" "PsA5009CD4" "PsA5010CD4" "PsA5012_CD4" "PsA5013CD8" "PsA5014CD4" "PSA5017_CD4" "PsA5018CD4" "PsA5019CD4" "PsA5021CD4" "PsA5026CD4" "PsA5036CD4" "PSA5037_CD4" "PSA5040CD4")
patient_CD8=("PsA4920_CD8" "PsA4941CD8" "PsA4944CD8" "PsA4945_CD8" "PSA4946CD8" "PsA4947_CD8" "PsA4948_CD8" "PSA4949_CD8" "PsA4950CD8" "psa4951_CD8" "PsA4952_CD8" "PsA4953_CD8" "PsA4954_CD8" "PSA4955CD8" "PsA4956CD8" "PsA4958CD8" "PSA4959_CD8" "PsA4960_CD8" "PsA4961_CD8" "PsA4962CD8" "PsA4963_CD8" "PsA4964_CD8" "PsA4965CD8" "PSA4966CD8" "PsA4968CD8" "PSA4969CD8" "PsA5006CD8" "PsA5007CD8" "PSA5008CD8" "PsA5009CD8" "PsA5010CD8" "PsA5012_CD8" "PsA5013CD4" "PsA5014CD8" "PsA5015CD8" "PSA5017_CD8" "PsA5018CD8" "PsA5019CD8" "PsA5020CD8" "PsA5021CD8" "PsA5022CD8" "PsA5023CD8" "PsA5024CD8" "PsA5026CD8" "PsA5036CD8" "PSA5037CD8" "PSA5039_CD8" "PSA5040CD8")

# Define the directory path
MERGED_BAM_DIR="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/merged_bam_files"
# Create the directory to store merged BAM files
mkdir -p "$MERGED_BAM_DIR"

# Function to merge BAM files
merge_bam_files() {
    local sample_group=$1
    local output_file=$2
    local samples=("${!3}") # Accessing the array passed as the third argument using parameter expansion

    local bam_files=() # Array to hold BAM files for merging

    # Populate the array with BAM files for all samples
    for sample in "${samples[@]}"; do
        bam_files+=("${BAM_DIR}/${sample}/${sample}_align_dedup_filtered.bam")
    done

    # Merge all BAM files into one output BAM file
    samtools merge "${MERGED_BAM_DIR}/${output_file}" "${bam_files[@]}"
}

# Call the function for each sample group to merge BAM files
merge_bam_files "healthy_CD4" "merged_healthy_CD4.bam" healthy_CD4
merge_bam_files "healthy_CD8" "merged_healthy_CD8.bam" healthy_CD8
merge_bam_files "patient_CD4" "merged_patient_CD4.bam" patient_CD4
merge_bam_files "patient_CD8" "merged_patient_CD8.bam" patient_CD8