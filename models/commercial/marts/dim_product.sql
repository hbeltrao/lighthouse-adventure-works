with product as (

    select * from {{ ref('stg_production__product') }}
)

select * from  product