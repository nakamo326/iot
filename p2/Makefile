CLUSTER_NAME = iot

all:
	vagrant up

# make cluster. if there's already, delete current cluster
k3d: k3d_del
	k3d cluster create $(CLUSTER_NAME) -p "80:80@loadbalancer"

# delete cluster.
k3d_del:
	k3d cluster delete $(CLUSTER_NAME)

# install apps for k3d cluster.
app:
	kubectl apply -f k8s/app1.yaml
	kubectl apply -f k8s/app2.yaml
	kubectl apply -f k8s/app3.yaml

add_hosts:
	echo "192.168.56.110 app1.com\n192.168.56.110 app2.com\n" >> /etc/hosts

.PHONY: all init k3d k3d_del app add_hosts