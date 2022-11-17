
#!/bin/bash

psql postgresql://$DB_ADMIN_USER:$DB_ADMIN_PASSWORD@$DBT_DB_HOST:$DBT_DB_PORT/$DBT_DB_NAME << EOF
-- Create roles

create role dbt_dev_role;

grant create on database $DBT_DB_NAME to dbt_dev_role;

-- Grant all permissions required for the development role

create role dbt_prod_role;

grant create on database $DBT_DB_NAME to dbt_prod_role;

-- Grant all permissions required for the production role

create role $DBT_CI_USER with login password '$DBT_CI_PASSWORD';

grant dbt_dev_role to $DBT_CI_USER;

create schema $DBT_CI_SCHEMA;

grant all on schema $DBT_CI_SCHEMA to dbt_dev_role;

alter schema $DBT_CI_SCHEMA owner to dbt_dev_role;

create role $DBT_PROD_USER with login password '$DBT_PROD_PASSWORD';

grant dbt_prod_role to $DBT_PROD_USER;

-- Mask user
alter role $DBT_PROD_USER set role dbt_prod_role;
EOF