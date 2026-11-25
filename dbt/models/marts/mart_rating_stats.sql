-- Rating statistics per category and year (used for EDA and the report).
select
    category,
    review_year,
    count(*)                                         as reviews,
    avg(star_rating)                                 as avg_rating,
    avg(case when star_rating = 5 then 1.0 else 0 end) as share_5_star,
    avg(case when star_rating = 1 then 1.0 else 0 end) as share_1_star,
    avg(word_count)                                  as avg_word_count,
    avg(case when verified_purchase then 1.0 else 0 end) as share_verified,
    avg(helpful_votes)                               as avg_helpful_votes
from {{ ref('stg_reviews') }}
group by category, review_year
