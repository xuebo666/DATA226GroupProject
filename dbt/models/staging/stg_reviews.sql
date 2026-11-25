-- Light cleanup and type casting on top of the raw table.
select
    review_id,
    product_id,
    cast(customer_id as bigint)        as customer_id,
    category,
    cast(star_rating as integer)       as star_rating,
    cast(helpful_votes as integer)     as helpful_votes,
    cast(total_votes as integer)       as total_votes,
    verified_purchase,
    cast(review_date as date)          as review_date,
    cast(review_year as integer)       as review_year,
    review_text,
    cast(word_count as integer)        as word_count
from {{ source('raw', 'reviews') }}
where review_id is not null
  and star_rating between 1 and 5
  and review_text is not null
