{{ config(
    materialized='incremental',
    unique_key='transaction_id'
) }}

WITH dedup AS (

    SELECT
        transaction_id,
        event_ts,
        customer_id,
        merchant_id,
        state,
        payment_method,
        channel,
        device_type,
        amount,
        currency,
        transaction_status,
        is_international,
        risk_score,
        fraud_flag,
        ROW_NUMBER() OVER (
            PARTITION BY transaction_id
            ORDER BY event_ts DESC
        ) AS rn
    FROM {{ ref('stg_payment_events') }}

),

final AS (

    SELECT
        transaction_id,
        event_ts,
        customer_id,
        merchant_id,
        state,
        payment_method,
        channel,
        device_type,
        amount,
        currency,
        transaction_status,
        is_international,
        risk_score,
        fraud_flag
    FROM dedup
    WHERE rn = 1

)

SELECT *
FROM final

{% if is_incremental() %}
WHERE event_ts > (SELECT COALESCE(MAX(event_ts), '1900-01-01'::timestamp) FROM {{ this }})
{% endif %}
