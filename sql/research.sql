CREATE OR REPLACE FUNCTION column_distinct_counts(tablename text)
RETURNS TABLE(column_name text, distinct_count bigint)
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT c.column_name
        FROM information_schema.columns c
        WHERE c.table_name = tablename
    LOOP
        EXECUTE format(
            'SELECT COUNT(DISTINCT %I) FROM %I',
            r.column_name,
            tablename
        )
        INTO distinct_count;

        column_name := r.column_name;
        RETURN NEXT;
    END LOOP;
END;
$$;

-- просмотр какие колонки в таблице mock_data имеют уникальные значения
SELECT * FROM column_distinct_counts('mock_data');

-- проверка уникальности ключа для таблицы dim_product
SELECT
    product_price,
    product_release_date,
    product_expiry_date,
    COUNT(*)
FROM mock_data
GROUP BY
    product_price,
    product_release_date,
    product_expiry_date
HAVING COUNT(*) > 1;