{{ config(
        materialized='view'
    )
}}

{% set attributes = dbt_utils.get_column_values(table=ref('ACCOUNTS_ATTRIBUTES'), column='FIELD') %}

SELECT
    ACCOUNT_ID
{% for atr in attributes %}
    ,MAX(IFF(FIELD = '{{ atr }}', VALUE, NULL)) AS {{ atr }}
{% endfor %}
FROM
    {{ ref('ACCOUNTS_ATTRIBUTES') }} A
GROUP BY A.ACCOUNT_ID