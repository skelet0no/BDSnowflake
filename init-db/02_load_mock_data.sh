#!/bin/bash

set -e

DB_NAME="${POSTGRES_DB:-postgres}"
DB_USER="${POSTGRES_USER:-postgres}"
DB_PASSWORD="${POSTGRES_PASSWORD:-postgres}"

CSV_DIR="/docker-entrypoint-initdb.d/исходные данные"

for file in "$CSV_DIR"/*.csv; do
    echo "Загружаем $file в mock_data..."
    psql -v ON_ERROR_STOP=1 --username "$DB_USER" --dbname "$DB_NAME" <<-EOSQL
        COPY mock_data FROM '$file' DELIMITER ',' CSV HEADER;
EOSQL
done
