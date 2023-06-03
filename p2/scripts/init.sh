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

# install helm
echo -e "${grn}install helm command.${nc}"
helm_version="v3.11.3"
if [ `uname -m` = "arm64" ] ;then
# arm64の時はapple silicon決め打ち
target="darwin-arm64"
else
target="linux-amd64"
fi
curl -O https://get.helm.sh/helm-${helm_version}-${target}.tar.gz
tar -zxvf helm-${helm_version}-${target}.tar.gz
sudo mv ${target}/helm /usr/local/bin/helm
rm -rf ${target} helm-${helm_version}-${target}.tar.gz

# install repo
echo -e "${grn}add helm repository.${nc}"
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add ckotzbauer https://ckotzbauer.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
