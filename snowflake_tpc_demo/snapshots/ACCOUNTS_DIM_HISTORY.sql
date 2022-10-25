{% snapshot ACCOUNTS_DIM_HISTORY %}

    {{
        config(
          target_schema=env_var('SNOWSQL_SCHEMA'),
          strategy='check',
          unique_key='ACCOUNT_ID',
          check_cols='all',
        )
    }}

    SELECT *
    FROM {{ ref('ACCOUNTS_DIM') }}

{% endsnapshot %}