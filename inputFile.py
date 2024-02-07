tableList=['Customer','Orders','Salesperson','Starbucks_Employees','Starbucks_Stores','city','Occupations','bst','station','Employee','Manager','Senior_Manager','Lead_Manager','Company']
filePath='~/Desktop/DataStore/advanceSQL/data/'
sqlPath='/Users/abuhura/Desktop/desktop_19thSep2023/Training/workspace/advanceSQLQuery/sql/query.sql'

def fileReader(path):
    file=open(path,'r')
    res=file.read()
    file.close()
    return res