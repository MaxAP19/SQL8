WITH visits AS ( -- первый временный подзапрос, считаем количество посещений
    SELECT name,
    COUNT(*) AS count, -- считаем общее количество посещений для каждой пиццерии
    'visit' AS action_type -- добавляем таблицу действия
FROM person_visits
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id -- объединяем, чтобы получить название пиццерии
GROUP BY name -- группируем по названию пиццерии
ORDER BY count
),
orders AS ( -- второй временный подзапрос
    SELECT name, -- то же самое, что и ранее только для заказа
    COUNT(*) AS count,
    'order' AS action_type
FROM person_order
JOIN menu ON menu.id = person_order.menu_id -- два джойна, чтобы добраться до названия пиццерии
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
GROUP BY name
ORDER BY count
)
SELECT pizzeria.name, -- а это уже основной запрос, чтобы получить название пиццерии
(CASE -- здесь производим подсчеты, обрабатываем нулл значения, иначе - считаем
    WHEN visits.count IS NULL THEN 0 ELSE visits.count END
)
+ -- суммируем
(CASE -- аналогично для заказов
    WHEN orders.count IS NULL THEN 0 ELSE orders.count END)
AS total_count -- это общий результат
FROM pizzeria
LEFT JOIN visits ON visits.name = pizzeria.name -- лефт джойны нам понадобятся для суммирования, чтобы были соединения даже там, где нулл результаты
LEFT JOIN orders ON orders.name = pizzeria.name
ORDER BY total_count DESC, name; -- упорядочиваем по убыванию действия, при равенстве - по названию пиццерии по возрастанию
/*получим список пиццерий и подсчитаем общее количество
посещений и заказов для каждой пиццерии*/