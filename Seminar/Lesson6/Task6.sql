USE lesson_4;
-- ТРИГГЕРЫ 
-- триггер для корректировки возраста пользователя при вставке новых строк
DROP TRIGGER if exists check_user_age_before_insert;
DELIMITER //
CREATE TRIGGER check_user_age_before_insert BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN
    IF NEW.birthday > CURRENT_DATE() THEN
        SET NEW.birthday = CURRENT_DATE();
    END IF;
END//
DELIMITER ;

-- триггер для проверки возраста пользователя перед обновлением
DELIMITER //
CREATE TRIGGER check_user_age_before_update BEFORE UPDATE ON profiles
FOR EACH ROW
BEGIN
    IF NEW.birthday > NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Обновление отменено. Дата рождения не может быть больше текущей даты!';
    END IF;
END//
DELIMITER ;

-- проверка работы триггеров
-- вывод всех пользователей
SELECT u.id, u.firstname, u. lastname, p.birthday FROM users u
INNER JOIN profiles p ON u.id=p.user_id
ORDER BY u.id DESC;

-- добавление нового пользователя
CALL sp_user_add('Иван', 'Диванов', 'ivan_2023@mail.ru', 9876543221, 'Moscow', NULL, '2030-01-01', @tran_result); 
CALL sp_user_add('Петр', 'Петров', 'retya_2023@mail.ru', 9876543222, 'Moscow', NULL, '2023-01-01', @tran_result); 


-- обновление данных 
UPDATE profiles 
SET birthday = '2030-01-01'
WHERE user_id = 10;

UPDATE profiles 
SET birthday = '2020-01-01'
WHERE user_id = 10;