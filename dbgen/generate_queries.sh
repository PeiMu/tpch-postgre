mkdir -p out/queries

timer_begin='
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
'

timer_end='
   _end_ts   := clock_timestamp();
   
-- RAISE NOTICE '\''Timing overhead in ms = %'\'', _overhead;
   RAISE NOTICE '\''Execution time in ms = %'\'', 1000 * (extract(epoch FROM _end_ts - _start_ts)) - _overhead;
END
$do$;
'

# Convert newlines in insert_code to literal "\n" for sed
insert_code_begin=$(echo "${timer_begin}" | sed ':a;N;$!ba;s/\n/\\n/g')

# Escape special characters in insert_code
insert_code_end=$(echo "${timer_end}" | sed "s/'/\\\\'/g")


for i in {1..22}; do
  ### add timer_begin
  ./qgen -v -c -d -s 1 ${i} > out/queries/${i}.sql
  sed -i "1s/^/${insert_code_begin}/" out/queries/${i}.sql
#  echo -e "${timer_begin}" | cat - out/queries/${i}.sql > temp && mv temp out/queries/${i}.sql

  ### add timer_end
#  sed -i -e "\$a\\${insert_code_end}" out/queries/${i}.sql
  echo "${timer_end}" >> out/queries/${i}.sql

  ### replace first `select` by `perform`
  sed -i '0,/select/{s//perform/}' out/queries/${i}.sql
done

