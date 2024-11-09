import pandas as pd

# Define the file paths
input_file_path = 'Homo_sapiens.GRCh38.112_sorted.gtf'   # Replace with the path to your input file
output_file_path = 'Homo_sapiens.GRCh38.112_sorted_chr.gtf' # Replace with the path where you want to save the modified file

# Read the file into a DataFrame
df = pd.read_csv(input_file_path, sep='\t', header=None, comment='#')

# Rename the columns for clarity
df.columns = ['Chromosome', 'Source', 'Feature', 'Start', 'End', 'Score', 'Strand', 'Phase', 'Attributes']

# Convert chromosome numbers to "chr" format
df['Chromosome'] = df['Chromosome'].apply(lambda x: f'chr{x}')

# Save the modified DataFrame to a new file
df.to_csv(output_file_path, sep='\t', header=False, index=False)

print(f"File has been processed and saved as {output_file_path}")


