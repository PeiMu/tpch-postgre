for i in {1..22}; do
  ./qgen -v -c -d -s 1 ${i} > out/queries/${i}.sql
done

