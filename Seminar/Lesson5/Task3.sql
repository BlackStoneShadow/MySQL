-- ВРЕМЕННАЯ ТАБЛИЦА
DROP TABLE IF EXISTS tbl_friends;
CREATE TEMPORARY TABLE tbl_friends 
SELECT initiator_user_id AS user_id, target_user_id AS friend_id FROM lesson_4.friend_requests 
WHERE  status='approved' -- ID друзей, заявку которых подтвердили
UNION
SELECT target_user_id, initiator_user_id FROM  lesson_4.friend_requests  
WHERE  status='approved'; -- ID друзей, подтвердивших заявку

SELECT friend_id FROM tbl_friends
WHERE user_id=1;
-- ОБЩЕЕ ТАБЛИЧНОЕ ВЫРАЖЕНИЕ
WITH friends AS  
(SELECT initiator_user_id AS user_id, target_user_id AS friend_id FROM lesson_4.friend_requests 
WHERE  status='approved' -- ID друзей, заявку которых подтвердили
UNION
SELECT target_user_id, initiator_user_id FROM  lesson_4.friend_requests  
WHERE  status='approved') -- ID друзей, подтвердивших заявку

SELECT friend_id FROM friends
WHERE user_id=1;

-- ПРЕДСТАВЛЕНИЯ

CREATE OR REPLACE VIEW v_friends AS  
(SELECT initiator_user_id AS user_id, target_user_id AS friend_id FROM lesson_4.friend_requests 
WHERE  status='approved' -- ID друзей, заявку которых подтвердили
UNION
SELECT target_user_id, initiator_user_id FROM  lesson_4.friend_requests  
WHERE  status='approved'); -- ID друзей, подтвердивших заявку

SELECT friend_id FROM v_friends
WHERE user_id=1;