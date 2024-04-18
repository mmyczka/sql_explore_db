SELECT  schema_name(t.schema_id) AS schema_name, 
	t.name AS table_name,
	c.column_id,
	c.name AS column_name,
	fk.name AS FK_name,
	t_pk.name AS PK_table,
	c_pk.name AS PK_column
FROM sys.tables t
	INNER JOIN sys.columns c ON t.object_id = c.object_id
	LEFT JOIN sys.foreign_key_columns fkc ON t.object_id = fkc.parent_object_id
		AND c.column_id = fkc.parent_column_id
	LEFT JOIN sys.foreign_keys AS fk ON fkc.constraint_object_id = fk.object_id
	LEFT JOIN sys.tables t_pk ON fkc.referenced_object_id = t_pk.object_id
	LEFT JOIN sys.columns c_pk ON fkc.referenced_column_id = c_pk.column_id
		AND fkc.referenced_object_id = c_pk.object_id
ORDER BY schema_name, table_name, c.column_id