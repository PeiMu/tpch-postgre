switch to c_r;
switch to relationshipcenter;

set max_parallel_workers = 0;
set effective_cache_size to '8 GB';
set statement_timeout = '1000s';


DO
$do$
DECLARE
   _timing1  timestamptz;
   _start_ts timestamptz;
   _end_ts   timestamptz;
   _overhead numeric;     -- in ms
   _timing   numeric;     -- in ms
BEGIN
   _timing1  := clock_timestamp();
   _start_ts := clock_timestamp();
   _end_ts   := clock_timestamp();
   -- take minimum duration as conservative estimate
   _overhead := 1000 * extract(epoch FROM LEAST(_start_ts - _timing1 , _end_ts - _start_ts));
   _start_ts := clock_timestamp();
-- TPC TPC-H Parameter Substitution (Version 2.17.3 build 0)
-- using default substitutions
-- $ID$
-- TPC-H/TPC-R Promotion Effect Query (Q14)
-- Functional Query Definition
-- Approved February 1998


perform
	100.00 * sum(case
		when p_type like 'PROMO%'
			then l_extendedprice * (1 - l_discount)
		else 0
	end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
	lineitem,
	part
where
	l_partkey = p_partkey
	and l_shipdate >= date '1995-09-01'
	and l_shipdate < date '1995-09-01' + interval '1' month;

   _end_ts   := clock_timestamp();
   
-- RAISE NOTICE 'Timing overhead in ms = %', _overhead;
   RAISE NOTICE 'Execution time in ms = %', 1000 * (extract(epoch FROM _end_ts - _start_ts)) - _overhead;
END
$do$;

