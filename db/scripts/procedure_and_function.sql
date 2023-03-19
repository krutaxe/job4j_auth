CREATE OR REPLACE PROCEDURE delete_data()
    LANGUAGE 'plpgsql'
AS
$$
BEGIN
    DELETE FROM products WHERE count = 0;
END
$$;



CREATE OR REPLACE PROCEDURE delete_data_by_id(d_id integer)
    LANGUAGE 'plpgsql'
AS
$$
BEGIN
    DELETE FROM products WHERE  id = d_id;
END
$$;

CALL delete_data();
CALL delete_data_by_id(92);




CREATE OR REPLACE FUNCTION f_delete_data()
RETURNS integer
    LANGUAGE 'plpgsql'
AS
    $$
    DECLARE
        rsl integer;
    BEGIN
        DELETE FROM products WHERE price < 20;
        SELECT INTO rsl sum(count) FROM products;
    RETURN rsl;
END;
$$;



CREATE OR REPLACE FUNCTION f_delete_data_by_id(d_id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
AS
$$
DECLARE
    rsl integer;
BEGIN
    DELETE FROM products WHERE id = d_id;
    SELECT INTO rsl sum(price) FROM products;
    RETURN rsl;
END;
$$;

SELECT f_delete_data();
SELECT f_delete_data_by_id(83);