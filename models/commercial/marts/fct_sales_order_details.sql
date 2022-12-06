with sales_order_details as (

select * from {{ ref('int_sales_orders_details') }}
)

select * from sales_order_details