# advanceSQLQuery
This repository will provide the sample datasets, the necessary function in python attached to use to set-up a SQL environment.So that, we can connect the system and run the query as needed to test our knowledge.

Refer this link for table and query: https://www.programmerinterview.com/database-sql/advanced-sql-interview-questions-and-answers/

#Install PostGre:

1. Install PostgreSQL:
First, make sure PostgreSQL is installed. If it's not, you can install it using Homebrew, a package manager for macOS. Open your Terminal and run the following commands:

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install postgresql

brew services start postgresql

2. Create a New PostgreSQL Database

createdb <mynewdatabase>

Note: <mynewdatabase> as advSQL

'''
Under construction
2. Create a New Role (User) with a Password
Access the PostgreSQL command line. You can do this by simply typing:

psql postgres

CREATE ROLE <myusername> WITH LOGIN PASSWORD '<mypassword>'

ALTER ROLE <myusername> CREATEDB

3. Create a New Database
Now that you have a user, you can create a new database. You can do this from the psql interface or from the Terminal directly. If you're still in psql, you can exit by typing \q and then enter:

createdb advSQL -O <myusername>


4. Connect to Your New Database
To connect to your new database using the new role, you can use:

psql -d advSQL -U <myusername>
'''



