#!/bin/bash

RED=$'\e[0;31m'
NC=$'\e[0m'

echo "${RED}Removing files and subdirectories${NC}"
rm -rfv ../Records/*
