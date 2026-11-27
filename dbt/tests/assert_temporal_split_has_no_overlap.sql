-- Fails (returns a row) if any training year is later than or equal to a test year.
select *
from (
    select
        max(case when split = 'train' then review_year end) as max_train_year,
        min(case when split = 'test'  then review_year end) as min_test_year
    from {{ ref('split_temporal') }}
) t
where max_train_year >= min_test_year
