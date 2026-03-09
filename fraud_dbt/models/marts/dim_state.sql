SELECT DISTINCT
    state
FROM {{ ref('stg_payment_events') }}
