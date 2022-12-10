with sales_order_headers as (

    select * from {{ ref('stg_sales__salesorderheader') }}
)

, sales_order_details as (

    select * from {{ ref('stg_sales__salesorderdetail') }}
)

, joined as (

    select
        sales_order_details.salesorderdetailid
        , sales_order_details.salesorderid
        , sales_order_details.productid
        , sales_order_details.unitprice
        , sales_order_details.orderqty
        , sales_order_details.specialofferid
        , sales_order_details.carriertrackingnumber
        , sales_order_details.unitpricediscount

        , sales_order_headers.salespersonid
        , sales_order_headers.purchaseordernumber
        , sales_order_headers.billtoaddressid
        , sales_order_headers.shiptoaddressid
        , sales_order_headers.taxamt
        , sales_order_headers.onlineorderflag
        , sales_order_headers.territoryid
        , sales_order_headers.status
        , sales_order_headers.currencyrateid
        , sales_order_headers.orderdate
        , sales_order_headers.duedate
        , sales_order_headers.shipdate
        , sales_order_headers.creditcardapprovalcode
        , sales_order_headers.subtotal
        , sales_order_headers.creditcardid
        , sales_order_headers.revisionnumber
        , sales_order_headers.freight
        , sales_order_headers.totaldue
        , sales_order_headers.customerid
        , sales_order_headers.accountnumber
        , sales_order_headers.last_updated_date
    
    from sales_order_details

    left join sales_order_headers
    on sales_order_details.salesorderid = sales_order_headers.salesorderid

)

select * from joined