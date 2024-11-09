#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32_process3                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 4

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# This code removes the _mitifID from the 4th column for eeach TF: AhrArnt_MA0006.2 ---> AhrArnt


# Define the base directory containing the BINDetect_CD4 and BINDetect_CD8 folders
basedir="/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/BINDetect_output"
# Define the subdirectories to look for within the base directory
subdirs=("BINDetect_CD4" "BINDetect_CD8")

# Process each subdirectory (CD4 and CD8)
for subdir in "${subdirs[@]}"; do
    # Construct the full path to the BINDetect_CD4 or BINDetect_CD8 directory
    full_subdir_path="${basedir}/${subdir}"
    echo "Processing on subdirectory ${full_subdir_path}"
    
    # Loop through each TFgene_unique-motifID directory within the current subdirectory
    for tf_motif_dir in "${full_subdir_path}"/*; do
        # Extract the basename (e.g., "Alx1_MA0854.2")
        tf_motif_name=$(basename "${tf_motif_dir}")
        # Construct the full path to the 'beds' directory
        tf_motif_path="${tf_motif_dir}/beds"
        echo " "
        echo "Processing on directory ${tf_motif_path}"
        
        # Ensure the path exists and is a directory
        if [ -d "${tf_motif_path}" ]; then
            echo "Directory ${tf_motif_path} exists"
            # Identify the healthy and patient BED files
            for condition in "healthy" "patient"; do
                for celltype in "CD4" "CD8"; do
                    # Construct the filename pattern
                    file_pattern="${tf_motif_name}_${condition}_${celltype}_bound.bed"
                    file_path="${tf_motif_path}/${file_pattern}"
                    echo "---File ${file_pattern} at ${file_path} is searched"
                    
                    # Check if the file exists
                    if [ -f "${file_path}" ]; then
                        echo "File ${file_pattern} exists"
                        # Create a temporary file for the output
                        temp_file=$(mktemp)
                        
                        # Modify the fourth column by removing everything after '_'
                        awk 'BEGIN{OFS="\t"} {split($4, a, "_"); $4=a[1]; print $0}' "${file_path}" > "${temp_file}"
                        
                        # Construct the new filename
                        new_filename="${tf_motif_name%_*}_${celltype}_${condition}_bound.bed"
                        new_file_path="${tf_motif_path}/${new_filename}"
                        
                        # Move the temp file to the final output file
                        mv "${temp_file}" "${new_file_path}"
                        
                        echo "Processed and saved: ${new_filename}"
                    else
                        echo "File not found: ${file_path}"
                    fi
                done
            done
        else
            echo "Directory not found: ${tf_motif_path}"
        fi
    done
done

echo "Processing complete"