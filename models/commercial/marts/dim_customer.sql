with person as (

    select * from {{ ref('stg_person__person') }}
)

, customer as (

    select * from {{ ref('stg_sales__customer') }}
)

, joined as (

    select 
        customer.customerid as customer_id
        , customer.personid as person_id
        , customer.storeid as store_id
        , customer.territoryid as territory_id
        , case when person.namestyle = False then concat(person.firstname, ' ', person.lastname)
          when person.namestyle = True then concat(person.lastname, ' ', person.firstname)
          end as customer_full_name
    
    from customer
    left join person on customer.personid = person.businessentityid
)

select * from joined