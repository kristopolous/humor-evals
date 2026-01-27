#!/bin/bash
server="http://localhost:11434"
for model in $(llcat -su $server -m | sort); do
    printf "%-40s," $model
    score=0
    for i in $(seq 1 250); do
        all=$(./joke_eval.py $i)
        correct=${all:0:1}
        guess=$(timeout 300s llcat -u $server -m "$model" "${all:2}" | tr -cd 'AB' )
        guess=${guess:0:1}
        [[ -n "$guess" ]] || guess="X"

        if [[ "$guess" == "$correct" ]]; then
            echo -n "."
            (( score++ ))
        else
            echo -n "!"
        fi
    done
    echo ", $(( 100 * score / i )), $model"
done
