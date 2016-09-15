'''
Created on Jul 13, 2015

@author: sarvani
'''
from _hashlib import new
my_file = open("dna.txt");
file_contents = my_file.read();
print(file_contents);

my_file_name = "dna.txt"#is a string & stores name of a file on disk
my_file_obj = open(my_file_name);#is a file object
my_file_contents = my_file_obj.read();#store the
                                       #resulting string in the variable my_file_contents

#is the same as 
apple = "dna.txt";
banana = open(apple);
grape = banana.read();

#what we open we can read 
#what we read we can print
#open and w -writing or r reading a -appending
#diff-w-over writes and a -does not overwrite

my_file = open("dna.txt");
file_contents = my_file.read();
#after reading file contents use rstrip to remove new lines like chomp
my_dna = file_contents.rstrip("\n");
dna_length = len(my_dna);

new_file = open("out.txt", "w");
new_file.write("Hello World as usual");
new_file.close()
#close is a method,open is a function

#EXERCISES
#Q.1
"""
Seq = open("ch2seq.txt","r");
dnaSeq = Seq.read().rstrip("\n");
exon_one = dnaSeq[0:62]; # String start at index 0. So get exon_on from 0.
exon_two = dnaSeq[90:]; # Strins are 0 indexed so make sure 91st character starts from 90.
intron = dnaSeq[62:90];
intfile = open("intronfile", "w");
intfile.write("intron");
intfile.close();
"""
#Q.2
dnaSequence2 = "actgatcgacgatcgatcgatcacgact";
convertedSeq = dnaSequence2.upper();
DNASequence3= "ACTGAC-ACTGT--ACTGTA----CATGTG"
file = open("fastaFile.FASTA", "w");
file.write(">ABC123\nATCGTACGATCGATCGATCGCTAGACGTATCG");
file.write("\n>DEF456\n"+convertedSeq);
file.close();





