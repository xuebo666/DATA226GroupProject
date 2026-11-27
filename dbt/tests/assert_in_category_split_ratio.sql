-- Fails (returns rows) if a category's train share is more than 2 points away from train_pct.
select
    category,
    avg(case when split = 'train' then 1.0 else 0.0 end) as train_share
from {{ ref('split_in_category') }}
group by category
having abs(avg(case when split = 'train' then 1.0 else 0.0 end) - {{ var('train_pct') }} / 100.0) > 0.02
