with source as (

    select * from {{ source('person', 'person_countryregion') }}
)

select * from source