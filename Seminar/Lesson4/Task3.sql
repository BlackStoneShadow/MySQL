-- выбрать id друзей пользователя с id = 1
-- (используя UNION)
SELECT initiator_user_id AS id FROM friend_requests 
WHERE target_user_id = 1 AND status='approved' -- ID друзей, заявку которых я подтвердил
UNION
SELECT target_user_id FROM friend_requests 
WHERE initiator_user_id = 1 AND status='approved'; -- ID друзей, подтвердивших мою заявку

-- CROSS JOIN
SELECT * FROM users, messages;
SELECT * FROM users
JOIN messages;

-- INNER JOIN
SELECT * FROM users u
JOIN messages m 
WHERE u.id=m.from_user_id;

SELECT * FROM users u
JOIN messages m ON u.id=m.from_user_id;

-- LEFT JOIN
SELECT u.*, m.*  FROM users u
LEFT JOIN messages m ON u.id=m.from_user_id;

-- RIGHT  JOIN
SELECT u.*, m.*  FROM users u
RIGHT JOIN messages m ON u.id=m.from_user_id;

-- FULL JOIN 
SELECT u.*, m.*  FROM users u
LEFT JOIN messages m ON u.id=m.from_user_id
UNION 
SELECT u.*, m.*  FROM users u
RIGHT JOIN messages m ON u.id=m.from_user_id;