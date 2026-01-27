#!/bin/bash
server="http://localhost:11434"
for model in $(llcat -su $server -m | shuf); do
    printf "%-40s" $model
    score=0
    for i in $(seq 1 60); do
        all=$(./joke_eval.py $i)
        correct=${all:0:1}
        guess=$(timeout 30s llcat -u $server -m "$model" "${all:2}" | tr -cd 'AB' )
        echo -n "$guess:"

        if [[ "$guess" == "$correct" ]]; then
            (( score++ ))
        fi
    done
    echo " $(( 100 * score / i )) $model"
done
