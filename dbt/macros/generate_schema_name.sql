{# dev  -> every model goes into your personal schema (DBT_<USERNAME>)
   prod -> staging models go to STAGING, marts go to MARTS (exact names, no prefix) #}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if target.name == 'prod' and custom_schema_name is not none -%}
        {{ custom_schema_name | trim | upper }}
    {%- else -%}
        {{ target.schema }}
    {%- endif -%}
{%- endmacro %}
