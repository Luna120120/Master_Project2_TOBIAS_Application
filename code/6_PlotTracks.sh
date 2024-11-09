#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

CORRECTED_BW_healthy_CD4=
FOOTPRINT_BW_healthy_CD4=

PLOT_REGION=
BINDING_SITE=
GENES=

# For healthy_CD4
TOBIAS PlotTracks --bigwigs test_data/*cell_corrected.bw \
    --bigwigs test_data/*cell_footprints.bw \
    --regions test_data/plot_regions.bed \
    --sites test_data/binding_sites.bed \
    --highlight test_data/binding_sites.bed \
    --gtf test_data/genes.gtf \
    --colors red darkblue red darkblue

# For healthy_CD8


# For patient_CD4


# For patient_CD8