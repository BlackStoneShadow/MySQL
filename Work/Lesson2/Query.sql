/*
1. Используя операторы языка SQL,
создайте таблицу “sales”. Заполните ее данными.
*/
-- создаём базу данных
DROP DATABASE IF EXISTS lesson_2;
CREATE DATABASE lesson_2;
USE lesson_2;

-- продажи
CREATE TABLE Sales(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	order_date DATE NOT NULL, 	
	count_product INT UNSIGNED DEFAULT 0
);

INSERT INTO Sales(order_date, count_product) VALUES
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);

-- Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT 	
	CASE 
		WHEN count_product < 100 THEN 'X < 100'
		WHEN count_product BETWEEN 100 AND 300 THEN '100 < X < 300'
		ELSE 'X < 300'
	END AS Segment,
	COUNT(*) AS Count
FROM Sales
GROUP BY Segment
ORDER BY 
CASE 
	WHEN count_product < 100 THEN 1 
	WHEN count_product BETWEEN 100 AND 300 THEN 2 
	ELSE 3 
END;

/*
Создайте таблицу “orders”, заполните ее значениями. Выберите все заказы. 
В зависимости от поля order_status выведите столбец full_order_status: 
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
*/
CREATE TABLE Orders(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	employee_id CHAR(3) NOT NULL, 
	amount DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 0,
	order_status VARCHAR(10) NOT NULL 
);

INSERT INTO Orders(employee_id, amount, order_status) VALUES
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED');

SELECT
	employee_id, amount, 
	CASE order_status 
		WHEN 'OPEN' THEN 'Order is in open state'
		WHEN 'CLOSED' THEN 'Order is closed'
		WHEN 'CANCELLED' THEN 'Order is cancelled'
	END
FROM Orders;
/*
Чем NULL отличается от 0?
NULL это отсутствие значения, 0 - число, NULL не затрачивает ресурсы на хранения данных 
и имеет особый оператор проверки соответствия IS NULL.
*/