with sales_reason as (

    select * from {{ ref('stg_sales__salesreason') }}
)

, salesorder_header_salesreason as (

    select * from {{ ref('stg_sales_salesorderheadersalesreason') }}
)

, joined as (

    select 
        salesorder_header_salesreason.salesorderid
        , sales_reason.name as sale_reason_name
        , sales_reason.reasontype as sale_reason_type
    
    from sales_reason

    left join salesorder_header_salesreason
    on sales_reason.salesreasonid = salesorder_header_salesreason.salesreasonid
)

select * from joined