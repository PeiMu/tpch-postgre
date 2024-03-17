for table in customer lineitem nation orders partsupp part region supplier
do psql -c \
        "\copy "$table" to '$PWD/out/$table.csv' CSV;"
done

