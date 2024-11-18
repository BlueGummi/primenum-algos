#!/bin/bash

is_prime() {
    local num=$1
    if (( num < 2 )); then
        return 1
    fi
    for ((i=2; i*i<=num; i++)); do
        if (( num % i == 0 )); then
            return 1
        fi
    done
    return 0
}

count=2 
while true; do
    if is_prime $count; then
        echo $count
    fi
    ((count++))
done
