mkdir -p out/pure_QuerySplit/

cp out/pure_queries/* out/pure_QuerySplit/.

split_algo="${1:-relationshipcenter}"
order_decision="${1:-c_r}"

for i in {1..22}; do
  sed -i "1s/^/switch to ${split_algo};\n/" out/pure_QuerySplit/${i}.sql
  sed -i "1s/^/switch to ${order_decision};\n/" out/pure_QuerySplit/${i}.sql
done


