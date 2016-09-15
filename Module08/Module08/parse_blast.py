'''
Created on Jul 14, 2015

@author: sarvani
'''
#reads in blastp.outfmt6 from the /scratch/RNASeq directory.
#splits each line on tabs ("\t").
#for fields that contain |, split the variables on |.
#print the transcript ID (e.g. c1006_g1_i1), the isoform (e.g. m.806), the SwissProt ID (e.g. O94631.1), and the identity (e.g. 100.00) separated by tabs to a file named parsed_blast.txt using a file object.
#open the input file
my_file = open("/scratch/RNASeq/blastp.outfmt6");
#create output file
out_file = open("parsed_blast.txt", "w");

# For every line split on tab
for line in my_file:
    words = line.split("\t");
    # First word consists of transcript ID and isoform. So, split them further on '|'
    firstParts = words[0].split("|");
    transcriptID = firstParts[0];
    isoform = firstParts[1];
    
    # Second word consists of sp ID. 
    secondParts = words[1].split("|");
    swissProtID = secondParts[3];
    identity = words[2];
    
    # Finally write the values to the output file.
    out_file.write(str(transcriptID) + "\t" + str(isoform) + "\t" + str(swissProtID) + "\t" + identity + "\n");
    
   
    
    
    
    

