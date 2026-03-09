SELECT
    event_id,
    event_ts,
    transaction_id,
    customer_id,
    merchant_id,
    merchant_category,
    payment_method,
    currency,
    amount,
    state,
    channel,
    device_type,
    transaction_status,
    is_international,
    risk_score,
    fraud_flag
FROM {{ source('raw', 'payment_events_partitioned') }}
