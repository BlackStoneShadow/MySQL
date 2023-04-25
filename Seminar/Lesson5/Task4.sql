use lesson_4;
/*
создайте представление, в котором будут выводится все сообщения, в которых принимал участие пользователь с id = 1;

найдите друзей у  друзей пользователя с id = 1 и поместите выборку в представление; 
(решение задачи с помощью CTE)

 найдите друзей у  друзей пользователя с id = 1. 
(решение задачи с помощью представления “друзья”)
*/
-- создайте представление, в котором будут выводится все сообщения, в которых принимал участие пользователь с id = 1;
CREATE OR REPLACE VIEW v_messages_id1 AS 
SELECT * 
FROM messages
WHERE from_user_id = 1
UNION ALL
SELECT * 
FROM messages
WHERE to_user_id = 1;

SELECT * FROM v_messages_id1;

WITH RECURSIVE friends AS  
(
	SELECT 
		initiator_user_id, target_user_id
	FROM friend_requests 
	WHERE initiator_user_id = 1 AND status = 'approved' 
	OR target_user_id = 1 AND status = 'approved'
	UNION ALL
	SELECT 
		r.initiator_user_id, r.target_user_id
	FROM friends f
	INNER JOIN friend_requests r ON r.initiator_user_id = f.target_user_id
)
SELECT * FROM friends; 

-- найдите друзей у  друзей пользователя с id = 1 и поместите выборку в представление; 
-- вариант 2
WITH friends AS  
(SELECT initiator_user_id AS user_id, target_user_id AS friend_id FROM lesson_4.friend_requests 
WHERE  status='approved' -- ID друзей, заявку которых подтвердили
UNION
SELECT target_user_id, initiator_user_id FROM  lesson_4.friend_requests  
WHERE  status='approved')
SELECT friend_id FROM friends WHERE user_id 
IN (SELECT friend_id FROM friends
WHERE user_id=1) AND friend_id !=1;

-- вариант 3
WITH friends AS  
(SELECT initiator_user_id AS user_id, target_user_id AS friend_id FROM lesson_4.friend_requests 
WHERE  status='approved' -- ID друзей, заявку которых подтвердили
UNION
SELECT target_user_id, initiator_user_id FROM  lesson_4.friend_requests  
WHERE  status='approved')
SELECT f2.friend_id 
FROM friends f1 
JOIN friends f2 ON f1.friend_id = f2.user_id
WHERE f1.user_id = 1 AND f2.friend_id!=1;

-- С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10
WITH RECURSIVE cte AS
(
	SELECT 1 AS a, 1 as result
	UNION ALL
	SELECT a + 1, pow(a+1,2) as result FROM cte
	WHERE a < 10
)
SELECT a, result FROM cte;
