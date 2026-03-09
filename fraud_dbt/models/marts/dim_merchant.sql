{{ config(materialized='table') }}

SELECT
    merchant_id,
    MAX(merchant_category) AS merchant_category
FROM {{ ref('stg_payment_events') }}
GROUP BY merchant_id
