matrix = [1, 2, 3, 4, 5, 6, 6, 7, 8];
(transcript,Sp_ds,Sp_hs,Sp_log,Sp_plat) = matrix[0:5];

print(transcript);


def parse_blast(blast_line="NA"):

    
    #return(transcriptId, swissProtId);
    return("c0_g1_i1", "Q9HGP0.1")

assert parse_blast("c0_g1_i1|m.1    gi|74665200|sp|Q9HGP0.1|PVG4_SCHPO    100.00    372    0    0    1    372    1    372    0.0      754") == ("c0_g1_i1", "Q9HGP0.1")

transcript_to_protein = {};
transcript = 1;
protein = 'q';

transcript_to_protein[transcript] = protein;