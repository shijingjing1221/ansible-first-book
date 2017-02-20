#!/bin/bash

output_md_file="../ansible-first-book.md"

all_md_files=$(grep -oE '\([^()]*.md\)' SUMMARY.md|sed -e 's/(//g'|sed -e 's/)//g')
echo "-------"
echo $all_md_files
echo "-------"
# cat $(echo $all_md_files) > ../ansible-first-book.md
echo "" > $output_md_file
for f in $all_md_files; do (cat "${f}"; echo) >> $output_md_file; done
echo "-------"
