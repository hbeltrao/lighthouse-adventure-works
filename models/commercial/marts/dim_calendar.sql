with calendar as (

    select distinct orderdate

    from {{ ref('int_sales_orders_details') }}
)

, exploded as (

    select
        orderdate
        , extract(year from orderdate) as year_date
        , extract(month from orderdate) as month_date
        , extract(week from orderdate) as week_date
        , extract(day from orderdate) as day_date
        , concat(extract(year from orderdate), "-", extract(month from orderdate)) as year_months
    
    from calendar
)

select * from exploded