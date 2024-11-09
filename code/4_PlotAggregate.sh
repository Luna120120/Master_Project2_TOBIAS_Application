#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32                     # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

$TFBS_BOUND_CD4=/
$TFBS_BOUND_CD8=/
$HEALTHY_CD4=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/healthy_CD4/merged_healthy_CD4_corrected.bw
$HEALTHY_CD8=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/healthy_CD8/merged_healthy_CD8_corrected.bw
$PATIENT_CD4=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/patient_CD4/merged_patient_CD4_corrected.bw
$PATIENT_CD8=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/patient_CD8/merged_patient_CD8_corrected.bw


# For CD4
TOBIAS PlotAggregate --TFBS \
    --signals $HEALTHY_CD4 $PATIENT_CD4\
    --output \
    --share_y both \
    --plot_boundaries \
    --signal-on-x

# For CD8
TOBIAS PlotAggregate --TFBS \
    --signals $HEALTHY_CD8 $PATIENT_CD8\
    --output \
    --share_y both \
    --plot_boundaries \
    --signal-on-x

