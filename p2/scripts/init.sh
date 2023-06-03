#!/bin/bash

# ==== Color definition ==== #
ylw="\033[33m"
grn="\033[32m"
blu="\033[34m"
mgn="\033[35m"
cyn="\033[36m"
nc="\033[m"

# instal k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=enp0s8" sh -
# vagrnt userからクラスターにアクセスできるようにreadの権限を付与
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# source completion
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /home/vagrant/.bashrc


echo "waiting for metrics-server to be ready"
while :; do
kubectl wait -n kube-system --timeout=90s --for=condition=Ready pod -l k8s-app=metrics-server
if [ $? = 0 ];then
  break
fi
sleep 1
done
echo "done waiting"

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

# install app
helm dependency build /vagrant/helm/app
helm install app /vagrant/helm/app --timeout 15m
kubectl get secret --namespace default app-grafana -o jsonpath="{.data.admin-password}" | base64 --decode > /vagrant/helm/grafana_password
