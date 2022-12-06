with source as (

    select
        cast(businessentityid as string) as businessentityid
        , cast(territoryid as string) as territoryid
        , salesquota
        , salesytd
        , bonus
        , saleslastyear
        , commissionpct
    
    from {{ source('sales', 'sales_salesperson') }}
)

select * from source