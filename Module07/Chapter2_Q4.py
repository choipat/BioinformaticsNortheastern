# Q4 Splicing out introns, part one
# Here's a short section of genomic DNA:
# ATCGATCGATCGATCGACTGACTAGTCATAGCTATGCATGTAGCTACTCGATCGATCGA
# TCGATCGATCGATCGATCGATCGATCATGCTATCATCGATCGATATCGATGCATCGACT
# ACTAT
# It comprises two exons and an intron. The first exon runs from the start of the
# sequence to the sixty-third character, and the second exon runs from the ninetyfirst
# character to the end of the sequence. Write a program that will print just the
# coding regions of the DNA sequence.

seq = "ATCGATCGATCGATCGACTGACTAGTCATAGCTATGCATGTAGCTACTCGATCGATCGATCGATCGATCGATCGATCGATCGATCATGCTATCATCGATCGATATCGATGCATCGACTACTAT";
 
#Get total length of DNA Section
length = len(seq);
print(length);

#x = "ABCD";
#print(x[0:]);

#Extract exons or coding regions
exon_one = seq[0:62]; # String start at index 0. So get exon_on from 0.
exon_two = seq[90:]; # Strins are 0 indexed so make sure 91st character starts from 90.
intron = seq[62:90];
print("First exon : " + exon_one);
print("Second exon : " + exon_two);

# print(seq == exon_one + intron + exon_two);

# Splicing out introns, part two
# Using the data from part one, write a program that will calculate what percentage
# of the DNA sequence is coding.

length_exon_one = len(exon_one);
length_exon_two = len(exon_two);
length_of_exons = length_exon_one + length_exon_two;
coding_percentage = ((length_of_exons/length) * 100);
print(str(coding_percentage) + " % of DNA sequence is coding.");

# Splicing out introns, part three
# Using the data from part one, write a program that will print out the original
# genomic DNA sequence with coding bases in uppercase and non-coding bases in lowercase.

newSeq = exon_one.upper() + intron.lower() + exon_two.upper();
print("Transformed sequence is : ");
print(newSeq);
