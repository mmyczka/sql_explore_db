SELECT  
	t.object_id AS table_id,
	schema_name(t.schema_id) + '.' + t.name AS table_name,
	c.column_id,
	c.name AS column_name,
	tp.name AS type_name,
	c.max_length,
	c.precision,
	c.is_nullable, 
	case when (c.column_id = ic.column_id) then 1
	else 0 end AS is_PK,
	fk.name AS FK_name,
	t_pk.object_id AS PK_table_id,
	schema_name(t_pk.schema_id) + '.' + t_pk.name AS PK_table,
	c_pk.name AS PK_column
FROM sys.tables AS t
	INNER JOIN sys.columns AS c ON t.object_id = c.object_id
	LEFT JOIN sys.types AS tp ON c.user_type_id = tp.user_type_id
	LEFT JOIN sys.indexes i ON t.object_id = i.object_id 
		AND i.is_primary_key = 1
	LEFT JOIN sys.index_columns ic ON i.object_id = ic.object_id 
		AND i.index_id = ic.index_id
		AND c.column_id = ic.column_id
		LEFT JOIN sys.foreign_key_columns fkc ON t.object_id = fkc.parent_object_id
		AND c.column_id = fkc.parent_column_id
	LEFT JOIN sys.foreign_keys AS fk ON fkc.constraint_object_id = fk.object_id
	LEFT JOIN sys.tables t_pk ON fkc.referenced_object_id = t_pk.object_id
	LEFT JOIN sys.columns c_pk ON fkc.referenced_column_id = c_pk.column_id
		AND fkc.referenced_object_id = c_pk.object_id
ORDER BY table_name, column_id