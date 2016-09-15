'''
Created on Aug 15, 2015

@author: sarvani
'''

class blast:
    # Parse given BLAST line and construct an object.
    def __init__(self, blast_line="NA"):
        #Remove end-of-line with rstrip and split on tabs.
        fields = blast_line.rstrip("\n").split("\t")
        # Get the query ID string from index zero of the fields list.
        self.queryIdString = fields[0]
        # Get the subject ID string from index one of the fields list.
        self.subjectIdString = fields[1]
        # Get the identity from index two of the fields list.
        self.identity = float(fields[2])
        # Split the query ID string on |.
        self.queryIds = self.queryIdString.split("|")
        # Split the subject ID string on |.
        subjectIds = self.subjectIdString.split("|")
        # Get the transcript ID
        self.transcript = self.queryIds[0]
        # Get the SwissProt ID
        self.swissProt = subjectIds[3]
        # Get the base SwissProt ID (without version)
        self.base = self.swissProt.split(".")[0]

trans_to_protein = {};
class Matrix:
    def __init__(self, matrix_line="NA"):
        # Remove end-of-line chars and split on tabs
        matrixFields = matrix_line.rstrip("\n").split("\t")
        # Make sure there are enough fields to unpack this
        if len(matrixFields) == 5:
            # Unpack the matrix field list into named variables
            (transcript,Sp_ds,Sp_hs,Sp_log,Sp_plat) = matrixFields
            # Default protein to transcript in case no dictionary match
            self.protein = transcript
            # Check if there's an entry for the transcript in the dictionary
            if transcript in trans_to_protein:
                # Get the protein ID from the dictionary
                blast_obj = trans_to_protein.get(transcript)
                self.protein = blast_obj.swissProt
                
            self.Sp_ds = Sp_ds
            self.Sp_hs = Sp_hs
            self.Sp_log = Sp_log
            self.Sp_plat = Sp_plat

def identity_threshold(blast_object):
    return blast_object.identity > 95

# Helper utility to add tabs to tuples
def tuple_to_tab_sep(one_tuple):
    tab = "\t"
    return tab.join(one_tuple)

# Open the BLAST output file.
blast_output = open("/scratch/RNASeq/blastp.outfmt6")

# Read all the lines from the file and create blast objects.
parsed_blast = map(blast, blast_output.readlines())

# Use filter to construct filtered dictionary
filtered_blast = filter(identity_threshold, parsed_blast)
trans_to_protein = {blast_obj.transcript:blast_obj for blast_obj in filtered_blast}

matrix_file = open("/scratch/RNASeq/diffExpr.P1e-3_C2.matrix")
matrix_map = map(Matrix, matrix_file.readlines())

for matrix_obj in matrix_map:
    print(tuple_to_tab_sep((matrix_obj.protein,
                           matrix_obj.Sp_ds,
                           matrix_obj.Sp_hs,
                           matrix_obj.Sp_log,
                           matrix_obj.Sp_plat)))
