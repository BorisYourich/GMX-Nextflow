#!/bin/bash -ue
STOP=$((10 - 1))
for i in {0..$STOP}
do
    mkdir dir$i
done
echo "done"
