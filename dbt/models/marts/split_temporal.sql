-- Experiment 3: train on earlier years, test on later years.
-- Years before temporal_min_year are excluded (too few reviews).
select
    review_id,
    category,
    review_year,
    case
        when review_year < {{ var('temporal_min_year') }}      then 'excluded'
        when review_year <= {{ var('temporal_train_end_year') }} then 'train'
        else 'test'
    end as split
from {{ ref('stg_reviews') }}
