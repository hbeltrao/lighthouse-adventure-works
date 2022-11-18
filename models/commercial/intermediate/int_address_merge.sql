with address as (

    select * from {{ ref('stg_person__address') }}
)

, state_province as (

    select * from {{ ref('stg_person__stateprovince') }}
)

, country_region as (

    select * from {{ ref('stg_person__countryregion') }}
)

, state_province_country_joined as (

    select
        state_province.stateprovinceid
        , state_province.name as state_province_name
        , state_province.stateprovincecode as state_province_code
        , state_province.territoryid as territory_id
        , country_region.name as country_name

    from state_province

    left join country_region on state_province.countryregioncode = country_region.countryregioncode

)

, full_joined as (

    select
        address.addressid
        , address.stateprovinceid
        , address.city
        , address.spatiallocation
        , address.addressline1
        , address.addressline2
        , address.postalcode
        , state_province_country_joined.state_province_name
        , state_province_country_joined.state_province_code
        , state_province_country_joined.territory_id
        , state_province_country_joined.country_name

    from address

    left join state_province_country_joined
    on address.stateprovinceid = state_province_country_joined.stateprovinceid

)

select * from full_joined