#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32_CD4                      # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

MOTIFS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/test_run/data/clean/JASPAR_motifs/joined_motifs.jaspar
HEALTHY=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/ScoreBigwig_output/healthy_CD4_footprint_scores.bw
PATIENT=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/ScoreBigwig_output/patient_CD4_footprint_scores.bw
GENOME=/mnt/jw01-aruk-home01/projects/functional_genomics/common_files/data/external/reference/Homo_sapiens/hg38/Sequence/WholeGenomeFasta/genome.fa
PEAKS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/test_run/data/clean/merged_peaks/CD4_merged_peaks.bed
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/BINDetect_output/BINDetect_CD4

mkdir -p $OUTDIR

TOBIAS BINDetect --motifs $MOTIFS \
    --signals $HEALTHY $PATIENT \
    --genome $GENOME \
    --peaks $PEAKS \
    --outdir $OUTDIR \
    --cond_names healthy_CD4 patient_CD4 \
    --cores $NSLOTS