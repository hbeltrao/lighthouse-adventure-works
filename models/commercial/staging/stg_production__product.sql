with source as (

    select * from {{ source('production', 'production_product') }}
)

select * from source