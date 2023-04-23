-- выбрать фотографии (filename) пользователя с email: arlo50@example.org . ID типа медиа, соответствующий фотографиям неизвестен.
-- (используя вложенные запросы)
SELECT filename FROM media 
WHERE 
user_id = (SELECT id FROM users WHERE email = 'arlo50@example.org')
AND media_type_id IN (
      SELECT id FROM media_types WHERE name_type LIKE 'photo' ); 