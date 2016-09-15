# Q2. Complementing DNA
# Here's a short DNA sequence:
# ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT
# Write a program that will print the complement of this sequence.

seq = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT";

# First replace A with T by brute force method

seq = seq.replace('A', 'X');
seq = seq.replace('T', 'Y');
seq = seq.replace('X', 'T');
seq = seq.replace('Y', 'A');

# Now replace C with G
seq = seq.replace('C', 'X');
seq = seq.replace('G', 'Y');
seq = seq.replace('X', 'G');
seq = seq.replace('Y', 'C');

print(seq);

seq = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT";
# Try using 