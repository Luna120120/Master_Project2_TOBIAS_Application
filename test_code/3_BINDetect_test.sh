#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_3                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

Bcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/2_ScoreBigWig_test/Bcell_footprints.bw
Tcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/2_ScoreBigWig_test/Tcell_footprints.bw

# For B cell
TOBIAS BINDetect --motifs /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/motifs.jaspar \
    --signals $Bcell_signal $Tcell_signal \
    --genome /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/genome.fa.gz \
    --peaks /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks_annotated.bed \
    --peak_header /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks_annotated_header.txt \
    --outdir /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/3_BINDetect_test \
    --cond_names Bcell Tcell \
    --cores $NSLOTS
