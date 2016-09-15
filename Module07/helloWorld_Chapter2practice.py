'''
Created on Jun 30, 2015

@author: sarvani
'''
from test.test_sys_setprofile import protect
from _hashlib import new
print("Hello World");

print("Hello\nWorld\n");

Dna = "dog";
rna = Dna + "cat" + "123";#concatenation
print (rna);
rna_length = len(rna);
print(rna_length)
strg = str(rna);
print (strg);
print("strg@");

#original does not change
my_word = "FLOWER";
lowercase_word = my_word.lower();
print("after: " + my_word);

uppercase_word = Dna.upper();
print("after: " + Dna);

my_sentence = "sky is blue";
print(my_sentence.replace("sky", "pot"));
#original does not change

#extracting
my_word = "123456";
zeroth = my_word[1];
print(zeroth)

#counting
protein = "ktnktvvvvvv";

valine_count = protein.count('v');
print(valine_count);

print(str(protein.find('kt')));
print(str(protein.find('z')));

#EXERCISES
#Q1.CALCULATING AT CONTENT
my_Dna_Seq = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT"

AT_count = my_Dna_Seq.count('AT');
print (AT_count);

#compl_table = maketrans('ATGC','TACG')
#complement = my_Dna_Seq.translate(compl_table))
#Q.3.Restriction fragment lengths
my_Seq = "ACTGATCGATTACGTATAGTA GAATTC TATCATACATATATATCGATGCGTTCAT";
my_Seqt = "ACTGATCGATTACGTATAGTAGAATTCTATCATACATATATATCGATGCGTTCAT";

seq1, seq2 = my_Seqt.split('GAATTC');
seq3, seq4 = my_Seq.split('AATTC');
partn = my_Seqt.partition('AATTC');
print (seq1, seq2);
print (seq3, seq4);
print (partn)

#Q.4.A.Splicing out introns, part one

my_Dna_Section = "ATCGATCGATCGATCGACTGACTAGTCATAGCTATGCATGTAGCTACTCGATCGATCGATCGATCGATCGATCGATCGATCGATCATGCTATCATCGATCGATATCGATGCATCGACTACTAT" 
#Get total length of DNA Section
length_Section = len(my_Dna_Section);
print(length_Section);

#Extract exons or coding regions
exon_one = my_Dna_Section[1:63];
exon_two = my_Dna_Section[91:123];
intron = my_Dna_Section[64:90];
print(exon_one);
print(exon_two);

#Q.4.B.Splicing out introns, part two
length_Exon_One = len(exon_one);
length_Exon_Two = len(exon_two);
length_both = length_Exon_One + length_Exon_Two;
coding_Percentage = ((length_both/length_Section) * 100);
print(coding_Percentage);

#Q.4.C.Splicing out introns, part three
new_Dna = exon_one.upper() + intron.lower() + exon_two.upper();
print(new_Dna);






