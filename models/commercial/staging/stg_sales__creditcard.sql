with source as (

    select
        cast(creditcardid as string) as creditcardid
        , cardtype
    
    from {{ source('sales', 'sales_creditcard') }}
)

select * from source