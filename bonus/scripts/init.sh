#!/bin/bash

# ==== Color definition ==== #
ylw="\033[33m"
grn="\033[32m"
blu="\033[34m"
mgn="\033[35m"
cyn="\033[36m"
nc="\033[m"

# install repo
echo -e "${grn}add helm repository.${nc}"
helm repo add gitlab https://charts.gitlab.io
helm repo update
