SELECT  schema_name(t.schema_id) AS schema_name, 
	t.name AS table_name,
	c.column_id,
	c.name AS column_name,
	tp.name AS type_name,
	c.max_length,
	c.precision,
	c.is_nullable, 
	case when (c.column_id = ic.column_id) then 1
	else 0 end AS is_PK
FROM sys.tables AS t
	INNER JOIN sys.columns AS c ON t.object_id = c.object_id
	LEFT JOIN sys.types AS tp ON c.user_type_id = tp.user_type_id
	LEFT JOIN sys.indexes i ON t.object_id = i.object_id 
		AND i.is_primary_key = 1
	LEFT JOIN sys.index_columns ic ON i.object_id = ic.object_id 
		AND i.index_id = ic.index_id
		AND c.column_id = ic.column_id
ORDER BY schema_name, table_name, column_id