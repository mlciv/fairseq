#!/bin/bash

# Time-stamp: <>
# --------------------------------------------------------------------
# File Name          : split_data.sh
# Original Author    : jiessie.cao@gmail.com
# Description        :  split dataset
# --------------------------------------------------------------------


# training:valid:test=25:1:1
. ./env.sh
file_prefix=$1
echo $file_prefix

pushd ${FAIR_SEQ_BASE}/seq_data
cat ${file_prefix}.csv | grep -v "#" > ${file_prefix}.all.raw
shuf ${file_prefix}.all.raw > ${file_prefix}.all.raw.shuf

cat ${file_prefix}.all.raw.shuf| head -n 4870 > ${file_prefix}.valid.raw
cat ${file_prefix}.all.raw.shuf| head -n 9740| tail -n 4870 > ${file_prefix}.test.raw
cat ${file_prefix}.all.raw.shuf| tail -n 121781 > ${file_prefix}.train.raw
popd



