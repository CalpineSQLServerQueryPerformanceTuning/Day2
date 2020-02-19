use AdventureWorks;

-- Query Store supported in SQL Server 2016 and later

-- Note:	In SSMS | Object Explorer | Server | Databases | AdventureWorks
--			No node for Query Store

-- Enable Query Store for AdventureWorks database
alter database AdventureWorks set query_store = on;

-- Note:	Node should now appear after refreshing

-- In order to turn on / off Query Store and configure its properties using GUI
--		SSMS:	Object Explorer | Server | Databases | Right Click AdventureWorks | Properties | Query Store


-- Change Operation Mode
--		Read_Write	Collect New Data, Reports Available, Forced Plans still forced
--		Read_Only	Don't Collect New Data, Reports Available, Forced Plans still forced
--		Off			Don't Collect New Data, Reports Available (until data purged), Forced Plans not forced
alter database AdventureWorks set query_store = on (operation_mode = read_only);
alter database AdventureWorks set query_store = off;
alter database AdventureWorks set query_store = on (operation_mode = read_write);

-- Purge Query Store data
alter database AdventureWorks set query_store clear;


-- Data Flush Interval - How frequently Query Store data is flushed to disk
--		Note:	Longer interval more data lost if a crash
--				Shorter interval more overhead on database / server
--				Default Value	15 minutes or 900 seconds
alter database AdventureWorks set query_store = on (data_flush_interval_seconds = 900);


-- Interval Length - Aggregation interval of collected stats to minimize storage overhead
--		Note:	Lower value means finer resolution but more overhead
--				Allowed Values	1, 5, 10, 15, 30, 60, 1440
--				Default Value	60 minutes
alter database AdventureWorks set query_store = on (interval_length_minutes = 60);


-- Max Plans Per Query - Number of Execution Plans stored for each query captured
--				Default Value	200
alter database AdventureWorks set query_store = on (max_plans_per_query = 200);


-- Max Storage Size - Amount of storage in database reserved for Query Store data
--		Note:	When storage runs out, Query Store automatically gets switched to Operation Mode Read_Only
--				Default Value	100 MB
alter database AdventureWorks set query_store = on (max_storage_size_mb = 100);


-- Query Capture Mode - What query types are captured
--		Note:	All means every executed query
--				Auto means tries to ignore ad hoc and infrequently executed queries
--				None means no new queries captured but existing queries that have been captured gather new data
--				Default Value	All
alter database AdventureWorks set query_store = on (query_capture_mode = all);


-- Stale Query Threshold - How long data will stay in Query Store
--				Default Value	30 Days
alter database AdventureWorks set query_store = on (cleanup_policy = (stale_query_threshold_days = 30));


-- Cleanup
alter database AdventureWorks set query_store = off;
alter database AdventureWorks set query_store clear;
