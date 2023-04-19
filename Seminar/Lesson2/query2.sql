-- Задача 2
USE lesson_1;
-- Пункт 1
SELECT * FROM lesson_1.students;
-- Пункт 2
SELECT * FROM lesson_1.students WHERE name_student = 'Антон';
-- Пункт 3
SELECT name_student, email FROM lesson_1.students;
-- Пункт 4
SELECT * FROM lesson_1.students WHERE name_student LIKE 'А%';