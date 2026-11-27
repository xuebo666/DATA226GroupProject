-- Experiment 1: random train/test split inside each category.
-- Uses a hash of review_id, so the split is random but always the same on every run.
select
    review_id,
    category,
    case
        when mod(abs(hash(review_id || '-in_category')), 100) < {{ var('train_pct') }}
        then 'train' else 'test'
    end as split
from {{ ref('stg_reviews') }}
