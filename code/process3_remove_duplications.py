# Function to read file, detect duplicates, and write to a new file
def remove_duplicates(input_file, output_file):
    # Create a set to store unique lines
    seen_lines = set()
    # List to store the cleaned content
    cleaned_lines = []

    # Open the input file for reading
    with open(input_file, 'r') as file:
        for line in file:
            # Check if the line is already seen
            if line not in seen_lines:
                # If not, add it to the set and the cleaned list
                seen_lines.add(line)
                cleaned_lines.append(line)
            else:
                print(f"Removing: {line}")
    
    # Open the output file for writing
    with open(output_file, 'w') as file:
        for line in cleaned_lines:
            file.write(line)
    
    print(f"Duplicates removed. Cleaned content saved to {output_file}")

# Specify the input and output file names
input_file = 'CD8_TFgene_geneID_4final.txt'
output_file = 'CD8_TFgene_geneID_final.txt'

# Call the function to remove duplicates and save to a new file
remove_duplicates(input_file, output_file)