/* All products should have prices with positive values
Hence any sale with a negative unitprice make the test fail */

select 
    salesorderid

from {{ ref('fct_sales_full') }}

where unitprice < 0