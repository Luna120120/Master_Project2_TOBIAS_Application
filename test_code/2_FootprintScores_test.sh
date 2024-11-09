#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_2                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1+i

Bcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell/Bcell_corrected.bw
Tcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Tcell/Tcell_corrected.bw

# For B cell
TOBIAS FootprintScores --signal $Bcell_signal \
    --regions /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks.bed \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/2_ScoreBigWig_test/Bcell_footprints.bw \
    --cores $NSLOTS

# For T cell
TOBIAS FootprintScores --signal $Tcell_signal \
    --regions /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/merged_peaks.bed \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/2_ScoreBigWig_test/Tcell_footprints.bw \
    --cores $NSLOTS