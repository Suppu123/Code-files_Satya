fileName="PDB_files.txt"
PDB_Files=readLines(fileName)

write("",file="Aligned_Structures.pdb")
write("",file="Position_nums.txt")
write("",file="Sequences.txt")

for(i in 2:length(PDB_Files))
{

	sysCommand = paste("./TMalign",PDB_Files[1],PDB_Files[i], "-o TM.sup")
	system(sysCommand)

	TM_File=readLines("TM.sup_all_atm_lig")
	B_Chain = subset(TM_File,substr(TM_File,22,22)=="B")
	
	#gsub('([A-Z]{2}\\s(B)\\s(\\1d{3}))', 'i', B_Chain)
	#B_Chain2 = gsub("B",i,B_Chain)
	
	if (i<10) write(paste("MODEL        ",i,sep=""),file = "Aligned_Structures.pdb",append = T)
	if (i>=10) write(paste("MODEL       ",i,sep=""),file = "Aligned_Structures.pdb",append = T)
	write(B_Chain,file = "Aligned_Structures.pdb",append = T)
	write("B_Chain",file = "Aligned_Structures.pdb",append = T)

	system("Rscript Align_DNA_structure2.R > Alignment.txt")

	Check_alignment_file = readLines("Sequences.txt")

	Alignment = read.table("Alignment.txt")
		
	if(nchar(Check_alignment_file[1]) < 1) 
	{
	  Sequences = Alignment[2]
	  write.table(Sequences,file="Sequences.txt",append=T,row.names=F,col.names=F,quote=F)
	}
		  

	Sequences = Alignment[3]

	write.table(Sequences,file="Sequences.txt",append=T,row.names=F,col.names=F,quote=F)
	#Sequences[i] = noquote(Alignment[3])
}


