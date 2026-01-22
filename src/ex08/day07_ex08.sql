SELECT address, pizzeria.name,
    COUNT(person_id) AS count_of_orders -- подсчитаем количество заказов
FROM person_order
JOIN person ON person_order.person_id = person.id -- подтянем адреса
JOIN menu ON person_order.menu_id = menu.id -- подтянем ид меню
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id -- подтянем названия пиццерий
GROUP BY pizzeria.name, person.address -- группируем и агрегируем данные для каждого сочетания адреса и пиццерии
ORDER BY address
/*найдем адресс, пиццерию и количество заказов каждого
человека*/