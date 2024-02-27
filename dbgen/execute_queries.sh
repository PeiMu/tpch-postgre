dir="/home/pei/benchmarks/tpch-postgre/dbgen/out/skinner_explained"
iteration=10

for i in {1.."${iteration}"}; do
  for sql in "${dir}"/*; do
    echo "execute ${sql}";
    psql < "${sql}"; 2>&1|tee log.txt
  done
done
