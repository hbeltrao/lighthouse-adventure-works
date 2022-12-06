with source as (

    select
        cast(salesreasonid as string) as salesreasonid
        , name
        , reasontype
    
    from {{ source('sales', 'sales_salesreason') }}
)

select * from source