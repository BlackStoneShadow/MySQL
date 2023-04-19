USE lesson_3;
SELECT staff_id, SUM(count_pages) AS pages FROM activity_staff GROUP BY staff_id;
SELECT date_activity, SUM(count_pages) AS pages FROM activity_staff GROUP BY date_activity;
SELECT date_activity, AVG(count_pages) AS pages FROM activity_staff GROUP BY date_activity;