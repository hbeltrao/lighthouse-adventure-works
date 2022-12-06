with source as (

    select
        cast(salesorderid as string) as salesorderid
        , cast(salespersonid as string) as salespersonid
        , cast(billtoaddressid as string) as billtoaddressid
        , cast(shiptoaddressid as string) as shiptoaddressid
        , cast(territoryid as string) as territoryid
        , cast(currencyrateid as string) as currencyrateid
        , cast(creditcardid as string) as creditcardid
        , cast(customerid as string) as customerid
        , accountnumber
        , revisionnumber
        , freight
        , totaldue
        , orderdate
        , duedate
        , shipdate
        , creditcardapprovalcode
        , subtotal
        , status
        , onlineorderflag
        , taxamt
        , purchaseordernumber
    
    from {{ source('sales', 'sales_salesorderheader') }}
)

select * from source