'''
Created on Jul 21, 2015

@author: sarvani
'''
#Write a python3 program parse_blast2.py, and define a function that parses a BLAST line and 
#returns the transcript ID and swissProt ID.
#Your program must use keyword arguments for the function.
#Read the tab-delimited file /scratch/RNASeq/diffExpr.P1e-3_C2.matrix and parse all fields.
#Get the corresponding protein for the transcript from the transcript_to_protein dictionary
#If there is no BLAST match use the transcript ID as the protein ID.
#Print protein, Sp_ds, Sp_hs, Sp_log, Sp_plat to the console in tab-delimited format

transcript_to_protein = {};

def parse_blast(blast_line="NA"):
    # split given blast line to get all the fields.
    fields = blast_line.rstrip("\n").split("\t");
    if len(fields) < 12:
        # make sure given line a valid Blast line.
        print("Not a valid blast line");
        return;

    # transcript id is in the first field.
    (transcriptId, isoform) = fields[0].split("|");
    (giType, gi, swissProtType, swissProtId, proteinId) = fields[1].split("|");
    
    transcript_to_protein[transcriptId] = proteinId;
    
    # open the matrix file
    matrix_file = open("/scratch/RNASeq/diffExpr.P1e-3_C2.matrix");
    for line in matrix_file:
        matrixFields = line.rstrip("\n").split("\t");
        if len(matrixFields) == 5: 
            (transcript, Sp_ds, Sp_hs, Sp_log, Sp_plat) = matrixFields; 
            
            protein = transcript;
    
            if transcript in transcript_to_protein:
                protein = transcript_to_protein.get(transcript);
            
            tab = "\t";
                #Print protein, Sp_ds, Sp_hs, Sp_log, Sp_plat to the console in tab-delimited format     
            fields = (protein,Sp_ds,Sp_hs,Sp_log,Sp_plat);     
            print(tab.join(fields));

        else:
            print("Not a valid matrix line");
                    
    return(transcriptId, swissProtId);

blast_file = open("./sampleBlastFile.txt"); # read 10 sample lines from blast file.
for line in blast_file:
    (transcriptId, swissProtId) = parse_blast(line);
    if not transcriptId:
        print("Error in parse_blast");