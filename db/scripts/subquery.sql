CREATE TABLE companies
(
    id   int PRIMARY KEY,
    city text
);

CREATE TABLE goods
(
    id         int PRIMARY KEY,
    name       text,
    company_id int REFERENCES companies (id),
    price      int
);

CREATE TABLE sales_managers
(
    id          int PRIMARY KEY,
    last_name   text,
    first_name  text,
    company_id  int REFERENCES companies (id),
    manager_fee int
);

CREATE TABLE managers
(
    id         int PRIMARY KEY,
    company_id int REFERENCES companies (id)
);

INSERT INTO companies
VALUES (1, 'Москва'),
       (2, 'Нью-Йорк'),
       (3, 'Мюнхен');

INSERT INTO goods
VALUES (1, 'Небольшая квартира', 3, 5000),
       (2, 'Квартира в центре', 1, 4500),
       (3, 'Квартира у метро', 1, 3200),
       (4, 'Лофт', 2, 6700),
       (5, 'Загородный дом', 2, 9800);

INSERT INTO sales_managers
VALUES (1, 'Доу', 'Джон', 2, 2250),
       (2, 'Грубер', 'Ганс', 3, 3120),
       (3, 'Смит', 'Сара', 2, 1640),
       (4, 'Иванов', 'Иван', 1, 4500),
       (5, 'Купер', 'Грета', 3, 2130);

INSERT INTO managers
VALUES (1, 2),
       (2, 3),
       (4, 1);

SELECT * FROM sales_managers
WHERE manager_fee > (SELECT AVG(manager_fee) FROM sales_managers);

SELECT AVG(manager_fee) FROM sales_managers;

SELECT name AS real_estate, price, (SELECT AVG(price) FROM goods) AS avg_price
FROM goods;

SELECT AVG(manager_fee)FROM sales_managers
WHERE sales_managers.id NOT IN (SELECT managers.id FROM managers);

SELECT city,
       (SELECT COUNT(*)
        FROM goods AS g
        WHERE c.id = g.company_id) AS total_goods FROM companies c;


SELECT c.city, COUNT(g.name) AS total_goods FROM companies c
         JOIN goods g ON c.id = g.company_id
GROUP BY c.city;


SELECT last_name, first_name, manager_fee FROM sales_managers sm1
WHERE sm1.manager_fee >= (SELECT AVG(manager_fee)
                          FROM sales_managers sm2
                          WHERE sm2.company_id = sm1.company_id);


SELECT company_id, AVG(price) AS average_price FROM goods
GROUP BY company_id
HAVING AVG(price) > (SELECT MAX(price) FROM goods) / 2;




CREATE TABLE customers
(
    id         serial PRIMARY KEY,
    first_name text,
    last_name  text,
    age        int,
    country    text
);


INSERT INTO customers
VALUES (1, 'Доу', 'Джон', 25, 'USA'),
       (2, 'Грубер', 'Ганс', 37, 'CAN'),
       (3, 'Смит', 'Сара', 21, 'AUS'),
       (4, 'Иванов', 'Иван', 46, 'RUS'),
       (5, 'Купер', 'Грета', 40, 'BEL');


CREATE TABLE orderss
(
    id          serial PRIMARY KEY,
    amount      int,
    customer_id int REFERENCES customers (id)
);

INSERT INTO orderss
VALUES (1, 20, 2),
       (2, 3, 1),
       (3, 10, 2),
       (4, 5, 1),
       (5, 30, 1),
       (6, 25, 5);


SELECT * FROM customers
WHERE customers.id NOT IN (SELECT orderss.customer_id FROM orderss);