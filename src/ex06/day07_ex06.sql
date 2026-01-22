SELECT name,
    COUNT(person_id) AS count_of_orders, -- подсчитаем количесто заказов для каждой пиццерии
    ROUND(AVG(price), 2) AS average_price, -- подсчитаем среднюю цену заказов, округленную до двух знаков после запятой
    MAX(price) AS max_price, -- максимальная цены среди заказов для каждой пиццерии
    MIN(price) AS min_price -- аналогично минимальная цена
FROM person_order
JOIN menu ON menu.id = person_order.menu_id -- подтянем инфу о пиццах и их ценах
JOIN pizzeria ON pizzeria.id = menu.pizzeria_id -- подтянем инфу о пиццериях
GROUP BY name -- группируем по названию пиццерии
ORDER BY name; -- сортируем по имени
/*посчитаем колиечество заказов, средную, максимальную,
минимальную цену пицц для каждой пиццерии*/