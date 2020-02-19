use AdventureWorks;

--	Turn on Actual Execution Plan (Ctrl-M)

select *
from HumanResources.vEmployee;


select *
from 
			HumanResources.vEmployee	as e
	join	Sales.vPersonDemographics	as pd	on e.BusinessEntityID = pd.BusinessEntityID;


go
create schema Test;
go

create view Test.vEmployee
--with schemabinding
as
	SELECT 
		e.[BusinessEntityID]
		,p.[Title]
		,p.[FirstName]
		,p.[MiddleName]
		,p.[LastName]
		,p.[Suffix]
		,e.[JobTitle]  
		,pp.[PhoneNumber]
		,pnt.[Name] AS [PhoneNumberType]
		,ea.[EmailAddress]
		,p.[EmailPromotion]
		,a.[AddressLine1]
		,a.[AddressLine2]
		,a.[City]
		,sp.[Name] AS [StateProvinceName] 
		,a.[PostalCode]
		,cr.[Name] AS [CountryRegionName] 
	FROM [HumanResources].[Employee] e
		INNER JOIN [Person].[Person] p
		ON p.[BusinessEntityID] = e.[BusinessEntityID]
		INNER JOIN [Person].[BusinessEntityAddress] bea 
		ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
		INNER JOIN [Person].[Address] a 
		ON a.[AddressID] = bea.[AddressID]
		INNER JOIN [Person].[StateProvince] sp 
		ON sp.[StateProvinceID] = a.[StateProvinceID]
		INNER JOIN [Person].[CountryRegion] cr 
		ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
		INNER JOIN [Person].[PersonPhone] pp
		ON pp.BusinessEntityID = p.[BusinessEntityID]
		INNER JOIN [Person].[PhoneNumberType] pnt
		ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
		INNER JOIN [Person].[EmailAddress] ea
		ON p.[BusinessEntityID] = ea.[BusinessEntityID];
go

select * from Test.vEmployee;

-- Add Index to View
create unique clustered index IX_vEmployeePersonDemographics_BusinessEntityID on Test.vEmployee
(
	BusinessEntityID asc
);

select * from Test.vEmployee;
select * from Test.vEmployee with (noexpand);		-- Needed to use the Indexed View


-- Cleanup
drop view Test.vEmployee;
drop schema Test;
