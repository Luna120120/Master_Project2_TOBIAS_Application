#!/bin/bash --login
#$ -j y
#$ -o /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/log
#$ -N job_32_CD4                     # Job name (output .o and .e files use this name)
#$ -pe smp.pe 32

#$ -t 1-2
INDEX=$((SGE_TASK_ID))

# Inform the app how many cores we requested for our job. The app can use this many cores.
# The special $NSLOTS keyword is automatically set to the number used on the -pe line above.
export OMP_NUM_THREADS=$NSLOTS

# Load relevant modules
module load functional_genomics/utils/envs/py3916_r423
module load functional_genomics/peak/tobias/0.16.1

# Select sample from index
SAMPLE=$(awk "NR==$INDEX" /mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/raw/clean_alignments/samples_CD4.txt)
filename="$SAMPLE" 
# Basename of sample
sample_name=$(echo "$filename" | sed 's/^merged_//; s/\.bam$//')
echo "running on sample" "$sample_name"

# Defines the paths for various necessary files
CORRECTED_BW=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/ATACorrect_output/$sample_name/merged_"$sample_name"_corrected.bw
PEAKS=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/test_run/data/clean/merged_peaks/CD4_merged_peaks.bed
OUTDIR=/mnt/jw01-aruk-home01/projects/oa_functional_genomics/projects/TOBIAS/analyses/luna_masters/data/output/ScoreBigwig_output/$sample_name

mkdir -p $OUTDIR

# Path to the output file
OUTPUT_FILE=$OUTDIR/"$sample_name"_footprint_scores.bw

sleep $(($INDEX*20))

TOBIAS FootprintScores --signal $CORRECTED_BW \
    --regions $PEAKS \
    --output $OUTPUT_FILE \
    --cores $NSLOTS