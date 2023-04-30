USE lesson_4;
-- ФУНКЦИИ
-- создание функции, вычисляющей коэффициент популярности пользователя
DROP FUNCTION IF EXISTS friendship_direction;
DELIMITER //
CREATE FUNCTION friendship_direction(check_user_id BIGINT)
RETURNS FLOAT READS SQL DATA 
BEGIN
	DECLARE requests_to_user INT; -- заявок к пользователю
	DECLARE requests_from_user INT; -- заявок от пользователя

	SET requests_to_user = (
		SELECT COUNT(*) 
		FROM friend_requests
		WHERE target_user_id = check_user_id 
		);
	/* 
	SET requests_from_user = (
	SELECT COUNT(*) 
	FROM friend_requests
	WHERE initiator_user_id = check_user_id 
	); */
	
	SELECT COUNT(*)
	INTO  requests_from_user
	FROM friend_requests
	WHERE initiator_user_id = check_user_id; 
	
	RETURN requests_to_user / requests_from_user;
END//
DELIMITER ;

-- вызов функции
SELECT friendship_direction(1);
SELECT truncate(friendship_direction(1), 2)*100 AS `user popularity`;