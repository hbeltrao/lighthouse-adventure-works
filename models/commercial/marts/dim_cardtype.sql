with card_type as (

    select * 
    from {{ ref('stg_sales__creditcard') }}
)

select * from card_type