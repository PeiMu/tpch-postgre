export DSS_CONFIG=$PWD
export DSS_QUERY=$DSS_CONFIG/queries
export DSS_PATH=$DSS_CONFIG/out

mkdir -p out

make
