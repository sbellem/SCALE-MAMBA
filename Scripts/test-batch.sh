#!/bin/bash

# Portably find the directory containing this script.
HERE=$(cd `dirname $0`; pwd)
# Assuming it lives in Scripts/, set ROOT to the root directory of the
# project.
ROOT=$HERE/..
# Now set the PYTHONPATH so we don't have to worry about the CWD
# whenever we invoke python scripts.
export PYTHONPATH=$ROOT:$PYTHONPATH

while getopts sCm:c:n opt; do
    case $opt in
	s) test_opts="-s"; compile_opts="$compile_opts -s" ;;
	c) compile_opts="$compile_opts -c $OPTARG" ;;
	n) compile_opts="$compile_opts -n" ;;
    esac
done

shift $[OPTIND-1]



run_test() {
    test=$1
    shift
    printf "\n\n\n\n\n\n\n\n\n\n"
    echo "$test"
    $ROOT/compile.py --dead-code-elimination $compile_opts $* Programs/$test || exit 1
    Scripts/run-online.sh Programs/$test || exit 1
    python Scripts/test-result.py $test_opts $test || exit 1
}

test_opts="-s"
compile_opts="--stop"
for test in "$@"; do
    run_test $test
done
