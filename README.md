tpch-kit
========

TPC-H benchmark kit with some modifications/additions

Official TPC-H benchmark - [http://www.tpc.org/tpch](http://www.tpc.org/tpch)

## Modifications

The following modifications have been added on top of the official TPC-H kit:

* modify `dbgen` to not print trailing delimiter
* add option for `dbgen` to output to stdout
* add compile support for macOS
* ~~add define for PostgreSQL to support `LIMIT N` for `qgen`~~ Deleted since PostgreSQL 14.10 doesn't support this
* adjust `Makefile` defaults


### Modifications based on QuerySplit

The following modifications have been added based on a SOTA paper. Ignore the related scripts for the common use.

* add some environment settings, in `generate_pure_queries.sh` and `generate_queries.sh`
* generate QuerySplit configs, in `generate_query_split.sh`

## Pre-Request

### Linux

Make sure the required development tools are installed:

Ubuntu:
```
sudo apt-get install git make gcc
```

CentOS/RHEL:
```
sudo yum install git make gcc
```

### macOS

Make sure the required development tools are installed:

```
xcode-select --install
```

Then run the following commands to clone the repo and build the tools:

## Using this tool
### Prepare Data
```bash
git clone git@github.com:PeiMu/tpch-postgre.git

cd tpch-postgre/dbgen/

# set env configs and compile
source ./compile.sh

# generate data
./dbgen -vf -s 1 

# start service
sudo systemctl start postgresql.service

# create database (optional)
sudo -u postgres psql -c "create database tpch;"

# switch database (optional)
sudo -u postgres psql -c "\c tpch"

# create tables (optional)
sudo -u postgres psql < dss.ddl

# load data
bash ./load_data.sh

# generate pure_quries (without timing functions, but has environment settings)
# please remove the environment settings for the common use
bash ./generate_pure_queries.sh

# generate queries (with timing functions and environment settings)
# please remove the environment settings for the common use
bash ./generate_queries.sh

# delete `(3)` manually
vi out/queries/1.sql

# execute queries
bash ./execute_queries.sh
```



## Notes

### SQL dialect

See `Makefile` for the valid `DATABASE` values.  Details for each dialect can be found in `tpcd.h`.  Adjust the query templates in `tpch-kit/dbgen/queries` as need be.

### Data generation

Data generation is done via `dbgen`.  See `dbgen -h` for all options.  The environment variable `DSS_PATH` can be used to set the desired output location.

### Query generation

Query generation is done via `qgen`.  See `qgen -h` for all options.

The following command can be used to generate all 22 queries in numerical order for the 1GB scale factor (`-s 1`) using the default substitution variables (`-d`).

```
qgen -v -c -d -s 1 > tpch-stream.sql
```

To generate one query per file for SF 3000 (3TB) use:

```
for ((i=1;i<=22;i++)); do
  ./qgen -v -c -s 3000 ${i} > /tmp/sf3000/tpch-q${i}.sql
done
```
