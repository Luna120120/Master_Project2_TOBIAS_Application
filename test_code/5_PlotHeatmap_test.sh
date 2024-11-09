#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_5                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 8

module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

Bcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Bcell/Bcell_corrected.bw
Tcell_signal=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/1_ATACorrect_test/Tcell/Tcell_corrected.bw

TFBS_all=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_all.bed
TFBS_Bcell_bound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Bcell_bound.bed
TFBS_Bcell_unbound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Bcell_unbound.bed
TFBS_Tcell_bound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Tcell_bound.bed
TFBS_Tcell_unbound=/mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/BATF_Tcell_unbound.bed

# Comparison of signal across different bigwigs:
TOBIAS PlotAggregate --TFBS $TFBS_all \
    --signals /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/Bcell_*.bw \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/5_PlotHeatmap_test/BATF_Bcell_heatmap.png \
    --sort_by -2 # !!! TOBIAS: error: unrecognized arguments: --sort_by -2

TOBIAS PlotAggregate --TFBS $TFBS_all  \
    --signals /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/Tcell_*.bw \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/5_PlotHeatmap_test/BATF_Tcell_heatmap.png \
    --sort_by -2 !!! TOBIAS: error: unrecognized arguments: --sort_by -2

# Comparison of TFBS subsets for different conditions (number of --TFBS must match number of --signals): --- !!! probably only this can work
TOBIAS PlotHeatmap --TFBS $TFBS_Bcell_bound $TFBS_Bcell_unbound --TFBS $TFBS_Tcell_bound $TFBS_Tcell_unbound \
    --signals $Bcell_signal $Tcell_signal \
    --output /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testoutput/5_PlotHeatmap_test/BATF_compare_heatmap.pdf \
    --signal_labels Bcell Tcell \
    --share_colorbar \
    --sort_by -1


