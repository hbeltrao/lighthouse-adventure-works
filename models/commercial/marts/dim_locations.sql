with locations as (

    select * from {{ ref('int_address_merge') }}
)

select * from locations