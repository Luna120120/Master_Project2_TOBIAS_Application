#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_7_test                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 8

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

TOBIAS CreateNetwork --TFBS /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/annotated_tfbs/* \
    --origin /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/motif2gene_mapping.txt



