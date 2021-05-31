#!/bin/bash

GREEN=$'\e[0;32m'
NC=$'\e[0m'

for i in {1..24}; do
  _dir_name="../Records/${i}h"
  echo "${GREEN}Creating directory ${_dir_name}${NC}"
  mkdir -pv $_dir_name

  _file_name="${_dir_name}/$(date +%Y%m%d_%H%M%S)"
  echo "${GREEN}Creating file ${_file_name}${NC}"
  realpath $_file_name > $_file_name
done
