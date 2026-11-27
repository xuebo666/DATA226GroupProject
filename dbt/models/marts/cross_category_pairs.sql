-- Experiment 2: train on category A, test on category B.
-- This is just the list of the 12 (train, test) pairs. In modeling, train rows are
-- the reviews of train_category and test rows are the reviews of test_category,
-- so we do not need to copy 18M rows 12 times.
with cats as (
    select distinct category from {{ ref('stg_reviews') }}
)
select
    a.category as train_category,
    b.category as test_category
from cats a
cross join cats b
where a.category <> b.category
