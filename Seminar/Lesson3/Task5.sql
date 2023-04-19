USE lesson_3;
/*
Сгруппируйте данные о сотрудниках по возрасту: 
1 группа – младше 20 лет
2 группа – от 20 до 40 лет
3 группа – старше  40 лет 
Для каждой группы  найдите суммарную зарплату
*/
SELECT 
CASE
	WHEN age < 20 THEN 1
	WHEN age BETWEEN 20 AND 40 THEN 2
	WHEN age > 40 THEN 3
END AS AgeGroup,
SUM(salary) AS salary
FROM staff age
GROUP BY AgeGroup;