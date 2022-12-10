with source as (

    select
        cast(salesreasonid as string) as salesreasonid
        , name as sale_reason_name
        , reasontype as sale_reason_type
    
    from {{ source('sales', 'sales_salesreason') }}
)

select * from source