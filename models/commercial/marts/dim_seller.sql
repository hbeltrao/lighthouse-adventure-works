with customer as (

    select * from {{ ref('stg_sales__customer') }}
)

, store as (

    select * from {{ ref('stg_sales__store') }}
)

, joined as (

    select

        customer.customerid
        , store.store_name
    
    from customer
    
    left join store on customer.storeid = store.businessentityid

)

select * from joined