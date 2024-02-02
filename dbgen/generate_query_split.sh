mkdir -p out/QuerySplit/

cp out/queries/* out/QuerySplit/.

split_algo="${1:-relationshipcenter}"
order_decision="${1:-c_r}"

for i in {1..22}; do
  sed -i "1s/^/switch to ${split_algo};\n/" out/QuerySplit/${i}.sql
  sed -i "1s/^/switch to ${order_decision};\n/" out/QuerySplit/${i}.sql
done


