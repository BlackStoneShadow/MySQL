-- Список медиафайлов пользователей, указав название типа медиа (id, filename, name_type)
-- (используя JOIN)
SELECT 
	m.id,
	m.filename AS 'медиа',
	mt.name_type AS 'тип медиа'
FROM media m
LEFT JOIN media_types mt ON mt.id = m.media_type_id
ORDER BY m.id;