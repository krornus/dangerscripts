#!/bin/bash

rc=$HOME/.inputrc
end=$(dirname $PYTHONSTARTUP)
n=$(($(cat $rc | wc -l)+1))

if [[ $PWD != "$end"* ]]; then
    python2
fi

while [[ $PWD != $end ]] ; do
    file=$(find . -maxdepth 1 -name '.inputrc' -printf "$PWD/%f")

    if [ -n "$file" ]; then
        cat $file >> $rc
    fi

    cd ..
done

cat $rc
python2
sed -i "$n,$ d" $rc
