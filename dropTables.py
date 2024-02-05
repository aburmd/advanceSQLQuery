from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy import text
import inputFile

#temp_db=create_engine('sqlite:///:memory',echo=True)
temp_db=create_engine('postgresql:///advSQL',echo=True)
metadata = MetaData()
metadata.reflect(bind=temp_db)

def dropTable(db,tablename):
    table_to_drop = Table(tablename, metadata, autoload_with=db)
    res=table_to_drop.drop(db)
    return res
 
tabList=inputFile.tableList
for tab in tabList:
    res=dropTable(temp_db,tab.lower())
    print("Table name {} is being deleted successfully".format(tab.lower()))