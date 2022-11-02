#!/bin/bash -ue
for i in {0..10}
do
    mkdir dir$i
    cp topol.top
done
echo "done"
