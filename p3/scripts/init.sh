#!/bin/bash

# ==== Color definition ==== #
ylw="\033[33m"
grn="\033[32m"
blu="\033[34m"
mgn="\033[35m"
cyn="\033[36m"
nc="\033[m"

# install k3d, please input your password
echo -e "${grn}install k3d command.${nc}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# install repo
echo -e "${grn}add helm repository.${nc}"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
