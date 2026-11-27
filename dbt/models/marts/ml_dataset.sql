-- The table the modeling notebooks read: a fixed random sample of reviews
-- (ml_sample_pct %) with all split labels attached.
select
    r.review_id,
    r.category,
    r.star_rating,
    r.rating_class,
    r.review_year,
    r.review_date,
    r.review_text,
    r.word_count,
    r.helpful_votes,
    r.total_votes,
    r.verified_purchase,
    i.split as in_category_split,
    t.split as temporal_split
from {{ ref('fct_reviews') }} r
join {{ ref('split_in_category') }} i on r.review_id = i.review_id
join {{ ref('split_temporal') }}    t on r.review_id = t.review_id
where mod(abs(hash(r.review_id || '-ml_sample')), 100) < {{ var('ml_sample_pct') }}
