with sales_order_details as (

select * from {{ ref('int_sales_orders_details') }}
)

, customer as (

    select * from {{ ref('dim_customer') }}
)

, locations as (

    select * from {{ ref('dim_locations') }}
)

, product as (

    select * from {{ ref('dim_product') }}
)

, calendar as (

    select * from {{ ref('dim_calendar') }}
)

, card_type as (

    select * from {{ ref('dim_cardtype') }}
)

, joined as (

    select
        sales_order_details.salesorderdetailid
        , sales_order_details.salesorderid
        , sales_order_details.productid
        , sales_order_details.unitprice
        , sales_order_details.orderqty
        , sales_order_details.specialofferid
        , sales_order_details.unitpricediscount
        , sales_order_details.salespersonid
        , sales_order_details.shiptoaddressid
        , sales_order_details.onlineorderflag
        , sales_order_details.status
        , sales_order_details.orderdate
        , sales_order_details.duedate
        , sales_order_details.shipdate
        , sales_order_details.subtotal
        , sales_order_details.creditcardid
        , sales_order_details.freight
        , sales_order_details.totaldue
        , sales_order_details.customerid
        , sales_order_details.last_updated_date
        , customer.customer_full_name
        , locations.city
        , locations.spatiallocation
        , locations.state_province_name
        , locations.state_province_code
        , locations.country_name
        , product.name
        , calendar.year_date
        , calendar.month_date
        , calendar.week_date
        , calendar.day_date
        , calendar.year_months
        , card_type.cardtype

    
    from sales_order_details

    left join customer
    on sales_order_details.customerid = customer.customer_id

    left join locations
    on sales_order_details.shiptoaddressid = locations.addressid

    left join product
    on sales_order_details.productid = product.productid

    left join calendar on sales_order_details.orderdate = calendar.orderdate

    left join card_type on sales_order_details.creditcardid = card_type.creditcardid
)

, null_fixed as (

    select
        *
        , case when cardtype is null then 'money' else cardtype end as cardtype_fixed
    
    from joined
)

select * from null_fixed