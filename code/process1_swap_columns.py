import csv

# Read the input file
input_filename = 'CD4_TFgene_geneID_1downloaded.txt'
output_filename = 'CD4_TFgene_geneID_2swapped.txt'

# Open the input file and read its contents
with open(input_filename, 'r') as infile:
    # Skip the header line and process the rest
    reader = csv.reader(infile)
    next(reader)  # Skip the header

    # Open the output file for writing
    with open(output_filename, 'w', newline='') as outfile:
        # Create a writer object that separates values by tabs
        writer = csv.writer(outfile, delimiter='\t')
        
        # Process each row
        for row in reader:
            # Swap columns and write to the output file
            swapped_row = [row[1], row[0]]
            writer.writerow(swapped_row)

print(f"Processed file saved as '{output_filename}'")

