'''
Created on Aug 09, 2015

@author: sarvani
'''

# Copy of solution 09 given by Prof. Chuck.

# Initialize the transcript_to_protein dictionary.
transcript_to_protein = {};

def parse_blast(blast_line="NA"):
    #Remove end-of-line with rstrip and split on tabs.
    fields = blast_line.rstrip("\n").split("\t")
    # Get the query ID string from index zero of the fields list.
    queryIdString = fields[0]
    # Get the subject ID string from index one of the fields list.
    subjectIdString = fields[1]
    # Get the identity from index two of the fields list.
    identity = fields[2]
    # Split the query ID string on |.
    queryIds = queryIdString.split("|")
    # Split the subject ID string on |.
    subjectIds = subjectIdString.split("|")
    # Get the transcript ID
    transcript = queryIds[0]
    # Get the SwissProt ID
    swissProt = subjectIds[3]
    # Get the base SwissProt ID (without version)
    base = swissProt.split(".")[0]
    # Return the parsed fields
    return(transcript, base, identity)

# Open the BLAST output file.
blast_output = open("/scratch/RNASeq/blastp.outfmt6")
# Read all the lines from the file.
blast_lines = blast_output.readlines()
# Iterate over the lines
for line in blast_lines:
    (transcript,swissProt,identity) = parse_blast(blast_line=line)
    # Add an entry to the dictionary with transcript as key and
    # SwissProt ID as value.
    transcript_to_protein[transcript] = swissProt

# Open the matrix file
matrix = open("/scratch/RNASeq/diffExpr.P1e-3_C2.matrix")
# Read in the matrix lines
matrix_lines = matrix.readlines()
# Iterate over the matrix lines.
for line in matrix_lines:
    # Remove end-of-line chars and split on tabs
    matrixFields = line.rstrip("\n").split("\t")
    # Make sure there are enough fields to unpack this
    if len(matrixFields) == 5:
        # Unpack the matrix field list into named variables
        (transcript,Sp_ds,Sp_hs,Sp_log,Sp_plat) = matrixFields
        # Default protein to transcript in case no dictionary match
        protein = transcript
        # Check if there's an entry for the transcript in the dictionary
        if transcript in transcript_to_protein:
            # Get the protein ID from the dictionary
            protein = transcript_to_protein.get(transcript)

        # Create a tab var to use in join
        tab = "\t"
        # Pack the fields into a list
        fields = (protein,Sp_ds,Sp_hs,Sp_log,Sp_plat)
        # Join the fields on tab and print
        print(tab.join(fields))
