import re

id = "id: GO:0000001"
nae = "name: mitochondrion inheritance"#^name.*
ns = "namespace: biological_process"#^namespace.*
is1 = "is_a: GO:0048308 ! organelle inheritance"#^is_a.*
is2 = "is_a: GO:0048311 ! mitochondrion distribution"
"""
trial = re.search (r"^name.*", id)
if trial:
    print (trial.group())
"""   
desiredstring = ns + "\n" + nae + "\n" + is1 + "\n" + is2
print(desiredstring)


dict = {'go_id': 'desiredstring' }


      

