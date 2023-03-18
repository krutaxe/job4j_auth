CREATE TABLE products
(
    id       serial PRIMARY KEY,
    name     varchar(50),
    producer varchar(50),
    count    integer DEFAULT 0,
    price    integer
);


CREATE OR REPLACE FUNCTION first()
    RETURNS trigger AS
$$
BEGIN
    UPDATE products
    SET price = price + price * 0.18
    WHERE id = (SELECT id FROM inserted);
    RETURN new;
END;
$$
    LANGUAGE 'plpgsql';



CREATE TRIGGER first_trigger
    AFTER INSERT
    ON products
    REFERENCING NEW TABLE AS inserted
    FOR EACH STATEMENT
EXECUTE PROCEDURE first();





CREATE OR REPLACE FUNCTION second()
    RETURNS trigger AS
$$
BEGIN
    new.price = new.price + new.price * 0.18;
    RETURN new;
END;
$$
    LANGUAGE 'plpgsql';


CREATE TRIGGER second_trigger
    BEFORE INSERT
    ON products
    FOR EACH ROW
EXECUTE PROCEDURE second();



create table history_of_price (
                                  id serial primary key,
                                  name varchar(50),
                                  price integer,
                                  date timestamp
);



CREATE OR REPLACE FUNCTION three()
    RETURNS trigger AS
$$
BEGIN
    INSERT INTO history_of_price (name, price, date)
    VALUES (new.name, new.price, current_timestamp);
    RETURN new;
END;
$$
    LANGUAGE 'plpgsql';


CREATE TRIGGER three_trigger
    AFTER INSERT
    ON products
    FOR EACH ROW
EXECUTE PROCEDURE three();



INSERT INTO products (name, producer, count, price)
VALUES ('milk', 'prod', 5, 1000);