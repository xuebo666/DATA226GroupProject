-- Light cleanup and type casting only. No business logic here.
select
    review_id::varchar        as review_id,
    product_id::varchar       as product_id,
    customer_id::bigint       as customer_id,
    category::varchar         as category,
    star_rating::int          as star_rating,
    helpful_votes::int        as helpful_votes,
    total_votes::int          as total_votes,
    verified_purchase::boolean as verified_purchase,
    review_date::date         as review_date,
    review_year::int          as review_year,
    trim(review_text)         as review_text,
    word_count::int           as word_count
from {{ source('raw', 'reviews') }}
where review_text is not null
