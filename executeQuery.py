import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy import text
import inputFile
from sqlalchemy import MetaData

#temp_db=create_engine('sqlite:///:memory',echo=True)
temp_db=create_engine('postgresql+psycopg2:///advSQL',echo=True)
metadata = MetaData()
metadata.reflect(bind=temp_db)
table_names = [table.name for table in metadata.tables.values()]
def executeQuery(db,query):
    with db.connect() as conn:
        print('The below query is being issued\n')
        print(query)
        res=conn.execute(text(query))
    return res

query=''
while query!='abort':
    print("----------------------------------------------------------------------------------")
    print(table_names)
    print("----------------------------------------------------------------------------------")
    query=input("Enter the sql query(type 'abort' to skip the prompt): \n")
    if not query:
        query=inputFile.fileReader(inputFile.sqlPath)
    print("----------------------------------------------------------------------------------")
    if query=='abort':
        continue
    res=executeQuery(temp_db,query)
    print(res.all())