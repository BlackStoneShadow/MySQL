USE lesson_4;
-- ЦИКЛЫ
ALTER TABLE `profiles`
ADD COLUMN time_update DATETIME ON UPDATE NOW(); 


DROP PROCEDURE IF EXISTS sp_data_analysis;
DELIMITER //
CREATE PROCEDURE sp_data_analysis(start_date DATE)
BEGIN
	DECLARE id_max_users INT;
	DECLARE count_find INT;
	
	SET id_max_users = (SELECT MAX(user_id) FROM profiles);
	WHILE (id_max_users > 0) DO
		BEGIN
			SET count_find = (SELECT COUNT(*) FROM profiles WHERE user_id = id_max_users AND birthday > start_date); 
			IF (count_find>0 )	THEN 
				UPDATE profiles
					SET birthday=NOW()
				WHERE user_id=id_max_users; 
			END IF;
	    	SET id_max_users = id_max_users - 1;
    	END;
  	END WHILE;
END//

DELIMITER ;

-- вызов процедуры
CALL sp_data_analysis('2000-01-01');