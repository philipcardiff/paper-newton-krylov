#!/bin/bash

for f in ../../tableJFNKvsSeg_*.tex
do
    # Strip the leading 'tableJFNKvsSeg_' part:
    new="${f#../../tableJFNKvsSeg_}"
    new="${new%.tex}.txt"
    echo "Copying $f to $new"
    \cp -- "$f" "$new"

    sed '/\\hline/d' "$new" \
        | sed -E 's/^[^&]*&//' \
        | sed -e 's/\\,//g' -e 's/\\\\//g' -e 's/\$//g' -e 's/&/ /g' -e 's/\\dag/-/g' \
        | sed -E 's/[[:space:]]+/ /g' \
        | sed -E 's/^[[:space:]]+//' > "$new.tmp" && mv "$new.tmp" "$new"
done

for i in *gnuplot
do
    echo "Running gnuplot $i"
    gnuplot $i
done;
