import sys
import csv
import os
from xlrd import open_workbook

V_OUTPUT_FILE='C:\Python27\scriptforfailuremanifest\ExpectedOutput.txt'
V_BOOK = open_workbook('C:\Python27\scriptforfailuremanifest\Sample Mapping File.xlsx')
V_SHEET = V_BOOK.sheet_by_index(0)
Total_cols = V_SHEET.ncols
try:
          lines_seen=set()  
          with open(V_OUTPUT_FILE, "wb") as output:
              writer = csv.writer(output,delimiter='|')
              
              for row_idx in range(1, V_SHEET.nrows):
                       V_M_sampleName = V_SHEET.cell(row_idx, 0).value
                       V_M_sampleId = V_SHEET.cell(row_idx, 1).value
                           
                       #print str(V_M_sampleName)
                       with open('C:\Python27\scriptforfailuremanifest\Example Instrument Output File 4.csv') as csvfile:
                          reader = csv.DictReader(csvfile)
                          for row in reader:
                               sampleName=row['Sample Name']
                               V_I_sampleName=sampleName[:6]+'.0'
                               #print row
                               #print V_I_sampleName
                               #print "Mapping"   
                               #print V_M_sampleName
                               #print "Instrument"
                               #print V_I_sampleName
                               if str(V_M_sampleName)==str(V_I_sampleName) and  sampleName[6]=='@' :     
                                    #print V_I_sampleName
                                    V_I_Gene=row['Gene']
                                    V_I_Results=row['Results']
                                    
                                    V_T_BOOK = open_workbook('C:\Python27\scriptforfailuremanifest\Test Code Mapping.xlsx')
                                    V_T_SHEET = V_T_BOOK.sheet_by_index(0)
                                    V_T_Total_cols = V_T_SHEET.ncols
                                    for row_idx in range(1, V_T_SHEET.nrows):
                                       for col_idx in range(0, V_T_Total_cols):
                                           cell_obj = V_T_SHEET.cell(row_idx, col_idx)
                                           V_T_Gene = V_T_SHEET.cell(row_idx, 0).value
                                           V_T_MULTIPLE = V_T_SHEET.cell(row_idx, 1).value
                                           V_T_SINGLE = V_T_SHEET.cell(row_idx, 2).value
                                       if str(V_I_Gene)==str(V_T_Gene):
                                            V_F_BOOK = open_workbook('C:\Python27\scriptforfailuremanifest\Failure Manifest for Run 1.xlsx')
                                            V_F_SHEET = V_F_BOOK.sheet_by_index(0)
                                            V_F_Total_cols = V_F_SHEET.ncols
                                            
                                            for row_f_idx in range(1, V_F_SHEET.nrows):
                                               for col_f_idx in range(0, V_F_Total_cols):
                                                    V_f_sampleid = V_F_SHEET.cell(row_idx, 0).value
                                                    if str(V_M_sampleName)==(str(V_f_sampleid[:6]+'.0')):
                                                        
                                                      V_TESTCODE=V_T_MULTIPLE
                                                      V_Results_1='CANCELLED'
                                                      V_Results_2='SAMPLE FAILURE'
                                                      
                                                      writer.writerow(['QATL'] +['']+ [V_M_sampleId]+['']+['']+['']+[V_TESTCODE]+[V_Results_1]+[V_Results_2]+[''])

 
          uniqlines = set(open('C:\Python27\scriptforfailuremanifest\ExpectedOutput.txt').readlines())
          out = open('C:\Python27\scriptforfailuremanifest\ExpectedOutputFailure.txt', 'w').writelines(uniqlines)
          print "Successfully Exported the data." 
        
except:
 	print("Something goes wrong!",sys.exc_info()[0],"occured.")

