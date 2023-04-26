# What and why

A view is a **named query** that provides another way to present data in the database tables. A view is defined **based on one or more tables** which are known as base tables. When you create a view, you basically create a query and assign a name to the query. Therefore, a view is useful for **wrapping a commonly used complex query**.

Like a table, you can **grant permission** to users through a view that contains specific data that the users are authorized to see.

A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.

You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data were coming from one single table.

A view always shows up-to-date data The database engine recreates the data, using the view's SQL statement, every time a user queries a view.

# Materialized views

Note that regular views do not store any data except the materialized views. In PostgreSQL, you can create special views called materialized views that **store data physically** and periodically **refresh** data from the base tables. The materialized views are handy in many scenarios, such as faster data access to a remote server and **caching**.

# Views compared to Stored procedures

Most simply, a view is used when only a SELECT statement is needed. Views should be used to store commonly-used JOIN queries and specific columns to build virtual tables of an exact set of data we want to see. Stored procedures hold the more complex logic, such as INSERT, DELETE, and UPDATE statements to automate large SQL workflows.

https://dev.to/rachelsoderberg/comparing-sql-views-and-stored-procedures-4pfb#:~:text=Views%20should%20be%20used%20to,to%20automate%20large%20SQL%20workflows.

You can use a view AS a table... stored procedures are for DOING things... views are for making your life easier

Stored procedure
* Can NOT be used as building block in a larger query
* Can contain several statements, loops, IF ELSE, etc.
* Can perform modifications to one or several tables

Views
* Can be used as building block in a larger query
* Can contain only one single SELECT query
* Can NOT perform modifications to any table

https://stackoverflow.com/questions/5194995/what-is-the-difference-between-a-stored-procedure-and-a-view#

# References

https://www.postgresqltutorial.com/postgresql-views/
https://www.postgresqltutorial.com/postgresql-views/managing-postgresql-views/
https://www.w3schools.com/sql/sql_view.asp

