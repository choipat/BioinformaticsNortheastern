'''
Created on Aug 01, 2015
@author: sarvani
'''
import re;

'''
Your object-oriented SwissProt parser should read in /scratch/SampleDataFiles/example.sp, 
parse accession (AC), dates (DT), organism (OS), and sequence (SQ). 
These should be be parsed within the constructor and assigned to attributes. 
Your class should have a printAll method that prints all the attributes in this order: 
AC, DTs, OS, SQ. for SQ include the whole block that follows, including the first line (e.g. 
SEQUENCE   1065 AA;  122205 MW;  2F2F1294E2D30F58 CRC64;
)
'''

class SwissProt:
    count = 0;
    'Parses SwissProt format file and updates attributes'
    def __init__(self, record):
        # Parse AC
        match = re.search(r"AC\s\s\s(.*?)\n", record);
        self.AC = match.group(1);
        
        # Parse DTs
        #self.DTs = re.findall(r"DT\s\s\s(.*?)\n", record, re.M);
        self.DTs = [];
        dts = re.findall(r"DT\s\s\s(\d{2})[/.-]([A-Z]{3})[/.-](\d{4}).*?\n", record, re.M);
        for dt in dts:
            self.DTs.append(dt[0] + "-" + dt[1] + "-" + dt[2]);
        
        # Parse OS
        match = re.search(r"OS\s\s\s(.*?)\n", record);
        self.OS = match.group(1);
        
        # Parse SQ
        match = re.search(r"SQ\s\s\s(.*)", record, re.S);
        self.SQ = "";
        self.SQ = match.group(1);
    
    def printAll(self):
        datesStr = '';
        for date in self.DTs:
            datesStr += date + "\n";
        print(self.AC + "\n" + datesStr + self.OS + "\n" + self.SQ);

def split_records(file):
    swiss_prot_file_handle = open(file);
    swiss_prot_file = swiss_prot_file_handle.read();
    records = re.findall(r"(.*?)//\n", swiss_prot_file, re.DOTALL);
    for record in records:
        obj = SwissProt(record);
        obj.printAll();
    swiss_prot_file_handle.close();
    
file = "/scratch/SampleDataFiles/example.sp";
split_records(file);