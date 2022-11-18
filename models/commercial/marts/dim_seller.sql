with sales_person as (

    select * from {{ ref('stg_sales__salesperson') }}
)

, person as (

    select * from {{ ref('stg_person__person') }}
)

, joined as (

    select
        sales_person.businessentityid
        , sales_person.territoryid
        , sales_person.salesquota
        , sales_person.salesytd
        , sales_person.bonus
        , sales_person.saleslastyear
        , sales_person.commissionpct
        , case when person.namestyle = False then concat(person.firstname, ' ', person.lastname)
          when person.namestyle = True then concat(person.lastname, ' ', person.firstname)
          end as seller_full_name
    
    from sales_person
    left join person on sales_person.businessentityid = person.businessentityid
)

select * from joined