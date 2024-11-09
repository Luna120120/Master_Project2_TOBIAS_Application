# Read the TF names from CD4_TFname_list.txt
def read_tf_names(file_path):
    with open(file_path, 'r') as file:
        return [line.strip() for line in file]

# Read the mapping from CD4_geneID_TFgene_2swapped.txt and return a dictionary
def read_mapping(file_path):
    mapping = {}
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.strip().split()
            if len(parts) == 2:
                tf_name, gene_id = parts
                mapping[tf_name.upper()] = gene_id
    return mapping

# Write the results to a new file
def write_results(tf_names, mapping, output_file_path):
    with open(output_file_path, 'w') as file:
        for tf_name in tf_names:
            gene_id = mapping.get(tf_name.upper(), '')  # Get gene_id or empty string if not found
            file.write(f"{tf_name}\t{gene_id}\n")

# File paths
tf_names_file = 'CD4_TFname_list.txt'
mapping_file = 'CD4_TFgene_geneID_2swapped.txt'
output_file = 'CD4_TFgene_geneID_3corrected.txt'

# Execute the steps
tf_names = read_tf_names(tf_names_file)
mapping = read_mapping(mapping_file)
write_results(tf_names, mapping, output_file)

print(f"Results written to {output_file}")
