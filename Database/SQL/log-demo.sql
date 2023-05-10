
╭────────────────────────────╮
│ Setup                      │
╰────────────────────────────╯

-- Connect to dvdrentals

╭────────────────────────────╮
│ Provoke errors             │
╰────────────────────────────╯

-- Find the data-directory for your postgres installation
-- Write this in PSQL Tool:

show data_directory;
/*
data_directory
-------------------------------------
 C:/Program Files/PostgreSQL/15/data
*/


-- Use Querytool
-- View path to current logfile

SELECT  pg_current_logfile();
-- "log/postgresql-2023-05-05_000000.log"

-- Run this query

select * from abc;

/*
Open the latest logfile in the log directory, e.g:

C:\Program Files\PostgreSQL\15\data\log\postgresql-2023-05-05_000000.log

and you'll see something like:

2023-04-24 21:13:26.082 CEST [8236] ERROR:  relation "abc" does not exist at character 15
2023-04-24 21:13:26.082 CEST [8236] STATEMENT:  select * from abc


Detail: if you don't see a logfile for this date, check the date for yesterday

*/

-- Try this

qqqqqq;

/*
2023-04-24 21:13:59.926 CEST [8236] ERROR:  syntax error at or near "qqqqqq" at character 1
2023-04-24 21:13:59.926 CEST [8236] STATEMENT:  qqqqqq;
*/

-- If you execute a valid query, then nothing should be logged
select * from film;

/*
Nothing is logged
*/



╭────────────────────────────╮
│ Change config              │
╰────────────────────────────╯

-- Open configuration file in VS Code

C:\Program Files\PostgreSQL\15\data\postgresql.conf

-- Change the directory to something else, save the file

log_directory = 'logxxxxxxxxxx'

-- The logfile hasn't changed yet, as you see if you run this:

SELECT  pg_current_logfile();
-- "log/postgresql-2023-05-05_104827.log"

-- Restart Postgres (in Windows, open Services and restart "postgresql-x64-15")
-- Now you'll se the new log file

SELECT  pg_current_logfile();
-- "logxxxxxxxxxx/postgresql-2023-05-05_104827.log"

-- Run something with syntax error and check that the file new file is used

-- Change back to the old directory (and save the file)

log_directory = 'log'

-- Then restart the server. Note that a new log-file has created


╭────────────────────────────╮
│ Log levels                 │
╰────────────────────────────╯

-- View all settings

select *
from pg_settings;

-- Verify that your minimum log level is set to "warning"

select *
from pg_settings
where name = 'log_min_messages'

/*

The log levels are (in order)

DEBUG       Gives developers more detailed information
INFO        Retrieves specific data requested by a user like verbose output
NOTICE      Offers useful information to users like identifier truncation
WARNING     Delivers warnings of likely problems
ERROR       Registers errors, including those that cause any command to abort
LOG         Logs data like checkpoint activity, which can be useful for the administrator
FATAL       Occurs for errors that caused the current running session to abort
PANIC       Occurs for errors that cause all database sessions to abort

You can use raise a message of level INFO by writing:

    RAISE INFO 'some message'

You can use raise a message of level WARNING by writing:    

    RAISE WARNING 'some message'

Detail: instead of "RAISE ERROR" write "RAISE EXCEPTION" or just "RAISE"

FATAL and PANIC can't be raised by code

You can simulate FATAL by terminating the connection (SELECT pg_terminate_backend())

*/

-- Run the code (one at a time) and see what messages get logged to the file

do $$ 
begin 
  raise debug 'debug message';
end $$;
-- Nothing

do $$ 
begin 
  raise info 'information message';
end $$;
-- Nothing

do $$ 
begin 
  raise notice 'notice message';
end $$;
-- Nothing


do $$ 
begin 
  raise warning 'warning message';
end $$;
/*
2023-05-05 11:13:15.811 CEST [32672] WARNING:  warning message
2023-05-05 11:13:15.811 CEST [32672] CONTEXT:  PL/pgSQL function inline_code_block line 3 at RAISE
*/

do $$ 
begin 
  raise exception 'exception/error message';
end $$;
/*
2023-05-05 11:28:35.007 CEST [32672] ERROR:  exception/error message
2023-05-05 11:28:35.007 CEST [32672] CONTEXT:  PL/pgSQL function inline_code_block line 3 at RAISE
2023-05-05 11:28:35.007 CEST [32672] STATEMENT:  do $$ 
	begin 
	  raise exception 'exception/error message';
	end $$;
*/

do $$ 
begin 
  raise log 'log message';
end $$;
/*
2023-05-05 11:32:02.537 CEST [32672] LOG:  log message
2023-05-05 11:32:02.537 CEST [32672] CONTEXT:  PL/pgSQL function inline_code_block line 3 at RAISE
2023-05-05 11:32:02.537 CEST [32672] STATEMENT:  do $$ 
	begin 
	  raise log 'log message';
	end $$;

*/

do $$ 
begin 
  raise log 'log message' using hint = 'my hint';
end $$;


╭────────────────────────────╮
│ Change log level           │
╰────────────────────────────╯


-- Verify that your minimum log level is set to "warning"

select *
from pg_settings
where name = 'log_min_messages'

-- Set minimal log level to INFO in postgresql.conf

log_min_messages = info

-- Restart the server.  Verify that the minimum log level has changed to "info"

select *
from pg_settings
where name = 'log_min_messages'

-- Raise an information message and verify that it is now seen in the logfile
do $$ 
begin 
  raise info 'information message';
end $$;
/*
2023-05-05 11:03:03.554 CEST [12828] INFO:  information message 2023-05-05 11:03:03.534859+02
2023-05-05 11:03:03.554 CEST [12828] CONTEXT:  PL/pgSQL function inline_code_block line 3 at RAISE
*/
