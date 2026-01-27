#!/bin/bash
{
echo "tally,score,model"
cat output.txt| cut -d ',' -f 2-5
} > output.csv
