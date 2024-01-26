mkdir -p out/QuerySplit/

cp out/queries/* out/QuerySplit/.

split_algo="${1:-minsubquery}"

for i in {1..22}; do
  sed -i "1s/^/switch to ${split_algo};\n/" out/QuerySplit/${i}.sql
done


