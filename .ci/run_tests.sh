#!/bin/bash

set -ev

IMG=$DOCKER_USERNAME/scale-mamba:$COMMIT
programs=(test_array test_branch test_branching test_comparison test_empty_tape
          test_flex test_float test_floatingpoint test_float_sorting test_float_vector
          test_function test_idle_threads test_lib test_loop test_mem_order test_sregint
          test_vector test_sfix test_sqrt test_custom_array test_fix_array test_all)

cp -R Auto-Test-Data/Cert-Store/* Cert-Store/

for i in $(seq 0 25); do
  \rm -f Scripts/logs/$i
done

cp -R Auto-Test-Data/$TEST_SET/* Data/
echo Running testscript on set $TEST_SET

docker run --rm --env TEST_SET $IMG sh ./Scripts/test-batch.sh "${programs[@]}"
