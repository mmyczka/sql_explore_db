SELECT  schema_name(schema_id) AS schema_name, 
	name AS table_name
FROM Sys.Tables
ORDER BY schema_name, table_name;