with source as (

    select * from {{ source('person', 'person_stateprovince') }}
)

select * from source