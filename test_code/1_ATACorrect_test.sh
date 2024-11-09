#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_1                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# For B cell
TOBIAS ATACorrect --bam /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/Bcell.bam \
    --genome /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/genome.fa.gz \
    --peaks /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks.bed \
    --blacklist /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/blacklist.bed \
    --outdir /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell \
    --cores $NSLOTS

# For T cell
TOBIAS ATACorrect --bam /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/Tcell.bam \
    --genome /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/genome.fa.gz \
    --peaks /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks.bed \
    --blacklist /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/blacklist.bed \
    --outdir /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Tcell \
    --cores $NSLOTS
