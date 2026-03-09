#!/bin/bash


DATE=$(date +%Y_%m_%d)
NEXT_DATE=$(date -d "+1 day" +%Y-%m-%d)
CURRENT_DATE=$(date +%Y-%m-%d)

TABLE_NAME="fact_transactions_${DATE}"

SQL="
CREATE TABLE IF NOT EXISTS ${TABLE_NAME}
PARTITION OF fact_transactions
FOR VALUES FROM ('${CURRENT_DATE}') TO ('${NEXT_DATE}');
"

docker exec -i streaming_postgres psql -U de_user -d streaming_dw -c "${SQL}"

echo "Partition ${TABLE_NAME} created successfully."
