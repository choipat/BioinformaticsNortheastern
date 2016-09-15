'''
Created on Jul 27, 2015
@author: sarvani
'''

import re;

go_dictionary = {};

def parse_record(record):
    go_id = re.search(r"id:\s+(.*?)\n", record, re.DOTALL);
    name = re.search(r"name:\s+(.*?)\n", record, re.DOTALL);
    namespace = re.search(r"namespace:\s+(.*?)\n", record, re.DOTALL);
    is_a_list = re.findall(r"is_a:\s+(.*)$", record, re.M);
    go_str_obj = namespace.group(1) + "\n" + name.group(1) + "\n";
    for is_a in is_a_list:
        go_str_obj += is_a + "\n";
    go_dictionary[go_id.group(1)] = go_str_obj;
    
def split_records(file):
    go_file = open(file);
    go_records = go_file.read();
    go_split_records = re.findall(r"\[Term\](.*?)\s+\s+", go_records, re.DOTALL);
    for go_record in go_split_records:
        parse_record(record = go_record);
    go_file.close();
    
split_records(file = "/scratch/go-basic.obo");

# Finally pretty print all key values
for go_id in go_dictionary.keys():
    line = go_id + "\t" + go_dictionary[go_id];
    print(line);