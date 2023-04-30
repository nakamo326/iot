CLUSTER_NAME = iot

# make cluster. if there's already, delete current cluster
all: del
	k3d cluster create $(CLUSTER_NAME) -p "80:80@loadbalancer"

# delete cluster.
del:
	k3d cluster delete $(CLUSTER_NAME)

# install helm chart.
# install:


# upgrade helm chart.
# up:

# temp TODO: delete
helm:
	helm install prometheus prometheus-community/prometheus -f k8s/prometheus.yaml

# wait metrics-server
wait_metrics:
	./scripts/wait.sh

.PHONY: all del install up wait_metrics