import pandas as pd
import re

def extract_gene_info(info_str):
    """
    Extract gene_id and gene_name from the given info string.
    """
    gene_id_match = re.search(r'gene_id\s*"([^"]+)"', info_str)
    gene_name_match = re.search(r'gene_name\s*"([^"]+)"', info_str)
    
    gene_id = gene_id_match.group(1) if gene_id_match else ""
    gene_name = gene_name_match.group(1) if gene_name_match else ""
    
    return gene_id, gene_name

def process_bed_file(input_file, output_file):
    # Read the input file into a pandas DataFrame
    df = pd.read_csv(input_file, sep='\t', header=None, dtype=str)  # Ensure all data is read as string

    # Extract gene_id and gene_name from the last column, converting NaN to empty string
    gene_columns = df.iloc[:, -1].fillna('').apply(lambda x: pd.Series(extract_gene_info(x)))
    gene_columns.columns = ['gene_id', 'gene_name']

    # Concatenate the original DataFrame with the new gene columns
    df = pd.concat([df.iloc[:, :-1], gene_columns], axis=1)

    # Rename columns only if needed (if you need to refer to them by specific names later)
    df.columns = [f'col{i}' for i in range(len(df.columns) - 2)] + ['gene_id', 'gene_name']
    
    # Write to the new output file
    df.to_csv(output_file, sep='\t', header=False, index=False)

def main():
    # Define the input and output file names
    input_file = '/Users/luna/Library/CloudStorage/OneDrive-Personal/UOM_Master/!!!Courses/BIOL61280_Research_Project_2/output/annotated_ATOH7_CD4_healthy_bound.bed'
    output_file = '/Users/luna/Library/CloudStorage/OneDrive-Personal/UOM_Master/!!!Courses/BIOL61280_Research_Project_2/output/ATOH7_CD4_healthy_bound_annotated_cleaned.bed'
    
    # Process the BED file
    process_bed_file(input_file, output_file)
    
if __name__ == '__main__':
    main()




