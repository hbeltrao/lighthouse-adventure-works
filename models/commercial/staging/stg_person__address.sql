with source as (

    select 
        cast(addressid as string) as addressid 
        , cast(stateprovinceid as string) as stateprovinceid 
        , city
        , spatiallocation
        , addressline1
        , addressline2
        , postalcode
    
    from {{ source('person', 'person_address') }}
)

select * from source