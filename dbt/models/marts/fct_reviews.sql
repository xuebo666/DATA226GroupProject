-- One row per review, plus a few derived columns used in analysis and modeling.
select
    *,
    case
        when star_rating <= 2 then 'negative'
        when star_rating = 3  then 'neutral'
        else 'positive'
    end                                                       as rating_class,
    length(review_text)                                       as char_count,
    case when total_votes > 0
         then helpful_votes::float / total_votes end          as helpful_ratio
from {{ ref('stg_reviews') }}
