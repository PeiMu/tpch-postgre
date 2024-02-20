mkdir -p out/pure_queries

for i in {1..22}; do
  ### add timer_begin
  ./qgen -v -c -d -s 1 ${i} > out/pure_queries/${i}.sql
done

