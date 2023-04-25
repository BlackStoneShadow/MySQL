USE lesson_5;
/*
Задача 1. Получить с помощью оконных функции:
средний балл ученика 
наименьшую оценку ученика
наибольшую оценку ученика
сумму всех оценок
количество всех оценок
*/
SELECT 
	name, 
	AVG(grade) OVER(PARTITION BY name) AS avg_grade,
	MIN(grade) OVER(PARTITION BY name) AS min_grade,
	MAX(grade) OVER(PARTITION BY name) AS max_grade,
	SUM(grade) OVER(PARTITION BY name) AS sum_grade,
	COUNT(grade) OVER(PARTITION BY name) AS count_grade
FROM academic_record;
/*
SELECT 
	name, 
	AVG(grade) OVER w AS avg_grade,
	MIN(grade) OVER w AS min_grade,
	MAX(grade) OVER w AS max_grade,
	SUM(grade) OVER w AS sum_grade,
	COUNT(grade) OVER w AS count_grade
FROM academic_record
WINDOWS w AS (PARTITION BY name);
*/