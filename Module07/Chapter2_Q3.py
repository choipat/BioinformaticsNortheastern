# Q3. Restriction fragment lengths
# Here's a short DNA sequence:
# ACTGATCGATTACGTATAGTAGAATTCTATCATACATATATATCGATGCGTTCAT
# The sequence contains a recognition site for the EcoRI restriction enzyme, which
# cuts at the motif G*AATTC (the position of the cut is indicated by an asterisk).
# Write a program which will calculate the size of the two fragments that will be
# produced when the DNA sequence is digested with EcoRI.

seq = "ACTGATCGATTACGTATAGTAGAATTCTATCATACATATATATCGATGCGTTCAT";

seq1, seq2 = seq.split('GAATTC');
print("First sequence is of length " + str(len(seq1) + len('G')));
print("Second sequence is of length " + str(len(seq2) + len('AATTC')));

#seq3, seq4 = seq.split('AATTC');
#partn = seq.partition('GAATTC');
#print (seq1, seq2);
#print (seq3, seq4);
#print (partn)