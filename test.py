import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy import text
'''
temp_db in RAM
push pandas DF to temp_db
sql query on tempDB
'''
df=pd.read_csv('~/Desktop/DataStore/advanceSQL/Salesperson.csv')
temp_db=create_engine('sqlite:///:memory',echo=True)
with temp_db.connect() as conn:  
    cleanup=conn.execute(text("drop table if exists Orders"))
'''
data=df.to_sql(name='Salesperson',con=temp_db)
with temp_db.connect() as conn:
    results=conn.execute(text("SELECT * FROM SALESPERSON"))
res=results.all()
print(res)
'''
