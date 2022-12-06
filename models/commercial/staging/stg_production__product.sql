with source as (

    select
        cast(productid as string) as productid
        , name
    
    from {{ source('production', 'production_product') }}
)

select * from source