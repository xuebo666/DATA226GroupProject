-- Modeling table: a balanced random sample per category, with labels and split flags.
--
--   in-category experiment : split_in_category  ('train' = 80%, 'test' = 20%, per review)
--   cross-category         : train on one category, test on another (filter on `category`)
--   temporal experiment    : split_temporal ('train' = years <= temporal_split_year, 'test' = later)
with ranked as (
    select
        *,
        row_number() over (partition by category order by hash(review_id)) as rn
    from {{ ref('stg_reviews') }}
)

select
    review_id,
    category,
    star_rating,
    star_rating                                              as label_5class,
    case when star_rating <= 2 then 0
         when star_rating = 3  then 1
         else 2 end                                          as label_3class,
    review_year,
    helpful_votes,
    total_votes,
    verified_purchase,
    word_count,
    review_text,
    case when mod(abs(hash(review_id || '-split')), 100) < 80
         then 'train' else 'test' end                        as split_in_category,
    case when review_year <= {{ var('temporal_split_year') }}
         then 'train' else 'test' end                        as split_temporal
from ranked
where rn <= {{ var('n_per_category') }}
