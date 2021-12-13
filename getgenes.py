#!/usr/bin/python

from __future__ import print_function
import re

strings = []


for line in open('TAIR_downstream_1000_singleline.fa'):   
    if line.startswith('>'):
        strings.append([line.strip(), ''])
    else:
        strings[-1][1] += line.strip()


for i in range(1,26):
    pattern = re.compile('AAAG(A|C|G|T){' + str(i) + '}CTTT')
    output_file = open('genes_down_1000_N' + str(i) + '.txt', 'w')
    for x in strings: 
        p = pattern.finditer(x[1]) 
        for m in p: 
            output_file.write(str(x[0])+'\n') 
    output_file.close()
