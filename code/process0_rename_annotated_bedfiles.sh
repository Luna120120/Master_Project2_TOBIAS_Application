#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_16_process7                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 16

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# Define directories
declare -a dirs=(
"/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/CreateNetwork_output/annotated_CD4_healthy_bound_bed"
"/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/CreateNetwork_output/annotated_CD4_patient_bound_bed"
"/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/CreateNetwork_output/annotated_CD8_healthy_bound_bed"
"/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/CreateNetwork_output/annotated_CD8_patient_bound_bed"
)

# Loop through each directory
for dir in "${dirs[@]}"; do
    echo "Processing directory: $dir"
    # Navigate to directory
    cd "$dir"
    # Check if directory change was successful
    if [ $? -eq 0 ]; then
        # Rename files with pattern 'annotated_*' to '*_annotated'
        for file in annotated_*.bed; do
            # Extract filename without 'annotated_' prefix and '.bed' extension
            base_name=$(echo "$file" | sed 's/^annotated_\(.*\)\.bed/\1/')
            # Create new filename format
            new_name="${base_name}_annotated.bed"
            # Rename file
            mv "$file" "$new_name"
            echo "Renamed $file to $new_name"
        done
    else
        echo "Failed to change directory to $dir"
    fi
done

echo "All files have been renamed."



