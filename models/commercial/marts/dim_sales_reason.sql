with sales_reason as (

    select * from {{ ref('stg_sales__salesreason') }}
)

, salesorder_header_salesreason as (

    select * from {{ ref('stg_sales_salesorderheadersalesreason') }}
)

, joined as (

    select 
        salesorder_header_salesreason.salesorderid
        , sales_reason.sale_reason_name
        , sales_reason.sale_reason_type
    
    from sales_reason

    left join salesorder_header_salesreason
    on sales_reason.salesreasonid = salesorder_header_salesreason.salesreasonid
)

, adjusted as (

    select
        salesorderid
        , case when sale_reason_name = 'Demo Event' then 'Demo_Event'
            when sale_reason_name = 'Magazine Advertisement' then 'Magazine_Advertisement'
            when sale_reason_name = 'Television  Advertisement' then 'Television_Advertisement'
            when sale_reason_name = 'On Promotion' then 'On_Promotion'
            else sale_reason_name
            end as sale_reason_name
    
    from joined
)

, pivoted as (

    select
        *

    from adjusted

        pivot (count(*) for sale_reason_name in ('Other','Price','Review', 'Quality','Manufacturer','Demo_Event','Sponsorship','Magazine_Advertisement','Television_Advertisement','On_Promotion'))
)

, deduped as (

    select 
        distinct salesorderid
        , Other
        , Price
        , Review
        , Quality
        , Manufacturer
        , Demo_Event
        , Sponsorship
        , Magazine_Advertisement
        , Television_Advertisement
        , On_Promotion
    
    from pivoted
)

select * from deduped