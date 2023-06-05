#!/bin/bash

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

# install app
kubectl apply -f /vagrant/k8s/app1.yaml
kubectl apply -f /vagrant/k8s/app2.yaml
kubectl apply -f /vagrant/k8s/app3.yaml
