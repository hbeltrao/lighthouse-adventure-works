with source as (

    select
        cast(customerid as string) as customerid
        , cast(personid as string) as personid
        , cast(storeid as string) as storeid
        , cast(territoryid as string) as territoryid
    
    from {{ source('sales', 'sales_customer') }}
)

select * from source