with source as (

    select
        cast(salesreasonid as string) as salesreasonid
        , cast(salesorderid as string) as salesorderid
    
    from {{ source('sales', 'sales_salesorderheadersalesreason') }}
)

select * from source