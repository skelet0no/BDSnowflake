CREATE TABLE dim_supplier (
    id SERIAL PRIMARY KEY,
    supplier_phone VARCHAR,
    supplier_name VARCHAR,
    supplier_email VARCHAR,
    supplier_country VARCHAR,
    supplier_contact VARCHAR,
    supplier_city VARCHAR,
    supplier_address VARCHAR
);

CREATE TABLE dim_seller (
    id SERIAL PRIMARY KEY,
    source_seller_id INT,
    seller_postal_code VARCHAR,
    seller_last_name VARCHAR,
    seller_first_name VARCHAR,
    seller_email VARCHAR,
    seller_country VARCHAR
);

CREATE TABLE dim_product (
    id SERIAL PRIMARY KEY,
    source_product_id INT,

    product_weight REAL,
    product_size VARCHAR,
    product_reviews INT,
    product_release_date VARCHAR,
    product_rating REAL,
    product_quantity int,
    product_price REAL,
    product_name VARCHAR,
    product_material VARCHAR,
    product_expiry_date VARCHAR,
    product_description VARCHAR,
    product_color VARCHAR,
    product_category VARCHAR,
    product_brand VARCHAR,
    pet_category VARCHAR,
    sale_date VARCHAR
);

CREATE TABLE dim_customer (
    id SERIAL PRIMARY KEY,
    source_customer_id INT,

    customer_postal_code VARCHAR,
    customer_pet_type VARCHAR,
    customer_pet_name VARCHAR,
    customer_pet_breed VARCHAR,
    customer_last_name VARCHAR,
    customer_first_name VARCHAR,
    customer_email VARCHAR,
    customer_country VARCHAR,
    customer_age INT
);


CREATE TABLE dim_store (
    id SERIAL PRIMARY KEY,

    store_supplier_id INT,
    sale_seller_id INT,

    store_email VARCHAR,
    store_state VARCHAR,
    store_phone VARCHAR,
    store_name VARCHAR,
    store_location VARCHAR,
    store_country VARCHAR,
    store_city VARCHAR,

    FOREIGN KEY (store_supplier_id)
        REFERENCES dim_supplier(id),

    FOREIGN KEY (sale_seller_id)
        REFERENCES dim_seller(id)
);

CREATE TABLE fact_sales (
    id SERIAL PRIMARY KEY,

    product_id INT,
    customer_id INT,
    store_id INT,

    sale_total_price REAL,
    sale_quantity INT,

    FOREIGN KEY (product_id)
        REFERENCES dim_product(id),

    FOREIGN KEY (customer_id)
        REFERENCES dim_customer(id),

    FOREIGN KEY (store_id)
        REFERENCES dim_store(id)
);


CREATE INDEX idx_dim_supplier_email ON dim_supplier(supplier_email);

CREATE INDEX idx_dim_seller_email ON dim_seller(seller_email);

CREATE INDEX idx_dim_customer_email ON dim_customer(customer_email);

CREATE INDEX idx_dim_store_email ON dim_store(store_email);

CREATE INDEX idx_dim_product_lookup
ON dim_product(product_price, product_release_date, product_expiry_date);
