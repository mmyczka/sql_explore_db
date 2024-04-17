SELECT  schema_name(schema_id) AS schema_name, 
	t.name AS table_name,
	c.name AS column_name
FROM sys.tables AS t
	INNER JOIN sys.columns AS c ON t.object_id = c.object_id
ORDER BY schema_name, table_name, column_name