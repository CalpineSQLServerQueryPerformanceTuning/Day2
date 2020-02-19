-- Create Some Execution Plans
use AdventureWorks;
go
select * from Production.Product;
go
select * from Sales.SalesOrderHeaderEnlarged;
go


-- Display SQL Text and Execution Plans for Top 10 Most Expensive Queries by Duration
select top 10
	  qs.total_elapsed_time										as [Total Time]
	, st.text													as [Statement Text]
	, db_name(qp.dbid)											as [Database Name]
    , qp.query_plan												as [Execution Plan]
	, qs.*
from
					sys.dm_exec_query_stats						as qs			-- Reverse comments to
					--sys.dm_exec_procedure_stats					as qs			-- View Stored Procs
	cross apply		sys.dm_exec_sql_text(qs.sql_handle)			as st 
	cross apply		sys.dm_exec_query_plan(qs.plan_handle)		as qp
where 
	db_name(qp.dbid) = 'AdventureWorks'
order by 
     qs.total_elapsed_time desc
;
