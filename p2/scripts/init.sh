#!/bin/bash

# instal k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=enp0s8" sh -
# vagrnt userからクラスターにアクセスできるようにreadの権限を付与
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml


# source completion
echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> /home/vagrant/.bashrc

# prometheus, grafanaインストール中にメトリクスサーバーがないみたいな怒られ方するので、
# shellで起動確認できないか検討中、まだ上手く動かないはず
# wait metrics-server up
ret=1
while [ "$ret" -ne 0 ]
do
sleep 1
kubectl -n kube-system wait --for=condition=available deployment/metrics-server
ret=$?
done

# install helm
curl -O https://get.helm.sh/helm-v3.11.2-linux-amd64.tar.gz 
tar -zxvf helm-v3.11.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# install prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -f /vagrant/k8s/prometheus.yaml

# install grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana -f /vagrant/k8s/grafana.yaml
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode; echo
