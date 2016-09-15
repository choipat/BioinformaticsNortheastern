'''
Created on Aug 09, 2015

@author: sarvani
'''
#Write a Python3 program that:
#• Reads a tab-separated file of BLAST output(/scratch/RNASeq/blastp.outfmt6),	parses	it,	and	creates a
#dictionary	with transcript	ID as the key and SwissProt	ID	as	the	value. This is
#similar to	what you did in	Module	9,	so	review	the	module	9	solution	to
#refresh	your	memory	on	BLAST	parsing	and	dictionaries.


#• Reads	the	same	input	files	and prints	the	same	output	as	the	module	9
#solution.



#• Uses	map	to	iterate	over the lines	of	differential	expression	data
#(/scratch/RNASeq/diffExpr.P1e-3_C2.matrix) and	produce	a	list
#of	tuples.	Each	element	in	the	list	corresponds	to	a	line	of	DE	data.	Each
#element	in	the	tuple	corresponds	to	a	field within	one	line	of	DE	data. The
#first	element	in	the	tuple	should	be	a	protein	ID	obtained	from	the	dictionary.
#If	no	dictionary	entry	for	the	transcript	use	the	transcript	ID.



#• Prints	the	tuples	in	tab-separated	format.



#• Has	only	one	for	loop.	You’ll	need	one	for	loop	to	create	the	dictionary.


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

# Parse one line of DE data
def parse_matrix(matrix_line):
    # Remove end-of-line chars and split on tabs
################this is in parseBlast2 file
    matrixFields = matrix_line.rstrip("\n").split("\t")
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
################################################################
        return(tuple([protein] + matrixFields))


########This is in the examples#################
# Helper utility to add tabs to tuples
def tuple_to_tab_sep(one_tuple):
    tab = "\t"
    return tab.join(one_tuple)


##### not in the file##############
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


###############This is in the examples

matrix = open("/scratch/RNASeq/diffExpr.P1e-3_C2.matrix")
newline = "\n"
list_of_de_tuples = map(parse_matrix, matrix.readlines())
list_of_tab_sep_lines = map(tuple_to_tab_sep, list_of_de_tuples)
print (newline.join(list_of_tab_sep_lines))