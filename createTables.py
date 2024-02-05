import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy import text
import inputFile

#temp_db=create_engine('sqlite:///:memory',echo=True)
temp_db=create_engine('postgresql:///advSQL',echo=True)
def createTable(path,db,tablename):
    df=pd.read_csv(path)
    df.columns = [col.lower() for col in df.columns]
    data=df.to_sql(tablename,con=db)
    return data

tabList=inputFile.tableList
for tab in tabList:
    path=inputFile.filePath
    path+=tab+'.csv'
    res=createTable(path,temp_db,tab.lower())
    print("Table name {} is being imported successfully".format(tab.lower()))
