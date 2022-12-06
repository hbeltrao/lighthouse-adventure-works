with source as (

    select
        cast(salesorderid as string) as salesorderid
        , cast(salesorderdetailid as string) as salesorderdetailid
        , cast(productid as string) as productid
        , cast(specialofferid as string) as specialofferid
        , unitprice
        , orderqty
        , carriertrackingnumber
        , unitpricediscount
    
    from {{ source('sales', 'sales_salesorderdetail') }}
)

select * from source