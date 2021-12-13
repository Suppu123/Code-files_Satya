#!/usr/bin/python

from __future__ import print_function


#open file
f = open('Oryza_chr2_singleline.fasta', 'r')

#read whole file into 'Seq'
Seq=f.read()

values={}

for i in range(0,27):
    values[i]=0
    for x in range(0,len(Seq)-7-i):
        if(Seq[x:x+4] =="AAAG") and (Seq[x+4+i:x+8+i] == "CTTT"):
            values[i]=values[i]+1

for i in range(0,27):
    print('Frequency AAAGnCTTT n=' + str(i) + ':' + str(values[i]))

f.close()
