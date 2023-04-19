/*
1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
2. Выведите 5 максимальных заработных плат (salary)
3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
5. Найдите количество специальностей
6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
*/
USE lesson_3;
-- 1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
SELECT * 
FROM staff 
ORDER BY salary ASC;

SELECT * 
FROM staff 
ORDER BY salary DESC;

-- 2. Выведите 5 максимальных заработных плат (salary)
SELECT
	salary 
FROM staff 
ORDER BY salary DESC 
LIMIT 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT 
	post, SUM(salary) as Salary 
FROM staff 
GROUP BY post;

-- 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT 
	COUNT(*) AS Count
FROM staff 
WHERE post = 'Рабочий'
  AND age BETWEEN 24 AND 49;

-- 5. Найдите количество специальностей
SELECT 
	COUNT(DISTINCT post) AS Count
FROM staff;

-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT
	post
FROM staff
GROUP BY post
HAVING AVG(Age) < 30;