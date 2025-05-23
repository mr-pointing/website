#!/bin/bash

find content -name '*.md' | while read file; do
  awk '
  BEGIN { changed = 0 }
  /^date: [0-9]{4}-[0-9]+-[0-9]+/ {
    split($2, d, "-");
    printf("date: %04d-%02d-%02d\n", d[1], d[2], d[3]);
    changed = 1;
    next;
  }
  { print }
  END { if (changed) print "Fixed:", FILENAME > "/dev/stderr" }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done
