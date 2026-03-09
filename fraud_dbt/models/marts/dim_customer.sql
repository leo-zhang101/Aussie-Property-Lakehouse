SELECT DISTINCT
    customer_id
FROM {{ ref('stg_payment_events') }}
