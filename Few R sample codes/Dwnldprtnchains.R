fileName="/Users/suppugan/Desktop/Align_DNA_Structures/1ea4.pdb"
PDBID = "1ea4"
Chain = 'L'

PDB = readLines(fileName)
PDB_atoms = subset(PDB,substr(PDB,1,4)=="ATOM")
PDB_Complex = subset(PDB_atoms,(substr(PDB_atoms,22,22)==Chain)|(substr(PDB_atoms,19,19)=='D'))

NEW_File = paste(PDBID,Chain,".pdb",sep="") 
write(PDB_Complex,file=NEW_File)