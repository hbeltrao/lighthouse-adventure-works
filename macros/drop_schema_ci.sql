{% macro drop_schema_ci(schema) %}
{% do adapter.drop_schema(api.Relation.create(database=target.database, schema=schema)) %}
{% endmacro %}
