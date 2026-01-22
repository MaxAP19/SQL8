SELECT DISTINCT name
FROM person
JOIN person_order ON person_order.person_id = person.id
ORDER BY name;
/*а теперь просто выведем список людей, которые делали заказы
в любой пиццерии и отсортируем по имени*/