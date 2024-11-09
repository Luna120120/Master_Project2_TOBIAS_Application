#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_4                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 8

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

Bcell_corrected=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell/Bcell_corrected.bw
Bcell_uncorrected=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell/Bcell_uncorrected.bw
Bcell_expected=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell/Bcell_expected.bw
Tcell_corrected=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Tcell/Tcell_corrected.bw

TFBS_all=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_all.bed
TFBS_Bcell_bound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Bcell_bound.bed
TFBS_Bcell_unbound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Bcell_unbound.bed
TFBS_Tcell_bound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Tcell_bound.bed
TFBS_Tcell_unbound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Tcell_unbound.bed

IRF1_all=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/IRF1_all.bed
IRF1_Bcell_bound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/IRF1_Bcell_bound.bed
IRF1_Bcell_unbound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/IRF1_Bcell_unbound.bed

# Visualize the difference in footprints between two conditions for all accessible sites: 
TOBIAS PlotAggregate --TFBS $TFBS_all \
    --signals $Bcell_corrected $Tcell_corrected \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/4_PlotAggregate_test/BATF_footprint_comparison_all.pdf \
    --share_y both \
    --plot_boundaries \
    --signal-on-x

# Visualize the difference in footprints between two conditions exclusively for bound sites: 
TOBIAS PlotAggregate --TFBS $TFBS_Bcell_bound $TFBS_Tcell_bound \
    --signals $Bcell_corrected $Tcell_corrected \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/4_PlotAggregate_test/BATF_footprint_comparison_boundonly.pdf \
    --share_y both \
    --plot_boundaries

# Visualize the split of bound/unbound sites for one condition:
TOBIAS PlotAggregate --TFBS $IRF1_all $IRF1_Bcell_bound $IRF1_Bcell_unbound \
    --signals $Bcell_uncorrected $Bcell_expected $Bcell_corrected \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/4_PlotAggregate_test/IRF1_footprint.pdf \
    --share_y sites \
    --plot_boundaries