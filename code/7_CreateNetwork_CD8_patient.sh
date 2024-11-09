#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_7_CD8_patient                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

TOBIAS CreateNetwork --TFBS /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_patient_bound_HSannotated_cleaned_bed/* \
    --origin /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/CreateNetwork_output/CD8_TFgene_geneID_final.txt



