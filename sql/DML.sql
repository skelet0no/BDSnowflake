INSERT INTO dim_supplier (
    supplier_phone,
    supplier_name,
    supplier_email,
    supplier_country,
    supplier_contact,
    supplier_city,
    supplier_address
)
SELECT DISTINCT
    supplier_phone,
    supplier_name,
    supplier_email,
    supplier_country,
    supplier_contact,
    supplier_city,
    supplier_address
FROM mock_data;

INSERT INTO dim_seller (
    source_seller_id,
    seller_postal_code,
    seller_last_name,
    seller_first_name,
    seller_email,
    seller_country
)
SELECT DISTINCT
    sale_seller_id,
    seller_postal_code,
    seller_last_name,
    seller_first_name,
    seller_email,
    seller_country
FROM mock_data;

INSERT INTO dim_customer (
    source_customer_id,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed,
    customer_last_name,
    customer_first_name,
    customer_email,
    customer_country,
    customer_age
)
SELECT DISTINCT
    sale_customer_id,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed,
    customer_last_name,
    customer_first_name,
    customer_email,
    customer_country,
    customer_age
FROM mock_data;

INSERT INTO dim_product (
    source_product_id,
    product_weight,
    product_size,
    product_reviews,
    product_release_date,
    product_rating,
    product_quantity,
    product_price,
    product_name,
    product_material,
    product_expiry_date,
    product_description,
    product_color,
    product_category,
    product_brand,
    pet_category,
    sale_date
)
SELECT DISTINCT
    sale_product_id,
    product_weight,
    product_size,
    product_reviews,
    product_release_date,
    product_rating,
    product_quantity,
    product_price,
    product_name,
    product_material,
    product_expiry_date,
    product_description,
    product_color,
    product_category,
    product_brand,
    pet_category,
    sale_date
FROM mock_data;

INSERT INTO dim_store (
    store_supplier_id,
    sale_seller_id,
    store_email,
    store_state,
    store_phone,
    store_name,
    store_location,
    store_country,
    store_city
)
SELECT DISTINCT
    sup.id,
    sel.id,
    m.store_email,
    m.store_state,
    m.store_phone,
    m.store_name,
    m.store_location,
    m.store_country,
    m.store_city
FROM mock_data m
LEFT JOIN dim_supplier sup
    ON m.supplier_email = sup.supplier_email
LEFT JOIN dim_seller sel
    ON m.seller_email = sel.seller_email;

INSERT INTO fact_sales (
    product_id,
    customer_id,
    store_id,
    sale_total_price,
    sale_quantity
)
SELECT
    p.id,
    c.id,
    st.id,
    m.sale_total_price,
    m.sale_quantity
FROM mock_data m
LEFT JOIN dim_product p
    ON p.product_price = m.product_price AND p.product_release_date = m.product_release_date
    AND p.product_expiry_date = m.product_expiry_date
LEFT JOIN dim_customer c
    ON c.customer_email = m.customer_email
LEFT JOIN dim_store st
    ON st.store_email = m.store_email;
