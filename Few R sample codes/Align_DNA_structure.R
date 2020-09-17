
#Aligned_File = read.table("/Users/suppugan/Desktop/Align_DNA_Structures/TM.sup_all_atm_lig.pdb",skip=17,sep="\n",header=T)
fileName="TM.sup_all_atm_lig"
Aligned_File=readLines(fileName)

Atom_Info = Aligned_File[(nchar(Aligned_File)==54)][ (substr(Aligned_File[(nchar(Aligned_File)==54)],1,1)=="A")]

DNA_Info = Atom_Info[substr(Atom_Info,19,19)=="D"]

BasePair_Info = subset(DNA_Info,(substr(DNA_Info,22,22)=="A")&(substr(DNA_Info,14,15)=="N1")&((substr(DNA_Info,19,20)=="DA")|(substr(DNA_Info,19,20)=="DG"))  
|((substr(DNA_Info,22,22)=="A")&(substr(DNA_Info,14,15)=="N3")&((substr(DNA_Info,19,20)=="DC")|(substr(DNA_Info,19,20)=="DT")))) 

X_coords = as.numeric(substr(BasePair_Info,32,38))
Y_coords = as.numeric(substr(BasePair_Info,40,46))
Z_coords = as.numeric(substr(BasePair_Info,48,54))

Sugar_Info = Atom_Info[substr(Atom_Info,14,16)=="C3'"]

Sugar_Info_A = Sugar_Info[substr(Sugar_Info,22,22)=="A"]
Sugar_Info_B = Sugar_Info[substr(Sugar_Info,22,22)=="B"]

k=0
Basepairs = c()
for(i in 1:length(Sugar_Info[substr(Sugar_Info,22,22)=="A"]))
{ 
  Closest = sqrt((X_coords[i]-X_coords)^2+(Y_coords[i]-Y_coords)^2+(Z_coords[i]-Z_coords)^2)
  Closest[i]=500
  min(Closest)
    
  BasePair_Info[i]
  BasePair_Info[which.min(Closest)]
  
  if((min(Closest) < 3.3)&(as.numeric(substr(BasePair_Info[i],23,26)) < as.numeric(substr(BasePair_Info[which.min(Closest)],23,26)) ))
  {
    k=k+1 
    Basepairs[k]= paste(substr(BasePair_Info[i],19,26),"-",substr(BasePair_Info[which.min(Closest)],19,26))
  } 
}





X_coords_SugA = as.numeric(substr(Sugar_Info_A,32,38))
Y_coords_SugA = as.numeric(substr(Sugar_Info_A,40,46))
Z_coords_SugA = as.numeric(substr(Sugar_Info_A,48,54))

X_coords_SugB = as.numeric(substr(Sugar_Info_B,32,38))
Y_coords_SugB = as.numeric(substr(Sugar_Info_B,40,46))
Z_coords_SugB = as.numeric(substr(Sugar_Info_B,48,54))

chain_A_count = length(Sugar_Info[substr(Sugar_Info,22,22)=="A"])

Distances = c()
aligned = matrix("X",nrow=length(Basepairs),ncol=2)

pos_numA = c()
pos_numB = c()
k=0

for(i in 1:length(Sugar_Info[substr(Sugar_Info,22,22)=="A"]))
{
  Closest = sqrt((X_coords_SugA[i]-X_coords_SugB)^2+(Y_coords_SugA[i]-Y_coords_SugB)^2+(Z_coords_SugA[i]-Z_coords_SugB)^2)
  Closest[i]=500
  min(Closest)
    
  Sugar_Info_A[i]
  Sugar_Info_B[which.min(Closest)]


  
  if(min(Closest) < 6)
  {
    #aligned[k] = paste(substr(Sugar_Info[i],19,26)," - ",substr(Sugar_Info[which.min(Closest)],19,26)," :",min(Closest))
    #print(aligned[k])
  
    for(j in 1:length(Basepairs))
    {
      if(grepl(substr(Sugar_Info_A[i],19,26),Basepairs[j]))
      {
        if(aligned[j,1]=="X")
        {
          aligned[j,1] = paste(substr(Sugar_Info_A[i],19,26)," - ",substr(Sugar_Info_B[which.min(Closest)],19,26)," :",min(Closest))

          k=k+1
          pos_numA[k] = as.numeric(substr(Sugar_Info_A[i],23,26))  
          pos_numB[k] = as.numeric(substr(Sugar_Info_B[which.min(Closest)],23,26))
        } 
        if(aligned[j,1]!="X")
        {
          aligned[j,2] = paste(substr(Sugar_Info_A[i],19,26)," - ",substr(Sugar_Info_B[which.min(Closest)],19,26)," :",min(Closest))
        }   
      }
    }
  
  }
}


Chain_Allignments=c()
Chain_Allignments_comp=c()

Chain_Allignments[1] = paste(substr(aligned[,1],2,2),collapse="",sep="")
Chain_Allignments[2] = paste(substr(aligned[,1],15,15),collapse="",sep="")

Chain_Allignments_comp[1] = paste(substr(aligned[length(aligned[,1]):1,2],2,2),collapse="",sep="")
Chain_Allignments_comp[2] = paste(substr(aligned[length(aligned[,1]):1,2],15,15),collapse="",sep="")


print(noquote(paste(Chain_Allignments[1],Chain_Allignments[2],sep=" ")))
#write.table(noquote(Chain_Allignments),file = "Alignment.txt",row.names=F,col.names = F)

info = paste(pos_numB, collapse = " ")

write(noquote(info),file = "Position_nums.txt",append = T)

