dir="/home/pei/benchmarks/tpch-postgre/dbgen/out/skinner_explained"
iteration=10

for i in {1.."${iteration}"}; do
  for sql in "${dir}"/*; do
    echo "execute ${sql}";
    #psql -f "${sql}" 2>&1|tee -a skinner_explained_tpch-3.txt;
    psql -f "${sql}";
  done
done
