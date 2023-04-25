/*
Задача 2. Получить информацию об оценках 
Пети по физике по четвертям:
*/
SELECT 
	quartal, 
	grade,
	LAG(grade) OVER(ORDER BY quartal) AS lag_grade, 
	LEAD(grade) OVER(ORDER BY quartal) AS lead_grade
FROM academic_record
WHERE name = 'Петя' AND subject = 'физика';

SELECT 
	name, quartal, subject, 
	grade, 
	LAG(grade) OVER w AS prev_grade,
	LAG(grade, 1, 0) OVER w AS prev_grade, -- смещение на 1 и вместо NULL будет 0
	LEAD(grade) OVER w AS last_grade,
	LEAD(grade, 1, 0) OVER w AS last_grade -- смещение на 1 и вместо NULL будет 0
FROM academic_record
WHERE name = 'Петя' AND subject = 'физика'
WINDOW w AS (ORDER BY  quartal);