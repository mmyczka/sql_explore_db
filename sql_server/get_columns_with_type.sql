SELECT  schema_name(t.schema_id) AS schema_name, 
	t.name AS table_name,
	c.column_id,
	c.name AS column_name,
	tp.name AS type_name,
	c.max_length,
	c.precision
FROM sys.tables AS t
	INNER JOIN sys.columns AS c ON t.object_id = c.object_id
	LEFT JOIN sys.types AS tp ON c.user_type_id = tp.user_type_id
ORDER BY schema_name, table_name, column_id