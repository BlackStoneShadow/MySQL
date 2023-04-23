-- выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
-- (используя JOIN)
SELECT 
	u.id,
	CONCAT(u.firstname, ' ', u.lastname) AS 'Пользователь', 
	p.hometown AS 'Город',
	m.filename AS 'Аватарка'
FROM users u
JOIN profiles p ON  u.id=p.user_id 
LEFT JOIN media m ON p.photo_id=m.id;
