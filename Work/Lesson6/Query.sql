USE lesson_4;
/*
1.Создайте таблицу users_old, аналогичную таблице users. 
Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
2.Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
3.(по желанию)* Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, communities и messages в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа.
*/
-- Создайте таблицу users_old, аналогичную таблице users. 
-- Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
-- (использование транзакции с выбором commit или rollback – обязательно).
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS sp_user_move;
DELIMITER //
CREATE PROCEDURE sp_user_move(user_id INT, OUT result varchar(100))
BEGIN
	
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE error_code varchar(100);
	DECLARE error_string varchar(100); 

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = b'1';
 		GET stacked DIAGNOSTICS CONDITION 1
			error_code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	END;

	START TRANSACTION;
		
	INSERT INTO users_old 
	(
		id, firstname, lastname, email
	)
	SELECT
		id, firstname, lastname, email
	FROM users
	WHERE id = user_id;

	DELETE u FROM users u
	WHERE u.id = user_id;

	IF `_rollback` THEN
		SET result = CONCAT_WS(' ' , 'Ошибка Код:', error_code, 'Ошибка Текст: ', error_string);
		ROLLBACK;
	ELSE
		SET result = 'OK';
		COMMIT;
	END IF;
END//
DELIMITER ;

CALL sp_user_move(1, @result); SELECT @result;
CALL sp_user_move(2, @result); SELECT @result;
CALL sp_user_move(3, @result); SELECT @result;

SELECT * FROM users;
SELECT * FROM users_old;

-- 2.Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello(TimeOfDay TIME)
RETURNS VARCHAR(15) READS SQL DATA 
BEGIN
	RETURN 
	(
		SELECT 	CASE 
					WHEN TimeOfDay BETWEEN ADDTIME(0, "0:00") AND ADDTIME(0, "5:59:59") THEN "Доброй ночи" 
					WHEN TimeOfDay BETWEEN ADDTIME(0, "6:00") AND ADDTIME(0, "11:59:59") THEN "Доброе утро" 
					WHEN TimeOfDay BETWEEN ADDTIME(0, "12:00") AND ADDTIME(0, "17:59:59") THEN "Добрый день"
					WHEN TimeOfDay BETWEEN ADDTIME(0, "18:00") AND ADDTIME(0, "23:59:59") THEN "Добрый вечер"
				END
	);
END//
DELIMITER ;
SELECT CONCAT_WS(" ", hello(CURTIME()), CURRENT_USER()) AS Result;

-- 3.(по желанию)* Создайте таблицу logs типа Archive. 
-- Пусть при каждом создании записи в таблицах users, communities и messages в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа.
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	timestamp DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	table_name ENUM('users', 'communities', 'messages'),
	table_key BigInt NOT NULL,
	CONSTRAINT UNIQUE uq_logs(timestamp, table_name, table_key) 
);
DROP TRIGGER IF EXISTS user_log_before_insert;
DROP TRIGGER IF EXISTS communities_log_before_insert;
DROP TRIGGER IF EXISTS messages_log_before_insert;
DELIMITER //
CREATE TRIGGER user_log_before_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs(table_name, table_key) VALUES("users", NEW.id);
END//
CREATE TRIGGER communities_log_before_insert AFTER INSERT ON communities
FOR EACH ROW
BEGIN
    INSERT INTO logs(table_name, table_key) VALUES("communities", NEW.id);
END//
CREATE TRIGGER messages_log_before_insert AFTER INSERT ON messages
FOR EACH ROW
BEGIN
    INSERT INTO logs(table_name, table_key) VALUES("messages", NEW.id);
END//
DELIMITER ;
-- Проверка лога
SET @num = round(rand() * 10, 0);

INSERT INTO users (firstname, lastname, email) VALUES(CONCAT('first', @num), CONCAT('last', @num), CONCAT(@num, '@emails.ru'));
INSERT INTO messages (from_user_id, to_user_id, body, created_at) VALUES(last_insert_id(), 10, 'test body', CURRENT_TIMESTAMP);
INSERT INTO communities (name) VALUES(CONCAT('test', @num));

SELECT * FROM logs;