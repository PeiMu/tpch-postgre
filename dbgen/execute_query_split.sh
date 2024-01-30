for i in {1..22}; do sudo -u postgres psql < out/QuerySplit/$i.sql; done
