select *
from {{source('kondado_marketing_raw','google_ads_keywords_performance_new')}}
limit 10