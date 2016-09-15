#protSeq = "MSRSLLLRFLLFLLLLPPLP"
#rcode = "M"
"""
def aaPerc(protSeq, rcode):
    Seq = protSeq.upper();
    resid = rcode.upper();
    length = len(Seq);
    residCount = Seq.count('resid');
    protPerc = ((residCount) / length * 100);
    return protPerc# test the function with assertions
assert aaPerc("MSRSLLLRFLLFLLLLPPLP", "M") == 5
assert aaPerc("MSRSLLLRFLLFLLLLPPLP", "r") == 10
assert aaPerc("msrslllrfllfllllpplp", "L") == 50
assert aaPerc("MSRSLLLRFLLFLLLLPPLP", "Y") == 0   
"""   
temp = 33;
if temp > 30:
    print ("my its hot")
    
accs = ['ab56', 'bh84', 'hv76', 'ay93', 'ap97', 'bd72']
for accession in accs:
    if accession.startswith('h'):
        print(accession);    
     
love = ['flowers','fruit','leaves'];
for item in love:
    if item.endswith('t'):
        print(item)
    else:
        print("nopes")
#and or or condition can be used           
accs = ['ab56', 'bh84', 'hv76', 'ay93', 'ap97', 'bd72']
for accession in accs:
    if accession.startswith('a') and accession.endswith('3'):
        print(accession)   
count = 0
while count<10:
    print(count)
    count = count + 1 

words = ['love','log','kind','forgiving'];
for word in words:
    if word.startswith('l') and not word.endswith('g'):
        print(word)

accs = ['ab56', 'bh84', 'hv76', 'ay93', 'ap97', 'bd72']
for acc in accs:
    if acc.startswith('a') and not acc.endswith('6'):
        print(acc)
    
    
    

