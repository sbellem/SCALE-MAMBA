#!/bin/bash

set -ev

cp -R Auto-Test-Data/Cert-Store/* Cert-Store/

for i in $(seq 0 25); do
  \rm -f Scripts/logs/$i
done

cp -R Auto-Test-Data/$TEST_SET/* Data/
echo Running testscript on set $TEST_SET

# We do not run sfix, float, math, sqrt and custom_array tests for 32 bit inputs 
programs=(
    test_array
    #test_branch
    #test_branching
    #test_comparison
    ##test_count
    #test_empty_tape
    #test_flex
    ##test_for_range_multithread
    #test_function
    #test_idle_threads
    #test_lib
    #test_loop
    ##test_map_reduce
    #test_mem_order
    ##test_new_threads
    ##test_threads
    #test_vector
    #test_all
)
./Scripts/test-batch_32.sh "${programs[@]}"
