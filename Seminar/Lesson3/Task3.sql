USE lesson_3;
SELECT count(*) as worker FROM staff WHERE post = 'Рабочий';
SELECT sum(salary) as salary FROM staff WHERE post = 'Начальник';
SELECT avg(age) as avg_age FROM staff WHERE salary > 30000;
SELECT min(salary) as min_salary, max(salary) as max_salary FROM staff;