with source as (

    select 
        cast(businessentityid as string) as businessentityid
        , persontype
        , namestyle
        , firstname
        , lastname
    
    from {{ source('person', 'person_person') }}
)

select * from source