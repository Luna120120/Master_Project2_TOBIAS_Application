#!/bin/bash --login
#$ -j y
#$ -o /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testlog
#$ -N job_6                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 8

module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1


TOBIAS PlotTracks --bigwigs /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/*cell_corrected.bw \
    --bigwigs /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/*cell_footprints.bw \
    --regions /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/plot_regions.bed \
    --sites /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/binding_sites.bed \
    --highlight /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/binding_sites.bed \
    --gtf /mnt/iusers01/fatpou01/bmh01/msc-bioinf-2023-2024/f48035lh/scratch/TOBIAS_testdata/genes.gtf \
    --colors red darkblue red darkblue

