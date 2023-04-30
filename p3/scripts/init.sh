#!/bin/bash

# install k3d, please input your password
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# install helm
curl -O https://get.helm.sh/helm-v3.11.2-linux-amd64.tar.gz 
tar -zxvf helm-v3.11.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64 helm-v3.11.2-linux-amd64.tar.gz

# install repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add ckotzbauer https://ckotzbauer.github.io/helm-charts
helm repo update
