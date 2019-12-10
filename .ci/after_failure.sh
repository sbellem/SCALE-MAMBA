#!/bin/bash

set -ev

for f in Scripts/logs/*; do
    printf "%0.s*" {1..79}
    printf "\n                    $f\n"
    printf "%0.s*" {1..79}
    echo
    cat $f
    printf "\n\n"
done
