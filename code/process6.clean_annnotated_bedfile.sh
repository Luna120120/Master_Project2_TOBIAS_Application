#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32_process6                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# Define input directories
inputdir_CD4_healthy="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD4_healthy_bound_HSannotated_bed"
inputdir_CD4_patient="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD4_patient_bound_HSannotated_bed"
inputdir_CD8_healthy="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_healthy_bound_HSannotated_bed"
inputdir_CD8_patient="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_patient_bound_HSannotated_bed"

# Define output directories
outputdir_CD4_healthy="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD4_healthy_bound_HSannotated_cleaned_bed"
outputdir_CD4_patient="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD4_patient_bound_HSannotated_cleaned_bed"
outputdir_CD8_healthy="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_healthy_bound_HSannotated_cleaned_bed"
outputdir_CD8_patient="/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_patient_bound_HSannotated_cleaned_bed"

# Ensure output directories exist
mkdir -p "$outputdir_CD4_healthy"
mkdir -p "$outputdir_CD4_patient"
mkdir -p "$outputdir_CD8_healthy"
mkdir -p "$outputdir_CD8_patient"

for condition in "CD4_healthy" "CD4_patient" "CD8_healthy" "CD8_patient"; do
    input_dir="inputdir_${condition}"
    output_dir="outputdir_${condition}"
    
    # Check if input directory exists
    if [ -d "${!input_dir}" ]; then
        echo "Processing files from: ${!input_dir} to ${!output_dir}"

        # Ensure output directory exists
        [ ! -d "${!output_dir}" ] && mkdir -p "${!output_dir}"

        # Process each BED file in the input directory
        for file in "${!input_dir}"/*.bed; do
            echo "Processing file: $file"
            filename=$(basename "$file")
            output_file="${!output_dir}/${filename%.bed}_cleaned.bed"
            
            # Extract gene_id and gene_name using awk and skip lines with "NA"
            awk -F'\t' '{
                gene_id = ""; gene_name = "";                      
                match($NF, /gene_id "([^"]+)"/, arr);              
                gene_id = (length(arr[1]) > 0 && arr[1] != "NA") ? arr[1] : "";
                match($NF, /gene_name "([^"]+)"/, arr);            
                gene_name = (length(arr[1]) > 0 && arr[1] != "NA") ? arr[1] : "";

                if (gene_id != "" && gene_name != "")              
                    print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, gene_id, gene_name;
            }' OFS='\t' "$file" > "$output_file"
            
            echo "Output generated: $output_file"
        done
    else
        echo "Warning: Input directory ${!input_dir} does not exist"
    fi
done




