import re

print (r"\t/n");#used to escape spl CHAR
 
dna = "ATTTGGGAATTCCN";

if re.search (r"A",dna):
    print("result found");
    

if re.search (r"A[TGA]" , dna):
    print("yes");

if re.search (r"[^ATGC]" , dna):
    print("k");

#quantifiers
# + matches one or more times,?zero or once
if re.search (r"AT+G+AA" , dna):
    print("worked");
if re.search (r"AT+G+AA+T+C+N*" , dna):
    print("worked1"); 
if re.search (r"AT{3}" , dna):
    print("worked2");
m = re.search (r"^A" , dna);#extracting we use .group
print(m.group());

dna = "ATGACGTACGTACGACTG"
m = re.search(r"GA([ATGC]{3})AC([ATGC]{2})AC", dna)
print("start: " + str(m.start()))
print("end: " + str(m.end()))
print("group one start: " + str(m.start(1)))
print("group one end: " + str(m.end(1)))
print("group two start: " + str(m.start(2)))
print("group two end: " + str(m.end(2)))

trial = "id: GO:0000001"
m = re.search(r"(x(idGO:\d{7}))", trial, re.DOTALL)
print(m)
