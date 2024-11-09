# Application of TOBIAS for ATAC-seq data analysis and TF-TF interactive networks creation

## Background knowledge

**1. ATAC-seq (Assay for Transposase-Accessible Chromatin using sequencing)** is a technique used to study chromatin accessibility across the genome. It employs a transposase enzyme that inserts sequencing adapters into open, accessible regions of DNA, allowing researchers to identify active regulatory elements such as promoters and enhancers. 

The principle of ATAC-seq:

![ATAC-seq principle](figures/ATAC-seq_principle.svg | width = 100)

ATAC-seq data analysis workflow:

![TOBIAS workflow](figures/ATAC-seq_data_analysis_workflow.svg | width = 100)

**2. TOBIAS (Transcription factor Occupancy prediction By Investigation of ATAC-seq Signal)** is a computational tool used with ATAC-seq data to predict transcription factor binding sites. By accounting for chromatin accessibility and footprinting, TOBIAS improves the accuracy of identifying transcription factor occupancy, enabling deeper insights into gene regulation and cell-specific regulatory networks.

TOBIAS principle:

![TOBIAS principle](figures/TOBIAS_principle.svg | width = 100)

## Description
This repository contain:

(1) The test script to run the test data from the TOBIAS repository: https://github.com/loosolab/TOBIAS.

(2) The scripts for data processing and applying TOBIAS to the analysis of ATAC-seq data of the health and patient CD4 and CD8 cell samples to decipher TF-binding regulatory mechanism responsible for Psoriatic Arthritis (PsA).

All the scripts are adapted to The University of Manchester CFS3 (Computational Share Facility 3).

## Workflow
