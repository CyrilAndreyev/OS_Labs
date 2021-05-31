#!/bin/bash

echo 'Removing old files'
find /tmp/ -maxdepth 1 -name 'FilteredProcessList_*.csv' \
  | sort \
  | head -n -4 \
  | xargs rm -f --

read -r -p 'Please specify %MEM parameter value to filter processes: ' _input

if ! [[ $_input =~ ^[0-9]+([.][0-9]+)?$ ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

_file_name="/tmp/FilteredProcessList_$(date +%Y%m%d_%H%M%S).csv"
echo 'COMMAND,PID,%MEM' > "$_file_name"
echo 'Getting process list'
ps --sort=-%mem -e -o %c, -o %p, -o %mem \
  | awk -F ',' "{ gsub(\" *, *\", \",\"); if (\$3 > ${_input}) print \$0 }" \
  >> "$_file_name"
