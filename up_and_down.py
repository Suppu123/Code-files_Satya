#!/usr/bin/python

genes = {}

with open('genes_updown_N7.txt', 'r') as file:
    for line in file:
        line = line.strip()
        if line.split()[0] in genes:
            #genes[line.split()[0]][5] = int(genes[line.split()[0]][5]) + int(line.split()[6])
            genes[line.split()[0]][4] = 'up+down'
        else:
            info = []
            info = line.split()[1:7]
            genes[line.split()[0]] = info

with open('genes_up_down_N7.txt', 'w') as outfile:
    for gene in genes:
        outfile.write(gene + '\t' + genes[gene][0] + '\t' + genes[gene][1] + '\t' + genes[gene][2] + '\t' + genes[gene][3] + '\t' + genes[gene][4] + '\t' + str(genes[gene][5]) + '\n')
