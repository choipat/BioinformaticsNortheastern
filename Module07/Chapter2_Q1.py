# Q1.CALCULATING AT CONTENT
# Here's a short DNA sequence:
# ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT
# Write a program that will print out the AT content of this DNA sequence. Hint: you
# can use normal mathematical symbols like add (+), subtract (-), multiply (*), divide
# (/) and parentheses to carry out calculations on numbers in Python.
# Reminder: if you're using Python 2 rather than Python 3, include this

my_Dna_Seq = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT"

A_count = my_Dna_Seq.count('A');
T_count = my_Dna_Seq.count('T');
print ("A count = " + str(A_count));
print ("T count = " + str(T_count));