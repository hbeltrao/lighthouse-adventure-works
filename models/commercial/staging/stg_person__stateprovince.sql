with source as (

    select 
        cast(stateprovinceid as string) as stateprovinceid
        , cast(territoryid as string) as territoryid
        , countryregioncode
        , name
        , stateprovincecode
    
    from {{ source('person', 'person_stateprovince') }}
)

select * from source