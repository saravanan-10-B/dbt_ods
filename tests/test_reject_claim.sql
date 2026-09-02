select *
from {{ ref('t_claim_src') }}
where upper(claim_status) = 'REJECTED'
  and coalesce(claim_amount, 0) <> 0