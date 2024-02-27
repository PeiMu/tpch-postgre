mkdir -p out/pure_queries


QuerySplit_settings='
set max_parallel_workers = 0;
set effective_cache_size to '\''8 GB'\'';
set statement_timeout = '\''1000s'\'';
'

insert_code=$(echo "${QuerySplit_settings}" | sed ':a;N;$!ba;s/\n/\\n/g')

for i in {1..22}; do
  ### add timer_begin
  ./qgen -v -c -d -s 3 ${i} > out/pure_queries/${i}.sql
  sed -i "1s/^/${insert_code}/" out/pure_queries/${i}.sql
done

