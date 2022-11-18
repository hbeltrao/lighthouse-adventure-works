with source as (

    select * from {{ source('person', 'person_address') }}
)

select * from source