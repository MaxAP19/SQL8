(SELECT name, -- первый подзапрос
    COUNT(*) AS count, -- посчитаем количество посещений каждой пиццерии
    'visit' AS action_type -- тобавим колонку с типом действия "визит"
FROM person_visits -- основная таблица откуда берем инфу
JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id -- соединяем с таблицей пиццерий, чтобы получить название пиццерии
GROUP BY name -- группируем по имени пиццерии
ORDER BY count DESC LIMIT 3) -- выбираем топ-3 пиццерий и сортируем по убыванию визитов
UNION -- объединяем результаты подзапросов без дубликатов
(SELECT name, -- второй подзапрос
    COUNT(*) AS count,
    'order' AS action_type
FROM person_order
JOIN menu ON menu.id = person_order.menu_id -- здесь нужно сделать 2 объединения, чтобы добраться до имени пиццерии, меню - промежуточная
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
GROUP BY name -- снова группируем по имени пиццерии
ORDER BY count DESC LIMIT 3) -- аналогичная сортировка
ORDER BY action_type, count DESC; -- отсортируем результат по типу действия и количества - по убыванию
/*найдем три самых популярных пиццерии по количеству посещений
и заказов. Нужно объединиться два набора данных из таблиц посещений
и заказов и отразить их в списке активностей*/
-- COUNT(*) + GROUP BY нужны для подсчета количеств строк в каждой группе