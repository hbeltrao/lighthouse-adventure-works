with source as (

    select
        cast(businessentityid as string) as businessentityid
        , name as store_name
    
    from {{ source('sales', 'sales_store') }}
)

select * from source