with sales_full as(

    select * from {{ ref('fct_sales_full') }}
)

, sales_reason as (

    select * from {{ ref('dim_sales_reason') }}
)

, seller as (

    select * from {{ ref('dim_seller') }}
)

, joined as (

    select 
        sales_full.* 
        , sales_reason.Other
        , sales_reason.Price
        , sales_reason.Review
        , sales_reason.Quality
        , sales_reason.Manufacturer
        , sales_reason.Demo_Event
        , sales_reason.Sponsorship
        , sales_reason.Magazine_Advertisement
        , sales_reason.Television_Advertisement
        , sales_reason.On_Promotion
        , seller.store_name
    
    from sales_full

    left join seller on sales_full.salespersonid = seller.customerid

    left join sales_reason on sales_full.salesorderid = sales_reason.salesorderid

)

select * from joined