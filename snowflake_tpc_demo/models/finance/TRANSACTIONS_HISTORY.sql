{{ config(
        materialized='incremental',
        unique_key='TRANSACTION_ID'
    )
}}

SELECT
    {{ dbt_utils.star(source('finance', 'TRANSACTIONS')) }}
FROM {{ source('finance', 'TRANSACTIONS') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  WHERE _SNOWFLAKE_LOADED_AT >= (SELECT MAX(_SNOWFLAKE_LOADED_AT) FROM {{ this }})

{% endif %}