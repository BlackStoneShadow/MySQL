USE lesson_3;
/*
1. Выведите id сотрудников, которые напечатали более 500 страниц за все дни

2.  Выведите  дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.

3. Выведите среднюю заработную плату по должностям, которая составляет более 30000
*/
SELECT staff_id 
FROM activity_staff 
GROUP BY staff_id 
HAVING sum(count_pages) > 500;

SELECT date_activity, COUNT(staff_id) AS Count 
FROM activity_staff 
GROUP BY date_activity 
HAVING Count > 3;

SELECT post 
FROM staff 
GROUP BY post 
HAVING AVG(salary) > 30000 ;