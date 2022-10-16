CREATE
OR REPLACE FUNCTION update_status_date_trigger() RETURNS TRIGGER AS $ update_status_date_trigger $ BEGIN NEW.status_date = current_timestamp;

RETURN NEW;

END;

$ update_status_date_trigger $ LANGUAGE PLPGSQL;

CREATE TRIGGER change_status_date_on_update BEFORE
UPDATE
    ON orders FOR EACH ROW EXECUTE FUNCTION update_status_date_trigger();

SELECT
    *
FROM
    orders
WHERE
    order_number = '87abd6f1-291a-b836-5c6e-ff6cafb7b0c1';

UPDATE
    orders
SET
    status = 'delivery'
WHERE
    order_number = '87abd6f1-291a-b836-5c6e-ff6cafb7b0c1';

SELECT
    *
FROM
    orders
WHERE
    order_number = '87abd6f1-291a-b836-5c6e-ff6cafb7b0c1';
