{{ config(
        materialized='view'
    )
}}
SELECT
    A.ACCOUNT_ID,
    {{ dbt_utils.star(from=ref('ACCOUNTS'), relation_alias='A', except=['ACCOUNT_ID']) }},
    C.NAME AS COUNTRY_OF_RESIDENCE_NAME,
    {{ dbt_utils.star(from=ref('ACCOUNTS_ATTRIBUTES_PIVOT'), except=['ACCOUNT_ID']) }}
FROM
    {{ ref('ACCOUNTS') }} A
    INNER JOIN {{ ref('ACCOUNTS_ATTRIBUTES_PIVOT') }} AA ON A.ACCOUNT_ID = AA.ACCOUNT_ID
    INNER JOIN {{ ref('COUNTRY_CD_TP') }} C ON A.COUNTRY_OF_RESIDENCE = C.CODE